Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C037BE4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376748AbjJIPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376478AbjJIPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:34:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D315A8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3998HnwY015992;
        Mon, 9 Oct 2023 10:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Y
        F8GMFdoqe5hznvMm3y2/t2RPeHrqis4CldRU1rABgw=; b=QsaUCaqh1Wbzs/Jt3
        f+uizHqbTqVVG/3d3v3SYpbStO7gPr7zGJVJxmc4dnjHj2wXE1MrekR9+7+wzy0g
        9/6u/eF+q0s7KcltCJjoWflfX16EdKiuqFPN30k9WVg+x9OOUNekPs0nmeEntNGN
        ySUion/ca1y/+EEEvjC5MnQ3fmwUx+liiE+7/rK6cnOrpGwLDGUEJrlUgjqF/feW
        mbGtAOTGWv6P9+n5nj45KDhGFX8N3NbbvALLcNqBKr5l9YhfZeTc7gsyEw9v5sGa
        5QXEhl4OMq9X7cLxgw4py+XszGF0NcoTb531AV8nbSSHVeE4XTDKBwBN8j/fC6zJ
        8mXnQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tkhkc1tyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 10:34:18 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 9 Oct
 2023 16:34:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 9 Oct 2023 16:34:16 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B14D5B06;
        Mon,  9 Oct 2023 15:34:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: ASP1 DOUT must default to Hi-Z when not transmitting
Date:   Mon, 9 Oct 2023 16:34:12 +0100
Message-ID: <20231009153412.30380-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: etGRMJSsjEDt_F24RyJ-U4IEtwZvHZzI
X-Proofpoint-GUID: etGRMJSsjEDt_F24RyJ-U4IEtwZvHZzI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASP1 DOUT line must be defaulted to be high-impedance when
it is not actually transmitting data for an active channel.

In non-SoundWire modes ASP1 will usually be shared by multiple
amps so each amp must only drive the line during the slot for
an enabled TX channel.

In SoundWire mode a custom firmware can use ASP1 as a secondary
chip-to-chip audio link or as GPIO. It should be defaulted to
high-impedance since by default the purpose of this pin is not
known.

Backport note:
On kernel versions before 6.6 the cs35l56->base.regmap argument
to regmap_set_bits() must be changed to cs35l56->regmap.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 8ccdd3f134a5..45b4de3eff94 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1197,6 +1197,12 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	/* Registers could be dirty after soft reset or SoundWire enumeration */
 	regcache_sync(cs35l56->base.regmap);
 
+	/* Set ASP1 DOUT to high-impedance when it is not transmitting audio data. */
+	ret = regmap_set_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL3,
+			      CS35L56_ASP1_DOUT_HIZ_CTRL_MASK);
+	if (ret)
+		return dev_err_probe(cs35l56->base.dev, ret, "Failed to write ASP1_CONTROL3\n");
+
 	cs35l56->base.init_done = true;
 	complete(&cs35l56->init_completion);
 
-- 
2.30.2

