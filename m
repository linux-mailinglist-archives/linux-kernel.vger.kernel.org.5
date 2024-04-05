Return-Path: <linux-kernel+bounces-133591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C490889A608
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B71F228EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964A175542;
	Fri,  5 Apr 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DuM3G8uQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD71C36
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352297; cv=none; b=LzMFZrMPXd0IWA+qzZz4gTYlkkMfPrpDW8QmD8Bc9qCYVqUGnHUyLelL5Frjb/jwxsnsnHLoha6JzOiJ4DgNg3VRx+1YLn8MOGa/9KVh46XncCrBlJFRlETww+Al+wbfq5zhIlZG5t9vYgKOrmBqpzA7/Y1Z9bfS+g/q23l/IAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352297; c=relaxed/simple;
	bh=AzRzhyt+Vd1boYqQdmsKxcKo8CA6xnf/+ug55dlAcB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/ny9jilUqWotFnZ8uD6/5IzjnuAlcDHB+MufrhHNQb5def9Erz952VYf+Ls28JZE5duBreCbQYDZvvAkvCRYyN1jwaq6hu81akmCKjv8pO1123hbp7FnoHbYhbozDGMjFsf6VeArRJR9n2kIhgZnPT6gHSNZgiLrlxTPH3OG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DuM3G8uQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 435I8xXx029173;
	Fri, 5 Apr 2024 16:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=C
	9xz+q7sZO8o2T0HIFUpDXObF87YG74PWWGj+Gj3weQ=; b=DuM3G8uQfZrZMEkYL
	zpo5GuvLH7n6HUcJF6/CQbz9MJ2geUx0uwXVFmiUw6BYfGuWhN7MWd5RZi/cO10q
	YnVkL/z8BZoRiQDMqNK/HcyX6Vo3IzkjTIgZRAPavdyms5F9oKNd/T3NJkxAvuCk
	M+ygjLdmWccEsmwO/+TS3jJEYYo8O6mRTDo372GhHMSDPvf1sO4435nj/rodWsv/
	qWmhavKXOxE8MYjTp7B/NB1NVewdebGXOCfQ+y4YuIRpJIg+PL/Lk8dsHqDbSuWI
	cL+8D1nT0SF6s2m94yq1RzSlqhtAE0eXGpQN0MWKuejLKrwjoHmU0hgoTKMyvJpp
	1sOIg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x9em6a4pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 16:06:51 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Apr 2024
 22:06:48 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Fri, 5 Apr 2024 22:06:48 +0100
Received: from lon-bigdaddy.ad.cirrus.com (EDIN3CZV9K3.ad.cirrus.com [198.61.64.177])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3BB21820243;
	Fri,  5 Apr 2024 21:06:48 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>
CC: Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov
	<vitalyr@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP SnowWhite laptops
Date: Fri, 5 Apr 2024 22:06:35 +0100
Message-ID: <20240405210635.22193-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LG0YJO8b7yPBTUgBPBVWPxmRa5ixgG7z
X-Proofpoint-ORIG-GUID: LG0YJO8b7yPBTUgBPBVWPxmRa5ixgG7z
X-Proofpoint-Spam-Reason: safe

Add support for HP SnowWhite laptops with CS35L51 amplifiers on I2C
bus connected to Realtek codec.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36aa5..5baf68c254d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10037,6 +10037,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.40.1


