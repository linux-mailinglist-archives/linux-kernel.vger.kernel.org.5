Return-Path: <linux-kernel+bounces-136149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8508A89D07F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D272828C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE455776;
	Tue,  9 Apr 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYNZwNdq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66654F95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630986; cv=none; b=DaD7bWV5Z5I7RTWvxLZyeNYk/UAPLUmD/OHQ5G87rEloYgGqd5lN5ccnh3BR6XuvEDUK5+H7mv7BcvPgPmXXcIn4qEslzK+8Y7L0I3yrA0so/4F1wQE+jSyHGI8QvzDco/6DH64+OHXrslLjgX7vRb6AGDC67DW+xDVc74pv3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630986; c=relaxed/simple;
	bh=k0KGMptnz+F1UC0zIJgwuo+OTxL6NVxrxti4vjkbAO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6ZzxScxw60KwI6u3owsyIKdy8kalrDr0mPEp8xbyGGy7fKHhN1KLYgOlRPQqLWCM1nf4cmRnPmCwsOciYHOYxs1wcngarwVIl8V49yrGKFJoRT1INUuDfwvZSheIgVrS1da9ugltBuvu6sOpQS5aGzqFPyHYNhAcsMUqOBPxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYNZwNdq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4392mprT035069;
	Mon, 8 Apr 2024 21:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712630931;
	bh=dU9aZ6uKGPORdccriw5y521hjgLvs8ulO4Q71rRgmaA=;
	h=From:To:CC:Subject:Date;
	b=GYNZwNdqiecEjxVLwd/GflJPsm351Uy41Sf+oy5DRCfQoyM+tdGKIeJfj0KUre6NN
	 Bhxst1fIa8xo5xp0CrzZgzX77PoMx1YR0HjpABrWmU1Xa+LkXL/bT0Cr99G/UZyHMo
	 DCyQmADIVZmyWxe6zA+LJr8v8n5qny6cGWpwD/3s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4392mpPg021108
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 21:48:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 21:48:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 21:48:50 -0500
Received: from lelvsmtp6.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4392mikr024930;
	Mon, 8 Apr 2024 21:48:45 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v2 0/3] ALSA: hda/tas2781: Add tas2781 driver for SPI.
Date: Tue, 9 Apr 2024 10:48:12 +0800
Message-ID: <20240409024816.1180-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
It use ACPI node descript about parameters of TAS2781 on SPI, it like:
    Scope (_SB.PC00.SPI0)
    {
        Device (GSPK)
        {
            Name (_HID, "TXNW2781")  // _HID: Hardware ID
            Method (_CRS, 0, NotSerialized)
            {
                Name (RBUF, ResourceTemplate ()
                {
                    SpiSerialBusV2 (...)
                    SpiSerialBusV2 (...)
                }
            }
        }
    }

And in platform/x86/serial-multi-instantiate.c, those spi devices will be
added into system as a single SPI device, so TAS2781 SPI driver will
probe twice for every single SPI device. And driver will also parser
mono DSP firmware binary and RCA binary for itself.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Baojun Xu (3):
  ALSA: hda/tas2781: Modification for add tas2781 driver for SPI
  ALSA: hda/tas2781: Main code of tas2781 driver for SPI
  ALSA: hda/tas2781: Firmware load for tas2781 driver for SPI

 drivers/acpi/scan.c                           |    1 +
 .../platform/x86/serial-multi-instantiate.c   |   10 +
 sound/pci/hda/Kconfig                         |   15 +
 sound/pci/hda/Makefile                        |    2 +
 sound/pci/hda/patch_realtek.c                 |   15 +
 sound/pci/hda/tas2781-spi.h                   |  162 ++
 sound/pci/hda/tas2781_hda_spi.c               | 1336 ++++++++++
 sound/pci/hda/tas2781_spi_fwlib.c             | 2289 +++++++++++++++++
 8 files changed, 3830 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c
 create mode 100644 sound/pci/hda/tas2781_spi_fwlib.c

-- 
2.40.1


