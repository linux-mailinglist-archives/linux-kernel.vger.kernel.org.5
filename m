Return-Path: <linux-kernel+bounces-51201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B058487B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385C31C21EF1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F825FBBB;
	Sat,  3 Feb 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5m2k566"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9B633F7;
	Sat,  3 Feb 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979271; cv=none; b=nhr285GEUeDA/vnvZV8novnDJoSEoorsHXEbthmnVHdF39yWht+6jNHYXRaty922VYiflaI8UaQBAhgH3mgAum6B5e75fdK2UJH2R+COzV/QLSNOHPrtp28aWBSDsY2eHhudFupj5Lvvcjs8DsR311VG5h4oX0JwliFtw2vgZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979271; c=relaxed/simple;
	bh=/iu3i4lCRf05QKtEGgRuwOk5MraCwhiOQ7WyKw5EEtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho4iunIt9532J3cisAhXnx4bQDJG51E5pH1FjfkX15btLsAiDgVtaMZMx40i4tjBBd9aKHaiAcrIwajmX5KGiDGZo89H4WSUe7l5UCvh918/ydJjdD8iTLTNA2Ii25a1OkCepCLwslKfwGwzMovpqV1LUKaQKK7hUYTZAeFtqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5m2k566; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c00cfd7156so125437439f.0;
        Sat, 03 Feb 2024 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979268; x=1707584068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV5GVJAeOV5TOmmqtEiNPh6TTuzFDGGYosrKg+K0ogs=;
        b=k5m2k566fJ7YtNHH2TF3Msj3/C0vvwNV7pQPtna57LR09i7XKiefOZYZ7gmM4fCLqv
         /D92ETJgm0QlXKMgRCVtNi2KBv913nScaEBjkYanq+3u1PAD877OWj54nWnGoTYetkom
         vyhTbdQzkgG/pKdOl2D6zZTMkHxjUuEhM5f+OobyzHrDzSUvJ6PJ4LBsZVQD89zyekkC
         u60gcHz/LNmKNrlp1xCWbyI7TcJr+n2XUBJSi3rtXqIaJ+VtfTGONc+spsrwoEb8azaO
         VuaGcyEqO42NzO4NMb3i+t7wPVJp8Bsckk+9zn6czgWorOYEauZ65vdm3Wf69O8I7zKG
         8eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979268; x=1707584068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV5GVJAeOV5TOmmqtEiNPh6TTuzFDGGYosrKg+K0ogs=;
        b=A+SiWbdILJPsFtuEkDldw4xT5SNv1uoZRv2DAWrw+q2uSQR0zcfggO2CDT+zTWqXai
         11k0tn1K0CYdjX+Jhj3IXzWppEMef9+PIksEwDL0R1ipwUfPK6HZw277d+z0l1N0VYVq
         sALR/1UW0ZrY0wnFAkVGNwRAPRuclkg/GVHK9Jh3L6wtV/dGfX4BMc76YP5R9FHvYG8x
         +NcJ/L/jhlSr1vuvYepSOG1hd6T7KNFV53SE9nrAlHJaeqDgSrYlvzlZa0EZeEHTZ3GI
         BdvntEfL4rSKCbrlWiymhBRpND8yMZ6wMMCQepTcn8XiV8ZA5tRJcZfba/Pf/W7PFmSI
         n3Iw==
X-Gm-Message-State: AOJu0Yy/e99XIGOHK8IG5eyJrn3Bkoeo6XdZS+XOlTmUgSQZUaih5wpA
	rLCB4Gk3pvKVVIHSckqSM87nEb95B/kD5qKVnUcDpGNfUnl5fUXP
