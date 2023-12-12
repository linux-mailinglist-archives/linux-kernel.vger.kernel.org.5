Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD480E468
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjLLGpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLGpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:45:36 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0461BF;
        Mon, 11 Dec 2023 22:45:42 -0800 (PST)
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5C214420EB;
        Tue, 12 Dec 2023 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702363540;
        bh=0CIojiFNIL7TgUO9/Pp1FGrJpR5/T7LOaiQGQuP8+Ko=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Xk+oQ24O6vui7YdqkCdOsFuEE4q4rJNy9hm8argAxhe/e4+IJ1XS2ydSqQDy5jHJS
         ClRlWoBBUuro9Sg7lf182EHV8b8POYGlztQKGH9eRHxhbxeRFvOojGANif5w9fkRyp
         iUGPQo17L6RtXu3Kmb9dvEwMvuikdvx42dNSjURxShsY054NwuKVwBMGl5flsv3GdA
         4+spFBvKw1ONVly6qWbVEdFmXrXF1faekhfxBxtsavjvrd3+8kOtNi6FMpmOAqFOKg
         5Fe6br4uoy2xN7SdxNZlp50ct/WyICLrf/QW9C+xY8ql4Qfzq7I7EtpJT332wcw4VP
         jN6gXPSKdVwkw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdac_hda: Fix NULL pointer dereference when hda_pvt is not set
Date:   Tue, 12 Dec 2023 14:45:31 +0800
Message-Id: <20231212064533.233748-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel splat can be found on boot:
[    7.906438] BUG: kernel NULL pointer dereference, address: 0000000000000078
[    7.906449] #PF: supervisor read access in kernel mode
[    7.906455] #PF: error_code(0x0000) - not-present page
[    7.906461] PGD 0 P4D 0
[    7.906466] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    7.906472] CPU: 15 PID: 109 Comm: kworker/15:0 Not tainted 6.7.0-rc5+ #9
[    7.906480] Hardware name: HP HP ZBook Fury 15 G7 Mobile Workstation/8783, BIOS S92 Ver. 01.15.00 10/03/2023
[    7.906489] Workqueue: events sof_probe_work [snd_sof]
[    7.906509] RIP: 0010:hdac_hda_dev_probe+0x48/0x110 [snd_soc_hdac_hda]

This is caused by attempting to dereference hda_pvt, so check if it's
NULL before using it.

Fixes: a0575b4add21 ("ASoC: hdac_hda: Conditionally register dais for HDMI and Analog")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/soc/codecs/hdac_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index b075689db2dc..abc214f201a8 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -632,7 +632,7 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
 
 	/* ASoC specific initialization */
-	if (hda_pvt->need_display_power)
+	if (hda_pvt && hda_pvt->need_display_power)
 		ret = devm_snd_soc_register_component(&hdev->dev,
 						&hdac_hda_hdmi_codec, hdac_hda_hdmi_dais,
 						ARRAY_SIZE(hdac_hda_hdmi_dais));
-- 
2.34.1

