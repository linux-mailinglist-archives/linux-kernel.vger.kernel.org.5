Return-Path: <linux-kernel+bounces-55779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6084C1B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EDD1F25177
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3DD2FE;
	Wed,  7 Feb 2024 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gQVmsxkr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A88F48;
	Wed,  7 Feb 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268525; cv=none; b=meeP72FErvplYMxxzRXV1Tjs3F+X2QPz9eO9yj34PdtKB4qrOEmEW467hI6cgiw7ihokxd4Ea01K6Fvlj26mVK4WTeaVaNIXTxKjhbWx47pcCuYb2ji+qDkjFfA3dCiKLVqkn5tptLFx2vSNQrXXnIXHnzq+ya3LUwAhciiG0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268525; c=relaxed/simple;
	bh=jb0WADSs8jzHMDJOumcCK5xjY92G5/BQFltArPqFDCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fu4oPRNDUUrLbe4FvrWKW5ZWtXfF1XPmPFaDiBeo/bPmCLmsMiZD2HcJe9FwxA6nPjG8QVIe8UwA+te28nQX0/a0Zvg3iAmjE1g8UVqsDR3v6UzHRLQtSWKv4Oxk9sDPhBvlQmP+0jTBP1LXe+ApLZGsZaj78wqHGUoumlGVVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gQVmsxkr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKgD053885;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=nLwkfNDASkjCG3CEoS36quV/YANOd685QNozGD7eIdE=;
	h=From:To:CC:Subject:Date;
	b=gQVmsxkrPJ0jn9/Va0hRfHlV1T23hZ+X+gKQt/EIQzZ+l5wRzRb6aET49EFfpX6Lr
	 Mk9iteoZ06coQdt22XvkgANmyIsJlSdJufVLqWy6QPIHzY0pXd7uC2rrN6vZ+fTcrC
	 52F7+Yq1pYi1pE2AcbqzbaRyuIiZEZkFXxHx1CNE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKA8109412
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMo122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] Add tuning algorithm for delay chain
Date: Tue, 6 Feb 2024 19:15:13 -0600
Message-ID: <20240207011520.3128382-1-jm@ti.com>
X-Mailer: git-send-email 2.43.0
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
  mmc: sdhci_am654: Add missing OTAP/ITAP enable
  mmc: sdhci_am654: Fix itapdly/otapdly array type
  mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
  mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
  mmc: sdhci_am654: Fix ITAPDLY for HS400 timing

 drivers/mmc/host/sdhci_am654.c | 176 ++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 38 deletions(-)


base-commit: 40d83f40c44ba8aa79cba409ace619db3a7f86f2
-- 
2.43.0


