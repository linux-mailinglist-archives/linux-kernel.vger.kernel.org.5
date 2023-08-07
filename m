Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94966772ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjHGTfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHGTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:35:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF031722
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:35:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso28864255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436923; x=1692041723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEn7Vyzxp0oT+8eRlG36dyHTspz7ckMQVTd2N8j7ySI=;
        b=2xJv9sDHJKP5PmcQdVHo1SUlesf5gaJlLd8lQYvoteDchIWKBRSVJAMI1oZpAr27Ec
         wRwU11Jx/l6GHM3u6UvvAZX8cqvyhiUppJd3l7U1NPJkP3Xss8KlH8homneaSFWCPVXy
         kcptShpBP3L9qosCIjH8M2OLqVFnX/AnWy+uyDeTfQZ1ndG0pxKg4ADQVZb3fbJaIvkp
         XJ7imsBYFC22SFv+0yZSXrhW3dmfop09nGBchQ1pot7JY7JjhKlebDzqlF0g97fYWrYj
         La3D1AuBVu6LdDL0jLMmhi1WJ8CS5l22HW9VEI0LkH2cY7ZoLrzmsS+g2iosDBX6dHc5
         YJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436923; x=1692041723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEn7Vyzxp0oT+8eRlG36dyHTspz7ckMQVTd2N8j7ySI=;
        b=ehfwqpqJ5BmrneTxM7g9s7xICBBL4CppTkarJPQRgDKGI90vZmf5ru8r6JAMoYTil2
         NcbjNsghYXWhNR/bE6GTXFbmWCzBFFUzvO8/lbjKh38FnPNDJMuBqFNW/TPdfwCPy6D6
         YNXM+A77brYW7GEIAkSq+lkOLI+SF7Dm0ZULH3xACSn1DrUmf0SrcB2cFZkn0zu2xwfe
         uQDHDPAxIzD9JDeRkuQ4YArYuZ8yByOGvdRN7aP9JXDASiXWtwTZriev5XRJ31wqSv03
         T6V8jrvae7rKy851GeMYr28RtKuqoXBRNTNeBA4HpR8lB4a9lRKmiEEkPldHopsmMgE7
         oENA==
X-Gm-Message-State: AOJu0Yzs4j+VN0uJlMhsloFlRlHidh4hVOeGhj1ORLv5Y5/1+/8cT/s0
        9moTLPXLNEeepeiwrKayBo5bmg==
X-Google-Smtp-Source: AGHT+IH8Xr6+EP/rdBj2XSnQSzFIwvg9Ltd6zyko+R/lBTfw2Io8uLU5JqkOEBdcsM5ijdPR5Z9F5g==
X-Received: by 2002:a7b:c7ca:0:b0:3fe:4548:188d with SMTP id z10-20020a7bc7ca000000b003fe4548188dmr7888606wmk.7.1691436922836;
        Mon, 07 Aug 2023 12:35:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:22 -0700 (PDT)
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
Subject: [PATCH 4/9] arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet1
Date:   Mon,  7 Aug 2023 21:35:02 +0200
Message-Id: <20230807193507.6488-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193507.6488-1-brgl@bgdev.pl>
References: <20230807193507.6488-1-brgl@bgdev.pl>
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

Add the MDC and MDIO pin functions for ethernet1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 09ae6e153282..38327aff18b0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -480,6 +480,22 @@ ethernet0_mdio: ethernet0-mdio-pins {
 		};
 	};
 
+	ethernet1_default: ethernet1-default-state {
+		ethernet1_mdc: ethernet1-mdc-pins {
+			pins = "gpio20";
+			function = "emac1_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet1_mdio: ethernet1-mdio-pins {
+			pins = "gpio21";
+			function = "emac1_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
-- 
2.39.2

