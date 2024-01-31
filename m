Return-Path: <linux-kernel+bounces-46185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD62843BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD57D1F2807E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E269D01;
	Wed, 31 Jan 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iAiPeekn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B76775E;
	Wed, 31 Jan 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696098; cv=none; b=mtdTT6HRnUAe/QkeAO7VvtdVFVrA5jv0tXdPEr97TVVMK+BHghqVvtp1/6I0yJufgDsHUcXNOOC+8E5OdLe6tdP4W8JxGLpEJztBRJM6NEQ7vkbhRogaNnaLJu+pHYLiq8MyDZTFYfobC8ppExtDjO608KAnt0Os2gbmLe4Lj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696098; c=relaxed/simple;
	bh=IkroIMjgy+G5btOeuOvlYGekXmTMKjluqKOiathfD5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQsrvVN+RTLpug27Z0IDHSBht53LlMJoU0pYmAEkojTjS4i/es62oXKfvfXSrQMvsVoX1hmqfFD8K6bBQgGhWew7cKN9Tn0+Us1B7WKUuEf3hCMzJK5wZJBGxGqIUvXfz/4MekOaZ6qnZfPyo87ULjHvjauVTMQOjjTbmlUrZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iAiPeekn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEm7Q055753;
	Wed, 31 Jan 2024 04:14:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706696088;
	bh=gx0uOPVMLK8j2rTRmqiR0p0caoGaUmIzhyugNe5BgM0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iAiPeeknL35yUYkeeJGXXbz3L+XoIaFQV6U51kWF5dmZPm3ttoARTKak+K2foutVQ
	 iDXJgbQ6yWQuwEJN6oZwhx4D4bLXJF1xauTzEVJaubapYt87RKkA9a0eK++EG9dNcW
	 aewiSlP7c1DkWJdQ3wRXEg7+qZusjnb2mC0ffo7M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VAEmfC025166
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 04:14:48 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 04:14:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 04:14:47 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VAElod110235;
	Wed, 31 Jan 2024 04:14:47 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v4 2/6] arm64: dts: ti: k3-j784s4: Add alias to MCU CPSW2G
Date: Wed, 31 Jan 2024 15:44:37 +0530
Message-ID: <20240131101441.1362409-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101441.1362409-1-c-vankar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
for the port directly from U-Boot.
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d..b74f7d3025de 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -27,6 +27,7 @@ aliases {
 		mmc1 = &main_sdhci1;
 		i2c0 = &wkup_i2c0;
 		i2c3 = &main_i2c0;
+		ethernet0 = &mcu_cpsw_port1;
 	};
 
 	memory@80000000 {
-- 
2.34.1


