Return-Path: <linux-kernel+bounces-106280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2D87EBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2781C21428
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA14F1FA;
	Mon, 18 Mar 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LsA889O1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF34AEDD;
	Mon, 18 Mar 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775053; cv=none; b=oVDBkO2DhZnlyHaWrPX0hJyMz69Hl4rQwQZTOO73ugWr1Z4UujnEfmijyxBM/zy2wFzDl+0jX+V0JMrOEzpBTU9yS1leQId9oMcuod17CtQm5pcUJRnTNeO0H790CsWVJ0DEsBpWH9AcEXDuGv/buTFOuOLoQbD5qhrXH3MWaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775053; c=relaxed/simple;
	bh=w2n75A/kj3J/4IBH2cC2pSlyikWeeKJ87ThFP0+iN6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KsErf2lPCKukrLLthWVf+4kYFgP4xka7pepLBRLGwiq2AoqOBar3X8HXz+Hz1MJGedcBxF7Ye5TXkPEcv2QFCIY6Kc+a5qvdWsTY3y4lDqCG8qjTEQ5R/HwI3okDPfxO8x5897o04BVHDM4bDEjTtzUx4n77p3Co0KMEHpBuiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LsA889O1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IFHCwl088234;
	Mon, 18 Mar 2024 10:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710775032;
	bh=M0aS16XjNekktHyawIldzzdU9h0bG+8UksAGhO2RXOc=;
	h=From:To:CC:Subject:Date;
	b=LsA889O1oMYe0v4pMtoY1zRB/UJDAaNp1ZMfpsEeyMQJbRovGqQ1YAMgLp7IGnM8B
	 1JwCxivPkssEdbeEPr6BlVylA11KPo+8BZiNTxt6dt2Ki8u8K5fdEYWQ26vJtnscon
	 9trR8YAQx7mXUmYMNHrL4a1EMG871b88om+ihr6k=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IFHC7Q031746
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 10:17:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 10:17:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 10:17:12 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IFH8GR095329;
	Mon, 18 Mar 2024 10:17:09 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V2 0/2] PM: wakeup: make device_wakeup_disable return void
Date: Mon, 18 Mar 2024 20:46:30 +0530
Message-ID: <20240318151631.1621881-1-d-gole@ti.com>
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

This is a follow up patch based on discussions with Rafael[0] on a previous
patch I sent to propagate return value from device_wakeup_disable
further upward inside device_init_wakeup

However, it doesn't seem like today any return values from
device_wakeup_disable are very useful to the caller.

I could only spot one caller of this function that was actually
propagating the return value upward other than the PM core calls. I have
tried to update sdhci-pci-core to work with the new changes

[0] https://lore.kernel.org/all/CAJZ5v0jbHwiZemtNAoM-jmgB_58VqmKUkqv4P7qrPkxWzBzMyQ@mail.gmail.com/

Changelog:

v1 --> v2:
* Squashed the mmc fix into first patch [Rafael]

Dhruva Gole (2):
  PM: wakeup: make device_wakeup_disable return void
  PM: wakeup: Remove unnecessary else from device_init_wakeup

 drivers/base/power/wakeup.c       | 11 +++++++----
 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 include/linux/pm_wakeup.h         | 12 +++++-------
 3 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.34.1


