Return-Path: <linux-kernel+bounces-50122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0776847488
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3541F2CB78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446611474DE;
	Fri,  2 Feb 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="U2D7rWPe"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254E1474CF;
	Fri,  2 Feb 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890677; cv=none; b=eMkfjndmlSrnkR/EEaCsdqh7imxyfC6BlylcYc7BgHv/FUvgIL6IUuJAaXajQKyQVPro9AyPTBWZMI6YqAfNK+tDT67eDW70mtB6sPp/oXZZNbvA+UEWsy5KYg9EjBmlGuPzkcPpxF5DZOI4Ay5+CovFPUD689J/DP/XLIKE2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890677; c=relaxed/simple;
	bh=AE0SEUj7Y/tfMu8o/0l1ilY4/oHuzQA8xZ6TeYOyFJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nxy4RoZ0ROAwPnQ/tQiuKdauco5zrBmRYq3Q9ZxKxkApB2otYRNMSf2nfnqCABLVvzhwKLlSCZL4ZmOvTbQO25tuEEuEDvUF0te4s0pzgynYEyeR8jt5PzVWLwyJZVWzxiF56xNcHHyOz2wxI5cXbJZlyoODzVc0ESfOn0/qdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=U2D7rWPe; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412G7T7N005383;
	Fri, 2 Feb 2024 10:17:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=d
	ztUlVgM3uruxT9g6eLIIFQ6JObOYYRKqDfkXdE9Lv4=; b=U2D7rWPeo0Kwqh2Mq
	qIqYSkGA2P9FvQOg8UODMnxUo/37N075UlLDm0Q6zn3erVVzSq+Zpr9FxfndCH1J
	FUYa0pl8gfSxTVyZNEnpwZ57YPhv0kopDBurQ+7yJNFYBKTJqtEsdpjQKc++eYzl
	V3fsUilNanUxqiDi+VU2KRZ1n6C7rd5ZDDjiGGPkBdb725t8dLKElgE91CQmGBcS
	HPUvhfoXi8E3maV3zNejSyt/YwPvKkyM7r7+MZ5nxVqsakM25a6d7w40sMLh6K7z
	oXGOePxSS441yRrlHFuV+BLu0OezMDfKyK/DEy06aMyfKcUsMByvqfB5vV0teZsG
	sdsbA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w0puwgqxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:17:35 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 16:17:33 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 2 Feb 2024 16:17:33 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.191])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C43FD820246;
	Fri,  2 Feb 2024 16:17:32 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
Date: Fri, 2 Feb 2024 16:17:27 +0000
Message-ID: <20240202161727.321373-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Lh3Nk5urHu-PSPEdo_zb_V356sj0i91C
X-Proofpoint-GUID: Lh3Nk5urHu-PSPEdo_zb_V356sj0i91C
X-Proofpoint-Spam-Reason: safe

These two HP laptops are changing configurations.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 348505edf063..3d7e7b32fcf4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9855,8 +9855,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8d01, "HP EliteBook G12", ALC287_FIXUP_CS35L41_I2C_4),
-	SND_PCI_QUIRK(0x103c, 0x8d08, "HP EliteBook 1045 G12", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.34.1


