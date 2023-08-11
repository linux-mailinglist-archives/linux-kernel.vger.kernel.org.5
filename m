Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CB779B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjHKXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjHKXVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:21:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA51BFD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so37036021fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796059; x=1692400859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV2ppUbirWtPHw5hlnV07fud9hr2V8DYXLWFwecoAvU=;
        b=ak2coThTY6G5nEvwr2WyyyQvAzlOGYui7oxfWySoxm2hqOQ3g6Ug0BWrHxcMTo0AZB
         WuFIUCrLaWmDi0IiX7a2HfmwolT5t87V3ajAUtUNMaM3yZvAC4xn4aGxIH3SZ2hDWdj9
         dMbTim6MBxGpZeN69ayozHv+8wUlVUjrtyOCDZc5LfTuecKH7Ft4/H9wg7kejpgXBXBq
         DRijyzuWwmQ7cB8kplLXd2Jx4oC5XDzHgcYghLHxjE1lKXnKEcNG7uiOhs7WECot0rk0
         7Fz0sjFT0b0dCaUaJ6zXnnSU3X/n8VkZvXUP3pmex1zSu6CSZSVxj9YfExuce0/vVSHh
         3BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796059; x=1692400859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV2ppUbirWtPHw5hlnV07fud9hr2V8DYXLWFwecoAvU=;
        b=MuLiUa2jQrjLnTy3d8ODYOtKngoaXAk0y9JKkYR7+q4SuuGC7ymAooG5uxKBXolKEr
         flU7FXn4YcXBNH8jWHmYbDVl1GMHnrtxYwdAfn6r3ZxANAUu/oLvqE6/HdrTigyYr7Ub
         9G4Rrk5VX6mEb2q76GEFt1YCW35faOp5mTAIE5tKgxUa90S3gETHwab7z9Z5A4Dec0wx
         tyFazM3ondEzRdFU1YOUiVMy6gYCeuzp/bysyEfudVIm/k8nUAHgtDhxZ4vxjyj8ji+w
         m4NDaGiwHkCzFIkmj9oqLTJu3gLs0aXUEopRm1FrFxP4kzgDVUbAwVOvt2jQXw7sirPZ
         l9xQ==
X-Gm-Message-State: AOJu0YypvHNaNBBFjSuMd5eH3MuCIbJlDqOIJ6IEYm6aYJ5nF9QpNtu1
        pTkjMFD1Tf3Isjek1OKyUTpgnQ==
X-Google-Smtp-Source: AGHT+IHgb4vee5QUpd7XjXOvjgYX3xTkQDMxswF+dy3tY89NudE7L54jK1imddks9CRE7kWABk3jpg==
X-Received: by 2002:a2e:b61a:0:b0:2b7:11f8:27d with SMTP id r26-20020a2eb61a000000b002b711f8027dmr2562870ljn.7.1691796059292;
        Fri, 11 Aug 2023 16:20:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:50 +0200
Subject: [PATCH v2 07/11] interconnect: qcom: sdm845: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-7-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=746;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FnOUFC0TXeUdyRrITi9pFZTIzYpWLpJ9cgmI0mdR7Og=;
 b=XFLza56JxQCyn+o42KxA+HMcq6OIqkVL38ZVcCBxG9J0T9zDF1EwwfVJDCVa0Qafq6sTnAJu6
 p5Ot0RCikW5AprEoSp+tHdiaDmJbN0c7nHjndFEfs4zR58iRXz4JZkN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index b9243c0aa626..855802be93fe 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1265,6 +1265,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

