Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B157798C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjHKUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbjHKUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157A30EB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe1c285690so3736423e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691786924; x=1692391724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pxu621iOgDMVf5ytcvTvDymBIHNNCG8lYXpYeJOQc/s=;
        b=O3cstlrC8x31U8pm9x7wPu1gRqdwnwU+N7HWBN63Q5dVvwM/LP6bhxnr7/KFiMtQXl
         7SvvS7B0XkxEeDhxUMkOMpRl1JjGuR6VZ7109PY2qz2K4P+eLz+++0QnXEOYIb469Cad
         A2STxCMhXFevpxDmcYLf3mGC95Oq49GFyGYQbZCVcqQr8jx8Igu9G/ebA5G/HnkzsJii
         dq2R6OQjm98IJpc85tNk3gJ+8KPyYCkqnMsI0BShMrl/kvSEOD2SlmfeosUli/KeC4/6
         36OUJ04qexUiuP/zcrS18CmQMxOlisG6vaxGWEufi1VRiiQA/QfxOoh+ywlpJT+9h6o3
         iGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786924; x=1692391724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxu621iOgDMVf5ytcvTvDymBIHNNCG8lYXpYeJOQc/s=;
        b=M2tgzg5rlr8hN39XY/tTZbohE43/Fk4FdEjmXjmQ+1n46ntr+996G2fKSUMQ++TJix
         oC8Z++C+GTRT5YPbxkFS3nnbqkZH/TR/erfI/BhRobsqWq2BeyjcB30O+JpTLC4g9sR/
         sUWCQA55HAXq5pvoNOnmYtfjTMpythU1EE7C8lNahxEQw+t3Sf0im3lTVDvwr3jaXpvg
         8Lv8vpxiwvs2qwYeVyz1U1e1+oDo9cikRaL3CXldPjuarSOJ8is2h8T68w7P5LSjeKgl
         S5nCCUxcNbIil2Qt/4crRh0r/ZIry9MuYAmnfOQnyp4UUyJg6lr4pnBdh7m+jYXAqxd7
         vGMQ==
X-Gm-Message-State: AOJu0Yw4rVcDvBKzsGxH/Euf+5Vh3/Wj2CgyNa3OgxzGG4P/OZg7hLVl
        NUQIv8TGl1phdnFr55x+4GJDCw==
X-Google-Smtp-Source: AGHT+IHvAfMqxIniDKXjvF3S8MxYiNINKcPRE7fmH3IqE0X204ZkTeHcNHFmDhAmsARsY5koqZthYA==
X-Received: by 2002:a05:6512:1094:b0:4f6:3ab6:3d9e with SMTP id j20-20020a056512109400b004f63ab63d9emr2418415lfg.59.1691786924317;
        Fri, 11 Aug 2023 13:48:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w1-20020ac24421000000b004fe8d684172sm843603lfl.234.2023.08.11.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:48:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 22:48:36 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: sc8280xp: Hook up PDC as
 wakeup-parent of TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-tlmm_wakeup-v1-3-5616a7da1fff@linaro.org>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691786918; l=721;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kYvW1Y7s3IPV5ZeIvEGtTVuGsinHTVjJIAqHXcfSnqE=;
 b=BQSob8/ASC9YBeFxeETIW6Iyjz3GvK06YaeuywWDWzO8xX/X1yhXRNtvltV8GZ4Wr2wSIcWe1
 IKD8U7hqeYCBJyVh4czH38Kz5o0bNIpB7zWQCP/dxFcGCEU6rMVb35E
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some TLMM pins are wakeup-capable. Describe the relationship between
these two peripherals to enable this functionality.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0756b7c141ff..cad59af7ccef 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4059,6 +4059,7 @@ tlmm: pinctrl@f100000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 230>;
+			wakeup-parent = <&pdc>;
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.41.0

