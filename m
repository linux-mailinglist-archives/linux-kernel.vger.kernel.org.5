Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767137D8584
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjJZPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjJZPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663A8129;
        Thu, 26 Oct 2023 08:06:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39QF2DtX011762;
        Thu, 26 Oct 2023 10:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=P2RZ5FPl+x4KIbUrLBvQodtbr+Kus6IGLLMqcPJmaeY=; b=
        KvitG4L1GV+7ZfKxNWN2mxEFrAf1OxqyEMvuS2j5d10rTK1ttAjT3if8guwQUEhe
        FkjQtu8KLhfeaxBAgW1FqV9zYmxn7ZB+FLDM+3v9zy9GKFjOUWEGoICZjrS7b/Hn
        upRUgOYVed7K/ng/GW2nEieN/ogKDH5I1jL0ugy4GqZzi2pY9YFerD21lt1j26ci
        ZsIuyd/VlsZy2ObrDfTN3jw9vdDDZx6CUknvTvTDfRqhbsijaW8ZfRo5l9TKWe+n
        ywRvJrvOsDVKU8y3X/4myxbO8iH+727YGY2pYv+/0IXGBnYVuqTXGcav+AvtzN9o
        M8haN7gnf6lXFB2XWkqcbg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tvb2j6tep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 26 Oct 2023 16:06:09 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 681BF11AA;
        Thu, 26 Oct 2023 15:06:09 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 8/8] ASoC: cs35l41: Detect CSPL errors when sending CSPL commands
Date:   Thu, 26 Oct 2023 16:05:58 +0100
Message-ID: <20231026150558.2105827-9-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2mnMNV1ezLHzUEslcCyFHivS6CNyn6IL
X-Proofpoint-ORIG-GUID: 2mnMNV1ezLHzUEslcCyFHivS6CNyn6IL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code checks for the correct state transition after sending
a command. However, it is possible for the message box to return -1,
which indicates an error, if an error has occurred in the firmware.
We can detect if the error has occurred, and return a different error.
In addition, there is no recovering from a CSPL error, so the retry
mechanism is not needed in this case, and we can return immediately.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l41.h        | 2 ++
 sound/soc/codecs/cs35l41-lib.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 80df80fe31e2..043f8ac65dbf 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -816,6 +816,8 @@ struct cs35l41_otp_map_element_t {
 };
 
 enum cs35l41_cspl_mbox_status {
+	CSPL_MBOX_STS_ERROR = U32_MAX,
+	CSPL_MBOX_STS_ERROR2 = 0x00ffffff, // firmware not always sign-extending 24-bit value
 	CSPL_MBOX_STS_RUNNING = 0,
 	CSPL_MBOX_STS_PAUSED = 1,
 	CSPL_MBOX_STS_RDY_FOR_REINIT = 2,
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index ddedb7e63cb6..4569e4f7cf7e 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1474,6 +1474,11 @@ int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			continue;
 		}
 
+		if (sts == CSPL_MBOX_STS_ERROR || sts == CSPL_MBOX_STS_ERROR2) {
+			dev_err(dev, "CSPL Error Detected\n");
+			return -EINVAL;
+		}
+
 		if (!cs35l41_check_cspl_mbox_sts(cmd, sts))
 			dev_dbg(dev, "[%u] cmd %u returned invalid sts %u", i, cmd, sts);
 		else
-- 
2.34.1

