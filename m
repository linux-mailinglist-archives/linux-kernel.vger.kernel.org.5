Return-Path: <linux-kernel+bounces-71178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860EA85A1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E63FB227FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CA2C68B;
	Mon, 19 Feb 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="Ki5Mtkst"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D92C1A6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341298; cv=none; b=XMkGDrREwQU4BrG4N9kzI46h+5gMaFxSKMqBKvudR2MxbJGADrjTNFl7yI7cj1slEDCC4FwXfgnW+pmeR0TaHstBrzvUeGEBERdYBFJcTuFqaYujPVznD4vzrxDrhbwY6sQ5qXUtmc762+2FpulZMq21d36VjbWypce7CkwgEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341298; c=relaxed/simple;
	bh=ULBNcEaS2s2h6CAzqgMl7AJ8bhXxGkxAed2ivEK5jvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1GHg9blLDOgcsSGveUQ3E6SxuwGVK4X+LoL5023mvtQ/y/cVwueCa9of4nGv8IaQgblrQ3ZfkiErL3z7+mAGFzBJvQgHq1rOv+83K9Eoxe+y5rfL/7QbyogVjg/zFPMVpmoDqsdkXwyXtNLrhD5pKWBVO6cbgcYpr4tMK7lGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=Ki5Mtkst; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70]) by mx-outbound14-174.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 19 Feb 2024 11:14:45 +0000
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-299cae4f36bso43785a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1708341284; x=1708946084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsmDyzoAGxpVurHPntS4K3DVa+kJVyBNWB3C2+ThclA=;
        b=Ki5MtkstKQiP98FE9p/r5ah+4tBbIloVQ+GfcW/DkGE2l+Pkg77BTSlq89hp9Mx4lt
         Syk6qoa7cuPaQxMJXCOgYMpi7nCWbTkML60iFA0zwQ4m6Ah8jccYhNy9Rb9uVQ7S/sZ1
         BSxqWMXplVcOCh3ZYptfVuCJAOwNkGa79KFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341284; x=1708946084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsmDyzoAGxpVurHPntS4K3DVa+kJVyBNWB3C2+ThclA=;
        b=PCcavodMS8WzVD1/JcrUjmFGvK1XyAgAQiIHAAjc7PFEpywZPIqdLfl3JyKG8pDcOa
         XS0G2kP01Tg1vzKMitEypRJH8ohgiGT68gbon8P45N4KgmIRtRy6z92gtxpqNTrU/fT7
         IL4GAKY2c+YmkIaiX2SfJdtL8mrihGH8H93r93aDNmxOQJ8oKBgIN1VSH2XQgdJWlVwe
         XmsGsl8SkC+JQ9NxEg7bs/OlB3A/v8H2Vt6H73agWMf7dBlJJpSvRIlLIfrrVLnTWH0D
         w8v14WZOLTlbgFvCm7xU8rr5kzNgYfKg/3ZEPC1/r7mWMNsDiUB4NJIOBxnyO3TTEGiy
         SMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0zUI8XdJ2iZrp5GU6WZgRDKvgYnWaMU7FeI6fueUhsjOie6Xh1+tZ5w2f08WFoS2lmCI4/TyyelOFg3ob+8m6vEkLjZ4g3fm27A8
X-Gm-Message-State: AOJu0YynWMG//9Ikst0A24Y6DWZ9tvguufoCdAdLr33A2Rc7PhmVTCFP
	2aV2pMP9A1WwGUgcT8zlQr1Ua3m5Lb2217FsNG2H/zZte1PAlSf1NUWlP1UD/a842wW2SLoSEf3
	nEd3BQ4SBi1Zc2SWDpfRpp4IitQdujIcuu92cQ/CSg/QYIBmLRkj4KBZl6nLdE18R2CTlMwnFbf
	L3bzj2TyrEq5ixE94ZB2JX
X-Received: by 2002:a17:90a:bb86:b0:299:3eb3:4d41 with SMTP id v6-20020a17090abb8600b002993eb34d41mr4655024pjr.7.1708341283809;
        Mon, 19 Feb 2024 03:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDqEGQhuxXxFJUHYDwzqihQf+NJLM+lMWx31lGoQ48iy/Y2D4yU+kn0eLMzt3TnyjOOH+DQw==
X-Received: by 2002:a17:90a:bb86:b0:299:3eb3:4d41 with SMTP id v6-20020a17090abb8600b002993eb34d41mr4655012pjr.7.1708341283429;
        Mon, 19 Feb 2024 03:14:43 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id cq15-20020a17090af98f00b00299947ed2efsm2343878pjb.2.2024.02.19.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:14:43 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [RESEND PATCH V2 1/2] arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
Date: Mon, 19 Feb 2024 16:44:21 +0530
Message-Id: <20240219111422.171315-2-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111422.171315-1-sabiya.d@ti.com>
References: <20240219111422.171315-1-sabiya.d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1708341284-303758-12434-278-1
X-BESS-VER: 2019.1_20240214.1700
X-BESS-Apparent-Source-IP: 209.85.216.70
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIysjSxALIygILJ5hYWxompqW
	nmyeaGBsmGBikplhZGpsZGKebmaWYmJkq1sQClL9LgQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254323 [from 
	cloudscan21-72.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK board has several CAN bus interfaces on both MCU and MAIN domains.
This enables the CAN interfaces on MCU and MAIN domain.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 475bcec99bd6..0ff4d1623cf4 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -322,6 +322,31 @@ tfp410_out: endpoint {
 			};
 		};
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
 };
 
 &main_pmx0 {
@@ -430,6 +455,20 @@ hdmi_hpd_pins_default: hdmi-hpd-default-pins {
 			J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
 		>;
 	};
+
+	main_mcan6_pins_default: main-mcan6-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x098, PIN_INPUT, 0) /* (AH36) MCAN6_RX */
+			J784S4_IOPAD(0x094, PIN_OUTPUT, 0) /* (AG35) MCAN6_TX */
+		>;
+	};
+
+	main_mcan7_pins_default: main-mcan7-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0A0, PIN_INPUT, 0) /* (AD34) MCAN7_RX */
+			J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -526,6 +565,20 @@ hdmi_pdn_pins_default: hdmi-pdn-default-pins {
 			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 7) /* (H37) WKUP_GPIO0_14 */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
+			J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0)/* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
 };
 
 &wkup_pmx3 {
@@ -989,3 +1042,31 @@ dp0_out: endpoint {
 		};
 	};
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan6 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan6_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan7 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan7_pins_default>;
+	phys = <&transceiver4>;
+};
-- 
2.34.1


