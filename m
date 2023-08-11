Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983FF779024
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjHKNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjHKNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174D270C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe44955decso2283680e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759057; x=1692363857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2gqpaEPctpbBWhVHiUrRTuW6FgZPxJ4z9NtL8e2FcE=;
        b=o68STLi5YnClwGi+FDrzztvPnSVtmYLtQ6pgwaetu1EcDSKzwB4vLEwSSX3YFyjjFE
         Tv3ZpaVufpWLT739uwyG2VgowVcY5KB7lb+64AQkr0A+jP/l8mbrP3b6XC7TwDf6GWUC
         Us89j4+BduJPIdQfABPXLfdIVYexEWecDlZ8X6z1JkDu+WXeIzBBxKrDmjFitW6Aj3n1
         HY/LgTMKxy5Mu9shKr6nz79zS6SgLd6Ff6P8TGKaoSyA2dngSCbHheEO7j/eJ/z0yvLb
         eCi4V0s/cvrSGQEcTEGYDqG5L2Svv/GXQq3YyQW7MFotI7F0uOlLtaK8NjXA9fbvSN6i
         FTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759057; x=1692363857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2gqpaEPctpbBWhVHiUrRTuW6FgZPxJ4z9NtL8e2FcE=;
        b=KasqsenVCqVvA7IYFhq36KZ/jFYIPEl708gjnC/gdFeiFlB5Vj1JrImAiqzKfi42k/
         dhxpOpfQZgXFh03vp4ZVacKutwZhM6/rK/i0JfvtIBDsM2wbzDPPEdpAf87RUpmjOR3r
         G0dQ7ZKlU38WGlRBYC4/9m2tB0Dg8B0gj2OQ999gp0eo8B1k6YCgp+3mlzX3FkYjrCIY
         IesWxJLayyPmII6SZXUD0z1ZZ5kaYHVFjqtsFky4jRldDgiq4ZEfuVHv5VjOjcmW7qpf
         //ngWIC9AZzcZSpAr7aid3ItnZj5CPoPBKbXQXfYhCOujT04ff0R8W74Rl9bJ+0zDPXZ
         VATg==
X-Gm-Message-State: AOJu0YzOcfmGFlawKTyspbB9SGlRzzzuOvTq7HXvWooDrnBkpzoOvS+y
        QLJsJ353pkkngU7Zdfk1xWuPIiDE7BxJgUh039M=
X-Google-Smtp-Source: AGHT+IGlHLki2wPRwNC0S1hcBJlL7LSMUZmB189Jk8dxCiyyzdByiDBO8oYZN2QpBg6KmHMgMIXl1Q==
X-Received: by 2002:a05:6512:3192:b0:4fe:8be:6065 with SMTP id i18-20020a056512319200b004fe08be6065mr888268lfe.5.1691759057244;
        Fri, 11 Aug 2023 06:04:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:09 +0200
Subject: [PATCH 02/11] interconnect: qcom: sc7180: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-2-a85b6e94f46d@linaro.org>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
In-Reply-To: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=752;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FoXftCPZOnzoFkkp8/g7uY07NVaDU78+4cdDrOJ/6So=;
 b=7uA72fqFsQLe4C4tlsc/TLIQQ9+YX3kz/nyuqNuBBnp7B2KxBsCjz+gPhrcZhPcSzTnvUDPGS
 mQlRRZ/twc9BzJLoZtthkAgUZGrcAOWNJUbtZmueLHUKg4rqEKO1Q6X
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

Fixes: 2d1f95ab9feb ("interconnect: qcom: Add SC7180 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index d94ab9b39f3d..013b6840d59d 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1238,6 +1238,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

