Return-Path: <linux-kernel+bounces-163464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E218B6B98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5861F21B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B83F8E2;
	Tue, 30 Apr 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GoTCIlfl"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2372C184
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462073; cv=none; b=YxGvfWYw0uDwehvj+VL0k6Ipztk4dqWvtFYzJkej46qJwIFN8huZGBRlRycSF4M7cXQPd39QOjgEaHiRKurG+h8T05YDa8OeHJf55/voIqVrmwdG7PrtrmRyyX8OCg2o74rzH0vNVCFnSKvmnvXA68u4/LgntqbNwysA3RGo2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462073; c=relaxed/simple;
	bh=f4HexFXrgl33Xvb0NsdgdkEQEzHfWh5sA10LWpZKdS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lh5bKCBRIhqy7Yv7nHm4vqC6t2aPlFhK6MjT8iuDMLU3TPPjd1E+4e02rAZ0p7O4mqV79kDLQ6tsdKO6NSVZEYRAIludam9tfdpe1qKmzMpwZDdIqcE1+j0WcWQJfZ5nihpbGvvU+ABx+b8j45wfiKJTvwL04hOa6RPhMWG3kZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GoTCIlfl; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U7QbNU087453;
	Tue, 30 Apr 2024 02:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714461997;
	bh=KTYnkmUys+v1UyGXnvoxWeo9cURnTj9K09u6LrUM9CA=;
	h=From:To:CC:Subject:Date;
	b=GoTCIlflIYy4J7RgskGGNAOfB0uv3KFT0dmKyNc/UC1SFKtYY3meBzzuE+BpkaZ05
	 PbmjhSBbE+3ax88IjO6NkJgRpcjaMssHVtSA3XCQs7It2o8p0MRiA5Vug50H8Kam81
	 zj0UC/aNjsN6JPTvHp2QSAngJTksVlGRsNz1mWLs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U7QbJr129537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 02:26:37 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 02:26:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 02:26:36 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U7QT59096668;
	Tue, 30 Apr 2024 02:26:30 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <13916275206@139.com>,
        <v-po@ti.com>, <niranjan.hy@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v4 0/3] ALSA: hda/tas2781: Add tas2781 driver for SPI.
Date: Tue, 30 Apr 2024 15:25:41 +0800
Message-ID: <20240430072544.1877-1-baojun.xu@ti.com>
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
  ALSA: hda/tas2781: Add tas2781 hda driver based on SPI
  ALSA: hda/tas2781: Tas2781 hda driver for SPI
  ALSA: hda/tas2781: Firmware load for tas2781 hda driver based on SPI

 drivers/acpi/scan.c                           |    2 +
 .../platform/x86/serial-multi-instantiate.c   |   13 +
 sound/pci/hda/Kconfig                         |   14 +
 sound/pci/hda/Makefile                        |    2 +
 sound/pci/hda/patch_realtek.c                 |   13 +
 sound/pci/hda/tas2781-spi.h                   |  149 ++
 sound/pci/hda/tas2781_hda_spi.c               | 1240 +++++++++
 sound/pci/hda/tas2781_spi_fwlib.c             | 2252 +++++++++++++++++
 8 files changed, 3685 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c
 create mode 100644 sound/pci/hda/tas2781_spi_fwlib.c

-- 
2.40.1


