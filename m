Return-Path: <linux-kernel+bounces-48177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D2845844
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE51C2A4F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802A5339C;
	Thu,  1 Feb 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B9sq9QGz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D486649;
	Thu,  1 Feb 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792110; cv=none; b=H+4D1afTxWe5htJe25pB1TbbvEi1UyY69J386oBFHfIOz/9+Qb7HeUeA/rbW4mTxVM2sr3x39R8LEQ42xiGE4GJsPaxgPsRmGxaMds4WaUYaEVexr8LCv88YvsjwAoCRF12XvpLejRA0vBVHo6xmLZhP2mO5bBUZLl2mhwqUpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792110; c=relaxed/simple;
	bh=Mr/Zkt8JPleAbXMnwe+hgMTOnTk7eqQCY4KlDPbx6LQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhYKf+Ic4zntce9UXZWXCiZvDWFMoGdL16fWyUsifV1kQ2FgOOtqIWu+TYxrdkyVeCMJHRFsD2xV6SFhczsI84kmBH1/izre1MrwJVK6HtmG/zEqfVxxpkz0jd2i/XvjGCQaZ9rYOoCQI0HqM2b3spN8zmhAe7SQPr5SvN3UnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B9sq9QGz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411CswDn030469;
	Thu, 1 Feb 2024 06:54:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792098;
	bh=ljOISbxwAaWgC1U7v2QSWxsLa2EOhwDdDPkRu4yl3fY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=B9sq9QGzABbE4gs1OlFCPozh4Jk4R8cxTYRSImwhzwEw8zefLzBXbimP3f6xE0P3Y
	 kqjXCRH8Y6Icjm3Ow+mO3SsQVbMTFW9lsRYFxuLjGzB3TearKySefnrzayDYc6R+lQ
	 bxv+eYpszs+iorMo7V+lKp07TOnsicXiycJ2nXZA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411CswW9055124
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 06:54:58 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 06:54:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 06:54:58 -0600
Received: from localhost (uda0496377.dhcp.ti.com [10.24.69.150])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411CsvGJ125154;
	Thu, 1 Feb 2024 06:54:57 -0600
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List
	<linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai
 Luthra <j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: Makefile: Add HDMI audio check for AM62A7-SK
Date: Thu, 1 Feb 2024 18:24:52 +0530
Message-ID: <20240201125452.1920623-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201125452.1920623-1-a-bhatia1@ti.com>
References: <20240201125452.1920623-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

HDMI audio can be enabled over AM62A-SK using the same DT overlay that
is used for AM625 / AM62-LP SK-EVMs.

Add the sk.dtb + hdmi-audio.dtbo combination for AM62A7-SK as well, to
check for overlay applicability during DTBS compile tests.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..a0304fcd6b5e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -101,6 +101,7 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
@@ -118,6 +119,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
+	k3-am62a7-sk-hdmi-audio.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
-- 
2.34.1


