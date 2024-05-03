Return-Path: <linux-kernel+bounces-167279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72888BA6F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA111F21C50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593D139D02;
	Fri,  3 May 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SkQ9EgEH"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A513A41E;
	Fri,  3 May 2024 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717487; cv=none; b=tzG8louOyRhzUSVAMlThVjis/eufGsOj+MOF9KQCPMT6P8e2ZNjohCcltyqmjIl+48Fg9LCn1a64hviARuDYm1vfXCLJ6FimwR4Wjy6vnRt09M3azGEm2esJaIXvvJ4AbZzFb2Rbcv/aS8CkNqC8J5gZmtOw4/VPEF6morusWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717487; c=relaxed/simple;
	bh=ms787+VDSUJVr4gentGEwMrxdU0V9Eq9IdAE2jQcbXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrtfNQLSOTQNAGX5lEGGoXTUJsVeM+ZykZmi7hWEzh55QFVRP+ytHKSyZTUQ/q3vfLe6M7sTlW/joCwpEVY/ukTdpRGRDXXWWy7KdIZYn0NrnC4VjTUjaz61awzF24was7dR+FSFmIf50Mech5ErgInkXN+8KxP3p5Rp36NTmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SkQ9EgEH; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4436OQwc003348;
	Fri, 3 May 2024 01:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714717466;
	bh=mJ1DVQQVz2yseshJunHssERf6F7gKZYeGqOa+0gs7yw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SkQ9EgEHNgMJRmSOAJ9GD0dRxIWasX6Vj5Kxs/6Pj+TUPg2EJC+quFlnlEnHAt3UV
	 G6k2rFOO2KiToYkrip3mLX1Mm5Lok7nXPLIPJNUBY900YTlC6KoHTrTHhsD1jQT9gI
	 YBFMj2ohav2z6gHzqf+bZWZhOmGcjZoHkgcUNaEQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4436OQce030872
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 01:24:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 01:24:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 01:24:25 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4436OEaa130748;
	Fri, 3 May 2024 01:24:22 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-anna@ti.com>,
        <hnagalla@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e-main: Switch MAIN R5F clusters to Split-mode
Date: Fri, 3 May 2024 11:54:12 +0530
Message-ID: <20240503062414.804209-3-b-padhi@ti.com>
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

J721E SoCs have two R5F clusters in the MAIN domain, and both of these
are configured for LockStep mode at the moment. Switch both of these R5F
clusters to Split mode by default to maximize the number of R5F cores.
The MCU R5F cluster continues to be in the preferred LockStep mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for early-booted
remoteprocs through the corresponding IPC-only support in the K3 R5F
remoteproc driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0da785be80ff..a11af617a566 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2149,7 +2149,7 @@ watchdog1: watchdog@2210000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721e-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
@@ -2189,7 +2189,7 @@ main_r5fss0_core1: r5f@5d00000 {
 
 	main_r5fss1: r5fss@5e00000 {
 		compatible = "ti,j721e-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
-- 
2.34.1


