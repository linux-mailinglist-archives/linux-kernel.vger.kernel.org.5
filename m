Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38E8052F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjLELdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjLELd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:33:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5D1739
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:23:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333b46f26aso2763860f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701775403; x=1702380203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6sGRXmJ2vFZwbq7OvwUrXyLM1kjgTEB3KpBaM2KT6U=;
        b=WxO++xJACxUyyaG0e+BvdYboOSN7SLb2Rh7B+wNO6wB5Df1IrZx3xjSqt4urDdMA+L
         l82/rdY93hVPkkXlGcoSy3gBXKy4mcwIjnxXafCcNRvnzFG4BEoCthPx2D7T0KCEBfYp
         bUa+sQYR9YhBR903/uYKD3660fhZv7yZMdMdpnUp8QeZ8hzFcfJJ3AXtXZvbpO5g5W31
         7fANJUSKvdMtUXA/g15lVGzbo55s6VX8K4w3qkeSgojfrlggxSj+XdGWnCoJD3IefdXS
         VxOrKs0QBrNqMvBPXys6r3swA5f9Teaw6M78/xSeHPYD8wvYNp6w7B1xlxQ3VdKz2k9/
         /IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775403; x=1702380203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6sGRXmJ2vFZwbq7OvwUrXyLM1kjgTEB3KpBaM2KT6U=;
        b=jfAEqzKGDJe2vRpd+jTvQTxujvJVGcyFOqTaBT27k5IUa+xOtSyiU5b+BpLEeL3AdD
         mk1BNjH5wMKAIs1nqLizyj+S/kFRz/Q0stRoSN89HpbmmNLUTB3tEJiZby0st5vgMjVa
         sWaNA/G7lVmYJkgIfRtMPTbhokvwv+atPL3f7hzZM1eJeBGkASyVuyK5b0/MO6heXk92
         Qq6bs83ovRvmFc6Pdl8VtSVQkilDPEf0KKH9BpRYRogDYw0e+FO/zEfIwVdAxwwXpvhF
         HLggpTQjRUuK4WIb/4Z62aoyJ75ULmJJrOj2I2E0ZkAdn8xrzO86mqYNOk3jNO344xG1
         XN0g==
X-Gm-Message-State: AOJu0Yx+isf4O1halTDAkNyjYoivfMK2uz90jPebPjcoA7nOYLTuPvne
        rt0tBv+kf/MEDY3V++Zv+nu+3g==
X-Google-Smtp-Source: AGHT+IG8kRfC4Kuhw3jHxqdgrgNiTzCNx9TNRsyxtfxsUFLhZilZXEA06L5+jvWkFRz9ZcHxl/V9/g==
X-Received: by 2002:a05:6000:71e:b0:333:4c89:f44a with SMTP id bs30-20020a056000071e00b003334c89f44amr1683678wrb.2.1701775403066;
        Tue, 05 Dec 2023 03:23:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2dd9:dce:96c5:9e9a])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b003333ed23356sm8127775wrr.4.2023.12.05.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:23:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: qrb5165-rb5: add a pin function for BT enable GPIO
Date:   Tue,  5 Dec 2023 12:23:10 +0100
Message-Id: <20231205112311.16391-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205112311.16391-1-brgl@bgdev.pl>
References: <20231205112311.16391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Set up the pin function for the Bluetooth enable GPIO.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index ce6ae0771d34..ead0c45ba60c 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1264,6 +1264,17 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	bt_en_state: bt-default-state {
+		bt-en {
+			pins = "gpio21";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
 	lt9611_irq_pin: lt9611-irq-state {
 		pins = "gpio63";
 		function = "gpio";
-- 
2.40.1

