Return-Path: <linux-kernel+bounces-47208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0E844A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C98B29923
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1313D0A0;
	Wed, 31 Jan 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aCBlxTj6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C43B7A1;
	Wed, 31 Jan 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737850; cv=none; b=tHs063usNkKSsr1mvXWCFb8HywWB1X7RtnEngrP2sKb8v9vIbgEHD9uT3Jfyu2JjAu4bjGRbW2NCKOc1T1oAvAP+sPDzDB+fFLKXwOHjrZWyjoumx9u1R43e1f7bbVF/WWH30gBdzyv+bpEMORGVrZsVSeG0CB/s2lhzK427HW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737850; c=relaxed/simple;
	bh=AJ7CHvndAYS2a3l/+9EVCWRU12fx/Hr9/yeThq5Bej0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SoiYJ2hcET+nJX67fbCQ3qgZ+mYNe4IshhNK4E4K6fJaZzHy0DLMtHiZWo3q5rJ028JDvJcmL5jYgaDUJD68lwiXBDKsTeNe1+uT8H+X17W+pUUC13A1ES2NqDC9JE/WkBkTSJHRR17wY2CAybqy0YBv9XkKJ97cjqAorw+jKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aCBlxTj6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLojIm123740;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=JQQNLrzTHBVd/MJigjdcPGt25xZhhB98X0xrCURyJCk=;
	h=From:To:CC:Subject:Date;
	b=aCBlxTj6pSQ5/+uBH2SH6xMedU3r4a78+WKJnWP1UMKr2IPAQp9B2nCo0a2LxXpHZ
	 mfl5tcTv69ch1PVlxKvHsjUlBWicxUKQMc4CQwGwIoV2esoWg9SIK9QbFKR8oqr+cc
	 ZvkovStHGfu8M/pOd3tN/mAgSFazbNh3wNqFXYbI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLoj50006408
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig2062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 0/5] Add tuning algorithm for delay chain
Date: Wed, 31 Jan 2024 15:50:39 -0600
Message-ID: <20240131215044.3163469-1-jm@ti.com>
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

[0] https://www.ti.com/lit/an/spract9/spract9.pdf

Judith Mendez (5):
  mmc: sdhci_am654: Add tuning algorithm for delay chain
  mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
  mmc: sdhci_am654: Add missing OTAP/ITAP enable
  mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
  mmc: sdhci_am654: Fix ITAPDLY for HS400 timing

 drivers/mmc/host/sdhci_am654.c | 215 +++++++++++++++++++++++++--------
 1 file changed, 165 insertions(+), 50 deletions(-)

-- 
2.34.1


