Return-Path: <linux-kernel+bounces-115042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8B888CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FA01F29583
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105A1C1C08;
	Mon, 25 Mar 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5RUsx/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD452853C5;
	Sun, 24 Mar 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323822; cv=none; b=GWOANZvZci3HLEmtkytd1dr1Gu0/aH0nUoLjucuByvwdeyjK/7n+3VNe5NSFF94bOGX2DkL02vdKl76IW8FMS1IAun5XUNIl0AGKriqzRCvVPF7G+Eu79x3cP1eFOykl/Y0vqk5ruk2O47QRltLROeXoVP2pJ2iXZ5OX6y2pxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323822; c=relaxed/simple;
	bh=LYazFtegKbUQmWF4+002xX2Q9D4Jt0jQN6fweMdHyiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UibFkBS3QarJbf/5ExntpZV/dVByI92KDTZLAMULJxot8mcAIRWeP64HR3G0qV32g2bAKfRP/NXxPcKMQtiIPC9031dAQQL97/3J9wMM4oz+jbXfeNRo1FmlfdBqjzohH9pDESy0yH8wMYFJPkIBSipWHdQMMLSrHs5CeBY1Bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5RUsx/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D21C43390;
	Sun, 24 Mar 2024 23:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323821;
	bh=LYazFtegKbUQmWF4+002xX2Q9D4Jt0jQN6fweMdHyiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5RUsx/27tYdzHGQF3diTgs2az5Bp9KdnWcYBTcLWzvbReeg7m10N3/F3L6rwuoZB
	 mI46DfOwjLQXfQGZxL8fDizxhzDxt1pj/gI0TImldlOglIWc23C3S+AgQT2HMcLag3
	 b5dVApQkasMHVpww0/8m6FEWj2pXzOD46TOzKr6P2e3iJCgPwPymNfYasdo8wQ/eME
	 61C14WEWIM4YcTYGhuKxmNrFzYGlUFwnhUibYqsFHaeNSmELcCcf7q3fBuqL2d1bww
	 qG8ASU5bU35pdoR/I3pcvI7ZHJlHpwdJ2P8ZWKRCBUKmGOrfN4qGjr8Ta6ZQFDyT96
	 66sAWb2O8twDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jorge Mora <jmora1300@gmail.com>,
	Jorge Mora <mora@netapp.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 200/238] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Sun, 24 Mar 2024 19:39:48 -0400
Message-ID: <20240324234027.1354210-201-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit bcac8bff90a6ee1629f90669cdb9d28fb86049b0 ]

Switch order of operations to avoid creating a short XDR buffer:
e.g., buflen = 12, old xdrlen = 12, new xdrlen = 20.

Having a short XDR buffer leads to lxa_maxcount be a few bytes
less than what is needed to retrieve the whole list when using
a buflen as returned by a call with size = 0:
    buflen = listxattr(path, NULL, 0);
    buf = malloc(buflen);
    buflen = listxattr(path, buf, buflen);

For a file with one attribute (name = '123456'), the first call
with size = 0 will return buflen = 12 ('user.123456\x00').
The second call with size = 12, sends LISTXATTRS with
lxa_maxcount = 12 + 8 (cookie) + 4 (array count) = 24. The
XDR buffer needs 8 (cookie) + 4 (array count) + 4 (name count)
+ 6 (name len) + 2 (padding) + 4 (eof) = 28 which is 4 bytes
shorter than the lxa_maxcount provided in the call.

Fixes: 04a5da690e8f ("NFSv4.2: define limits and sizes for user xattr handling")
Signed-off-by: Jorge Mora <mora@netapp.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf1..e7192d0eea3de 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -54,11 +54,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
  * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
  * 8 bytes long XDR-encoded.
  *
- * Include the trailing eof word as well.
+ * Include the trailing eof word as well and make the result a multiple
+ * of 4 bytes.
  */
 static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
 {
-	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+	u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
+
+	return (size + 3) & ~3;
 }
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
-- 
2.43.0


