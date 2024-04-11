Return-Path: <linux-kernel+bounces-141679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F48A21F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601F4287CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CF47A5D;
	Thu, 11 Apr 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D0zKLJTs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AD224FA;
	Thu, 11 Apr 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875988; cv=none; b=e0pL41j2x6MUJ5daA8o2OPy6bQ3a34KghNCIUWustnOP+SwvuPFMxJKndq9cIssRnmdm5Tm1JTzUIsZm4bJnw4uljS/svoKlZjrEzxKsgTBfIv2ON69M9Axwvubl3l6WHkTn9FG8zcMP+7C0sqYL+5xialzB9+tsdJlP/EwpbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875988; c=relaxed/simple;
	bh=zvmvF417rrunT9iqHHfUQkubRPufaxCziKLZeyjCEiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3RZVvK+CoBHE1RnOnOJNwd4pb2GXYFjAcTNoHVgebZ+YY3xp9cugHbAwIkjQ1jL6dCmw1yz00G6XIfRDyE8OhCpSyJUsjupYVfbwYv8VM8PwYo7tnDd9KQ89lMD+/wd3hvO42YxhI5DMQUskMM4B3Xgn29sj+4UvsPoCYLRS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D0zKLJTs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqwIe106823;
	Thu, 11 Apr 2024 17:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875978;
	bh=2LfTDKlFS9AeONkXkDfJQ8nmESoidJKOear7mi/CZWg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D0zKLJTsLgbiDY0k/nZoElt03uCqZTNTQPqUZ/QWRgiBEpbx/kV7KiOvjzXnbFZrE
	 91nUFIYd5fGuH53/DYBx6I56duAIrEHcoI5L/ysZSMywK0czdfiEygsBsfI1a/2Dzc
	 mTM7lfnPjgVj06hdwG4Hnts/FuyqLoGw2RFBciDI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqwqX108003
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7d002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 7/7] arm64: dts: ti: k3-j784s4-evm: Remove HS400 mode support for eMMC
Date: Thu, 11 Apr 2024 17:52:57 -0500
Message-ID: <20240411225257.383889-8-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Udit Kumar <u-kumar1@ti.com>

The eMMC fails to enumerate intermittently on HS400 mode. Also
observing multiple CQE recovery warnings.

Update the sdhci0 node to disable HS400.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bhavya Kapoor <b-kapoor@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[Judith: Reword commit]
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c57..04a241a91e6b8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -791,6 +791,7 @@ &main_sdhci0 {
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	no-mmc-hs400;
 };
 
 &main_sdhci1 {
-- 
2.43.2


