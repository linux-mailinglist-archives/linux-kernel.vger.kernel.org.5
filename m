Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0377B2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjHNHra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjHNHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62CE75
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56C36172B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E69C433C9;
        Mon, 14 Aug 2023 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691999238;
        bh=nKgrnCU7kI3wR/FQzbZP+F8vXg3oOXU0D3MYKHvXP28=;
        h=From:To:Cc:Subject:Date:From;
        b=PZF5xdDQSRmwEHZUVYWUZife4sXMwTWHGmoIsKx/KaSf1a06Fp+ipg2agrQLdIA5u
         BIZ9jnB+KwuIBkyNnT4NtCCoBsOXguWokAkjvC5hHu+5AciTuUXpghg961en0sZFqQ
         AUTvmyZIJ6XBCkxK4GXj2I9CqcjvENfPdhLoCUA2XiAg4Ay9HngHwvCE+R0U5Bv1na
         zDjoTiF9SHPAIpP8jWPkuf13GB80NZO55aTRZs3WAeZ3xlQvyBWzHXRjjvy82k5Sc3
         PucmcS+80lVumd9/fFkIrnQmMZTd7PgtVEXA9qYITI6UkLvp4NfWWz01G7zjPmFCJ8
         z1ipfXhOuVmxA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: fix hda_sdw_check_wakeen_irq()
Date:   Mon, 14 Aug 2023 09:46:29 +0200
Message-Id: <20230814074711.1068093-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function cannot work, as the 'chip' variable is never initialized:

sound/soc/sof/intel/hda.c:423:6: error: variable 'chip' is uninitialized when used here [-Werror,-Wuninitialized]
        if (chip && chip->check_sdw_wakeen_irq)
            ^~~~

Set it the same way that other functions in this file do.

Fixes: 9362ab78f175d ("ASoC: SOF: Intel: add abstraction for SoundWire wake-ups")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There hasn't been a new linux-next in a few days, so there is a good chance
someone else already fixed this in the meantime. Sending out my fix in case
that hasn't happened yet.
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 04c748a72b137..6c9c7b390cf53 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -415,7 +415,7 @@ bool hda_sdw_check_wakeen_irq_common(struct snd_sof_dev *sdev)
 static bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
 {
 	u32 interface_mask = hda_get_interface_mask(sdev);
-	const struct sof_intel_dsp_desc *chip;
+	const struct sof_intel_dsp_desc *chip = get_chip_info(sdev->pdata);
 
 	if (!(interface_mask & BIT(SOF_DAI_INTEL_ALH)))
 		return false;
-- 
2.39.2

