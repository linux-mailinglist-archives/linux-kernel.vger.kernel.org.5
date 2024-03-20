Return-Path: <linux-kernel+bounces-109463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812BD88198E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374BC1F22427
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D758615C;
	Wed, 20 Mar 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgtcbWn1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0968562E;
	Wed, 20 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974323; cv=none; b=GBlbxI1q0p/6jwowyujzGOb9wO3j70Zwpyw5VpXdp1/1nb9/c2WAwkhoWzm2gS25OKUtWE+Otom7NkZ/mJRw4Cx7S2EjmuBvOd1u3tnQdpseWsT6UvfV/rNwdeWI9ViQQ/JRO/IlHxcmmPasFQgwPaeGfhJBpzITMKVys7Zc9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974323; c=relaxed/simple;
	bh=tpyWdyjSsP+daxF6OoB1lyBOWSFqopLKhrW8aYpDHR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyDpr6wj1j9Yo538z+j5AuuQ8VwNlUq7SGVW/sD94k8GfMCf+WIUTx9RwLaud1+Hok8tMOvkF7bCT1hr3EdM3v/TXEw3o50Z7u1+BnGh0nJem4JOxnCANfZqtEIUpO5ZJDaKQrGZURrmLs7x7PnG1tELpDSXUCUAatNS+WG/2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jgtcbWn1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbwL010266;
	Wed, 20 Mar 2024 17:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710974317;
	bh=mDiYRNcI/MhcHCQFcwYplc0w//g18+WYtTLi9NZcXxo=;
	h=From:To:CC:Subject:Date;
	b=jgtcbWn1Dr0Wp3waS/61fxTEik2ZVS2bZQnSeDiyPXtpR6J+ugMp6l0dPkEfMI+yT
	 OlUK8Xkknf6TdtFd3Yn+sWQqxbCVaTCKkoLgTGQIPk5qy5A3jJtQKRRAzsY7HGgCyL
	 skgUKNikVllMTv2ldpH6FNMXDOyswISCAaqs3RFc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KMcbu7053636
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 17:38:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 17:38:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 17:38:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbum036138;
	Wed, 20 Mar 2024 17:38:37 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/7] Add tuning algorithm for delay chain
Date: Wed, 20 Mar 2024 17:38:30 -0500
Message-ID: <20240320223837.959900-1-jm@ti.com>
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
v4->v5:
- Add dll_enable = false
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

 drivers/mmc/host/sdhci_am654.c | 176 ++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 38 deletions(-)


base-commit: faf3b8014c357d71c7a9414302e217a1dd1679af
-- 
2.43.2


