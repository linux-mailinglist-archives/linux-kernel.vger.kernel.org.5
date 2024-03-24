Return-Path: <linux-kernel+bounces-115661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CF889466
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D601C2F26B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E515AAA7;
	Mon, 25 Mar 2024 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeAHk9uX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE92092EE;
	Sun, 24 Mar 2024 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321557; cv=none; b=cBpaVTClWsErmq7/idoffB8T1veJN1zWIvBpjqWVVbk5shScNwSv4ev3oYNi7zk4lO5Nlc699nWlhmmFHxfizIw8aww86VLjDLesko2NDcLeHHAEFs6AQ4LlgJi1zoNntEh/s3mt3/ANsxDmgvQrrnxaTpdbwFnS9D3ynmt+TrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321557; c=relaxed/simple;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJQHPjCWgGBeWRWxjbSE+KYkrwWIf7FQyZxVdFX1DGSM8JGWedLOwft3Yqpsn1w6BGFW+S26NXq/yToD8hEw1AhHraA4qCu2uq0fOLdfIEppVAuPoUZNB1l53wGyXhLLDDQoR3ohwsvl2bAyywkr4Oy6r9UAIX8dF68YnGxA8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeAHk9uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26800C433A6;
	Sun, 24 Mar 2024 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321556;
	bh=uRoRsaHWAWpKpAmF0MLAb2S1bcEcuSVKZ2mxImqiWlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeAHk9uXBRqPWZiVYjbMszM73CE1ASiTeQ68CD9WNqC3F4+Xy1eSFZMojhXvWkybc
	 CLxpB4VZRp2DBZ18+Ci/SY7thMBXA2rwaeWyGoSTHopTBDd0saVrFVqOMCyPPVUBFx
	 ADBMRF+5bA6PWikMse1gwD8PyyOI1CU61ziskfeZUy+ikimaHEAJ+JVZnEMBv4JAju
	 tHVW4AUs1QlT41moPQAx9IyIipKsxW67piN2iI7ebq4EiodxYEU2TSMBeNTr75T98x
	 UzbUDpqwRCyIHMvkCZ7wGCtiY/j/XPaKPKpp1ZTk/JcbjqXrY/sMMkuvDd1Fw4Pg5l
	 IMvG5mil9dlfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 285/638] SUNRPC: fix some memleaks in gssx_dec_option_array
Date: Sun, 24 Mar 2024 18:55:22 -0400
Message-ID: <20240324230116.1348576-286-sashal@kernel.org>
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


