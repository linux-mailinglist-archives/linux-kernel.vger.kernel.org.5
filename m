Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131BF79D65B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjILQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjILQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:32:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23310EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:32:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CFSmv9002448;
        Tue, 12 Sep 2023 11:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=sVc4KTYLdosqBY5c8XnIDGNWqNXt6ODbd7xx+vDE0Ss=; b=
        PXCpdORvKHqpb2pGHkM7k3GueQ9JgwlKBIQVTHx/f8olNtq0WMYoPvicVvPgmRIL
        9H9mdGlonuB0xsrBd2fVCffSiEj+GkbwxhAijxbWn03fZgpu2HwnluZZnkx3Mwxi
        cWsOGqz3P1564ZmxZGTL0zOaCMWm+e/jS6fAU/MAZTR9RH55Vs4bDI5AQaEJPtIU
        gO8PN4zTQ4iCZDv4YHrVepMQ1niQ31Lz1M9LhzVembfBl3Z4brSPV4zS7udF1/f+
        7H2tn+Sunx97eDMq3k22vGfsjNB8HNFIel2UWkF9hquy4IxFdNp5s5aqp35a0oO0
        Lwr5JSMitRmknXLPN72nkw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xkxdb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:32:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 17:32:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 12 Sep 2023 17:32:08 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0CD863575;
        Tue, 12 Sep 2023 16:32:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/4] ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
Date:   Tue, 12 Sep 2023 17:32:06 +0100
Message-ID: <20230912163207.3498161-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230912163207.3498161-1-rf@opensource.cirrus.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TCeSaKBKJ_FcRr18fOXrIMkho0cju1vq
X-Proofpoint-GUID: TCeSaKBKJ_FcRr18fOXrIMkho0cju1vq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PCI SSID has been set in the struct snd_soc_acpi_mach_params,
copy this to struct snd_soc_card so that it can be used by other
ASoC components.

This is important for components that must apply system-specific
configuration.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/intel/boards/sof_sdw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 5a1c750e6ae6..961241100012 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1924,6 +1924,12 @@ static int mc_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(codec_info_list); i++)
 		codec_info_list[i].amp_num = 0;
 
+	if (mach->mach_params.subsystem_id_set) {
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+	}
+
 	ret = sof_card_dai_links_create(card);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

