Return-Path: <linux-kernel+bounces-101934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40687ACD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAFAB24ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47212FF6D;
	Wed, 13 Mar 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFCfOPUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526C132460;
	Wed, 13 Mar 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348078; cv=none; b=DUrpXx1MwRDRVEiwyBzAOvw87oZd+JRC1jNlYNWGsU0Znfv8LVyf5LGm6vrhSf4AI0/DpGvBn6Fi9mUqHMNBPPICemAzidn8lXqL/q/IJbJ6cz/SQEljdM1Y2XimdNx/cQsQKc+N2AU5SGg2/DyZR2YZrClapA6GG9Nf9Jt80cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348078; c=relaxed/simple;
	bh=g+vF/N0P3uA7U7TKRAGCB3sVzuhtE+gpuhrYHSsENoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtFW4HUq+ey/elBUP7Sdx8p+f57lk4BbCG/hwpqDjWHThiR8tcAPw7MHEY6yF9MdXWejLfJv5GYahn5bRoeMgfUQMe5mODbq9wPn9KzTfClpqo3DgMsPTP9FosSVmADfJUQ+Z1ZpqbQjPtVKDTgUgZ2qIgMZfg+m09grncRgsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFCfOPUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE6EC43394;
	Wed, 13 Mar 2024 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348078;
	bh=g+vF/N0P3uA7U7TKRAGCB3sVzuhtE+gpuhrYHSsENoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFCfOPUBXFKxR3cUTds2YAX+yrsRpjSaWZ6NPeJh4f30aPII7lgk38bEt3KePQNTg
	 Ii+LUWtrB1e2lqRmZGx8zpEbOr0KLROp+Tqp8jqv6J+zw/UVYTXMtxeoJmFEKXkyBt
	 iwlp22DUO6qu3lFSK22zP/8a54ueZ1l4Q6XXUTVYjn31uEOdcCuvhaVBeRIXK6MG+/
	 KD8GVcM2D3m/3ufuSpkgttNBYa9O1YGfsdyVLNzmWCcvdTU8UGHK4JlnrZUvSeYjo2
	 8y7MFh6tqOCYd+dt2g0Ime1LOO2vnHhjuvF2L8FigN+/riXyZsia2x4lPi0yCj7PiT
	 KRYwoZ4uKXs5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 66/71] fs/proc: do_task_stat: use __for_each_thread()
Date: Wed, 13 Mar 2024 12:39:52 -0400
Message-ID: <20240313163957.615276-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]

do/while_each_thread should be avoided when possible.

Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 1b0d78dfd20f9..bcb645627991e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -526,12 +526,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 		/* add up live thread stats at the group level */
 		if (whole) {
-			struct task_struct *t = task;
-			do {
+			struct task_struct *t;
+
+			__for_each_thread(sig, t) {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
-			} while_each_thread(task, t);
+			}
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
-- 
2.43.0


