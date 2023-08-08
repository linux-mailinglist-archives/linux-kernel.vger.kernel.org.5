Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2077495B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjHHTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjHHTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:51:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4016AAE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:59:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0290f0a8so773917766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513952; x=1692118752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=KxN9zn0qcdPsWOBXcEYE7vphYvP4clfks02uQjtxf756V5xr3iZSwToC7ltPI2T0dm
         9jHbqraC7A07kvMkxdZ8S2XsSNE2uqpTs9f85TYSiwUTRvNdsG6oAyTIzMvzk4oHaQ5p
         JzJb3VuBxLBlu9QfyNeMf1Ul7TNB9JT3+/r68DapmcyhzBg6aqWK62AI92n035fGZu9u
         C6twuf0TldzXlUkqfgf2vvOrZk7p94hcmF6cRtMHkxbsZCotI6z28yEklNyaQAs0g+Yr
         eCbBjB7WlIuort18bV0WOvldZG48RIi4RTI4U0i86DA6rUT1+KKMT8d2P/a4TtH+EIBe
         LyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513952; x=1692118752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=lm7q71jDAmc7RtdOhJKOb26Dlb7sAFXNsEytaByM7P6MHDX4c/jzd8MTN1xfhKfwHX
         ev5/7qG+nJjc3PR2i4wGzIrQn7Fm0lUaa2Aylf4FSsDGzZWGUl1KcWu1/6wL0Kt/9mDH
         C+QKE776+ku4uAdUgHlDr5wOsPk+T0/QOYHRhIBF6agLrd1+XItJZ/uHFVVTUxFl3dlV
         7kdYSR14HRL84a/vglUUIsBiWCxW4YPGuR1B+7A1/IFeFNpiyD28+vc1+z4nvIZRRYao
         XrxQ09YhaN1sFJIHhseB2d//tiVm3rGqnUYeQ/KhUWOAgUhRr+MLeDX1FTbyMA5PNvTc
         P69Q==
X-Gm-Message-State: AOJu0YxLwr0JRLIQ6yWqJIOL0b29FSYcvcaLZOMxNFJPhXC/vaXiPGjO
        Ev8W+USSV4eo4AmpXmqe7F7UIxX1gdWgbDzChtM=
X-Google-Smtp-Source: AGHT+IHh37iYuUiKI2GbU0AYhtJBCPFDqyHRg6hHZo0rvcAp0zMmu3aywLaX3w+vkrjWoKcJi+lCTw==
X-Received: by 2002:a05:6512:20c1:b0:4f8:58af:ebd7 with SMTP id u1-20020a05651220c100b004f858afebd7mr6593359lfr.39.1691487897383;
        Tue, 08 Aug 2023 02:44:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 11:44:45 +0200
Subject: [PATCH v2 5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-5-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=87zmBNCrKExC5fA2pDw1hJreUEORhjqL4+NYXqa3bgY=;
 b=VT9trWuRQROU5ByyIvzOsud1+jUCahMFSSwl7lXsHgNEroaV6TNcWL2Qi+2HDnBgH+uqXNQKx
 XLni2Mv9lxlCRZ/eHiiHKdcIHZUZoGsQGa7E5QjDCIxTVH8MTuWmOw8
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

The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
votable.

Fix all of these issues.

Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index d0a5440e2291..4fdc41e7d2a8 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2627,11 +2627,13 @@ static struct gdsc camss_cpp_gdsc = {
 static struct gdsc bimc_smmu_gdsc = {
 	.gdscr = 0xe020,
 	.gds_hw_ctrl = 0xe024,
+	.cxcs = (unsigned int []){ 0xe008 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "bimc_smmu",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct clk_regmap *mmcc_msm8998_clocks[] = {

-- 
2.41.0

