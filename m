Return-Path: <linux-kernel+bounces-5550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBC818C19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379391C239B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D41208DB;
	Tue, 19 Dec 2023 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WMCIphRa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA920319;
	Tue, 19 Dec 2023 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ6vo3B022423;
	Tue, 19 Dec 2023 10:22:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BoVaGh/eH7nGZeEelaU0i1uh/HBS9k3X4xBMik9sYek=; b=
	WMCIphRaeyGQRQFZZyGmYxGArGpBbrgP27CTR5/VHMj25AcWvM4YvtTF3Wsvf935
	ZfZeJPYbKIZIH+enzPcKCsmWQO2MEUFvFj5pqGooSpJqDxlKLq4CiLMXbaXINekM
	Ebu0qAaMA6CQ8J8q/Tf/E/WOxoy/dM9P1LpYbvKhdVhl5WI5bSpjwT9YVlz1dEqm
	oHD2vqrDT5loHhvUyYbDFtVz1QpoC/nN3MOrajSLp0fG+6la04+/J+/S+Jc72hJ1
	iBwrY+t/UR0FHDooruvX6vV+FFMn2jQiLEkCK0/NyZ9sQk8ezv0sR3UOWFAtZRF+
	OpVY4TgSgRuEpPTm/CeWFw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a6249gs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:22:48 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 16:22:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 19 Dec 2023 16:22:43 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 451DE11D1;
	Tue, 19 Dec 2023 16:22:43 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 2/2] ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel
Date: Tue, 19 Dec 2023 16:22:32 +0000
Message-ID: <20231219162232.790358-3-sbinding@opensource.cirrus.com>
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
X-Proofpoint-GUID: yc_jk4S_5prVHkTVfhZhHYzieyQxFs6b
X-Proofpoint-ORIG-GUID: yc_jk4S_5prVHkTVfhZhHYzieyQxFs6b
X-Proofpoint-Spam-Reason: safe

If CONFIG_SPI is not set in the kernel, there is no point in trying
to set the chip selects. We can selectively compile it.

Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312192256.lJelQEoZ-lkp@intel.com/

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 73b304e6c83c..194e1179a253 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -210,6 +210,8 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
 	if (cfg->bus == SPI) {
 		cs35l41->index = id;
+
+#if IS_ENABLED(CONFIG_SPI)
 		/*
 		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
 		 * This is only supported for systems with 2 amps, since we cannot expand the
@@ -249,6 +251,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 				spi_setup(spi);
 			}
 		}
+#endif
 	} else {
 		if (cfg->num_amps > 2)
 			/*
-- 
2.34.1


