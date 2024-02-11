Return-Path: <linux-kernel+bounces-60793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A142850981
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785D0B20CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1475B5BD;
	Sun, 11 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG8sFCQA"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B85B20C;
	Sun, 11 Feb 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659746; cv=none; b=SNPXbaD1+4NXwxMV+L49TNHukvv+ErNwatD/DqwK7tgzBaonpnqw36wf5R0KI4iBnEHVb+/TGLkmBiJB+Hcz60MJjY2rhxsaEu3DAaQhk+LYwSlBSMOto5lpddRZPPBlFS48ErHKcpwpa6j4LXIb7j1L0rhTJrrUMP+APHNXmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659746; c=relaxed/simple;
	bh=w5xqFthcDBhxKh3OMcqhHxAaqjlhtZnynuLXQQeVpAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTU2H/ufd2KFR2AfpUzqCimz1se3h8y/OiMfDM3roWRq5eAR3ThCu12B62VwckPdrhScI+zLx5bgxZUei9AS8XxDQppOlRpvfBI2uOxiVQx9MlmxYOOhlEztdD1qLwFfDWZdTBvKNXn9EHFtEuiQp8N0HsjLt+2ytXVIZMpGJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG8sFCQA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-785d5fa8169so5774485a.1;
        Sun, 11 Feb 2024 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707659744; x=1708264544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHezDecZCr8/1EVo1Tr1y30b1k/XQnc+ccR9wgFs+vM=;
        b=MG8sFCQAGphPoa7/cvFmbrgh9ZHXh7SMhI1XTe/ddbzld8ImwJB1lMl7ELg+7pxHKe
         pqiVgayuKr4R89HteHYGsT9yiF5UXgNoRT0505Yvw93s/XTtuL2VippYssR8316tT0+N
         cLyj5BG6x9w918ab/aQ4dixLj0Nd3UPa2ccIOuOQ3pn2dHqdH2EW54boAKIvaZX/1uhl
         wObYoEQF1JoVhHRKEKqDv1fQyB2RJfUbjappXHuBIusAKetDnepXEGPMSPCqVh8iR6EU
         b375VlENtZLBSbjunB8rUTwyT/Mxd3SGb77J6sbDIZUcAsFl918PHkPx+Qb1HG2dv0/G
         +bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659744; x=1708264544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHezDecZCr8/1EVo1Tr1y30b1k/XQnc+ccR9wgFs+vM=;
        b=QxTGimX2CJNFf5DN6zdXjCsQW1EZECr63lmU/WoA4CQUUsRCsFCa3TcfdlsnRh0tPl
         jTkDHPVg1eaWXvnyS9tJxjs2ahPAh68RAUoTNoFweKUYMP2RWTG4JJ83bGnsseL7Kq9Q
         KgHKqHcu5MsHvspVkdSJoZSfn4XLZLhaq5Re3ViiaBVJEnHQe3ZJ+/NEggCoivbp2fRH
         9GvgclNKV1ohYSUMyed9UimU+BquuBFTuNyGPTpmxgSHMSElwrrsVTALyodyrxKqBpEy
         7dNSCDcgHOH81YdLNS8o6+pVDVWqC5+fs4Wb4smoMZ21apS1bSp8MDc5/0MBSQjpwkOj
         p94g==
X-Forwarded-Encrypted: i=1; AJvYcCVFzhgPCo6bj33EjhwTVxeaZ6b1PoLrr1impsAMQyhjhh3pIzBae0pF8SQYpfPIUpNe2BAhqlNN2Fbeon0gdezSCdf50e4VFWZ9T8xf0GZQy75lQNgsx/6Vp6Rmx7ytYGakF9uIANfv7w==
X-Gm-Message-State: AOJu0YyQgo4hKQV6n76c3gKwmyEryt1XvLpCCNqzYG4ecPgoJibW9+58
	wZJpY8h5wb8YbY/2JsP64pvLQi+xqycWsMLadzYhEAFUf/3oSfO2G5cDQNJb
X-Google-Smtp-Source: AGHT+IF6GSK5ddTlqsM9+t2Oe465rwkV8tBFzprzS4PpRTI3dizThB6L0Ca5HwCPbVRE/G8fVbDNQw==
X-Received: by 2002:a0c:e28d:0:b0:68c:cd52:967e with SMTP id r13-20020a0ce28d000000b0068ccd52967emr4155841qvl.38.1707659743882;
        Sun, 11 Feb 2024 05:55:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjEpSkevZY0QXGN39PD9q2XxycynkMr1r0oIF3Aaq6hVFxTEq+bMCRksBtjl9ouyhbqcOpfMxgZ/MfWHlfRsvxIn6xaMZkaLGeYlatBGzC3PVWEcWWKaR26Eu4Tmhp+iwb8rkMSYXVrRLGQt+kfOCyAuJtLhYpvizShP8Ey64E7m28LX/iI2T4UR0NRK4SJziSAxhZ/oySUBaDZcgb7SoW5LxMvVgkfCqmGZmRJIsXUlOprfg7T/ali0vG/Qg3g5QpPFXRLut7FuRIP6k+gg8RshDiausUnDsvakFNq6HfvQaPtJhlJXrwGVsjjzl0DMwCGNhgjKahWBahPbsBcSyueATD1Ianw48FYAFLMw4ERxi2yzBOZALgDa5DH32J1402HMFUKNLm14SJaz/xOJ9a
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c7:5c6f:e011:4867])
        by smtp.gmail.com with ESMTPSA id pj11-20020a0562144b0b00b0068cdbdb8af8sm1823912qvb.119.2024.02.11.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 05:55:43 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-beacon: Configure multiple queues on eqos
Date: Sun, 11 Feb 2024 07:55:34 -0600
Message-ID: <20240211135535.68516-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx8mp-beacon SOM has an integrated PHY connected to
the EQOS ethernet controller which can support up to five
queues.  Configure these queues in the same manor as done
on the imx8mp-evk.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 2ec282b91c42..8be251b69378 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -50,6 +50,8 @@ &eqos {
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	snps,force_thresh_dma_mode;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
 	status = "okay";
 
 	mdio {
@@ -66,6 +68,71 @@ ethphy0: ethernet-phy@3 {
 			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+			snps,map-to-dma-channel = <0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+			snps,map-to-dma-channel = <1>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+			snps,map-to-dma-channel = <2>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+			snps,map-to-dma-channel = <3>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+			snps,map-to-dma-channel = <4>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
 };
 
 &flexspi {
-- 
2.43.0


