Return-Path: <linux-kernel+bounces-115730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A694588948B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55091C2F396
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD44363390;
	Mon, 25 Mar 2024 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvBzOTYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818913F014;
	Sun, 24 Mar 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321804; cv=none; b=p32GmRnzhA50UuYar9ETtDbDVNlWI4SeIj41Pn69uf0BbyYdtjM2xCJvnNHfYG2WFKx9/TN4qLsDSAS98DbtUk0bV486QJh+jwm9+AbFIfUaLUxtJtq2AmCTfHGRRBr5rIQDeXzA0bWv2h+BgbKgJ3olAUacfCyFpOPHlsTz8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321804; c=relaxed/simple;
	bh=e4yb4F4zb1+s4XBIwIWnFEIjhB0//9tbvD+tPZOWKe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSi4PH7eBXjsBV4UBNCsu5S1KwkhaWYRq2BXZGgy797hsWGLdpOVyQEVGG+5FdjpyIu0q1Kp7T8vLZQTOBhSsi+bg6ITs8+3rfBl2Sqb3qyBOvInvx54BgcuTZ4Vk5ZjgTXhT9E78Q6JbVt1tCcFfHPDcwkXUfxI/NB6ZYysCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvBzOTYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCEBC433B1;
	Sun, 24 Mar 2024 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321803;
	bh=e4yb4F4zb1+s4XBIwIWnFEIjhB0//9tbvD+tPZOWKe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvBzOTYYc4ZX3cM5x9/rDHz7NwM2Yy0hd1L6NtSLKcKiD+eLQGx0qsMsclm1AChDt
	 TJ7y673WyD13EF49AE1D4U3e/k3LRR7NfMIsWsefDb3oB/a22ZGeg9zdYNQP1RnZtA
	 +36qGSV669cAJPRgEiJsgM8X9NtwaTde6dmTbvJBBb3F0z+bP1fQ+plRtTdJHXYr5U
	 aI45Z/eApj1p6HrYo+tYO2ak+rsI0YbODwR/wvaOyivEKSnWJUQUoDtUheomdTwZoa
	 K0SRKhIcAC3dZu9F03fUqAzZDR4psKmksf9gpX0H5KL3w49HBALo6tF1+ZaDlkpqYp
	 4RXNTOnMVzVpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jorge Mora <jmora1300@gmail.com>,
	Jorge Mora <mora@netapp.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 531/638] NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102
Date: Sun, 24 Mar 2024 18:59:28 -0400
Message-ID: <20240324230116.1348576-532-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jorge Mora <jmora1300@gmail.com>

[ Upstream commit 251a658bbfceafb4d58c76b77682c8bf7bcfad65 ]

A call to listxattr() with a buffer size = 0 returns the actual
size of the buffer needed for a subsequent call. When size > 0,
nfs4_listxattr() does not return an error because either
generic_listxattr() or nfs4_listxattr_nfs4_label() consumes
exactly all the bytes then size is 0 when calling
nfs4_listxattr_nfs4_user() which then triggers the following
kernel BUG:

  [   99.403778] kernel BUG at mm/usercopy.c:102!
  [   99.404063] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
  [   99.408463] CPU: 0 PID: 3310 Comm: python3 Not tainted 6.6.0-61.fc40.aarch64 #1
  [   99.415827] Call trace:
  [   99.415985]  usercopy_abort+0x70/0xa0
  [   99.416227]  __check_heap_object+0x134/0x158
  [   99.416505]  check_heap_object+0x150/0x188
  [   99.416696]  __check_object_size.part.0+0x78/0x168
  [   99.416886]  __check_object_size+0x28/0x40
  [   99.417078]  listxattr+0x8c/0x120
  [   99.417252]  path_listxattr+0x78/0xe0
  [   99.417476]  __arm64_sys_listxattr+0x28/0x40
  [   99.417723]  invoke_syscall+0x78/0x100
  [   99.417929]  el0_svc_common.constprop.0+0x48/0xf0
  [   99.418186]  do_el0_svc+0x24/0x38
  [   99.418376]  el0_svc+0x3c/0x110
  [   99.418554]  el0t_64_sync_handler+0x120/0x130
  [   99.418788]  el0t_64_sync+0x194/0x198
  [   99.418994] Code: aa0003e3 d000a3e0 91310000 97f49bdb (d4210000)

Issue is reproduced when generic_listxattr() returns 'system.nfs4_acl',
thus calling lisxattr() with size = 16 will trigger the bug.

Add check on nfs4_listxattr() to return ERANGE error when it is
called with size > 0 and the return value is greater than size.

Fixes: 012a211abd5d ("NFSv4.2: hook in the user extended attribute handlers")
Signed-off-by: Jorge Mora <mora@netapp.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e8b52e36906cc..2499459f0369a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10587,29 +10587,33 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	ssize_t error, error2, error3;
+	size_t left = size;
 
-	error = generic_listxattr(dentry, list, size);
+	error = generic_listxattr(dentry, list, left);
 	if (error < 0)
 		return error;
 	if (list) {
 		list += error;
-		size -= error;
+		left -= error;
 	}
 
-	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
+	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, left);
 	if (error2 < 0)
 		return error2;
 
 	if (list) {
 		list += error2;
-		size -= error2;
+		left -= error2;
 	}
 
-	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
 
-	return error + error2 + error3;
+	error += error2 + error3;
+	if (size && error > size)
+		return -ERANGE;
+	return error;
 }
 
 static void nfs4_enable_swap(struct inode *inode)
-- 
2.43.0


