Return-Path: <linux-kernel+bounces-50213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EAA8475D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB732959BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195E14C5BD;
	Fri,  2 Feb 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YNpPnRm0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E614C594;
	Fri,  2 Feb 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893737; cv=none; b=sdl5X3A+bhKDsXfDRL9EQYestTqmSz7PPVlqom8JumNxCZ/nglduE0YJcppDZfhvhTnrJ2+fUnC64+eOq7lIdEC9OxUj2vpqWivB/PWjdHZIondDlWdCD9xUnFa4k474thCvGzcCvYFs54fhw6/HHHG2thVz6FnZaW47Tez8hfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893737; c=relaxed/simple;
	bh=n7dJMVI068abkx41i1owQt7AFxVmgCir8E9N+Q7lsug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzicGtiPFdR27JO/wmwAsO+j/s9wOOnsfk6TyxHLDDfWCMIfxfI6rusvDRJHnqQTpBbiNgUw2Wy/LKwME1HoWO2HlDey6RrUmqESoRUZtB1W3TWGJIvUDGVT2eHqAYaTnuuCR1FRV5IGRYrmRhL5KI/Cz1aFdV6rt4mVNVa8U4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YNpPnRm0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412G7M2j013161;
	Fri, 2 Feb 2024 11:08:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=o
	Y+0TBrmVbqVRe9GsKH89Cjn0lEAjYQJNhHXZcdhOnQ=; b=YNpPnRm0NwDchvvwK
	moKgLtwKB0r9shYJ+IUhVgMaKFQN3swErYgqrviPoa/MPnG3tx8e2t7cLqw8bJNs
	Ro9CG/O/T0p4OKt+DEIaf7xz6XPRHF6cx7XagMqNnEbIFBGrXbSTRqnQQmiZV2F6
	ChYl6EsdBWv7ijqCoiwJz2JRDjkFw2VxvYt5UOQ4kGI4DCjN7+lGOLSo99o0NhWP
	SP8IOXOB0IB9xoQy4uyK3WiAA6C0CoZpkzsZlC91Ze1UH1cg26k5DdZjeVgjQe91
	WIl64wikmAWL8wuutkZT3BSXshKglu5Ce4UwHkvBlAAlag57m/HQqrNQMTnnmXZH
	QPNOA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3w0pwx0sd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:08:46 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 17:08:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 2 Feb 2024 17:08:44 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.191])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 64B59820246;
	Fri,  2 Feb 2024 17:08:44 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
Date: Fri, 2 Feb 2024 17:08:42 +0000
Message-ID: <20240202170842.321818-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nh77Ipbv6KCK5tgXpCvkIzzUfG8HapK2
X-Proofpoint-ORIG-GUID: nh77Ipbv6KCK5tgXpCvkIzzUfG8HapK2
X-Proofpoint-Spam-Reason: safe

The SKUs, and associated SSIDs, are no longer going to include the
CS35L41. They may come back, but will need a different quirk.

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


