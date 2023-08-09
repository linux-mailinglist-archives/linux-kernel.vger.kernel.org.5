Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A74776887
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjHITVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjHITV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:21:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CC2127
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:21:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so2585991fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608841; x=1692213641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=VzyIj7kpmL0GI4+H4dQgi+UkUqLL/c7AY4Rxja5tdpF915CELH4iPRezqR4JDiLnJh
         hYWiJDYoMzzJV5MOSC8CjjSlzrYOHQ10ohlzh1bPxmj1pr+/0siODEQNxkxj8Yh9A15S
         zI/qS1L0OWycrmB7G1C/yp5U3na9yIXRmmtuRliwEkSdu6YiQewsJJXy6uF7YPyjbuSp
         yBKQ+5U3WetAiIi2o4FlPGztZERZdbxrFevAtYlQ7nZclkZyC3NgxUPVi2x2kQyOfnnJ
         /9NEypY0RwWjU0nhuHENuUW3M2BNeFJ+Ce+M5dutJ5CYEMVFUVzkHqcp1d3icMk49mwb
         AQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608841; x=1692213641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=hERzL6XKC6NruaZTlj//pVCbgtb5Zy7XCUDCttIhKm4HiOfqKz7zTRgw/VjAkuM498
         G/uHUCSgx2ooChBEcfEwqRRZwsWNxZqPDMQ6pqJSYvYKCkdQ7Rvx7dAyG/vOKIT2yqOb
         YgFYWBSEYpnntAW7kfO+++4TJNaaOWT3N4jmSY/RZzv9gm0bHVaEDXJGrrVuXXA3+sJs
         RkedLjvWuk7WztMclL9HDZtRGH0mb574v+GIKKezqwI4Hidp9yXpqjIq9fQ1vH0JDGAy
         gMdWOxp0gKaqZBeQunSOoVbCBK8jWbKPb0VsShQv6JTdbswrx9Pvoea2eKjFgLgm0x+8
         JJBA==
X-Gm-Message-State: AOJu0YzFbX1xE9SsMigprceCvjUdW6bk8snTEcil6hdZQCTDApycYSjc
        uwOdEP7Y9k2hKDuuZ4p0pm8RjIyNecK+slb98uA=
X-Google-Smtp-Source: AGHT+IHkKP1lMchPzHbm+j7W1NCjA5ROEnb+i2koQY3n9dklYzTIduqy4k3ASK3zu6ne7YURGmApPg==
X-Received: by 2002:a2e:9c50:0:b0:2b9:5695:d10d with SMTP id t16-20020a2e9c50000000b002b95695d10dmr82394ljj.36.1691608841249;
        Wed, 09 Aug 2023 12:20:41 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 21:20:27 +0200
Subject: [PATCH v3 4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on
 some branch clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-4-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=1407;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=haDOFYx+cWB8WYF0AFsxGiNUFhwDHpLSQyDe+vgkap0=;
 b=ivHa7Psm9IKmZjT3K/fiYAso4o3IjbutXh3aiP/PX5cuAobhTzT3jwBqR6ntC92H28DCKPHah
 56lr1ds08k8Cbcneb+IbXt/B0FrSWryIzQYDSVIg30b+uHh5Nmoezjz
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

Some branch clocks are governed externally and we're only supposed to
send a request concerning their shutdown, not actually ensure it happens.

Use the BRANCH_HALT_SKIP define to skip checking the halt bit.

Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index c62aa270af1c..d0a5440e2291 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2452,6 +2452,7 @@ static struct clk_branch fd_ahb_clk = {
 
 static struct clk_branch mnoc_ahb_clk = {
 	.halt_reg = 0x5024,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x5024,
 		.enable_mask = BIT(0),
@@ -2467,6 +2468,7 @@ static struct clk_branch mnoc_ahb_clk = {
 
 static struct clk_branch bimc_smmu_ahb_clk = {
 	.halt_reg = 0xe004,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe004,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -2484,6 +2486,7 @@ static struct clk_branch bimc_smmu_ahb_clk = {
 
 static struct clk_branch bimc_smmu_axi_clk = {
 	.halt_reg = 0xe008,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe008,
 	.hwcg_bit = 1,
 	.clkr = {

-- 
2.41.0

