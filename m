Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21A769D72
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjGaQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjGaQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:58:23 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF881BCE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:57 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJQ017071;
        Mon, 31 Jul 2023 11:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=RHyGoQzk1u5genvtgwGtlQ8eSjyHd0Gs4TL3IEXqR+A=; b=
        U5vUnEnlzFelQxYvCphDPRU+MpWHHJHBUlJdiIZ2pV5SukOR1kJsHs7jFzettXd0
        JSXzGjb69lZ1F4B8ry1mCQjUVDa1kOTJNYR/avSjGwbziEXkPxa3+Z8SHgJigucC
        WcMzCVjkINQ6bEYErJXVGoFgNLiNSfr4t2eUA5bC5meCxps3tXPGp7zjp0uAWhjX
        AdNvcJMxNu8UPe/cn7fKI9RAsywS0RNKIybfyytIq4xUFi5xtpkDYaCIilf7fKVj
        i8xknsPGQUF2p4CxxAsk9JRzTQHERSGvcJ72CqAV59TX3y682EPBqbYNL4/gKPPJ
        pZEHXXu/49KRpbEgZKvfWg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 17:57:33 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 07796475;
        Mon, 31 Jul 2023 16:57:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 9/9] ALSA: hda/cs35l56: Reject I2C alias addresses
Date:   Mon, 31 Jul 2023 17:57:26 +0100
Message-ID: <20230731165726.7940-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aR0Fv-GAtzh-w4nrEOUP9pw2wCSgsztH
X-Proofpoint-ORIG-GUID: aR0Fv-GAtzh-w4nrEOUP9pw2wCSgsztH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI nodes for CS35L56 can contain an extra I2CSerialBusV2 that
is not a real device, it is an alias address.

This alias address will not be in the cirrus,dev-index array, so reject
any instantions with a device address not found in the array.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 004740509dbd..76b9c685560b 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -852,8 +852,12 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int id)
 			break;
 		}
 	}
+	/*
+	 * It's not an error for the ID to be missing: for I2C there can be
+	 * an alias address that is not a real device. So reject silently.
+	 */
 	if (cs35l56->index == -1) {
-		dev_err(cs35l56->base.dev, "No index found in %s\n", property);
+		dev_dbg(cs35l56->base.dev, "No index found in %s\n", property);
 		ret = -ENODEV;
 		goto err;
 	}
@@ -891,7 +895,8 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int id)
 	return 0;
 
 err:
-	dev_err(cs35l56->base.dev, "Failed property %s: %d\n", property, ret);
+	if (ret != -ENODEV)
+		dev_err(cs35l56->base.dev, "Failed property %s: %d\n", property, ret);
 
 	return ret;
 }
@@ -904,10 +909,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
 	ret = cs35l56_hda_read_acpi(cs35l56, id);
-	if (ret) {
-		dev_err_probe(cs35l56->base.dev, ret, "Platform not supported\n");
+	if (ret)
 		goto err;
-	}
 
 	cs35l56->amp_name = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "AMP%d",
 					   cs35l56->index + 1);
-- 
2.30.2