X-Google-Smtp-Source: AGHT+IFnDvtXlMmMQMAwllyK2p1O6sOo0/5lgyhi5R6gSBcyqbb6GieWlNuW2+KRpkUDfPvTDFKq0w==
X-Received: by 2002:a6b:6e17:0:b0:7c1:b54c:15db with SMTP id d23-20020a6b6e17000000b007c1b54c15dbmr4318249ioh.15.1706979268376;
        Sat, 03 Feb 2024 08:54:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmqWTm894swln2GDV8F3WEq0djHX3OxF/EqeGpkI7kiPokKS2KcpbgZo/Uut92LTwLhUI6PYbQDh31v+/cFCyk+FJH2smLUK0r/V63WoEXqaD2Cp0aFLb+Hy2N8+QWKvt6x6e6pT0ImqLU9m7LjhQK6aDCCVEbHcYd+SdsbHG1AST5aBMskATXyLHvegi1DtRqOf5M1EjuNqXD1+SyPzdufudg/fCA9qsLiED37rWzRNrj1e2B+xkeiQQOC6iiD6BtQn4BjFCVif3rWMf4ea27VaZ4WGtJw7/2QpKQPpn3scr9XL113hBuZ00WR3QrCR1L9GLav1MBgTDbYEVYTfz0oDB1iGec1YcNnZICfuifQDWEsz+rwno7sL49LLhE6S5YnKbxzPSBW+4yvvRpQrfyjb60E34WzSnUQOcaf6Dv75Z2SduMXvvhVrY5L0NaQ5XEpiF+1ZHVX5cpWqcpK7QdIK3QhV6y2nfJGIznwKDU61GfYW1w6C48a6JGzi/5pxeWexQU/O7lsZ4FPr7CzsUSizXl4QEuQH9hPzT4drBAoA5qm359X+ty9HM68qF10ccyO1npxaJQ1cf5JWCUuZauyXNFz54cAaUsZUjdN3fhgOgErzpiutEPxXwr1GOeeNBmNyDYsPImDEFH46D0NPvt6Jov6X4VLO+Zhmd+N9+XwkSJgPx0eRmT+se+VwAjD0dHBWmQdUlIAZ0fCqF8/mIup/bugxLhtDOm0nCUj5x2nglochi1SjxxVdbIJhjHjc0nVSJNeG2aQ+x23fP7eFf7HcZ3DqBuujqpIYLm1DQwuyIuBfgpAmH9dZlEPegP4DQzDy/HOqkEDdIqO5CSFX8kB5IV/BKnGuhRTIeBo8IHloiulv2DHmwsNH/KTo1zUXvixxQYDmxoqRw+blKfqc5zUCVirPgT/dsqSdbF2f3fN5Dd4MvBmWNqYCboBQj3W0/ris
 emPfAbHNNRrGK4lwUBOjq5ovieCPN1t2tDrNLQzrfSqo6vMcVv5O2MPoOiYjsYb+O1Yw6xBf18ayT5cS03xuZNTZ9njmDDY9M4kenkI/u19v80u6GvW2R4ehld2ewO1GKmkQwVCNxz2+e9mO3RWYe7tVQ2YtKrYS6EJT+49cK5rnNDdDw1h2T7s/gI4BNHB1tlkK8od3YGs7C7rmiIdVQ/oQhiR5vuQA==
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:54:26 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 11/12] arm64: dts: imx8mp: add HDMI display pipeline
Date: Sat,  3 Feb 2024 10:52:51 -0600
Message-ID: <20240203165307.7806-12-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This adds the DT nodes for all the peripherals that make up the
HDMI display pipeline.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>

---
V2:  I took this from Lucas' original submission with the following:
     Removed extra clock from HDMI-TX since it is now part of the
     power domain
     Added interrupt-parent to PVI
     Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
     Added ports to HDMI-tx
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 94 +++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 5e51a766f3d9..e84b4f40e570 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1412,6 +1412,100 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
 				clock-names = "ipg";
 				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
 			};
+
+			hdmi_pvi: display-bridge@32fc4000 {
+				compatible = "fsl,imx8mp-hdmi-pvi";
+				reg = <0x32fc4000 0x40>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						pvi_from_lcdif3: endpoint {
+							remote-endpoint = <&lcdif3_to_pvi>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						pvi_to_hdmi_tx: endpoint {
+							remote-endpoint = <&hdmi_tx_from_pvi>;
+						};
+					};
+				};
+			};
+
+			lcdif3: display-controller@32fc6000 {
+				compatible = "fsl,imx8mp-lcdif";
+				reg = <0x32fc6000 0x238>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				clocks = <&hdmi_tx_phy>,
+					 <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_LCDIF>;
+
+				port {
+					lcdif3_to_pvi: endpoint {
+						remote-endpoint = <&pvi_from_lcdif3>;
+					};
+				};
+			};
+
+			hdmi_tx: hdmi@32fd8000 {
+				compatible = "fsl,imx8mp-hdmi-tx";
+				reg = <0x32fd8000 0x7eff>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_32K>,
+					 <&hdmi_tx_phy>;
+				clock-names = "iahb", "isfr", "cec", "pix";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_REF_266M>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
+				reg-io-width = <1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						hdmi_tx_from_pvi: endpoint {
+							remote-endpoint = <&pvi_to_hdmi_tx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						/* Point endpoint to the HDMI connector */
+					};
+				};
+			};
+
+			hdmi_tx_phy: phy@32fdff00 {
+				compatible = "fsl,imx8mp-hdmi-phy";
+				reg = <0x32fdff00 0x100>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_24M>;
+				clock-names = "apb", "ref";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_24M>;
+				assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		aips5: bus@30c00000 {
-- 
2.43.0


