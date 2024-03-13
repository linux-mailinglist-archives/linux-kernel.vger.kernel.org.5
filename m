Return-Path: <linux-kernel+bounces-102162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611087AEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FE11C232A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93B193804;
	Wed, 13 Mar 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScXHIL3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0921937ED;
	Wed, 13 Mar 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349379; cv=none; b=Zd7YPLuH/elgQXWb3U7yTH5uErTbhcaJ5R7bOBRMWe7G1bk2qIY1AhL3f8HDFShEVFOhAUyywmzgaB6xqNB3yoNj/PekuCk4qnVfBu1upoKlIK2jGqt2ojYd2rjab67BDST1316O9v1lnP59eNPPmkDXHQiixKbtjNx6NYYA/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349379; c=relaxed/simple;
	bh=bBofMW1wjrC8hqZ5A+vCmR2DthDdxVhCOpTWPQuL2p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgy92647+f6l3fVxxSvwM86VIvG5O0PH4R38t6Hw+c4Urfky1xLYqdI69HjeU/oSdsAnn6m//0dVI/Htdxj3Q4JQpse1zqjhsG1dHjEaSL1l4UcpF81luHeWWQo2xANfe2v4TGTIKWRmlgDS7G7uacmrAPVu/lbPe/pgHgBSbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScXHIL3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D210FC43394;
	Wed, 13 Mar 2024 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349379;
	bh=bBofMW1wjrC8hqZ5A+vCmR2DthDdxVhCOpTWPQuL2p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScXHIL3+i8IiH1DoVo1bA1YbhYSJ7QsjbBy+2TzsK9UbI/IClf3qy1QwKigtVt3ve
	 5UBOD65XndpzbFbeQLKiBPQJrgMr8NjgWI7kVP/P5lxX417IvY/Z3oSsXJixnbDnFk
	 8GCzapyNtoiumlwUqdBeOod8Mm1ybCq1KsQna5l1zxgmIdxuduq3MleyRTdJpNrhxR
	 121TpQ7Jw2DNh//4keVC8/FWh3HjhblNxlt1ux/T/uOAE7WN5Wt0vnk3NR+K/TPXhT
	 CxDXwZp1mpoFdqIijHn2NZWEdVe3Pek3NCcDONiotfbrCbfN0VXGHUfScUz6TW9YEW
	 9BkAwb2xCEkFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 41/51] getrusage: use __for_each_thread()
Date: Wed, 13 Mar 2024 13:02:02 -0400
Message-ID: <20240313170212.616443-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 13b7bc60b5353371460a203df6c38ccd38ad7a3a ]

do/while_each_thread should be avoided when possible.

Plus this change allows to avoid lock_task_sighand(), we can use rcu
and/or sig->stats_lock instead.

Link: https://lkml.kernel.org/r/20230909172629.GA20454@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7ec1cd5cc7e ("getrusage: use sig->stats_lock rather than lock_task_sighand()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index b53ad9e50e465..4a5b03ad6e9b4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1755,10 +1755,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
-		t = p;
-		do {
+		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
-		} while_each_thread(p, t);
 		break;
 
 	default:
-- 
2.43.0


