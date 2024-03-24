Return-Path: <linux-kernel+bounces-116034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6888957A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DE61F308A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4126FA73;
	Mon, 25 Mar 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZBjBabh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8252779ED;
	Sun, 24 Mar 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323419; cv=none; b=WfeE86B0d5Vjz3RlJRZjZzoLr9T2w2g4gWYoOUw1GylLs0S7snZAZ3Np0WNgdfz43zFzKxDaKGJYMP+MpeWDSjSpiTn+bLUfu1QElw4MnZJBeaOlk+KIwDhUuq26zdl+A7nOTaPF/vZJZbtabg26eN5OBbLkJ6S8SWoJuWNlvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323419; c=relaxed/simple;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h87grDXm4JzqICtSrPhUuNfAvVvHbqE//FVMyXqJQ0taZynBp2Ei0q/wKfrmxkth3PJTvS4XIZlEfdiX7eOWxFJagchpiOfxsgx55+OsLExfRuYQxCZKFOr9rH2hI6lluYWfXtQk4pkC2LwM/0Cf3jesW7H9bsz5vt+LglFltZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZBjBabh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF80C433C7;
	Sun, 24 Mar 2024 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323419;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZBjBabhU1fCUD8SC/UJ4AwxavU5Z+EeUOovSjqjuAEr3iLJ6KxJckob1IX4IIpLQ
	 5LFbAJXp+LSZhm0WfFEAUEs8tCmnvr5eQxkCTFopzukODRkX9RLpkdgvFP3AJDKaUJ
	 O+5+qvtfH7ztiW785V9djzKidf+TDpLEUzUX4s+QtkxdcCJeBdil4niQeS9ksn4oIN
	 SZLEaEHpWr/Q55vbFuIM1cWbGRaUNkX1E+KNDIztwY7IdRRW28ST78hw9o3d/bSyzG
	 Xu4XvcTHx9t05rT2TGudEl1QKcuCyddJo69DLeBm8DW14SZmGgC7RbLZD2LpbRhBCv
	 NP8i5St8D9c4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 121/317] SUNRPC: fix some memleaks in gssx_dec_option_array
Date: Sun, 24 Mar 2024 19:31:41 -0400
Message-ID: <20240324233458.1352854-122-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 3cfcfc102a5e57b021b786a755a38935e357797d ]

The creds and oa->data need to be freed in the error-handling paths after
their allocation. So this patch add these deallocations in the
corresponding paths.

Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index d79f12c2550ac..cb32ab9a83952 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -250,8 +250,8 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
 	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
 	if (!creds) {
-		kfree(oa->data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_oa;
 	}
 
 	oa->data[0].option.data = CREDS_VALUE;
@@ -265,29 +265,40 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
 		/* option buffer */
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			return -ENOSPC;
+		if (unlikely(p == NULL)) {
+			err = -ENOSPC;
+			goto free_creds;
+		}
 
 		length = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, length);
-		if (unlikely(p == NULL))
-			return -ENOSPC;
+		if (unlikely(p == NULL)) {
+			err = -ENOSPC;
+			goto free_creds;
+		}
 
 		if (length == sizeof(CREDS_VALUE) &&
 		    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
 			/* We have creds here. parse them */
 			err = gssx_dec_linux_creds(xdr, creds);
 			if (err)
-				return err;
+				goto free_creds;
 			oa->data[0].value.len = 1; /* presence */
 		} else {
 			/* consume uninteresting buffer */
 			err = gssx_dec_buffer(xdr, &dummy);
 			if (err)
-				return err;
+				goto free_creds;
 		}
 	}
 	return 0;
+
+free_creds:
+	kfree(creds);
+free_oa:
+	kfree(oa->data);
+	oa->data = NULL;
+	return err;
 }
 
 static int gssx_dec_status(struct xdr_stream *xdr,
-- 
2.43.0


