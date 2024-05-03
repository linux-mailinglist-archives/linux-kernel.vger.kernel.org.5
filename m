Return-Path: <linux-kernel+bounces-167278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E668B8BA6F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94908282456
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44713A269;
	Fri,  3 May 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="glUahB9f"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2A139CFC;
	Fri,  3 May 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717483; cv=none; b=npNwxY2oklWdNGLb1xwnHVrVbnCPLcIrasG5LnP1geJy/DKQJAlVSwWVLxXJwmogJNo8ER+7F0/Z2AGj650RCdCGfcwZJ1LfSPYjEnnq0JROleVcKMtLgmEHi25vT7Hdsx5cbNPsDGtZTAvhSKcbi0QIbUE9yNAYavl/P+2oT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717483; c=relaxed/simple;
	bh=YWckMfXt0uuCgdLvy8OJrYniCxpBTDSlYgHjNC8O6Lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD9d2yGRL2wz8OkajX3XWu/7zkiNj6oMEG4qaTN9tgABwjmkh+Mz6zXqY0VSvs3otyo50+IN4LcGx8LsBLFt0mThrBGA90iedWTW2T5ttWkDmQumIb5g42pjy0XCR1p3ssz2+EtKvsTHA8AWFLAhqZFuv8gnoQ/zfmHPFC3+fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=glUahB9f; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4436OM0B026375;
	Fri, 3 May 2024 01:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714717462;
	bh=8pY6VCVAhK+MiWp3SZRUXBx49Zp1WACW7i1uA5n00mM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=glUahB9fG2zUwoTdTQi8iXV0VBJj9yzRMcVsXbsfTpWoIrNzMZiyFllkYP6OWtRZB
	 bbsVm6Qe0JThGGZnNq+9syuOcJlMqPyZh2TAYkwBGA522MuKFXzkbuHxnjQgA3bHwH
	 fH9pYaNCu4B5gkwPyn78zBee17Sn6jNCd7sk9HG4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4436OM5f030836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 01:24:22 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 01:24:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 01:24:22 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4436OEaZ130748;
	Fri, 3 May 2024 01:24:19 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-anna@ti.com>,
        <hnagalla@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
Date: Fri, 3 May 2024 11:54:11 +0530
Message-ID: <20240503062414.804209-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503062414.804209-1-b-padhi@ti.com>
References: <20240503062414.804209-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Suman Anna <s-anna@ti.com>

J7200 SoCs has a R5F cluster in each of the MAIN and MCU domains, and both
of these are configured for LockStep mode at the moment. Switch the MAIN
R5F cluster to Split mode by default to maximize the number of R5F cores.
The MCU R5F cluster continues to be in the preferred LockStep mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for early-booted
remoteprocs through the corresponding IPC-only support in the K3 R5F
remoteproc driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..a369fa35612d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1486,7 +1486,7 @@ main_timer19: timer@2530000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
-- 
2.34.1


