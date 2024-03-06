Return-Path: <linux-kernel+bounces-94233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D551D873BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1335E1C23C51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681EA13540F;
	Wed,  6 Mar 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P0KNUYq3"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B121350DB;
	Wed,  6 Mar 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741423; cv=none; b=rEi42dPDVIufgGYgDCOxMEkbij9jpU+4XhrrcJGOjltK+7RSUXEEz7iWcPJZgIC0xjfD/B6M2ZSCf+ffeVpodVeOiwTyGuy81fCwR3MuEib6l+kAUGndUJD9YvSX1Ukfu9LLXViQ6e4Glxa1QHg21GPlYGR/Pjz4sSEIkuN9P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741423; c=relaxed/simple;
	bh=G00J+4+dUpxZcMeleRzQ+W3voC5Yy0W0ueS7BgOeBg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOdLlLnN2eDp6giNSSybumbSqYvKPZy6zVG8a6/oiC4QCEvJJKzz+aoRZ+opjtvIzsH4q7sj5Mqqv/iZFLHg14CAyNi2X81dm5UQ0qKabyiuVyaQs6OuqFiMVF1JzNRy4VpH6DdOL8nV2UwLy5irQTeN6h0NVkKf6073haavf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P0KNUYq3; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266X7ls028436;
	Wed, 6 Mar 2024 10:10:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=b
	K/C31EqXJEuE0lvSsG+3sKplYWwbWFlvFfoWCjeDP4=; b=P0KNUYq32Yl31DDRz
	r+Ftv0GAFmjAoVyqGyGGFDs1RombMe6oVOsqWZeuzzqY5FuByuPyKo+nTWOOZDDR
	G78J9Hog2mY0PNY4PLU12Ek5MpInYekEQ13za2MYNs/yd8R0nYoOmBTMesK3tQFt
	um5/A24m9PUmJUtZFlzBc0zuwpNKwuwlO4tXzg0JfWbFXOvSWvugkJ3agFBFjtk1
	4i+NXxBZIWF0Cx+wHHMU+CT4DlbfMqdn61yb15BoJUDKOadcsVq8gQzCv12UgC/U
	iCQJhp0HYXKFzYVMQ7ZsWGnQKPZ+pj0aJlrowR3BGlSvYcfQWTBzEjpKfUwYPuhQ
	YUKug==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wm2d2mw78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:10:06 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 16:10:04 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 6 Mar 2024 16:10:04 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 56943820243;
	Wed,  6 Mar 2024 16:10:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Don't limit native CS to the first chip select
Date: Wed, 6 Mar 2024 16:10:04 +0000
Message-ID: <20240306161004.2205113-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9M5OlHJauDn5O2rakFhdG7BiTEytYT0q
X-Proofpoint-GUID: 9M5OlHJauDn5O2rakFhdG7BiTEytYT0q
X-Proofpoint-Spam-Reason: safe

As the chip selects can be configured through ACPI/OF/swnode, and
the set_cs() callback will only be called when a native chip select
is being used, there is no reason for the driver to only support the
native chip select as the first chip select. Remove the check that
introduces this limitation.

Fixes: ef75e767167a ("spi: cs42l43: Add SPI controller support")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d45d9e2e16116..27c995b657f2c 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -148,8 +148,7 @@ static void cs42l43_set_cs(struct spi_device *spi, bool is_high)
 {
 	struct cs42l43_spi *priv = spi_controller_get_devdata(spi->controller);
 
-	if (spi_get_chipselect(spi, 0) == 0)
-		regmap_write(priv->regmap, CS42L43_SPI_CONFIG2, !is_high);
+	regmap_write(priv->regmap, CS42L43_SPI_CONFIG2, !is_high);
 }
 
 static int cs42l43_prepare_message(struct spi_controller *ctlr, struct spi_message *msg)
-- 
2.39.2


