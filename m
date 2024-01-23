Return-Path: <linux-kernel+bounces-36139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC43839C27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056DD289D78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88254BE6;
	Tue, 23 Jan 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NjaccLT4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EA4F8A9;
	Tue, 23 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048752; cv=none; b=J7AdSBJbYg4X4UzTSo4DIp4fZ/7tt/gSuU5Ho53Mdt637YMmUit7qEg5ejoacXlzZfTEQziRulIas7Wu10WfRvN5OnweJ/BZT/UDH/gkS/k24AR3N40u8iQ/TJlHLXeR/728aCvX5IUWaI9k2HbxhqBqH9ejLQfUORenatRjIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048752; c=relaxed/simple;
	bh=xu0LZYDaXZx6BBoy5rzc6LxYf6GwfXiEYSMteQMIf0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYpDXJ8SnFZSsKT5H5xGf+P3DUwvuwQ5sTfmvqD/1F4tXrNLV0w4PDOL/DPGhizwrpenCU9hFXhEU+H2319RFQPZVoQmmDep1QNjMh9/y+ryMMjx+zVIHHWro66dGQXFr6ZS7a8UFRDop8y0vJX7S/w2FUcuNf9jV4jeWdyXRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NjaccLT4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPetv035835;
	Tue, 23 Jan 2024 16:25:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048740;
	bh=j9kP+qxBQdDc8gyKUuiBVklmjZTQzdzXaVXX4EEmkmU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NjaccLT42hT7pbR0hddJWS/XLVLnrDeNsmQAyIr/SO31f+phiiDv1Ed6lis1qdypM
	 KkWDbAKe2gmWc44VGdLtnacZh2BHh8nGCq9E1To4F3W16nBY+VCBr6NRN8YG3czyIa
	 ud4njsfoVzIdF9+xNuHj+SgZBgvvOuYqs2ShjtOI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPee3122101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:40 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:39 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPaba064564;
	Tue, 23 Jan 2024 16:25:39 -0600
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
Subject: [PATCH 07/11] arm64: dts: ti: k3-j7200-som-p0: Do not split single items
Date: Tue, 23 Jan 2024 16:25:32 -0600
Message-ID: <20240123222536.875797-7-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index ea47f10d393af..228efcc170afd 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -222,25 +222,25 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 };
 
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
-- 
2.39.2


