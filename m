Return-Path: <linux-kernel+bounces-5552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C979818C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333AA1C23DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949921364;
	Tue, 19 Dec 2023 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IIT2R+8t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8520315;
	Tue, 19 Dec 2023 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ6vo3A022423;
	Tue, 19 Dec 2023 10:22:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=kWx+FOgFshuXbEEqkcUUBv5Kl1kbOKWb4xX0B875/08=; b=
	IIT2R+8t3bT7OdewwNHScukbYxtUDo26JLmOO9T/Ab9SLxPlqSu+WSErFFSyKPen
	VJ6YdtDeQGYge5BoBoZQx1+8V54g7FQxmIwG/iXkCOChn0zKyg9VvQVE4au6TDcX
	jSO3e/qfvIxEjn1T3cM8d9a+qQ1b/KwZPAyS34nXbINCO+HkdslSPtfVcnOFwNv6
	wZTGJdOWQKVQk8z5MjKABkiQvUQvsijpooYlTNbZ2wV3h5k7xroFEPct21vUeLAV
	of0afIOtumAtJBHJwcYL7l1Ls8/fAXHywuGP2rF0L8ao0k/XGsi7UJimzxX98x1h
	/dAjOZdDQJRY+Zpnti1xlA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a6249gs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:22:47 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 16:22:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 19 Dec 2023 16:22:43 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A9A715B9;
	Tue, 19 Dec 2023 16:22:43 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/2] ALSA: hda: cs35l41: Do not allow uninitialised variables to be freed
Date: Tue, 19 Dec 2023 16:22:31 +0000
Message-ID: <20231219162232.790358-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
References: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ODee1_Mhp9AwakRjhVnYukfjuVkbAeWJ
X-Proofpoint-ORIG-GUID: ODee1_Mhp9AwakRjhVnYukfjuVkbAeWJ
X-Proofpoint-Spam-Reason: safe

Initialise the variables to NULL so that they cannot be uninitialised
when devm_kfree is called.

Found by static analysis.

Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c9eb70290973..73b304e6c83c 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -77,10 +77,10 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 static int cs35l41_add_gpios(struct cs35l41_hda *cs35l41, struct device *physdev, int reset_gpio,
 			     int spkid_gpio, int cs_gpio_index, int num_amps)
 {
-	struct acpi_gpio_mapping *gpio_mapping;
-	struct acpi_gpio_params *reset_gpio_params;
-	struct acpi_gpio_params *spkid_gpio_params;
-	struct acpi_gpio_params *cs_gpio_params;
+	struct acpi_gpio_mapping *gpio_mapping = NULL;
+	struct acpi_gpio_params *reset_gpio_params = NULL;
+	struct acpi_gpio_params *spkid_gpio_params = NULL;
+	struct acpi_gpio_params *cs_gpio_params = NULL;
 	unsigned int num_entries = 0;
 	unsigned int reset_index, spkid_index, csgpio_index;
 	int i;
-- 
2.34.1


