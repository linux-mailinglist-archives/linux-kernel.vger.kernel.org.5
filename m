Return-Path: <linux-kernel+bounces-162036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5828B54F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8494FB21438
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD92E639;
	Mon, 29 Apr 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k2rcLcOP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55872C85F;
	Mon, 29 Apr 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385955; cv=none; b=Tf+sr3raex/+fgiso8pnqAdq4cs0QWRaO5Wdv/9yiQ5XXZzBtFuN6mPAJlxUKc+thxgl9OM2nrSjyOVO9byTdLRmxxQ+enCrH3+0H+M4P1p9S0n3v0U4oTCc3kDWDIdjZxvBFcspX2/DsD6D9c/PA2TvgYM7XOuJfbkol89U+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385955; c=relaxed/simple;
	bh=ev59AdWAbZ/RQemLanIauu8AZNYsghNpk9ou1NHvgiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqmkQpQ0qDOvK6QmfGO9xNKDoO+e9P4ex9UC3rYp/5wlpSEGtWVRgfc4zPg3ln7/RWDDT7lPFmzkbuU3I3Q99J4Gebro3OGRtfeIZhrcSM3D/yE4zQlSBQnnwDQDD/UjRS7Am6CIkxY8TJeL9OF92kMDBSl7FSLSa85uLCXktC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k2rcLcOP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHhSg021072;
	Mon, 29 Apr 2024 05:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714385863;
	bh=5qXLHhWtt8flgYzu6zKpGgw0uVBc+TpXixF5TewC2Vg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k2rcLcOPieASl5t0pnffrFMWVVDMxy59epLhqAzuN8jA7zQEuNfOQZgI86h3rH1SW
	 aDcz0BZAmp5u2/Ahk1NHJgWe5KnQRWGv7FJziw1sHuDQAIKj5HVU3D32E4H+WUbP23
	 lhEPZH8y4ZVzzSASO7+LJNphezvbNE72tr79rE7c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAHhP9017110
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:17:43 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:17:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:17:43 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHgjF103061;
	Mon, 29 Apr 2024 05:17:43 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G MAC port 1
Date: Mon, 29 Apr 2024 15:47:38 +0530
Message-ID: <20240429101739.2770090-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429101739.2770090-1-c-vankar@ti.com>
References: <20240429101739.2770090-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Add alias for CPSW3G MAC port 1 to enable kernel to fetch MAC Address
directly from U-Boot.

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425102038.1995252-2-c-vankar@ti.com/

Changes from v2 to v3:
- Collected Reviewed by tag from Ravi.

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index fa43cd0b631e..5aced7e56192 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -22,6 +22,7 @@ aliases {
 		serial3 = &main_uart1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
 	};
 
 	chosen {
-- 
2.34.1


