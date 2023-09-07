Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313367979CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbjIGRUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbjIGRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:20:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76394
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:20:22 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A88C166072F7;
        Thu,  7 Sep 2023 18:10:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694106647;
        bh=rIB839KbtT4M8CYKZ1SHwXmr9eGS1OcT+UowfodUupQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YipAyS+s+34w+o5S1L4JGFAzu5i0XzX7Mm1+LeSjGSXnMAFaoUoQ1R7GKS+ZFf0Kh
         67E41SgZlirlEk5cElfhVylwcu1tZlXJ/v9aoCTCFS5Z7d4NbKeFmJVBhLePQvKVgm
         gA/zkun9e+nM+pt8yxV69r6KgWbiakFkmtZYiqKhFBBwlXo60Ci91duDxUU9hSF0ny
         zcnggy+6OTxCaKO/gVNoFqvjGuGFQlHirPsLNsGwngFPMerC5UwONMjZZ9o0eg4AZL
         G1qA1LUqB97//C6rWkxVRUbL8uxCviOscdPOvBf9kzjO/6ukokLf6eOA7mZqd9uS0v
         d91xxPzjrtAaQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 11/11] ALSA: hda: cs35l41: Consistently use dev_err_probe()
Date:   Thu,  7 Sep 2023 20:10:10 +0300
Message-ID: <20230907171010.1447274-12-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the remaining dev_err() calls in probe() with dev_err_probe(),
to improve consistency.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/pci/hda/cs35l41_hda.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 565f7b897436..c74faa2ff46c 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1550,27 +1550,27 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS4, int_status,
 				       int_status & CS35L41_OTP_BOOT_DONE, 1000, 100000);
 	if (ret) {
-		dev_err(cs35l41->dev, "Failed waiting for OTP_BOOT_DONE: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Failed waiting for OTP_BOOT_DONE\n");
 		goto err;
 	}
 
 	ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_sts);
 	if (ret || (int_sts & CS35L41_OTP_BOOT_ERR)) {
-		dev_err(cs35l41->dev, "OTP Boot status %x error: %d\n",
-			int_sts & CS35L41_OTP_BOOT_ERR, ret);
+		dev_err_probe(cs35l41->dev, ret, "OTP Boot status %x error\n",
+			      int_sts & CS35L41_OTP_BOOT_ERR);
 		ret = -EIO;
 		goto err;
 	}
 
 	ret = regmap_read(cs35l41->regmap, CS35L41_DEVID, &regid);
 	if (ret) {
-		dev_err(cs35l41->dev, "Get Device ID failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Get Device ID failed\n");
 		goto err;
 	}
 
 	ret = regmap_read(cs35l41->regmap, CS35L41_REVID, &reg_revid);
 	if (ret) {
-		dev_err(cs35l41->dev, "Get Revision ID failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Get Revision ID failed\n");
 		goto err;
 	}
 
@@ -1593,7 +1593,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
 	if (ret) {
-		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "OTP Unpack failed\n");
 		goto err;
 	}
 
@@ -1624,7 +1624,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
 	if (ret) {
-		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
+		dev_err_probe(cs35l41->dev, ret, "Register component failed\n");
 		goto err_pm;
 	}
 
-- 
2.41.0

