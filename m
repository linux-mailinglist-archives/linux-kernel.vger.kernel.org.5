Return-Path: <linux-kernel+bounces-113469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476E888493
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556A11C23ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C1B3A39;
	Sun, 24 Mar 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n68QrK2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD47175B;
	Sun, 24 Mar 2024 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320270; cv=none; b=JtGlrEL6/MQNLgnBMWhJIiQhampPRXfsIiZ8ivzSle1hN2OTQ7didyRVwcHYOhPYb3rQR7pGYuKQ/uLuDVoGszY5vz8R/WLXr7824HcPT7I128CgrSZOjPmxDD7Rl4M9NNdzsp05fpWxMMIxFq1YVz1mi7EKu1Gl6qTjOGAMdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320270; c=relaxed/simple;
	bh=g1ekMzSm4txgtotmTsA3S1y1NJqyvLL1l8D4Mk/0VZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFkPJrT3vaPrJMBjBq8DaIAB3g00mW1yU5SPgeIm10DKbHgsEgTS23KgtsxDFP4o052KhOCythtDl2dqA4oRSavRR8deZWQ1EdXSpTknc6M4Tuxs6wYx9T5jihlkeRgZtQAONscKj7/Jg4F2gNCYcdlIumQ6pJezU4rMSDHpNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n68QrK2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A56C43390;
	Sun, 24 Mar 2024 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320270;
	bh=g1ekMzSm4txgtotmTsA3S1y1NJqyvLL1l8D4Mk/0VZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n68QrK2doKmdWq4Rm+Q2xb0VJyeQJu3gHJF5CKXhhqdTMRgCUhYj6INVmb6YXgqxs
	 RVN9YDnOFp8qxMiraMTsvw9kDVLmkma+Fxje6UQM1GwtXR1NjKqs5BcWBAFB0tI9eF
	 iIviCTFVvMnh5s/vkFjLKENcfazcZUSt8DPA15ajPDjRs4OX0kW+/K+M1BpCAgoclU
	 8/mYYKQdSyskBim+v1IhXcjlyw/hJoHrmAiyY+drd8Lfmd7DUJzIJ6PE/nioBbqveK
	 DVNHAgFc8zabGzTXDOQA5bSrDiEc3s9rKj/tfYu/VT8jtEu+L+N9iXC8wyUtv4P7Dp
	 Tf89KUuMOQ09A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jorge Mora <jmora1300@gmail.com>,
	Jorge Mora <mora@netapp.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 578/715] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Sun, 24 Mar 2024 18:32:37 -0400
Message-ID: <20240324223455.1342824-579-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


