Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5675A900
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGTIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGTIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:21:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F22684
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:21:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K6I2k9026820;
        Thu, 20 Jul 2023 03:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=0ztLXni07vsC3C/pWxkosmXk1jxksKOi3kov4TK10D0=; b=
        hRAqG/+0BC68YGW/xlrdZfTNxb70kTnLmkwxgaGmLDbiy+5/foic0pecRLUIH1MA
        kPgKzRlcFMMUxjbSG0CXAftTbfJeV0i7oqkTeDDoxITqNuhqxrfdjGAV2ZsklTH+
        BjPMBuxo/4rZSnnYkTftAMvLLxgCDKNwowNPsL1QO/jcJVQ9kfq9fGDmxgR1qDES
        J7oMqbrDVXAKBAYl4JGuBxvGfbFkwf1K+HO+N7GnPb4k5zjs+xNSQl+bkKOTIoTP
        QLoF0lSW3sWyxCYf3T68NiGpv4Igu4X+TKTrwPn/P8E2oIg6EBXxhNyK1LKXK9x4
        xFYsFcCvGOPTPLnn/vC/9Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gwu9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 03:20:45 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 09:20:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 09:20:43 +0100
Received: from lon-bigdaddy.ad.cirrus.com (unknown [198.61.64.114])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B241458;
        Thu, 20 Jul 2023 08:20:43 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.com>
CC:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: Add support for DELL Oasis 13/14/16 laptops
Date:   Thu, 20 Jul 2023 09:20:22 +0100
Message-ID: <20230720082022.13033-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720082022.13033-1-vitalyr@opensource.cirrus.com>
References: <20230720082022.13033-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bEnsyKbpU1jp28Ozrjm9PgyqqK3HpZPA
X-Proofpoint-GUID: bEnsyKbpU1jp28Ozrjm9PgyqqK3HpZPA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for new Dell laptops using Cirrus Logic CS35L41
smart amplifiers with Realtek codec.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 56cbf5b38d48..943dccc14c0d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9398,6 +9398,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0c1c, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1d, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1e, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cbf, "Dell Oasis 13 Low Weight MTU-L", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc1, "Dell Oasis 14 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc2, "Dell Oasis 14 2-in-1 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc3, "Dell Oasis 14 Low Weight MTL-U", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc4, "Dell Oasis 16 MTL-H/U", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc5, "Dell Oasis MLK 14 RPL-P", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.34.1

