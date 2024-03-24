Return-Path: <linux-kernel+bounces-113171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1466888206
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CD11F21A3D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAD175561;
	Sun, 24 Mar 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUmSTNkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF52175546;
	Sun, 24 Mar 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319973; cv=none; b=KxvAjEJkhZVMsSHlj7ScUbWJzB75/d0Kg1A7kM4hFfZ+WbemCBzbE9/xcU5mwGE2PC+KlYN7ejQmRKEbKPtGsEI2h7q2xilGTxW7dY+VvZEm5KA1wHdE1Yioo+27cMGHcz+GRJE4dPlineueAIr/uGaPvKPt1fEyuez8jkw1QKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319973; c=relaxed/simple;
	bh=dxYv9j9I1vk7dVkAyDPF9nCoByCOZRCBcJTWm36K76w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvVWW6EOdM6XhUQnFP1DeuNlATLsjAQmZ0PQPncYLPLnmpRe8oA8o5ZOzt+C90Xojv2hcbEGI5nXBR2iJOUUAXbnIlOmBs4VV9Ap+IX2Ej5mertIItZXVQYq3ebg67UFdOYTwk+3FiW7xXAxGiIKTmgaOSCSXALGlcp9gEZ22Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUmSTNkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF89C433B1;
	Sun, 24 Mar 2024 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319973;
	bh=dxYv9j9I1vk7dVkAyDPF9nCoByCOZRCBcJTWm36K76w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUmSTNkv5wQEcHW+BknOv+IyzOdwXQa8Eo+pIyMVvOZ6T5CGqmuE9PqCELQGygC7d
	 kAwze90mgVx+kwXulx1JsM6LodT7fsXlraFmiDxJhdlxN9DKtnPgioBYVAReQotFX7
	 oA8bkfUdHERD4CiMZ0VJPp0oTdLAP9+aT3LK+b3dBF74eLPLa2bJeiTFdPfLNoXKUN
	 pYjaUG//oNFbJWzHlgFAx0Zr51XWe0GJ2qX3Xat5J6L1lLKpul5B5fU1Eb4x+PkLaX
	 vIX7NsFjuEpPnvqml3tL+3TUM0NbQNGqTfk2g2QdchJLPbALd9rc3j7rUj6qky3cr7
	 cGjug4xhE7axw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 280/715] SUNRPC: fix a memleak in gss_import_v2_context
Date: Sun, 24 Mar 2024 18:27:39 -0400
Message-ID: <20240324223455.1342824-281-sashal@kernel.org>
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

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit e67b652d8e8591d3b1e569dbcdfcee15993e91fa ]

The ctx->mech_used.data allocated by kmemdup is not freed in neither
gss_import_v2_context nor it only caller gss_krb5_import_sec_context,
which frees ctx on error.

Thus, this patch reform the last call of gss_import_v2_context to the
gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
formation.

Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 64cff717c3d9b..3366505bc669a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	u64 seq_send64;
 	int keylen;
 	u32 time32;
+	int ret;
 
 	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
 	if (IS_ERR(p))
@@ -450,8 +451,16 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	}
 	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
 
-	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	if (ret) {
+		p = ERR_PTR(ret);
+		goto out_free;
+	}
 
+	return 0;
+
+out_free:
+	kfree(ctx->mech_used.data);
 out_err:
 	return PTR_ERR(p);
 }
-- 
2.43.0


