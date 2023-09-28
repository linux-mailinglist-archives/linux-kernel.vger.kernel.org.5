Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4317B1671
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjI1Iwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1Iwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:52:34 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805CB7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:52:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vt19StJ_1695891122;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vt19StJ_1695891122)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 16:52:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     james.schulman@cirrus.com
Cc:     david.rhodes@cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: cs42l43: Remove useless else
Date:   Thu, 28 Sep 2023 16:52:00 +0800
Message-Id: <20230928085200.48635-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment of the else and if branches is the same, so the else
here is redundant, so we remove it.

./sound/soc/codecs/cs42l43-sdw.c:35:1-3: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6712
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/cs42l43-sdw.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-sdw.c b/sound/soc/codecs/cs42l43-sdw.c
index 55ac5fe8c3db..388f95853b69 100644
--- a/sound/soc/codecs/cs42l43-sdw.c
+++ b/sound/soc/codecs/cs42l43-sdw.c
@@ -31,11 +31,7 @@ int cs42l43_sdw_add_peripheral(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	snd_sdw_params_to_config(substream, params, &sconfig, &pconfig);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		pconfig.num = dai->id;
-	else
-		pconfig.num = dai->id;
+	pconfig.num = dai->id;
 
 	ret = sdw_stream_add_slave(sdw, &sconfig, &pconfig, 1, sdw_stream);
 	if (ret) {
-- 
2.20.1.7.g153144c

