Return-Path: <linux-kernel+bounces-96405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F72875BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC51F2226C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B323765;
	Fri,  8 Mar 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sKpkINbz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28813139E;
	Fri,  8 Mar 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859472; cv=none; b=ZrPz1HXMMtTlySBdCRFLpq+3jpAM5tloOTAZUCJuTDSI08nRhsdtsnV3N7Sdz+lJTQkkwJ6oc+8gMz61jndgCSLHPKWptValkaYMi5P+x2BdFEeN57CRGiGNZ0/ko2guuseK0wvNHl+6ygnZUZ+8/1To87JgZF5trvFZkLS9otM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859472; c=relaxed/simple;
	bh=TeKIejQgSh35+7plTRSY0hd81OvxHiz5CZSPmUw8Fpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tM+2i+A5MNg6yWUsciGfiPFEfwRhVJCikgQOIl5I4Kp7nc7CtyoTwkbbwH4GECydn3OZAdqtpTUt7QYzRkeEuc+rVB2B2rL/5Xs54g/SccfTheQkJJeunnhoTO+1jewplf4SiefsA/bIp+L0EGXTiGQ0c+yPlleXirmWK9iM8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sKpkINbz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vknu130642;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=8gYa92yeRY6/DAmiDJPxUJA2cdE/7PZUE8hLnxuCBAA=;
	h=From:To:CC:Subject:Date;
	b=sKpkINbzt/ur5OZdweyLTY7ptG9pM2JdzGhY5WyqIqxO+WY6fSjXtWblV2kAnez9j
	 MkOknNeHseeV08oJLRGxLftd71IIEWSGAqv4vSFFr/it2w72FkLUGvm/qYx38QGs5r
	 0KjGzSlI+/KFO1gDYL1ucjr0SwtgY7fZ5GIkIiQc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vkQS007717
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjR055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] Add tuning algorithm for delay chain
Date: Thu, 7 Mar 2024 18:57:39 -0600
Message-ID: <20240308005746.1059813-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series introduces a new tuning algorithm for
mmc. The new algorithm should be used when delay chain is
enabled. The ITAPDLY is selected from the largest passing
window and the buffer is not viewed as a circular buffer.
The new tuning algorithm is implemented as per the paper
published here [0] and has been tested on the following
platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
EVM.

The series also includes a few fixes in the sdhci_am654
driver on OTAPDLYEN/ITAPDLYEN and ITAPDELSEL.

Changelog:
v2->v3:
- Remove fixes tags when not needed
- Fix return for tuning algorithm
- Fix ITAPDLY_LAST_INDEX
- Use reverse fir tree order for variable declarations
- Save all ITAPDLYENA changes in itap_del_ena[]
- Remove unnecessary parenthesis
- Remove unnecessary variables
- Save itapdlyena for HS400 timing
v1->v2:
- Remove unnecessary indentations and if/else in
 sdhci_am654_calculate_itap
- Optimize sdhci_am654_calculate_itap()
- Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
 instead of sdhci_am654_setup_dll()
- Change otap_del_sel[], itap_del_sel[], and itap_del_ena[]
 to type u32
- Revert unnecessary reformating in sdhci_am654_set_clock()
 and sdhci_j721e_4bit_set_clock()

Judith Mendez (7):
  mmc: sdhci_am654: Add tuning algorithm for delay chain
  mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
  mmc: sdhci_am654: Add OTAP/ITAP delay enable
  mmc: sdhci_am654: Fix itapdly/otapdly array type
  mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
  mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
  mmc: sdhci_am654: Fix ITAPDLY for HS400 timing

 drivers/mmc/host/sdhci_am654.c | 176 ++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 38 deletions(-)


base-commit: faf3b8014c357d71c7a9414302e217a1dd1679af
-- 
2.43.2


