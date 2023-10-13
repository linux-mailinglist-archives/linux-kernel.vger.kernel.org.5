Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EC7C858D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjJMMUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJMMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:20:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA6BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405497850dbso21111395e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199622; x=1697804422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9maBdCKwzsg+Tw6rLdAkiCV8ObC+49aKfX4G+YkoatQ=;
        b=BEFsVMmIwRvJHAbyZNvDMDxdm/DwW4OQ7fypRWFHG9ojfoo2ugG4PXWyJ86aAAXD0G
         5Za72ZTNhZEQ+ZSCOSy0AWNowrKWTDZ8YjO1keoAdqYafKru/3VgYQrjNXHTVHHF5QDg
         EDahkviDjW5aoRpBWp68dMKGFjZzK4QAzrhlZcTV8nj46SqP/f3bZm4nWNN9yDFkTvMk
         XauohuxUBCdyA4DhPYA/IH2IikeyB0URa5OGxLZ++RxwvRWj24qLLFimTLsJ/Y+0bMEd
         bD/isGboBydNPagAkQP9bggAYyR1s9A7atlUUlntS86ZyQe5SB5Dt2IFhYteMuQJV4h0
         QztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199622; x=1697804422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9maBdCKwzsg+Tw6rLdAkiCV8ObC+49aKfX4G+YkoatQ=;
        b=dTRS8DWUtI3d/kpRLT5uJGRHwOB8ERLpSCapGkKEDM4PH3BmkgdaMdDLKUEEXKyK3O
         IFlGX+0Crwqj+xwBisljk6mwDgI0BnxmqjwdVkylJE9Lswc8AhSL85Jcjep6tfcZuOWD
         FZT7YUytvtog8y/9ODjo8D6Zgm2eiCepqInec3vXmbZKS65vRItqzWub7NiAqLzp78v8
         TlUluHNEShBNVZqCNQMv+WQPuM65JQ6qnx6czDc7v75vH5UypiTGkG6vBRUUKD3chNYJ
         j2eAE/fouo1GL8ViiVPIWGtoqiU7+iSjqNCvSykWgTq4xIljZ/W6B5NXk3ikdyS0LJNf
         L07w==
X-Gm-Message-State: AOJu0YwJF5v8qJtmeYtxYBp+L5HV6+mrqNwNjglkV/Pbc1rQ4fOzaqA+
        WaK9DsYhGTC+0wdnnZ+6yFK58Q==
X-Google-Smtp-Source: AGHT+IHbhu7Nxnf3Y55I9uxsGYZNnv5SinfVhL+e5F7LXcFujjXl6AH71X1+bA+w+I8mfT6eofVzLA==
X-Received: by 2002:a05:600c:3652:b0:3fb:a0fc:1ba1 with SMTP id y18-20020a05600c365200b003fba0fc1ba1mr25171661wmq.35.1697199622323;
        Fri, 13 Oct 2023 05:20:22 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b0040772934b12sm1806751wms.7.2023.10.13.05.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:20:21 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] misc: fastrpc: Free DMA handles for RPC calls with no arguments
Date:   Fri, 13 Oct 2023 13:20:05 +0100
Message-Id: <20231013122007.174464-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
References: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=yd97s/oOAaEGvMi6NJfTTxpJrr9MoheU7y7jr4w7r40=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTX3LLljk1Rqm0luEZuerO0osYjjQnjtc5T/l VVk06mpCA+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk19wAKCRB6of1ZxzRV NycsB/46GpsdDKbvvrvpiTY4vbx40oMgV4igrx7GCLJXgtgOfSS6CNWqOWq7U5B6mtKqDkzPwk7 vs6eEK/HWz3ChrLhqkarWT0CFfUV3zPxt/VeSpupZuHkN49gbAj5i5xULjuB9R3q0Ka7RsY76V9 3VDxrbakb47yC1gzfBE4uWNnRsdlaTkgWxdYhy29NTpxkThgigDaoLiTBu4KdohjiDnufMIT/Zk o8kiAVxsqVTnXQw4f18WJslSDSsKAoA9lWJMBxwGnt790yesWEtfvAMXBnS+41eydsHAudPW5Vw NNIXvaC162vaz4Ih0GpfWYLF6S3bCgzlhBmUViLF10c528wn
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

The FDs for DMA handles to be freed is updated in fdlist by DSP over
a remote call. This holds true even for remote calls with no
arguments. To handle this, get_args and put_args are needed to
be called for remote calls with no arguments also as fdlist
is allocated in get_args and FDs updated in fdlist is freed
in put_args.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fb921975b56d..a52701c1b018 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1091,6 +1091,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 		}
 	}
 
+	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
@@ -1157,11 +1158,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (ctx->nscalars) {
-		err = fastrpc_get_args(kernel, ctx);
-		if (err)
-			goto bail;
-	}
+	err = fastrpc_get_args(kernel, ctx);
+	if (err)
+		goto bail;
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
@@ -1185,14 +1184,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (ctx->nscalars) {
-		/* make sure that all memory writes by DSP are seen by CPU */
-		dma_rmb();
-		/* populate all the output buffers with results */
-		err = fastrpc_put_args(ctx, kernel);
-		if (err)
-			goto bail;
-	}
+	/* make sure that all memory writes by DSP are seen by CPU */
+	dma_rmb();
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
+	if (err)
+		goto bail;
 
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
-- 
2.25.1

