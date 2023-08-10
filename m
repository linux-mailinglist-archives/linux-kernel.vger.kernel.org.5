Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0F777236
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjHJIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjHJIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F010EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so5138555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654957; x=1692259757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i/SrZF+jY6u1jae550/qtxZRbJK0LYhJpc6f9zoYy0=;
        b=TSkZ/z19Ewdl3ii6ZrEpjy0SNsDYae+B7yxQS8iwRCi1WEu2S+GgYSD4gR0F7PXXyS
         JPZ+CZ58O4/ChchZJF6+bT7dYKRFqgJWnxq1w18KrL6Cd1ypmiU06phL3s+ye7RWoNIP
         iy8lqyG/45vIMyiZwX4JBx6/XUSY255F6HIldfVQC/o5uZHIUVKdXuTXR3peA984D8SC
         THWVHrngTGtBG9wISwBKfWv59BFyZtf/CBPCTUIoBAepxec30C1feXqhyl9yKZIebBmY
         UNvtdgdYEe4JgwO2qZp5Wc0qjxUByJDLSsF/LnFtMxenYNP6QuCmOCtt8L1GtqsizFPS
         /+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654957; x=1692259757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i/SrZF+jY6u1jae550/qtxZRbJK0LYhJpc6f9zoYy0=;
        b=A/B9BO3PD1GNQymosKiCHWLNP+N3d+8EC9VlSZIP83GKCxtXDBKrUBGLiQpnrhV8SB
         UndfcF4o79DC132paBxfgs2OJZobFVFeoyTacwQJsMBHGemhbqLgaO0v784US5G3Nuz6
         mGbKFP+NJbpklAHgQmq3RYppF461LrgQaWW8SrysRXn3zEdhIJx2A+7McyR2p540a1M1
         TvrgjGRNe1QNDPot0wCUhACJqNrgSHe5qFZQ6+a1uVmYUGGrQIrdKpkUVLxdXJ9597OX
         dH0KLlUCuXVhySilRY2fUmcYgWM5mfyjwnqBgyFT6frrb3dfgKTZVG4xAZx2fun6rmSL
         CSwg==
X-Gm-Message-State: AOJu0YxCokAocBV6+avorPwwirP52SlgyZUlJVlXbq4slGS0wc5VLDap
        SHzK2jWSnJgYoLtNv8CCTFeh4w==
X-Google-Smtp-Source: AGHT+IFXte2Z3OPC0mOtun/00VY/jOftBufylvOjCscAxfiFS59vQyoj6n4WvAWwPTvqANfIkD47LA==
X-Received: by 2002:a7b:ce0b:0:b0:3fe:3004:1ffd with SMTP id m11-20020a7bce0b000000b003fe30041ffdmr1291842wmc.4.1691654956853;
        Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 3/9] arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
Date:   Thu, 10 Aug 2023 10:09:03 +0200
Message-Id: <20230810080909.6259-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second SerDes PHY on sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ed76680410b4..09ae6e153282 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -448,6 +448,11 @@ &serdes0 {
 	status = "okay";
 };
 
+&serdes1 {
+	phy-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.39.2

