Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780CC772EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHGTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHGTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:35:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273919A9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:35:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so41719895e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436927; x=1692041727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo95VHacSOouEChX8JO8J2HsGNhYMKSzCOBU0ZPBnt4=;
        b=4qMn/9J/Lk2cBYAMpaJ+2vRHdGu6OkayegJxPaIgrZtyjc3dQzvSYRspTRgjtn+b2p
         dpsMTm+l9Z6ZSVwztLf2OQbec8/mRniGaTrUoTu6YwJ5u5Y80DNo7hbNQ26bdmzIYUkS
         D/27tCJnW1yHH9WI1FFIXmpUkl1a0vdHMEbpRQ0upjMLgQmqrwFH3Gh5tfgPXosi1R/o
         yyt41rY/No/0jfcae/hPZ/IhM2NJdKhzwHm3YHCrHkygzuudvV4Y3M72VujNLEsqzNNp
         LJkwvhGtrLuO4EBykjyVlWsAhh5YKsTpNB9CTWndSBZsHtcduDGPXwDIbKgnQ3V4QjNa
         HVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436927; x=1692041727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo95VHacSOouEChX8JO8J2HsGNhYMKSzCOBU0ZPBnt4=;
        b=PRpnk83SmTp303BvoMlM86dq93JriI/s7R2eS28EN9fPV5aGiJoGtcuro0fW9CV7eS
         OCuPRsqT6AuypDp6NiH30MGkVX/clqUEdAS/VTqgf/3zZjvmbbr3FBMmLAAy5X2jD0Ex
         FT/P5uLS5Wu8ZHe3R52ozQGfrMc25iQP4OaGBIPCYT6cWh27ZEwdjbdL8xOQVSWrpcM3
         6ntD/nM+QKvWXD9SceifeY2gbTBaNDfEbzpxHqVD9oqMgHHUNXZa8H8sSqi9Z6raJ7uC
         2s/I7hKjzo0t+IbaDivvwPXiI6DP4fI0/+zKX+CKhQOBc9WgJkFa4Gc2G2XFOX7aTKrx
         dFow==
X-Gm-Message-State: AOJu0YzhQ+kYaV9j3GMoxbms+5FssY5VReZl+Eq0kdmwgc9oOX4R4hSF
        bMXt/N8zlDtaYVusttWzQHEBEA==
X-Google-Smtp-Source: AGHT+IG8+ARG74TxYu0rJtXTmYwK0yAnAFoMjeeXJYE8/TO+exRWTkRiyDEGFAmQcXp5cftSvKFKeg==
X-Received: by 2002:a1c:f70f:0:b0:3fb:ffef:d058 with SMTP id v15-20020a1cf70f000000b003fbffefd058mr6645779wmh.0.1691436927715;
        Mon, 07 Aug 2023 12:35:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:27 -0700 (PDT)
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
Subject: [PATCH 9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
Date:   Mon,  7 Aug 2023 21:35:07 +0200
Message-Id: <20230807193507.6488-10-brgl@bgdev.pl>
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

Enable the second MAC on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index af50aa2d9b10..0862bfb4c580 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -356,6 +356,80 @@ queue3 {
 	};
 };
 
+&ethernet1 {
+	phy-mode = "sgmii";
+	phy-handle = <&sgmii_phy1>;
+
+	pinctrl-0 = <&ethernet1_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <1000>;
+	snps,shared-mdio = <&mdio0>;
+
+	status = "okay";
+
+	mtl_rx_setup1: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup1: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &i2c11 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&qup_i2c11_default>;
-- 
2.39.2

