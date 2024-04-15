Return-Path: <linux-kernel+bounces-144872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39A8A4C09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F29F1F22873
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17A47F4B;
	Mon, 15 Apr 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N2D1JOId"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8942047;
	Mon, 15 Apr 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174989; cv=none; b=G8noFHuo17pewF/RfHtQ8pE6lsJcgNHlSo1sXBJRgnMTEnqnNmMeByktSimKOeTc9B83qa6L0B61U+CI1ejs2WHjJwFRGqiMFj44cXqXuUWbCHaaXspd+FvAyCJmFaSh0VGgBjtAp1L5h29kSjWT947dsS6CL8Ya9ha40F9ha6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174989; c=relaxed/simple;
	bh=w9nJd1Yyg629O9/LcumIOIpNJlnLkq60aaUGSc5j7wY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iCTScIiXx5Epk/GVulwu6FqtKpHBFYNzkL4CEsovZBkVF3GqlTqXv13IMbZUZ5Nc5LzYmgJlsCcLBy7HVZs8sU+QBsW9aVqQEdnEO8XsLU+0Loh0Wh5WCJyhsrkzV7q6a+75BDDFBbZs7Vgfyu4q/EtagMjcjC2WeSzMFgicfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N2D1JOId; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uG5M062313;
	Mon, 15 Apr 2024 04:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713174976;
	bh=ebNW8pq7U1s+pcNdkGclNKb7uVEz2W19YON2XIEij9c=;
	h=From:To:CC:Subject:Date;
	b=N2D1JOIdDFWvnkw81n5WXlly26z8PytvVH5QaeMH4ZVLRMy7YS+q55eteXpvx9kj+
	 JXOuYhQcjluabXvBQ6Tckq7/h3FYCnq1Kbn58odedwnrD933N3R8mSfVyFHh2eA8ZE
	 IN2gJbPfTyRvdF26RGkGgT6UIkKVugJwVCamm968=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F9uGKc119947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 04:56:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 04:56:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 04:56:16 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uCqv074231;
	Mon, 15 Apr 2024 04:56:13 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH v2 0/2] Fix UART pin type and macro type
Date: Mon, 15 Apr 2024 15:26:03 +0530
Message-ID: <20240415095605.3547933-1-u-kumar1@ti.com>
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

This series fixes UART pin mux for J784s4-evm and am69.
Along with replacing pin mux macro of J784S4 SOC instead of J721S2.

Test logs
https://gist.github.com/uditkumarti/a28ec171732e32c16b2666c27093c115

For fixes, these errors should be caught during review but missed due to
cross reference is taken from tool's output.
Note to self, don't always rely on tool's output while reviewing the patch.


Change logs:
Changes in v2:
Splitting patch series into two as refactoring and fixes,
This series is for fixes, refactoring will be sent later
Link of v1: https://lore.kernel.org/all/20240415063329.3286600-1-u-kumar1@ti.com/


Udit Kumar (2):
  arm64: dts: ti: k3-j784s4-evm: Fix UART pin type and macro type
  arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro type

 arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 12 ++++++------
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1


