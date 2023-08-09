Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D936775E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHIMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjHIMEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:04:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E62122
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:04:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so59085335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691582685; x=1692187485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik+Vesa+3vygs95Y3Ss7LgnvyJofDuuC47JEx/KwcHI=;
        b=rBxTvRqs5x9YfW32WqwG9bKnRxvWc3eZAGt+drtDI621w+e/LRxqb7NnIzh1c44VgF
         RACsQLtR7XVhRXDmbmRmk0BdoYTy7yBwbDlM4nduSU+N6F5IebS8+5mhKfPsWBlhHp0C
         g/NnAmDsGd2rrGzSSM9xJ4jrvVmEiAk32qyAWc3ZoNCz2q2DKeb3DCcLO/QrIMmlo2Gk
         AsfSKFTFAQPkk/7gE0gu7uVtEoVK94yr5Swsvf8ok+obKMViCeZRVCsXGrK8dZmdNxyb
         3/NfhEoPBP2rF5x5DeC1DMm6gKGyr1t9zATMe/oflyTJ/ETiZFoUSJZD+VSL1x9NO/7L
         /wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582685; x=1692187485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik+Vesa+3vygs95Y3Ss7LgnvyJofDuuC47JEx/KwcHI=;
        b=FP6WFUtYEVwaVOR75VjF1DnPDIBf1o1EyA/EhCVlRAoKBWNKhAm6LKWJ+MKjdcY6nT
         17D3df1Wzj0qxOaKW3DyNWD0vIFxhi7TMkzH6MYc3kwyOahRKg+9oiUnnIjG4pTivbC9
         GvdiY5XgjYtBdQL+BgF8CqpFlR2LOZJH+5xJuKGQFTPYmvCmvoQMK3Mz6C1xHvkN978N
         30jMNV55PiXzKjXZV6LXIEb82PE5LUNXcX5qsK5MnYeTqQFoZTwhOhK0jqy+7iEfykQX
         +jEAM0nvEYt8KlYOx+ThoRk1/rSI9/cwThb+Su3CaWiXRhDV0d4sypZ90K0V4+sQtJFQ
         7L0A==
X-Gm-Message-State: AOJu0YxpSUlJjYTcLBudqVWsyW8QLlCX8x9pstEnoi7no9PSO3g2JqQc
        0s501m+vSmHT0rgREPMQTMr3Gg==
X-Google-Smtp-Source: AGHT+IH1egwPN7DJKbvHJ+pRj41qu864We1NH/hmj3uxHe5Im9RDLMTnqFEaRqK1um1pyaMooMzwCQ==
X-Received: by 2002:a05:600c:211:b0:3fe:1287:d2b0 with SMTP id 17-20020a05600c021100b003fe1287d2b0mr2026246wmi.3.1691582685307;
        Wed, 09 Aug 2023 05:04:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1808573wmi.2.2023.08.09.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:04:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 7/7] arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases
Date:   Wed,  9 Aug 2023 13:04:32 +0100
Message-Id: <20230809120432.1036405-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
References: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have no camera mezzanine attached it is still possible to run the
test-pattern generator of the CSID block.

As an example:

media-ctl --reset

yavta --no-query -w '0x009f0903 1' /dev/v4l-subdev2
yavta --list /dev/v4l-subdev2

media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:UYVY8_1X16/1920x1080 field:none]'
media-ctl -l '"msm_csid0":1->"msm_ispif0":0[1]'
media-ctl -d /dev/media0 -V '"msm_ispif0":0[fmt:UYVY8_1X16/1920x1080 field:none]'
media-ctl -l '"msm_ispif0":1->"msm_vfe0_rdi0":0[1]'
media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:UYVY8_1X16/1920x1080]'
media-ctl -d /dev/media0 -p

yavta -B capture-mplane --capture=5 -n 5 -I -f UYVY -s 1920x1080 --file=TPG-UYVU-1920x1080-000-#.bin /dev/video0

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 84641925f3329..46cbeaa2f2acc 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -250,6 +250,15 @@ &blsp_uart2 {
 	label = "LS-UART1";
 };
 
+&camss {
+	status = "okay";
+	ports {
+		port@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &lpass {
 	status = "okay";
 };
-- 
2.39.2

