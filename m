Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229B7D0C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbjJTJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjJTJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:51:15 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 305691A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:51:09 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1461660:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 20 Oct 2023 17:50:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 20 Oct
 2023 17:50:36 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 20 Oct 2023 17:50:36 +0800
From:   <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: codecs: rtq9128: Fix string compare in DAPM event callback
Date:   Fri, 20 Oct 2023 17:50:33 +0800
Message-ID: <1697795435-5858-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697795435-5858-1-git-send-email-cy_huang@richtek.com>
References: <1697795435-5858-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Since widget name may concatenate the component prefix. To compare the
the name with 'strcmp' function in shared DAPM event callback will
cause the wrong RG field control. Use 'strstr' function, instead.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rtq9128.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index 371d622c6214..8c1c3c65475e 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -291,11 +291,11 @@ static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kco
 
 	dev_dbg(comp->dev, "%s: %s event %d\n", __func__, w->name, event);
 
-	if (strcmp(w->name, "DAC1") == 0)
+	if (strstr(w->name, "DAC1"))
 		shift = 6;
-	else if (strcmp(w->name, "DAC2") == 0)
+	else if (strstr(w->name, "DAC2"))
 		shift = 4;
-	else if (strcmp(w->name, "DAC3") == 0)
+	else if (strstr(w->name, "DAC3"))
 		shift = 2;
 	else
 		shift = 0;
-- 
2.34.1

