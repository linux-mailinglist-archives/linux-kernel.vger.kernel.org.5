Return-Path: <linux-kernel+bounces-115082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8406888CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161171C2A76D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9A13E3FB;
	Mon, 25 Mar 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDj2Hxi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046E28A5AA;
	Sun, 24 Mar 2024 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324065; cv=none; b=KiR7dsCyU5+cPYeo0wIEo6eE8omtrw+1ka7keyad64ZiGYfM+zyookSCc+QWa1Lvr2v0e8jKoRdN4AqES3cVUaXKIvvNSoikmP83bsOXPlixfUWcXsCKnFo7/UyJyIpiDoz5/iQiNRrhDtna8FbaHSf8zdFiOfBGDVLRPc/J41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324065; c=relaxed/simple;
	bh=+bjCDMRwadsGgRz/Ka4YYjHtGlwmEY4ooDUpXQ3MzME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGrivOLz4zzUf4rbMO2RY4wmvk6mPWBDrz9qA2vpqOIjn1yl65priydHrtJxBTzK0tVaXhMRYCprSXTYwQVW354/gAIfE7Xk7qt4d8sprL630tUfaP+ydbht7E1j9bUToIKouuoyCjqwlFsPp6m+1hwqJ8l2ZK/Kq+QIPKxilhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDj2Hxi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43C3C433F1;
	Sun, 24 Mar 2024 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324064;
	bh=+bjCDMRwadsGgRz/Ka4YYjHtGlwmEY4ooDUpXQ3MzME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDj2Hxi24xQ0G6WEuTaLDaS1Fac/MXoj8y1H6dzaC+alI56H5BtZmofMKb32Yo4Ah
	 AgwVhFupnodrh3wvbIqgqBaoKQlda2MqZTkbLfLG23CtSKUhE+w4W6AopbTeNin6sO
	 Uk9GscYdRbiQHAkHnoAv+f2MgcQLvRwYQfsnUlAtZhjul2FDssXI8zV7veMHXsxXiL
	 MQpm3t+FbNyGMfbMOg2KA/gNHB9H9ZFy8Mnaq41HmZTBKM/S0OhGlSsBaWdVpjoVd5
	 /kurKuy5jX+Uv8fT7XibWAj2n9eEHKPoDvhUsIdVALIK33oOX0xuAB84QmVTvMRnbX
	 VEZWVEOOPD3tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/183] SUNRPC: fix some memleaks in gssx_dec_option_array
Date: Sun, 24 Mar 2024 19:44:38 -0400
Message-ID: <20240324234638.1355609-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 2ff7b7083ebab..e265b8d38aa14 100644
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


