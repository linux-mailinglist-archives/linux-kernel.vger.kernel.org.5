Return-Path: <linux-kernel+bounces-36133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41E839C15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A0B264F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743894F5FC;
	Tue, 23 Jan 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qgiXSoN2"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188D4F203;
	Tue, 23 Jan 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048748; cv=none; b=DVJ4YWJ+gr/sj2UAadHJx/flWeLOEO4VtmLxQPxJgv8KAunGjqfJq2DfTReGfy/GXMJKY9uxBuJJegsTWCvbxtLYzjfbrOdM8kw0/lbmDx9QY8VatFTsA9qp60tOZuB5M3g75IxomGT6x/4WaKytjxexytZf5AW7HjsdFlS9lOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048748; c=relaxed/simple;
	bh=i0yfXtshw6lO21ZutGgj1XMPJwPTE49CZBgl2deMjoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRuDcQ+mcS4B1yNM6nRMkGFspgmhoxGpMwyZIEVDNe8RSI4mwzI+8d6saDq9cGlAW1ziudVYFd+jzW93xD4skGp2UQhPDrxqQYqs9Q7DCMythFsfno168s8H3BzpRn1JVtGc1C0OnHNZkW/AkhIXNoLc2Oa1eETzentKW6oW1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qgiXSoN2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPcqv040286;
	Tue, 23 Jan 2024 16:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048738;
	bh=inqyc2jgv1Tymrek8RSJMk+y59S85OdTsyWcgQe8vf0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qgiXSoN24GQd8PXVc+txMESegDnZMmDDrfuTt1tZlOqBszInIXqUJ1RppsYoX1Kzx
	 R1L79Z1U/nxC4N7z5hkPeRpXizjOl8Ay4p4NskIvr7A0BzeBfZisx4lFpEbLCH2uxg
	 5E93pmqQ72WdB4ajAmfHKvs2KzOzBLPWVrbgtglU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPbe2122077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:37 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPabV064564;
	Tue, 23 Jan 2024 16:25:37 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 02/11] arm64: dts: ti: k3-am642-sk: Do not split single items
Date: Tue, 23 Jan 2024 16:25:27 -0600
Message-ID: <20240123222536.875797-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123222536.875797-1-afd@ti.com>
References: <20240123222536.875797-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Each "mboxes" item is composed of two cells. It seems these got split
as they appeared to be two items in an array, but are actually a single
two-cell item. Rejoin these cells.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1dddd6fc1a0d2..a00c20b99dfa8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -646,25 +646,25 @@ mbox_m4_0: mbox-m4-0 {
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
-- 
2.39.2


