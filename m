Return-Path: <linux-kernel+bounces-33207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD5836612
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C1E1C220A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA43FB05;
	Mon, 22 Jan 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DdbVxviB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CF3E474;
	Mon, 22 Jan 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935369; cv=none; b=cMh5VxwoTu3Z7yrl3N+LX5FrWIkPttpfKB8nhwV3YJS/CGRjH2Zi0P3CHtTmqmRS0Eq1T+MIrdkeEsXZCeDI/WHa5Ymnr9fJ7kl7sKrLwPvtJzYBFxKWGHY1vh3AtTqwg8Pcd5RgsivMK5W8UEP9687UaNFHEJRdHEADi4emifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935369; c=relaxed/simple;
	bh=TqKrYA+Byb1zeoOrAb4jwKeN7lOCuoeCLYCEW/2N5To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUBpqv9H3vN8mQjxCojpptdl3AfP2T40zd/5QTJktsKB83wvgC5qTlfj9hkRCqC5CeERRF3UkJPKJVFYO2OJci2GxtT8GtweevDEewOWS1CD/QL5qf2Edu7jaKvACztfLE0DJoC3vvK8PDQ4I6jnnWZ9FiQRB7cnazl/+XtiOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DdbVxviB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiAu068522;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=7zhlFAhqO2lV8Lg6g5i6nFY/4GM72ndVakk+D6U4XAk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DdbVxviBjksMMsN9Q4bQz8uv/gTTfzY1mu0PZVKb1ryhh0WHu+ccxHyV2d0MvulR4
	 h1CvG6CEm8na2O3VpyJBNiMyYEtrXDugkqTz0c3bw9T8qVrcmtyJRCcbfzPKCCOdtB
	 qVt5ICINKJN9XL4dqPPR/4n77LkOWjwlzT7adHGE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEti8V038761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEthlK014452;
	Mon, 22 Jan 2024 08:55:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 01/16] arm64: dts: ti: Use https for urls
Date: Mon, 22 Jan 2024 08:55:24 -0600
Message-ID: <20240122145539.194512-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145539.194512-1-nm@ti.com>
References: <20240122145539.194512-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Replace the pending http:// urls with https

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* No Change.

V1: https://lore.kernel.org/r/20240110140903.4090946-2-nm@ti.com

 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso              | 2 +-
 .../boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
index 43a0ddc123e5..08eb2e894bbc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
@@ -6,7 +6,7 @@
  * AM625 SK: https://www.ti.com/tool/SK-AM62
  * AM62-LP SK: https://www.ti.com/tool/SK-AM62-LP
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
index 3be92c39ecba..4209d991eb6b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
@@ -4,7 +4,7 @@
  * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
  * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
-- 
2.43.0


