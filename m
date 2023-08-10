Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796D77723C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjHJIJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHJIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F572133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso5956375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654959; x=1692259759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/ZCS8IPqTOVVmzyKUhKmwS1Ej6sOoZW7BgZ9pVGhqs=;
        b=EFKS9BtSiunTry9MFBRgW3vTX8qW7ha9pp7TeE5FsAiRNnY1JEb6/fDRmmHh5L0DDt
         5YjOu5WsGqDdloC8i2QJAoUI3ks76mdTVKkrWwP69P+cro2goE0e10xMGI897MvUe34m
         7jRA4rtyHt//svmLzt5rbY3Py9vWoVHTx7KqfqjxxVlvQPRj4ez/3iL0pp7oFXt9q596
         T8U/9AwEQmtQDyd8DDWTed257IhAHNJictOwwPrIM8ZFLWiry76tJ9A1mAiEfcjZ1S4C
         WDUE50BvzWl8pbPGMm77LM1s3AzQkQiTGSjasVptodfSzt8aGWKvEc0H9iTwIcQoVNHi
         gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654959; x=1692259759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/ZCS8IPqTOVVmzyKUhKmwS1Ej6sOoZW7BgZ9pVGhqs=;
        b=DKPF/xGWrzsHrqTu82aoAHTOfGEFEKAFE9KTZfzHM1X12mcXoKACXlrbzRyI7ANQRX
         n1DwhyhhvFL8bt2orgfOeONwTis/pciHMNuwsDf+A/PK/MZe3skD7Su9SDE245iRjZb7
         kWwM+t/3Ye9yrehDQCZgME9mJIQkVCC67eB2FVYTtC/SE/cSdEumhwX6jlmrKVoSmIal
         Mc06ivIXBO94TqbazOUj/WoMfyAguRWN0KTB3zfCudF6Ned6lJdTHt5RREPdAy+lJVXJ
         5oQHiKoJwZxwpRjv0MrK7/6QpebN7Q+PkE/FhRrwn8yXWYaxPoa8xk6j610XSKjg85qf
         KgEg==
X-Gm-Message-State: AOJu0YzQUgEgp6h+BZMXwe2Wzv7T3nXkty3HtfgAsKBYSpp/vyjCaqkE
        AnRj+il49U8szchm2RJG07IcEg==
X-Google-Smtp-Source: AGHT+IH5Mn1hEi6xgHbbSZZZCMoZat04tukAwJMRPhoiULmpdzR+7ULrU/FBeXMpLfzLNqJdtDdlUg==
X-Received: by 2002:a05:600c:2196:b0:3fe:2e0d:b715 with SMTP id e22-20020a05600c219600b003fe2e0db715mr1367285wme.18.1691654958836;
        Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:18 -0700 (PDT)
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
Subject: [PATCH v3 5/9] arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
Date:   Thu, 10 Aug 2023 10:09:05 +0200
Message-Id: <20230810080909.6259-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We'll be adding a second SGMII PHY on the same MDIO bus, so let's index
the first one for better readability.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index a03a4c17c8f0..f9e1a017798e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -263,7 +263,7 @@ vreg_l8e: ldo8 {
 
 &ethernet0 {
 	phy-mode = "sgmii";
-	phy-handle = <&sgmii_phy>;
+	phy-handle = <&sgmii_phy0>;
 
 	pinctrl-0 = <&ethernet0_default>;
 	pinctrl-names = "default";
@@ -279,7 +279,7 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		sgmii_phy: phy@8 {
+		sgmii_phy0: phy@8 {
 			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0x8>;
 			device_type = "ethernet-phy";
-- 
2.39.2

