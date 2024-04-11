Return-Path: <linux-kernel+bounces-140158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E218A0C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08831C212CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBC144302;
	Thu, 11 Apr 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XduEHopA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FB13FD65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827196; cv=none; b=EJz29rSm1i37WQyGcqU7Wvc+syN1l78MVcMFNJ4slzovSq4soiiNK+Mzsd37r0YgvQmn5vPeidIi/mO3fx/BtTNSJUUfJ318iUWbfBRTyysor+I+bRvsioXPCmofGp+V/hjapKTa0RO/YEnyz/7EVF2EqAohcIeGJ8FRWMWZuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827196; c=relaxed/simple;
	bh=yYbX9c2qG5hlbGJoAqWEe2556cH0fQSMa1/Q7x/jpyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8Derv+7XZWcKBmgWPdvXLEHmX8fd9lV24vYNJEW/nIrj0zmzIAPB6XnqNk+e2E+/I3q/hUROMVVUe+Ye9R6Fr7QYOb/U9HEts8V1u9GkaktJGF4VQYPNuZCovxVbqzfNnBvK+Ncn6HV1N2TU1EqiXuWR9CmPpw2jkW6TNxZ37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XduEHopA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43B9IYKS034162;
	Thu, 11 Apr 2024 04:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712827114;
	bh=F5Y0bUvegQqfSxqsS076FxIFuEmQqXXMOCGWbJ4XALE=;
	h=From:To:CC:Subject:Date;
	b=XduEHopAZwOOP0hobXBhZoJ82MGjl5D/SKIxH8ZDTbvcxuvpHfleJNe/3JPHGrGSA
	 FLAp2cMUDktmViv4iEOJL2oB4yz4Rb+4Q5SK7S50l/hi6uxWjUW20G3mxKqhFvSU0o
	 uYMDY/9I/i7wPlZumI0Ob4wwLm5paRnun3hQcI9E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43B9IXcU128003
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 04:18:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 04:18:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 04:18:33 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43B9IQ6Z064389;
	Thu, 11 Apr 2024 04:18:27 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <mimperial@lenovo.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <bard.liao@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kevin-lu@ti.com>,
        <robinchen@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>, <navada@ti.com>, <v-po@ti.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support ThinkPad ICE-1
Date: Thu, 11 Apr 2024 17:18:22 +0800
Message-ID: <20240411091823.1644-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add new vendor_id and subsystem_id to support new Lenovo laptop
ThinkPad ICE-1

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdcb28aa9d7b..051ca23c8cfa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10333,6 +10333,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x222e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2231, "Thinkpad T560", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC292_FIXUP_TPT460),
+	SND_PCI_QUIRK(0x17aa, 0x2234, "Thinkpad ICE-1", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
-- 
2.34.1


