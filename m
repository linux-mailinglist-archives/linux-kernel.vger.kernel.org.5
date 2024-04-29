Return-Path: <linux-kernel+bounces-162843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD8D8B614B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C202840C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98513AA39;
	Mon, 29 Apr 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IVomnz8S"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652B13AA27;
	Mon, 29 Apr 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416305; cv=none; b=k5Yk5FLBta8V2/qobd9WaW6s7fQMA4aHDcY5smzSDzlnTqEqPVJ2+qp+r9W+Avkxbk6O0klenODUi0bOwWMehvJ7JHsqNcc0f9yr8NVOBRjjJHr8/aNBIyfuKaS2hvNfjNB8McQ3wRYL7xSRIKHgWeAx23J7zeQpv1/V5gCW9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416305; c=relaxed/simple;
	bh=zPY7hLzbTy+LxKVaUSHZBYlNztmRr8ZvA5EWhz9y/AA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gX0x8nrg7hWOrjREaKixG1SYr2zEEvIgMwV5B2Nf9vmkXLpt4HqL7nl1o61g5I1iS+9giHAhuPFkPhKpFUbUFumd720PbTKP3xpbfD5rQuQxcieUTsuxE6+fYAXDE2xGgwL+3QO65+r3sfOL5jPP7nIODQA0k50IjJHJsmSacdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IVomnz8S; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TIimib008705;
	Mon, 29 Apr 2024 13:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714416288;
	bh=emWvFMVSjdWWzi3lqsMnMIF5LXNxHU9wHxBHQfKmECE=;
	h=From:To:CC:Subject:Date;
	b=IVomnz8SfnaDvqtA3h3ANEQNt2t1GoI/EPs+DhQ4kMxaRdNX5A0DJnCV0dxnXr9U2
	 UtfuAhqt/nVknsfVvqmFNnuzlrJud+vVwPYjEOy5DJ8LaslWZjj+Uw2ck0uBkqSwQ2
	 miKzTo08LuCAVOQ6oqX4Rk9OUGTgnso9+UtXUfKA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TIimsm026726
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 13:44:48 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 13:44:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 13:44:48 -0500
Received: from udb0866455.dhcp.ti.com (udb0866455.dhcp.ti.com [128.247.81.242])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TIimMB052574;
	Mon, 29 Apr 2024 13:44:48 -0500
From: Vibhore Vardhan <vibhore@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <khilman@baylibre.com>, <msp@baylibre.com>, <d-gole@ti.com>,
        Vibhore
 Vardhan <vibhore@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am62a-wakeup: Enable RTC node
Date: Mon, 29 Apr 2024 13:44:45 -0500
Message-ID: <20240429184445.14876-1-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On-chip RTC is used as a wakeup source on am62a board designs. This
patch removes the disabled status property to enable the RTC node.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index f7bec484705a..49a577a37ccf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -49,7 +49,6 @@ wkup_rtc0: rtc@2b1f0000 {
 		clock-names = "vbus", "osc32k";
 		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
 		wakeup-source;
-		status = "disabled";
 	};
 
 	wkup_rti0: watchdog@2b000000 {
-- 
2.34.1


