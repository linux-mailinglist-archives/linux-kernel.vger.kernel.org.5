Return-Path: <linux-kernel+bounces-132682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB247899889
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87851283FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE315FD0E;
	Fri,  5 Apr 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A0qnh8y2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955015FCE7;
	Fri,  5 Apr 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307149; cv=none; b=E6dftYaQMetqAv1BFcuhayl0CYPZCBH5vHDntvJ5e3Y9OHWgN2lz9FIo60qF9OVox6UUWzV+JxsncP8woHlVpJwajTRc5b7ymdKiL5z3TH9Tsp3cuG397lqlYisOphitFJNV+2JhhaLuVHmA5FeRBTLapZpBZzMutsApLPb4Il8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307149; c=relaxed/simple;
	bh=KH4tIB8MEJtaXqNCZ8ucp+IiBLHorX22cq3KG9pe6g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gTjLUgiUwCcyNILrcETltpedymAJnuYUeu+lVFiCvoJANAWodXTHYzPcDbn8JuS9gbG61m9ejF2uZjjXHHmQreRBv7mJGwZyt7JvxCm9wP8rKqfOYmIk9mU7ScHKPUok5Kia2WMRiRM6Qs+Dit/xB79EdsGdObS4U5ors3pn5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A0qnh8y2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358qA97040700;
	Fri, 5 Apr 2024 03:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712307130;
	bh=bkjx/8ToHSwIO3I+N2Gh680PfuvhGZ0zihLB3JROhD0=;
	h=From:To:CC:Subject:Date;
	b=A0qnh8y2GO66xQcFFJN5oO+4caF0C9rsSUIwqhb3Tu/bZfkjjic6UAaQRs/Xq3Tyc
	 +8AxSrAWAQuCb4/jEo9iFoEXpgbfgHPM/tlS9gCM/kifTV6spwbqJ9kRIUhgnyp8zL
	 5XTPew6k61JM2dtbbDpU81T8Nd5fMo1EsTz+ryYY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358qASo012714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 03:52:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:52:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:52:10 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358q9rQ052143;
	Fri, 5 Apr 2024 03:52:09 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <devicetree@vger.kernel.org>,
        <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] Fix reg ranges for dma-controller node
Date: Fri, 5 Apr 2024 14:22:05 +0530
Message-ID: <20240405085208.32227-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The dma-controller node 'main_pktdma' has few memory regions with
wrong sizes.

DMASS0_PKTDMA_RINGRT is marked as 4MB region when it is actually a 2MB
region. Similarly, DMASS0_PKTDMA_TCHANRT is marked as 256KB region but
the actual size is 128KB as shown in TRM in the section for Main Memory
Map (Table 2-1)

Fix these region across AM62, AM62A and AM62P (which is also used in
J722S)

TRM:

AM625: <https://www.ti.com/lit/pdf/spruiv7>
AM62A7: <https://www.ti.com/lit/pdf/spruj16>
AM62P: <https://www.ti.com/lit/pdf/spruj83>
J722S: <https://www.ti.com/lit/zip/sprujb3>

Jayesh Choudhary (3):
  arm64: dts: ti: k3-am62-main: Fix the reg-range for dma-controller
  arm64: dts: ti: k3-am62a-main: Fix the reg-range for dma-controller
  arm64: dts: ti: k3-am62p-main: Fix the reg-range for dma-controller

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1


