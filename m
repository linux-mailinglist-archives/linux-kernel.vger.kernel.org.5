Return-Path: <linux-kernel+bounces-163799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED38B711B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FF31C222F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2412C816;
	Tue, 30 Apr 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aWEk6jA0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAC12C472;
	Tue, 30 Apr 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474385; cv=none; b=gAyEetKd+ifRB8qAAYl1lX/VVBO+8NAHgr4AWTUYdfZCy0OMG3xMcwABrIovxVf3+NN4wRjEVwLE+MQshC7Dc/Qd8dlxRH9a0e1+085Jz8CbBW2Vm+IgSdC5DPFnVvFp3qw7AVFBL2NTr/zp00M6cf+wch6FCAW6TCGyJc+ZTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474385; c=relaxed/simple;
	bh=jK0QQzrQz3cCgNrOG7EB1dTpyxXLgqJ9I1xSmjq7AHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/CMjTD+7jpHq1BMCTHb0HmPqpygExvMciKcMRfG9pygYa3ypDHO/NFQ2PGYk+LjXHOfBAHvTCEUZS/TTAcgN96xA4X0wkeJmKWUj6JV+ZCjf6tYhXAvySMML0h/MH1zVSIJrDGW2w9hT1SwgoSyd3hs9ZnEnYu70BksswgVuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aWEk6jA0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UAqtHM130368;
	Tue, 30 Apr 2024 05:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714474375;
	bh=1grfJVdE3qxPY13h7SWzTRMLsU98hLQw9+TNVJnyIZM=;
	h=From:To:CC:Subject:Date;
	b=aWEk6jA0L/pZSLWqvPwjWfzNg97T1YmAv5ZcqzBEbNZkrAuCrfnZFh5YB2CqgUSd+
	 rMcSVsEn0P1k0u0nzdFLY9noVQq3mjn2ggScZq+Rs6gseWxmPj/CQbM/6+2X7zZ0KB
	 qEQuc0afs4QtsIV9+vaI1RO9LjSbDqExbCUsVPb8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UAqtxV031348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 05:52:55 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:52:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:52:54 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.115])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAqrhP037903;
	Tue, 30 Apr 2024 05:52:54 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] Fix reg ranges for main_pktdma dma-controller node
Date: Tue, 30 Apr 2024 16:22:50 +0530
Message-ID: <20240430105253.203750-1-j-choudhary@ti.com>
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

Changelog v1->v2:
- Add main_pktdma node name in commit message for more clarity about the
  dma-controller and mention the table for memory map in TRM in each patch.

v1 patch:
<https://lore.kernel.org/all/20240405085208.32227-1-j-choudhary@ti.com/>

Jayesh Choudhary (3):
  arm64: dts: ti: k3-am62-main: Fix the reg-range for main_pktdma
  arm64: dts: ti: k3-am62a-main: Fix the reg-range for main_pktdma
  arm64: dts: ti: k3-am62p-main: Fix the reg-range for main_pktdma

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1


