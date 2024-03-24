Return-Path: <linux-kernel+bounces-113761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A294C888E78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E328FD96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF412CDAD;
	Sun, 24 Mar 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrYyZwi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1A1E0E2B;
	Sun, 24 Mar 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320766; cv=none; b=BY/d1pdFxIondiQzWkNeCo19tkolCxiUgGvVCZe9rPRhbQwNMDyumtT1ZpfpsfysgrIXilTbpZv2qTjIu5P3sF//28uhu+yHrAe7L7k5jvYIvWu484lJEHqu9Rsxoh1wWVsEEx1Uu1RfjENcrYviA8N6fKEMJ1bFdpTnFukO75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320766; c=relaxed/simple;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clEuPJdXUejlCtCE527xdLysn/4zdq/asak/sQsv48oEHO3rU5TLg04yqmtRYPkwI0MaavCsiOomBa03JR6GMnn+1Wo9ABVjNYX7ykAMv4DN2tyc0IlAnlndmtAq0Kn2te5H6uUBlf1y5fT1SG4BGe+G0P5XOccWh43O71QY4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrYyZwi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB26C433C7;
	Sun, 24 Mar 2024 22:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320766;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrYyZwi3ppqlPUdYybm/B2WA7tvwx0cFdgLyb86lG1cTfPY2bGBl3vy0TLT9G8uv6
	 4jicFl4Ezmu/D167XJJy0oR1S8T6tc7xx4pljjOOmV5bLn8LIIMcF7mTF6BoZxD2KN
	 W5CDaSAuOlNReJciyvAzqR5wA3Z5WEdrl/gBH3/BiGI2Vgm4ypmLKBPjDnxpXLUTIM
	 Uada+i32ntmvdfqkg1SMG0AhT04E2A5sFmL6M1gnbjJ6RgRymtTweeLywUhBYqme4f
	 9mw/Z2mNTTQIuSuWJhlnwPgvCk8+pEoNUJA2CIK6rAHcpNF2eXZAtWLskzoCchJNG7
	 WVdgM/7gpk9iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 330/713] SUNRPC: fix some memleaks in gssx_dec_option_array
Date: Sun, 24 Mar 2024 18:40:56 -0400
Message-ID: <20240324224720.1345309-331-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


