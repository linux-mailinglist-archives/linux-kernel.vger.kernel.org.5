Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7930C777246
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjHJIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjHJIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60B26AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so5687245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654963; x=1692259763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XnXEHTpcZwsLX4QNNcVLRlqnkdUgZEa6wcYgGVtY88=;
        b=KHxobwMmJ5xLuQ3fTqWbKzB6qgqvAQdnuSJxNgr8p3NLWm51+bi9KztXc/Nn3jKmBQ
         /znodQXxIzxDNtXb62bMYgIR4q5VIXgRjdEt9TlcM2Ge/V2PVRicEt8B91KIdIxIB8I3
         o2ygAkhRR5mE+tO56OrSQormCUMSUVslpOF2yCabPGeHuwEYFeisK27aj4qjDhDbFhAG
         CF0pwVxYjxHLE+WGC/Zc+dLbfOsNVuXytzniNciQ0AF2oyVg7cfnK41Eq2xUluLtbTw3
         xy+rl9k9YOvAB9YDtV2uvbqqYyAx/YhIeUzrfjB8OFMO4ynncy9HfMohXrBr+9ghvcTw
         gPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654963; x=1692259763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XnXEHTpcZwsLX4QNNcVLRlqnkdUgZEa6wcYgGVtY88=;
        b=Ifi5jSGhWuWbBKlLqYQPVEFjy9vYdUXFf9Whcg28g9Iw1VS8guhYDpSQinNMirCLa1
         wWWNPH3MVcEQRpUfMESQP6A0MOVNnaQaWXyENnwZJpthLnXXTeEffyuSAe1GQb3DtZIy
         HqEHb2+6E7FylBWRtMb+9diJHNH5NayEYIkRLvjrO9BG3V4hCL6LvmwenzYQqG2YVLWh
         L/0zLaFl9i5v5HPrV+YxU0xPKPRXKSbqAXN5BzGoZh0bOUu774wBuojzKWMUNkPInDs5
         phOSCusxByJY5dnEr7rNVHqzKLhYYD+/DG3Zxfmfkmi95Ez11qG9no6SAZZiKIb23yvK
         MuFg==
X-Gm-Message-State: AOJu0YxMqnGhBnLqyEI/9fflpaYoKUIojJFCbqRccvWoa4jl6EJX6GC9
        nL5/Vk2SnRlafyzdTyRiyUygVQ==
X-Google-Smtp-Source: AGHT+IGuwA9g6Dv+9oaRLjpG3wLqlI4/PqOEjOrVytYMFrFOB7GDlqo/TdgkN3fFponJHiXh3bKVaQ==
X-Received: by 2002:a05:600c:b4e:b0:3fe:19cf:93ca with SMTP id k14-20020a05600c0b4e00b003fe19cf93camr1278555wmr.8.1691654962976;
        Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
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
Subject: [PATCH v3 9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
Date:   Thu, 10 Aug 2023 10:09:09 +0200
Message-Id: <20230810080909.6259-10-brgl@bgdev.pl>
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

Enable the second MAC on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 71 +++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 48119266c6fd..81a7eeb9cfcd 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet0;
+		ethernet1 = &ethernet1;
 		i2c11 = &i2c11;
 		i2c18 = &i2c18;
 		serial0 = &uart10;
@@ -359,6 +360,76 @@ queue3 {
 	};
 };
 
+&ethernet1 {
+	phy-mode = "sgmii";
+	phy-handle = <&sgmii_phy1>;
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <1000>;
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

