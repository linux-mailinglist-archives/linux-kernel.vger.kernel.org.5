Return-Path: <linux-kernel+bounces-167281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A218BA6FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713EF28243F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34EA13B2AC;
	Fri,  3 May 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XUccKRDe"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924313AD07;
	Fri,  3 May 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717491; cv=none; b=LThEdIDCbfbX5uChIL+ccX6MIhUJn/iD6cjwhEIqVsrVz+91EYXeyr9EhxYraaG3xb+KQDAay+rKNdTzxGVXHmXUa7wFlRbTKT1WO9ivQjsYgva2ifu5w8xmm7N0mll9QCSKzgR9JboTajoFwqwt8yLmAY9mhsffDsiryio/DI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717491; c=relaxed/simple;
	bh=QK4xl41vQAE1xnSXmqdpkXe/jrg9iwGvYYWY6EEEoTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnOD2B7KiQL62R4uhdTdCUUdqTQm3pAFF3URS/E73QwsLEv+86yTnXOvKW1JimrNZN3q2w3fbaD/0thHLnosQ3TdUYKxUNNP24A3pWLPkI6FPrEBvItVGN+PnMfvRcIJx1SRp4Ja28bUJ6yQnR6W3kNNIAf3eM6MhwQusEo3OkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XUccKRDe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4436OXvp064035;
	Fri, 3 May 2024 01:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714717473;
	bh=OYsNoLqDAhPK7pUA1MXB8AlEWHrz+SfUy54AUBD+Zqw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XUccKRDe0PcV3vOAYifIi0jQvvmDoVnHmb+ZThwlJr4yTQM/NiZGUtjOPXqNfvxin
	 onYLfGoD0Gmc2okCMFUpWi7/LyrZGw/1pFRd7QyrWMvEL7Bci2Zkq37Ozz8JRvFsAX
	 qv+/DRSzEbWgL+CaoZDZjWnuq4neaat8POyOxhho=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4436OXpF037806
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 01:24:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 01:24:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 01:24:33 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4436OEac130748;
	Fri, 3 May 2024 01:24:29 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-anna@ti.com>,
        <hnagalla@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j784s4-main: Switch MAIN R5F clusters to Split-mode
Date: Fri, 3 May 2024 11:54:14 +0530
Message-ID: <20240503062414.804209-5-b-padhi@ti.com>
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

From: Apurva Nandan <a-nandan@ti.com>

J784S4 SoCs have three R5F clusters in the MAIN domain, and all of
these are configured for LockStep mode at the moment. Switch both
of these R5F clusters to Split mode by default to maximize the number
of R5F cores. The MCU R5F cluster continues to be in the preferred
LockStep mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for early-booted
remoteprocs through the corresponding IPC-only support in the K3 R5F
remoteproc driver.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..fa4a1008a587 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1811,7 +1811,7 @@ ufs@4e84000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
@@ -1851,7 +1851,7 @@ main_r5fss0_core1: r5f@5d00000 {
 
 	main_r5fss1: r5fss@5e00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
@@ -1891,7 +1891,7 @@ main_r5fss1_core1: r5f@5f00000 {
 
 	main_r5fss2: r5fss@5900000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5900000 0x00 0x5900000 0x20000>,
-- 
2.34.1


