Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C4759B13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:41:48 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE713E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:41:47 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/9] ALSA: hda/intel: Fix error handling in azx_probe()
Date:   Wed, 19 Jul 2023 18:41:33 +0200
Message-Id: <20230719164141.228073-2-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing pci_set_drv to NULL call on error.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ef831770ca7da..0d2d6bc6c75ef 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2188,6 +2188,7 @@ static int azx_probe(struct pci_dev *pci,
 	return 0;
 
 out_free:
+	pci_set_drvdata(pci, NULL);
 	snd_card_free(card);
 	return err;
 }
-- 
2.39.2

