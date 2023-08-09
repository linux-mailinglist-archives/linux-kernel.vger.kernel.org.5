Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25B776280
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjHIOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjHIOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:30:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD72107
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:30:20 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379BTo37016955;
        Wed, 9 Aug 2023 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=WrwfX+hptzw51skcRKqLyoIQ5F/Ewg5STlwK7uaTLlM=; b=
        MkLZHbezQHCzZyGZdQA7jNXu13I8FTNJOgJk0rTqQxanqsK13TNrIi2gUfUBxI5o
        0sp/BE+KMgk6CEiMOH1SbCJal34zDa7NxuYhuQRmmxc+unZxeO6/t8VzWcakh6EY
        rKdCSNUQIJWG71Z/YWDqe2fnpsHzTt/dB/k3B/XTK+isXZw+0HqVvbV92wExvpz9
        XgnOEqJsPA4PlkI7v1QZUb+P2O0Eut0Hsr8u2CrLQA/AgN1DfFx/nWe2jDBygJAv
        Puyj7IpMjIpCY3KyMOZrSK2f4i9NGiCJi7z15+xS38Qw58MFgyOkWjRHeUBwp/t7
        NZUsWYcDe/UWxo+aZYYhOQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtahxs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:30:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 15:30:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 15:30:05 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.31])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EE29D475;
        Wed,  9 Aug 2023 14:30:04 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ALSA: hda/realtek: Switch Dell Oasis models to use SPI
Date:   Wed, 9 Aug 2023 15:29:57 +0100
Message-ID: <20230809142957.675933-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809142957.675933-1-sbinding@opensource.cirrus.com>
References: <20230809142957.675933-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: px_nm7hvtnNvi5xHn6B8GZBMIfCSJSu1
X-Proofpoint-ORIG-GUID: px_nm7hvtnNvi5xHn6B8GZBMIfCSJSu1
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All I2C Dell Oasis models using CS35L41 have been changed to use SPI.
In addition, System 10280cc5 is no longer required.

Fixes: de90f5165b1c ("ALSA: hda/realtek: Add support for DELL Oasis 13/14/16 laptops")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2b7528cb1780..3bb76f8b9607 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9430,11 +9430,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0cbf, "Dell Oasis 13 Low Weight MTU-L", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc1, "Dell Oasis 14 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc2, "Dell Oasis 14 2-in-1 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc3, "Dell Oasis 14 Low Weight MTL-U", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc4, "Dell Oasis 16 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc5, "Dell Oasis MLK 14 RPL-P", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc1, "Dell Oasis 14 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc2, "Dell Oasis 14 2-in-1 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc3, "Dell Oasis 14 Low Weight MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc4, "Dell Oasis 16 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.34.1

