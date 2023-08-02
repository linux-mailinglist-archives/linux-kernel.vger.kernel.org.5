Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5962676CA25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjHBJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHBJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:58:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F88E64
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:58:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6873f64a290so831773b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690970293; x=1691575093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34LZOxStMWZZys9xGZwVbp/iX1SrEVG3L8B12Rex+EM=;
        b=VCFVNY3p7kubvP52va28PuhOb0YgY8Rlr+G72KMNLgjn90lTBrz6+FWPiTGij/gZI/
         1EtyjaWUnX0JdITRZbS6SmaXHffsfoalg4+krgTUBZZVfoHgZ+WlkEw8Uk0+dDYrhu9B
         5L5PEl63m4rx+Y1hpT5wYq8HNxUtOcKLHwuVaP989erD0oxSuPNNcZIoSyvh1QGktJUK
         5XPRYzwPRmiXn+1iNAW2JFuLRybxzeO1zny+TID7XRfFXRqoP1Wi4imCgSc1G0T4L2++
         2bJS2OfnoYT5szsvn+p03828QqALWDDjIeo+v1PuoTTpTO/OfkOzPQZgIZAvOcddqRL0
         j9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970293; x=1691575093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34LZOxStMWZZys9xGZwVbp/iX1SrEVG3L8B12Rex+EM=;
        b=Bjbyv/6VaqylvvtKZFThrqu+Sy9t3xgpYkWLkDvgu/zDHZJRxPizJMc4QWuG7tdvXs
         7xlzkKSrWbu2m8CW+rlC+8IcJgZYprr5FY4OkHSjzd5QnJ46mreevMpUwmKHSEbeYhf9
         BIicWOPCFc+HwIl+nJe0HTjJ6TcWNOWHeJOqjCZl8BgL65GLFh9queqTMLfsevxXC4uy
         7ZhG9IZWqZg0hw2jp6pSaLvyn9Es94cAdYiJed3mtyTgIYCkbDvu4CTpKgNrMjLxvjug
         H1LBW3eF9pmFW/H9ZUsGJRWMAbALSaHJeq2shguaXlACBh7ByF94gCz76aZxRecO4FMG
         hDZQ==
X-Gm-Message-State: ABy/qLbiNl/j5OyAXOzTVKHkXgVotsSGWPQw51p4YXu24XICD2pWRm8t
        jY3YJqd/K3FWnraGOw9xrOrFIT+6XzTpUrdO/IYYWw==
X-Google-Smtp-Source: APBJJlGX4vqR73k27Ib3HHZ7v8cNqP6Ca8hNP+Ou8V+xI0MLLzb3k32wPzxUpFF+Por51r3J9ZnCMw==
X-Received: by 2002:a05:6a00:2d23:b0:67f:8ef5:2643 with SMTP id fa35-20020a056a002d2300b0067f8ef52643mr12877311pfb.2.1690970293532;
        Wed, 02 Aug 2023 02:58:13 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7900b000000b00686f048bb9dsm10742544pfo.74.2023.08.02.02.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:58:13 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: Add sku_id for lazor/limozeen
Date:   Wed,  2 Aug 2023 17:57:52 +0800
Message-Id: <20230802175628.2.Ia4e268a027980f00c8fb0451a29938d76b765487@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKU ID 10: Lazor LTE+Wifi, no-esim (Strapped 0 X 0)
SKU ID 15: Limozeen LTE+Wifi, TS, no esim (Strapped 1 X 0)
SKU ID 18: Limozeen LTE+Wifi, no TS, no esim (Strapped X 0 0)

Even though the "no esim" boards are strapped differently than
ones that have an esim, the esim isn't represented in the
device tree so the same device tree can be used for LTE w/ esim
and LTE w/out esim.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts     | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 913b5fc3ba76..cef57c15b70b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
-	compatible = "google,lazor-sku6", "qcom,sc7180";
+	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 15d77dc5f956..2038a82bc0e7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor Limozeen (rev9+)";
-	compatible = "google,lazor-sku4", "qcom,sc7180";
+	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 38027f13b9d0..438ab9cd3389 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor (rev9+) with LTE";
-	compatible = "google,lazor-sku0", "qcom,sc7180";
+	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
-- 
2.34.1

