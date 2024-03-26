Return-Path: <linux-kernel+bounces-118234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5B88B691
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFF82E5995
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7881CFBE;
	Tue, 26 Mar 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R/691TJz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835F1CD3D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415430; cv=none; b=ProFCC0EN5Vti8SVCLmaTfYZQJpYk6nH4Bv+wxBJ1YjHR82HLVU+WGitn1hHz9YKddluTWLJvnCmLCYXK3Rx0QcM4r6yGwdpHHk4AQ7DESWiKCdpiXpo1zn54yMbetuDayZMRH6kvnXHLLDawlV0URxAE+BHa71wqh5vRTmebt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415430; c=relaxed/simple;
	bh=4UhIaRuRqOaV1kNp9rkdyUlih5CFb8snPx0syCyI9mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgvHqadZs/sjSF6sKfefkU1loBrvrAAba15aA45qucvHkp+0Z3AevZmxLCw13lOlqF77ZsdDm38QhG/lJO+JRY7I/esEfqKerORoKQuINAiP0L/vuwHNv6mI66Wzp699RbIdr/rcOd1IrOaRLMAKx6nahY8FdYyQdsEqMXXhOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R/691TJz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19bxa009408;
	Mon, 25 Mar 2024 20:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711415377;
	bh=RbeU+aw5VD2UBRL5kXuLqyoGiW/SJVQAUj1q0YE0QXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R/691TJzGyOngMeAmFffVlJ7rJtIqSawHulrWQOO7AXNBuCNuAzf9osIaBc7YwruN
	 vExuE3g2gIW1dZVOL/O1Gs5Vaw1qABmfEjtgLCEvCVrFKFS8Aj9f/NWQMEfb8zdxQv
	 CynxJyk1GEqpksdaMaO+UqBNIHoYomHzz0popsi8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q19bu6005200
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 20:09:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 20:09:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 20:09:37 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19AYA120020;
	Mon, 25 Mar 2024 20:09:31 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v1 4/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Date: Tue, 26 Mar 2024 09:09:01 +0800
Message-ID: <20240326010905.2147-4-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240326010905.2147-1-baojun.xu@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add tas2781 spi driver files.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 13e04e1f6..9785cddb4 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -39,6 +39,7 @@ snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
 snd-hda-scodec-component-objs :=	hda_component.o
 snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
+snd-hda-scodec-tas2781-spi-objs :=	tas2781_hda_spi.o tas2781_spi_fwlib.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -70,6 +71,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_SPI) += snd-hda-scodec-cs35l56-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
 obj-$(CONFIG_SND_HDA_SCODEC_COMPONENT) += snd-hda-scodec-component.o
 obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
+obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_SPI) += snd-hda-scodec-tas2781-spi.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
-- 
2.40.1


