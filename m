Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F376CC66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHBMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjHBMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:13:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D82D70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:13:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 372AfO5i009394;
        Wed, 2 Aug 2023 07:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=8
        rBFF1JOEa2gQYBCopxKQOjevDVf2/rhuHmRPELguQI=; b=IJkEkMCZ5iseNP5OK
        aU/VSrAKi/w8tIinONgl9K2AARoLDPAs/bdZddf1zQlPGFKdBamC/VdI16kKazek
        eraGMvZ3GRRS5GDPYfm1d3DtTC8MqICb1jju0s3mI/bBN6gY3g2TO02vcPAZCUa4
        ByswCblnRk+AithPxdPKyzzD+1rEV0gijj4jf+kxNXxkmoIGKBKtdSaKyD3gu4jU
        YRBjFZ/8W1EXthOECHk0N3IjDQio1Xn7FwEhsUY+4jmwDpS3Bu1gUaLV1bitgvoC
        F/zBu3Wo9xBnJjslrheyDvl1LDQw8TbRjnT6DqxhdC6rWLZyEzoqLO7P1c4Y1n8X
        +sbUg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6juqs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 07:12:44 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 13:12:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 2 Aug 2023 13:12:43 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.244])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F89A15B4;
        Wed,  2 Aug 2023 12:12:43 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda: cs35l41: Print amp configuration after bind
Date:   Wed, 2 Aug 2023 13:12:35 +0100
Message-ID: <20230802121235.467358-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NEwOoSa2ppwufrcOLRYWrooU3qswq85R
X-Proofpoint-ORIG-GUID: NEwOoSa2ppwufrcOLRYWrooU3qswq85R
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print amp configuration information to be able to confirm ACPI
_DSD information (and other useful info) for each amp on each
system using CS35L41, without having to get the acpidump.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 98feb5ccd5866..825e551be9bb8 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1124,6 +1124,13 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
+	dev_info(cs35l41->dev,
+		 "CS35L41 Bound - SSID: %s, BST: %d, VSPK: %d, CH: %c, FW EN: %d, SPKID: %d\n",
+		 cs35l41->acpi_subsystem_id, cs35l41->hw_cfg.bst_type,
+		 cs35l41->hw_cfg.gpio1.func == CS35l41_VSPK_SWITCH,
+		 cs35l41->hw_cfg.spk_pos ? 'R' : 'L',
+		 cs35l41->firmware_running, cs35l41->speaker_id);
+
 	return ret;
 }
 
-- 
2.34.1

