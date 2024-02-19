Return-Path: <linux-kernel+bounces-71061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641485A02A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C2D281C32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2825625;
	Mon, 19 Feb 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="fvYDvvWY"
Received: from egress-ip43b.ess.de.barracuda.com (egress-ip43b.ess.de.barracuda.com [18.185.115.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC224A0A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336148; cv=none; b=IncPd1iKZ3fDnparUyuXWzOXVGC7qpx7DQchS3kdDkG9KzrnOMhEUkxi+BIbTtD44kt/f4jE8uRoaAFC5lg72tQ7bqCMtWL9MUEPTZdvFVu6H5Sna5ThCnqhGber6le/O72Ldy9alDF3m8hJkgM1EGGeSAYZd1zIcH91yVjmmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336148; c=relaxed/simple;
	bh=FqVikFmzluRuWznuQC1YJtnaJWBrWCiiS+vEsKl0JGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HAZVxsGRz29vsA+8M5JCY+u1Wkrn5jZJBvSc8z3iZGTdw5vvAH5up/zrUEmUh57LYwfp/NgkUb+NHVZkI9BXSj3aStrSLhB6vpoUjD89J54p0co+V8Qo6ISDOQ4IkuufJFyS7GxMRKpl0SyW2xGwoOL4xZEoIw257Y8K2rAA+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=fvYDvvWY; arc=none smtp.client-ip=18.185.115.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound47-141.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 19 Feb 2024 09:49:02 +0000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d9df9a3ef3so44539975ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1708336141; x=1708940941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miyKJdiB2gWRsatSJx8FIbILVUc1DBSiCVFq0Gs7BZA=;
        b=fvYDvvWY7CbZFSSQRCbdnVK45qlvDogy4vvSZGcRG3iN1rFwm+jNKa021+8M8onsik
         l3BOGPKtmMBtlzKG7/66DE1PFzeUisUHwklr/3XLCPGHQcg9mPUOB1CdtbWf7f381Fy5
         Yk8o0K+/IIH/4fYnmOTx4dw1KFp0zH98Y9Vbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336141; x=1708940941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miyKJdiB2gWRsatSJx8FIbILVUc1DBSiCVFq0Gs7BZA=;
        b=QVIM4yEtGUrOPS0tP8ugNFqOYR7B5nh1w8OQoULNKdNENNd15iX6c3DWBRFta+WwD7
         NiWrbRXAiXexgsovg4Y9i7rxsWDxpnxv2tTK20tt6ApAFohK5IapLZ+taMzLFcUI9sWE
         pr27V6DBfdPT7SRXgqL57EINAfZyncGpvcn+pMN//Z3CseEbxnfgfhxEsapMMmw06e4d
         VcVCAzzDiJZDmdaRAr7y6tnU6H9lmY8pcI1xo6rFhe2I+3CH7trGaNuLLxEG1Z8OuNKC
         3aSMzvHZXGG9cET7/UNJbt1Nv8qEL5ytnwECsECUThlCHjukG56z/Jnt21VjUtMcBqz4
         ytig==
X-Forwarded-Encrypted: i=1; AJvYcCXTnyGT2eNqxj4AvJaZOxLl4kzODotcooLG8farkBFVzb2FOnsyS/nCC5Jb0ZGYhjLvH+hVVGgts6fkfa0J+9+D6RbSmbiQsXUnPO0w
X-Gm-Message-State: AOJu0YypEzT9zHt9daKy4Mwyzga65iLmpsR3MotEPq+u57oGfXsM2FQC
	arwjBF6+5EJVkE09RbawjwTTn5ULd3Ucav+J9RFAUfsYCsSeHWFnDN+e/WxRvmJYfpJ6kstWOyo
	u+uf/Ltal6K+ZU0tTqGYkfugVJTwHvoFSLi8v3WLD4DKTkRXyNNzhNlYFUerYO0iVpcHlvNOAg+
	iDixWDBDaqicRuZurCz9dJ
X-Received: by 2002:a05:6358:63a2:b0:17b:c8d:f39c with SMTP id k34-20020a05635863a200b0017b0c8df39cmr13687164rwh.28.1708329580095;
        Sun, 18 Feb 2024 23:59:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR6bba8F48zsG94/WmE1CDv0XWbi4wAXc6sfLANAc3WjiY1EOsy5WvWL/JajzxA6qW8Wqobw==
X-Received: by 2002:a05:6358:63a2:b0:17b:c8d:f39c with SMTP id k34-20020a05635863a200b0017b0c8df39cmr13687153rwh.28.1708329579761;
        Sun, 18 Feb 2024 23:59:39 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id n12-20020a63ee4c000000b005dc4b562f6csm4072525pgk.3.2024.02.18.23.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:59:39 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2] arm64: dts: ti: k3-am68-sk-som: Add support for OSPI flash
Date: Mon, 19 Feb 2024 13:29:32 +0530
Message-Id: <20240219075932.6458-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1708336142-312173-12421-3210-1
X-BESS-VER: 2019.1_20240214.1700
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNjQ3AbIygILGRobmaYZmRh
	ZplikG5mZmpmZJSWnJhqaJKeYpxiYmaUq1sQCIw3SbQQAAAA==
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254321 [from 
	cloudscan14-78.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

AM68 SK has an OSPI NOR flash on its SOM connected to OSPI0 instance.
Enable support for the same. Also, describe the OSPI flash partition
information through the device tree, according to the offsets in the
bootloader.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V2:
=============
1. Address review comments
   a. remove pin E20, which is not connected.

V1: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240206092334.30307-1-sinthu.raja@ti.com/

 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 0f4a5da0ebc4..afaf702cfc9d 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -130,6 +130,24 @@ rtos_ipc_memory_region: ipc-memories@a8000000 {
 	};
 };
 
+&wkup_pmx0 {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
+			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
+			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
+			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
+			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (F18) MCU_OSPI0_D3 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (E19) MCU_OSPI0_D4 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D5 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (F19) MCU_OSPI0_D6 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
+			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
@@ -152,6 +170,66 @@ eeprom@51 {
 	};
 };
 
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
+
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
-- 
2.36.1


