Return-Path: <linux-kernel+bounces-102142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69A87AEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09528B24ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3E7351E;
	Wed, 13 Mar 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVEh/z9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470573500;
	Wed, 13 Mar 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349357; cv=none; b=i2wlU7IhXOcWLBAMvKVmGaht8SqnwA3eulClKzftP4CbzLcUMwFWlhhmFwZh5mxOVMnz2nilYl6CKtjqhVD32X4PY2RZOjOGlAo0mhq9ur58Tm2brOwOhCxhALKh4yvLVOt0FTjnT1zMYwwqJOu5D64jXQMIqwOtGCkSR5BcrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349357; c=relaxed/simple;
	bh=nD7ZXm8YsqdENodcu3jJqOHPdmAk/8dtGDrloYTBSIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7q1NsVgCN4QFHO3Nx5DWgE+4q/zarfFHFEjnEg7nL+Q5qvKUxK3I4J/Y4Gwbsos36yV1ZGuyeGdXtmxAF7hmbr0IhkHaFaYs+yz3zjAuewhrTmJ91ZbdZBB4nBirDKl/8xe0fGRl+jqNUz7aUgMoYj2KUrD6AQQ4NeWtuj/8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVEh/z9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA539C433F1;
	Wed, 13 Mar 2024 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349357;
	bh=nD7ZXm8YsqdENodcu3jJqOHPdmAk/8dtGDrloYTBSIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVEh/z9JZ1lwL6Qz0sdN8cmTDj8utdynu35B6rR4Kt5UEAHgxsFbLuw4A6FIKyPys
	 3LcNSbAimmLFVwt0I3ievfwv8Utir3MmbRecRqXfbThkDL5b6jVRlXQBbK4NVpWau2
	 d1fdtD/QLlWE4jD1n/EgrKzHAk903L3FSpK5J9IBo6GdO9+FJGUNPF6GZtjEyYtte5
	 RmUGcKgT2xhfWNjl+Y2IWmWrgiInHVMtIO3932Icg56QiO7vKMVJNZ332DliIXtg4h
	 kUqBTjI9JEK65v+LPLwMOHRmU1JLccWC351P1OHj/eFFg5uxfuuh8ddNXbDT1a6Pt/
	 s8VQqdAkk6GCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 21/51] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 13:01:42 -0400
Message-ID: <20240313170212.616443-22-sashal@kernel.org>
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

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit f99b494b40431f0ca416859f2345746199398e2b ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index bf29260f6e52a..e25bb0fe6d13c 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -439,7 +439,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


