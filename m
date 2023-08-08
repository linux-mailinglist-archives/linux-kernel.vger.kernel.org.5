Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04613774535
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHHSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjHHSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:38:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FCB117A35
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:48:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so49669405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513294; x=1692118094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=p1cM9EcjvVVgWJq2lQuzwDZDGsqB+brrTMqGChh+6ULWo8smSHu/aHPcxrJFHlynB8
         075KnC7+IV5BhoZ3K2858NWyltQFJqxjNyEaXL7JfeGJ46KszRfY5elDAjhG5T3L5TId
         qMQjHvnrYHcxSs0YEyB1FHKA/2VZTuxAUxa6t9TxL5x5D+ApbmUAhDHvB2bdwThiRXIG
         lNZL8QkaEEdIuhY2OO1E9uuytLF+X/001zpqDgu9DNsX0dvfNRc/P4fayr+zXRr2gZ8y
         GLRhcPgYiKPbCIqKIV1fU2p48rx/WoCBQOScEWoCzY+sdHn0EXm4gdmQHgYLLWnZ1uB3
         B7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513294; x=1692118094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=DXH0HO5yeMG1GZazRNzkGONGzeSesSMEyo9D3y/esfbLFoAmSfgTF1H8pciT5NeGpY
         CDXmNe3a77lQrCRnVz80GmrnkFmmtAQuHTtlyNMeLJpPD+N66ULYYXGcSKD4VbZzGfqT
         o8KLjfae85DyrXTG6bzbZ+iHVOSagYv44YSmxHmaFap0PLgwfmuInB8NBVuPfyVFpisQ
         g/uwjNh+bFjct4CrURR594PaeOgKws0dlmr/MJufk7+5bhXkQ7O89ji8ohjjEE7hO/Jo
         KW/TFv6veu41aKcFsmbt19L94wQOeusiQS/y8CXaUR2IGUYUSb65ztp22bkc+4Z+yyNB
         7nWA==
X-Gm-Message-State: AOJu0YxzFHkySsKx+SsIWO3rxBBxG8xQP+5KWfUqlARtPxhGFMSAp7YK
        UNZoSNsQbS5lSxVIsAwGAzXkUoqSD7USSQKdJb8=
X-Google-Smtp-Source: AGHT+IHZdXCtug2ljX6dDSj6oQkG8V1UJLNKTYOKnSjmV42sR9+Wv2CCmrrKVl5VAmfJlHe6DhBOLg==
X-Received: by 2002:a05:6512:2018:b0:4fd:c771:ed86 with SMTP id a24-20020a056512201800b004fdc771ed86mr6615303lfb.67.1691487895251;
        Tue, 08 Aug 2023 02:44:55 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 11:44:44 +0200
Subject: [PATCH v2 4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on
 some branch clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-4-34273e275c51@linaro.org>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1407;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=haDOFYx+cWB8WYF0AFsxGiNUFhwDHpLSQyDe+vgkap0=;
 b=ZrMZ0b0kru/BioU+kcPyTGDosiv5UYR3dvjZ97R7NYb1CKIWbtfb6OQL9uoCg1eDGTN2RtwgC
 KnIylLEWD68BzoXZqSp7GXw9MgJJMQxVOqARg8YLk04oG4zFHl8Kfq8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

