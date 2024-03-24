Return-Path: <linux-kernel+bounces-114395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FF888FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385C5290131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DEC174ECF;
	Sun, 24 Mar 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv++eqOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDD13F426;
	Sun, 24 Mar 2024 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321805; cv=none; b=OwTftL2Z3+fYpL9bt8kUUT0FI3tDR3POVc3smbU7AEip1QNiszoDZx/Ni2V7PCYo/lfJoga4GGcvC9kenICo5XVPnZYKofPEohN1zcvv4hyYC0VDRRN/FeiV70U3CY3Li/Hwag9RYCcZOOCVbvZLOY5cEwrLvnbAXNtREcsqAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321805; c=relaxed/simple;
	bh=g1ekMzSm4txgtotmTsA3S1y1NJqyvLL1l8D4Mk/0VZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOLGKQBsy3UHbsxxNfWu/5e/rMtS0qeJuPeEcvLksVAseXcWsF6rgtZUmql8jhVr0hyR032DhhlUsDnpx/SpVDHtDyra6UXaF7wzophlBQ3R2NDP2FEZ008w+wARYjMHFfVYk1lOoLoiTc75AzDeETyXzLgUlCYnV0QnHf4OaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv++eqOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EEBC43390;
	Sun, 24 Mar 2024 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321804;
	bh=g1ekMzSm4txgtotmTsA3S1y1NJqyvLL1l8D4Mk/0VZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cv++eqOefZVbCieB+kFo7c6m5Rd/MNI2qx2dzj2zVLCY1+odL7oPn/0Swu0Vk5N/l
	 jpeqStrqJrFefoOXklAkf7nC9jUiqY9e/Fh38dOfDomd+IdmMUA+VI4aZ6kEOmJZ/B
	 iMQehtdIn4LbhXiH/jTnzaacwRcsKBaoFRCRnf2Z32mS4neQ74C2Q7azfI88CcVsx1
	 a4zL7CZgDXqffHtrtFGjsE4nlsQCD3n39u8mVTYas72Rrm7lEiwXsa1cY4+IiF0TgA
	 u2GdOG6swdZvX/yzO2+8L+kEW4FgUos2WXVfLoWX/Xyu5RIxk/wSwHsSGgntjgRSuG
	 Ra2TfqSlg6obw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jorge Mora <jmora1300@gmail.com>,
	Jorge Mora <mora@netapp.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 532/638] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Sun, 24 Mar 2024 18:59:29 -0400
Message-ID: <20240324230116.1348576-533-sashal@kernel.org>
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
index b59876b01a1e3..0282d93c8bccb 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -55,11 +55,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
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


