Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1890C7D8588
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjJZPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbjJZPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88DE1A7;
        Thu, 26 Oct 2023 08:06:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUri011654;
        Thu, 26 Oct 2023 10:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=ILs6etz2DZGvRnWZW360VpqOgkeIGeiUCrGgWU3P3jg=; b=
        LOKuE4qucJ4JrzB8JohVpUotheVt+aLHJWQ8vcG4gM8GkDCSdPnYfqahY9SXfgOm
        o5e2vtxqb6wBfNKjjfHO2+grne4r7SAENH5mU8YpC8d0zspc0DLn+GesHa5cqi9y
        NJ4bXyEABYdu76JkyDoysB1ANHzqLLrGqfMlub7UsMzchFO3wIXe4rNbXPrunDmN
        OVcMyGz6PcFXcIKLD+beQHc6/1J9b9btzs9LTE2iPwPDpD72mG1NleJ1LnDXkH4c
        TwIafWECKws0hlTywt3t4D+7iCa7ZQxUnF4CRL4JO4493ogZH5zMYftmCtlahu3k
        cXX7fve6sI1K7jsLU4h7LQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:15 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 16:06:08 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8622115B6;
        Thu, 26 Oct 2023 15:06:08 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 5/8] ALSA: hda: cs35l41: Force a software reset after hardware reset
Date:   Thu, 26 Oct 2023 16:05:55 +0100
Message-ID: <20231026150558.2105827-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PhKpDYQLrnEWcvB-Hheiv1SO1oOK2mEi
X-Proofpoint-ORIG-GUID: PhKpDYQLrnEWcvB-Hheiv1SO1oOK2mEi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure the chip has correctly reset during probe and system suspend,
we need to force a software reset, in case of systems where the
hardware reset is not available.

The software reset register was labelled as volatile but not readable,
however, it is readable, (just returns 0x0). Adding it to readable
registers means it will be correctly treated as volatile, and thus
will not be cached.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l41.h        | 1 +
 sound/pci/hda/cs35l41_hda.c    | 5 +++++
 sound/soc/codecs/cs35l41-lib.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 2fe8c6b0d4cf..80df80fe31e2 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -735,6 +735,7 @@
 #define CS35L41_REVID_B2		0xB2
 
 #define CS35L41_HALO_CORE_RESET		0x00000200
+#define CS35L41_SOFTWARE_RESET		0x5A000000
 
 #define CS35L41_FS1_WINDOW_MASK		0x000007FF
 #define CS35L41_FS2_WINDOW_MASK		0x00FFF800
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index e787788c1be2..9746c64ff0dd 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -901,6 +901,9 @@ static int cs35l41_system_resume(struct device *dev)
 
 	regcache_cache_only(cs35l41->regmap, false);
 
+	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
+	usleep_range(2000, 2100);
+
 	ret = cs35l41_wait_boot_done(cs35l41);
 	if (ret)
 		return ret;
@@ -1766,6 +1769,8 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
 	}
 
+	usleep_range(2000, 2100);
+	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
 	usleep_range(2000, 2100);
 
 	ret = cs35l41_wait_boot_done(cs35l41);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 2ec5fdc875b1..ddedb7e63cb6 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -74,6 +74,7 @@ static bool cs35l41_readable_reg(struct device *dev, unsigned int reg)
 	case CS35L41_FABID:
 	case CS35L41_RELID:
 	case CS35L41_OTPID:
+	case CS35L41_SFT_RESET:
 	case CS35L41_TEST_KEY_CTL:
 	case CS35L41_USER_KEY_CTL:
 	case CS35L41_OTP_CTRL0:
-- 
2.34.1

