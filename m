Return-Path: <linux-kernel+bounces-106554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5687F03B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED400284A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF805A102;
	Mon, 18 Mar 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A7/vtALe"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945915917F;
	Mon, 18 Mar 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789113; cv=none; b=IEdLVIyH2hlqhn0oJHOlq+j0h9Nh9I9lXT1qer83V9dXjShkWgdYpvSGcDtMs8tUIl9zZJQoETOlvpLKrLhReu6jKIIWyohheum86h4YQdESSRoMKGEuA29EeZplrqri6zIANbEJX38UTDb3rTuMDb9wG0cVGg5fOlbpUxiVF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789113; c=relaxed/simple;
	bh=Il/+UkX6s/gBW9ffFzPmPo2/NGxTWJQCDvuzBU3+Urs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2t5fGQ1EPnf0S1KPtRaWjdD/EoL2V0N63xI9JAmcTcPCU6/8Zf2sNQP565N9CyHFHzakKr94IMObI8SBIeHLqVH4Fn2gqa2Vygx+jRCnxRZDd/FqGLQhdSSn7uu/5U5fy8bXk1nETZaJWQD74qrqXawp2VtDfHdhSn85ektgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A7/vtALe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhmu027768;
	Mon, 18 Mar 2024 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710789103;
	bh=gT57yxSHU824uBIJVC2fGHKbzz8VftyKwdqtWuO7w8Q=;
	h=From:To:CC:Subject:Date;
	b=A7/vtALeg6fNGzZpe6VRJ6yfnu5mjI/XXyOQTcPp05de5s7aLZXyy3R2OmGEeSV8Q
	 q7yHNc96Cb5t9b+i5qnAyAZOSNQ63/M+y2NNKNDvgpg29w41gtXSvEdW6O75q3D7QA
	 U2PzwEtB9a6LDlZDHPH0uGRTJANYAaSvhOj5eWBM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IJBhn8054628
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 14:11:43 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 14:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 14:11:43 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhc5077624;
	Mon, 18 Mar 2024 14:11:43 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] Add tuning algorithm for delay chain
Date: Mon, 18 Mar 2024 14:11:35 -0500
Message-ID: <20240318191143.27638-1-jm@ti.com>
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
v3->v4:
- Add acked-by
- Remove extra newline
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

 drivers/mmc/host/sdhci_am654.c | 175 ++++++++++++++++++++++++++-------
 1 file changed, 137 insertions(+), 38 deletions(-)


base-commit: faf3b8014c357d71c7a9414302e217a1dd1679af
-- 
2.43.2


