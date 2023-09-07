Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B787979D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbjIGRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjIGRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:22:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020481FE5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:22:02 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 762F566072F4;
        Thu,  7 Sep 2023 18:10:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694106641;
        bh=xCnO4kZnTTfiLFarcj0DdPXYKo5Wq4aT17BKxrFFaDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJgEtVCA+qN+J+SkwLyHkSm4H5oAXVS/ekNU9wN1B9xceWrjWmou6Pvolar4HkXIx
         h0wqrPE689J78gw5/D4a5TCujAKYqrPRZ52bOt+WwU4wb7xrwPGB7qVJMAEcF1wuKw
         kD0qvHC8W/EVxv/q/2VQ5bKXIdzbC/qQRq/FkbJF1n4zTt/iPv0JOiJpotAHizMIBx
         q89D/uSpSRY8JSrDQDHPVfKdivzOpYrKuuQ4JzaRizqBBUcCigQuOCQhr29JrWtTD+
         HD54bZ75JJb8NBgkLutoO8q0kq2ACU/e56+Ne70k0UNK5J1vv0grFP0g5y+m/BsLtC
         9TKrUCS8BRCHg==
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
Subject: [PATCH v2 09/11] ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
Date:   Thu,  7 Sep 2023 20:10:08 +0300
Message-ID: <20230907171010.1447274-10-cristian.ciocaltea@collabora.com>
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

If component_add() fails, probe() returns without calling
pm_runtime_put(), which leaves the runtime PM usage counter incremented.

Fix the issue by jumping to err_pm label and drop the now unnecessary
pm_runtime_disable() call.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/pci/hda/cs35l41_hda.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 09a9c135d9b6..6fd827093c92 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1625,8 +1625,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
 	if (ret) {
 		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
-		pm_runtime_disable(cs35l41->dev);
-		goto err;
+		goto err_pm;
 	}
 
 	dev_info(cs35l41->dev, "Cirrus Logic CS35L41 (%x), Revision: %02X\n", regid, reg_revid);
-- 
2.41.0

