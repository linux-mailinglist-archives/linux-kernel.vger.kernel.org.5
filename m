Return-Path: <linux-kernel+bounces-115196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29596888E96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF5CB2B05F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90C1CAC60;
	Mon, 25 Mar 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+S0MSJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00763184403;
	Sun, 24 Mar 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324270; cv=none; b=Ccr8rf9NqqIULkK38NsPbwPIDRkQr4kpl7VnYhDwQceZVUlqnJZYyzNteEz4/ofgL4B8trskkjU9sY6idctZp3rTo0Km+hbCgGS6Y1eLos4w7oY03wUu41MArvHcA7wuPfyf3pU3Kl4fKxLrawd/13RotPsJCfbufWasdbzEivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324270; c=relaxed/simple;
	bh=t0dlIHKdQlh5FOxOWMgprE0F0SGdYtgOUdiJq8cKvLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBVNS7XvonIRCrGCLlaoCfiuVyhHF4Rcffsr5w4oqQofN3FuD9ZX5lIPPtyJ9UG1TovWbe+kEVlEkJ2tvWWCGZrQY8SFjhhbGMW0G9JRNEmuaXFGqj5wg2O+ElRiFsgyxSCgRRU9U3+MF1o8w9RIuEs051wi4IP9l/PfqnQvEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+S0MSJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A85AC433C7;
	Sun, 24 Mar 2024 23:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324268;
	bh=t0dlIHKdQlh5FOxOWMgprE0F0SGdYtgOUdiJq8cKvLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+S0MSJQbzShn6+1lhH83E4nepGjkZXnS9yH01EvY/MsrnM+sXqsSiUh8mxXfjZDm
	 tYA2x2OV+xCyeeowKb2X3hN3+r15desgnhUmp5NDKJPk6jXEnJ4bX5x437k4BMsd8S
	 orToadriWLygdJiCIPuY6DVZNvOY3Xg5b4b7wERcw9ZM868fvYtTpzxPh+GPK7YXJB
	 oLIQTwfXVzMAbuicbl+J3jZg/nTL5QEHFU4Jp7DVGoUyxLutXk47OWkeO4zWf07tRl
	 xyLnVkVSKq2i81U7WMgeFkuiY1xnhQI83vnJ1gsXaIOLn7TsfD9krwl3oRU6TDayqC
	 3lLG79Wihy/IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/148] SUNRPC: fix some memleaks in gssx_dec_option_array
Date: Sun, 24 Mar 2024 19:48:32 -0400
Message-ID: <20240324235012.1356413-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 444380f968f11..730a9c4dc9931 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -263,8 +263,8 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
 	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
 	if (!creds) {
-		kfree(oa->data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_oa;
 	}
 
 	oa->data[0].option.data = CREDS_VALUE;
@@ -278,29 +278,40 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
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


