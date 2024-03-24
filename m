Return-Path: <linux-kernel+bounces-114216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF2888931
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E1B22E17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97198251995;
	Sun, 24 Mar 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeciWO1O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E732092EB;
	Sun, 24 Mar 2024 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321557; cv=none; b=lHJhad2wFGLU5NtCGlkVSlHN0PTneOphDytVfHa2q8HJXSe/fo9MYiL0jJLRwjEjCzYKJIIvoZlondrm0cGQAfdBM26YwlCDipERfy5JS0+676hlCumIQ1YYcMqyMRILqWQ9sVDxPdMSTBNn+uiuPU+fHcA4f1QyR8dd6gyFo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321557; c=relaxed/simple;
	bh=0ZbiRjqbqQPMs4lhJ5vHIlkejiYFnKo63dXZozmQ290=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7rA52M986rZxALPKrg4YXyqhDbukyeusbOI20tpmeM+gxuyGxMEmBlnK6s7sGBUW9h+FVYLTDUnyjgCGsjyMTZdrvS7fIcH9Lf8kZBKPmX0H2rDrgjrBg/vDf5gCjrUrkNf2pUdcymIUL4LLUzsDYIKvr4TESo/Kb9vcBVefK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeciWO1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B767C433F1;
	Sun, 24 Mar 2024 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321555;
	bh=0ZbiRjqbqQPMs4lhJ5vHIlkejiYFnKo63dXZozmQ290=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeciWO1Oum1BSIQAKgXYPeZBjZGiw+tmPFMJ1nW2jS/KHSHH+t2O0z1EzqBTmqPin
	 KSAXPffctZU+ldXfDBoJ/leM62mdTsHivW3UXviQY6i0KJtKhm1Wd7lEWsmaokIFk6
	 sCjz+YL28k3A+04qO3afIM7kzILCZLVDYsbNkSocRGjwWnpgNuAw/b70PauXXVtZ+N
	 HChC+KdB0AjUQYosvAUoinLz/SYHN8DC453DAS9zu/HmBa+0jmt1M3IsoQgIhNAcdV
	 CnwFQw/ywMLk2VWFUi9rhshk6nGHnzslkAPa8cN6rUgiW8BOEXl/SoFjKZNQGgTOkA
	 1jxRS/54vRxgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 284/638] SUNRPC: fix a memleak in gss_import_v2_context
Date: Sun, 24 Mar 2024 18:55:21 -0400
Message-ID: <20240324230116.1348576-285-sashal@kernel.org>
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
index e31cfdf7eadcb..f6fc80e1d658b 100644
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


