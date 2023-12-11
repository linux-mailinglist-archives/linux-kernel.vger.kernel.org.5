Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55680CCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjLKOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbjLKODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:03:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E811724
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:01:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3554C433CB;
        Mon, 11 Dec 2023 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303301;
        bh=zC6/XDgDVQlOUCHMNVvPVvZLXImj7C6TWacvh97MvNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pg2Ru1PNC6WYH4XO2qcJ/vSyYl51D3ukmnWAr5A8m9O1uXnliHRl1+6jAtApVVefO
         toDwIyFqwS7ih6xMHGkXCfhcwKpwuS9XkM1OiWaCgViGWfcil5/f/tqQJ6nbxsYgJU
         3Q+F6X/m/oMm1OjLv97FCUVjutLjUdxSQ7vEIZNdB3NRTlFfEhrcwCwtg4LMLaX0kh
         X3XTlc7AHpGgUhhP+qVETFGj6v7GEOG8aIC5BPSyTwJ+2LRm77JTTZr9o97q19wLFJ
         4eIr8Rj7tCDC6R9Yw5bqntpdOKp4G4nKymJXKX36zqexqiQrAAXSqOBhDAePsfx8Mx
         fKa+JJkFU/Cgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/16] ASoC: rt5650: add mutex to avoid the jack detection failure
Date:   Mon, 11 Dec 2023 09:00:31 -0500
Message-ID: <20231211140116.391986-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
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

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit cdba4301adda7c60a2064bf808e48fccd352aaa9 ]

This patch adds the jd_mutex to protect the jack detection control flow.
And only the headset type could check the button status.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20231122100123.2831753-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 99d91bfb88122..7dc80183921ed 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -421,6 +421,7 @@ struct rt5645_priv {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
 	struct rt5645_eq_param_s *eq_param;
 	struct timer_list btn_check_timer;
+	struct mutex jd_mutex;
 
 	int codec_type;
 	int sysclk;
@@ -3179,6 +3180,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 				rt5645_enable_push_button_irq(component, true);
 			}
 		} else {
+			if (rt5645->en_button_func)
+				rt5645_enable_push_button_irq(component, false);
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
@@ -3259,6 +3262,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	if (!rt5645->component)
 		return;
 
+	mutex_lock(&rt5645->jd_mutex);
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
@@ -3283,7 +3288,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 
 	if (!val && (rt5645->jack_type == 0)) { /* jack in */
 		report = rt5645_jack_detect(rt5645->component, 1);
-	} else if (!val && rt5645->jack_type != 0) {
+	} else if (!val && rt5645->jack_type == SND_JACK_HEADSET) {
 		/* for push button and jack out */
 		btn_type = 0;
 		if (snd_soc_component_read(rt5645->component, RT5645_INT_IRQ_ST) & 0x4) {
@@ -3339,6 +3344,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		rt5645_jack_detect(rt5645->component, 0);
 	}
 
+	mutex_unlock(&rt5645->jd_mutex);
+
 	snd_soc_jack_report(rt5645->hp_jack, report, SND_JACK_HEADPHONE);
 	snd_soc_jack_report(rt5645->mic_jack, report, SND_JACK_MICROPHONE);
 	if (rt5645->en_button_func)
@@ -4062,6 +4069,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	}
 	timer_setup(&rt5645->btn_check_timer, rt5645_btn_check_callback, 0);
 
+	mutex_init(&rt5645->jd_mutex);
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
 
-- 
2.42.0

