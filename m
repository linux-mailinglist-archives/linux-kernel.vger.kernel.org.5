Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E627A00A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjINJqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjINJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:46:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCACE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:45:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so855350a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1694684755; x=1695289555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulj0sxL109s6WRduuI+x9sWJvUGugBDVjc0AW8V0tV0=;
        b=uuk12mev2HWLDJAhvfuqzmp1ltAEshLoPc1rBu7J257yD0YyMPyYDYfaBLyTADJaxu
         dqql4D2SxdAMpnuCcVOXFJJAxWXXtdNELkrFL8uOSmn7veBVGudmPTklc18BUst7bjOz
         dIWDEIfOBIAqQGSKE9AICVaEPBxAvShaticG5T89j72wkvQc9+tucPvb4KetRke3LK48
         8wAgHTJ2kYoXi9Yy8XvbxA2ZNj4KcEACgsO17GmcNbaHYKrGwco06EXEbt00PvEEGws4
         owHyckkfo1sXQWsxJsskDakeryKHQy8K0BJ1aSf3XNgZz795Uz3JEjtxUgcjpxk+8JdH
         4mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684755; x=1695289555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulj0sxL109s6WRduuI+x9sWJvUGugBDVjc0AW8V0tV0=;
        b=TttErYL8CmI+h/jCg2n7xlp2wi4nKRfDkdSgZUXJOoiVQkmB7XVjF2YZKI+Gm94A6/
         saVsyvjcl88JSDJbOWN4qn+cfUjB8r68BNhcKTg4A2IXoKg5jqOIfCqJzUhdMIlPZvHr
         bAwoilAH+Ih288VKYUuau7iMzkYPEMqLpYZGuu47m3+f5FJ83P79ylk6oygNGtSj86v1
         hU7qRbKEU9T/ZZwGl0cZDMtQkrbiqaWQ96T1zmBWIoByiMhZexr3T4r7fNvpzZ3juxTX
         gviVxKjOc45XNOE9aFlw0NQHrRcAc8C5ExqTpgL60K5vdGKNcTR+sHU4QlaODPLz9vyr
         UDlw==
X-Gm-Message-State: AOJu0YyMOKHDG8b7J0ot71HTneXUjcXnr4J0WrnYoH0AusBGcwu5gsba
        xtnipzazEf0Bk3FTIsc6C+keOQ==
X-Google-Smtp-Source: AGHT+IHUUXjR202tEyKfXygRVDaxtDSF35MAKczmRFFXZk/N71UuM9KZrB8zkt+OWbntduc9N+RLTQ==
X-Received: by 2002:a05:6402:517b:b0:51d:d4c3:6858 with SMTP id d27-20020a056402517b00b0051dd4c36858mr4439955ede.12.1694684755560;
        Thu, 14 Sep 2023 02:45:55 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
        by smtp.googlemail.com with ESMTPSA id e10-20020a50ec8a000000b0052565298bedsm690790edr.34.2023.09.14.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:45:55 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] arm64: dts: marvell: eDPU: add support for version with external switch
Date:   Thu, 14 Sep 2023 11:45:01 +0200
Message-ID: <20230914094550.1519097-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914094550.1519097-1-robert.marko@sartura.hr>
References: <20230914094550.1519097-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New revision of eDPU uses an Marvell MV88E6361 switch to connect the SFP
cage and G.hn IC instead of connecting them directly to the ethernet
controllers.

U-Boot will enable the switch node and disable the unused ethernet
controller.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../boot/dts/marvell/armada-3720-eDPU.dts     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
index 57fc698e55d0..d6d37a1f6f38 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -12,3 +12,50 @@ / {
 &eth0 {
 	phy-mode = "2500base-x";
 };
+
+/*
+ * External MV88E6361 switch is only available on v2 of the board.
+ * U-Boot will enable the MDIO bus and switch nodes.
+ */
+&mdio {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&smi_pins>;
+
+	/* Actual device is MV88E6361 */
+	switch: switch@0 {
+		compatible = "marvell,mv88e6190";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "cpu";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+				ethernet = <&eth0>;
+			};
+
+			port@9 {
+				reg = <9>;
+				label = "downlink";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+			};
+
+			port@a {
+				reg = <10>;
+				label = "uplink";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+				sfp = <&sfp_eth1>;
+			};
+		};
+	};
+};
-- 
2.41.0

