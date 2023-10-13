Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1F7C858C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjJMMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjJMMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:20:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767FA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso20835855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199621; x=1697804421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiIL1G6bCBYYSUmLIMeOuFSL+jkm0ieM2MaGuJYDdP4=;
        b=UbzrCa4uWotcVVOxHsyQ6xG7iSoVxcmNrVbzYaaK/iji1IhTmdWLN5/AEplTGgeOYy
         XET9g1u1QLcZSqpcFlTYyeUvMddXHWg4F1yoAw7FH4FsnPBTbgxgyZ+jhJawYEuDwO/f
         G1GtPZNJBEKhdz0eRdkmBlQ3GvbIRvvsXK+U+saNTnkjcE3pYnM8bjEmuQYExgUObrho
         lvJIbVE7U92ZQaStwnagllYGFRq+Zac/GCkmrefbDAgJUPI7TR4H44YD2tvnuZvxwNTq
         0TFGbava8tgJIRLoVcBL5AswzCnjaHPMwoyLi6If5XXdZmJVd3lEEvsQbcngrZNXLcDL
         cqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199621; x=1697804421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiIL1G6bCBYYSUmLIMeOuFSL+jkm0ieM2MaGuJYDdP4=;
        b=EaC3pQZEnWELeiGOvMJg8eeT2jwRqyf54QQMLSq6/9y7xy850QqAGlGHrDl3dOGJS9
         NK0wS4sGGmWsRbKxKfA6AIl8DwsX3APKd205lH5wziWYtzTAL2FBTShpg9BaOHfubGYo
         gvC/KfiBjSPq0lA2MwBih8LOL1XQ6D7fcvZ5nPBILxOylZvfT71wxB10gulZ0SH51xOj
         69fIMcvGaPOHz/9xGYHVALuRCmoZrh0B8ZOX+XngCixhNP2rWCMX1yUcPm5X4Po9DTMK
         3mWeXk/qQAQJiNd71A+67JhzH0HoiN/LPpkBzwY+C8tTNiDIODXx0gK6rUxeSQ7b1Vb1
         hBZw==
X-Gm-Message-State: AOJu0Yx/OMNo4XemzGbpFcWPFYSiZe5KVMMqqqldaJVhiin2kkVQP9cs
        W3KOg31NNZYvb3nFuBrQDlP6dw==
X-Google-Smtp-Source: AGHT+IEgyDgb676i06I00jxxGCn5xBZM3lEX//EpitjZq22dHFoGDOmJP0jLEwSMDaZAs13pnZqBWQ==
X-Received: by 2002:a1c:7711:0:b0:405:959e:dc7c with SMTP id t17-20020a1c7711000000b00405959edc7cmr23674425wmi.30.1697199621165;
        Fri, 13 Oct 2023 05:20:21 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b0040772934b12sm1806751wms.7.2023.10.13.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:20:20 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] misc: fastrpc: Reset metadata buffer to avoid incorrect free
Date:   Fri, 13 Oct 2023 13:20:04 +0100
Message-Id: <20231013122007.174464-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
References: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nJ/oryflpci9PJcvqUQBAXxU2BVP7k1zJ7Aal1R8mSE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTX3iRAaMZ60lsLn0tsq6vc/LFoauUQ1ehboD xjtxW0r4TOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk19wAKCRB6of1ZxzRV NxGtCAC7/tomZz8lvSY1M/90T2UueEJFViy+O7F8wEvTZXvJUJwBOZnJ52PAXlwkxakbvF7CVOE m4BhmTM9aE75NpZcjRUcZeELy1tq85z1dzLx6w7U9BPrxoewjAoDQcOOzS67H/hF6F2fYhQN+ZZ M1B9EkkgQUkK3LtY2dPFf2AHYbZGwpaK1vzTCxKE87JiTo/gJy4EMsK9rnah7DsD74SkBewVahD xfnnBLfSkKA64BeZLG6mG9vzLbok7spDPSAKClDUz4cxstZqsYSuSER4+MaEF1zuto2MGqwtj9S Vg/t0XMEeiKxosLMv1wlkfLJ9Fi1uZs83Q8Od3Gr2eNgSq1w
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

Metadata buffer is allocated during get_args for any remote call.
This buffer carries buffers, fdlists and other payload information
for the call. If the buffer is not reset, put_args might find some
garbage FDs in the fdlist which might have an existing mapping in
the list. This could result in improper freeing of FD map when DSP
might still be using the buffer. Added change to reset the metadata
buffer after allocation.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a66b7c111cd5..fb921975b56d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -958,6 +958,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	if (err)
 		return err;
 
+	memset(ctx->buf->virt, 0, pkt_size);
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
-- 
2.25.1

