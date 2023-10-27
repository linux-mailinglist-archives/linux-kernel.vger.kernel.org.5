Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4837D9CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbjJ0PYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbjJ0PYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC4192;
        Fri, 27 Oct 2023 08:24:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF2EC433CA;
        Fri, 27 Oct 2023 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698420271;
        bh=ZIhEUto7Ie2F1PnCeV7zW6ioXwNxMy5PW9CRsJ9ceaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kR7uDf06h08elvu+XJN8uZlCZ8dl1wqzgxoWyGmvZjCeMLQULFLtq6usskfz3qYS+
         JL1BZvVg2IZX1FH0mJbEyKq3GzuYT1UlOQqnZmlpFvd01imUoGbeecshd/eYSLYXB2
         OJ5hG6QPDg3s9L33vsAeAfk7itH22rIeemJ1LlMHWyfAXTs7/eMgFt/daFGMV31Yip
         wQ4tmit17eQkF1VvPfcVQ9nABob44XSSjs+q+dPZkzL6fIUA5S9HdzTLvEmCrmQxD+
         6kUkvUmAes0O4NtGxZw3R/qRGaU8n5XdGvzJ5YnWSnwn5Ekf1o4TxUQzD8JkRIGK4A
         EZRQgWSrO+Jdw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Shuming Fan <shumingf@realtek.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: codecs: aw88399: fix typo in Kconfig select
Date:   Fri, 27 Oct 2023 17:23:53 +0200
Message-Id: <20231027152403.386257-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027152403.386257-1-arnd@kernel.org>
References: <20231027152403.386257-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The aw88395_lib module is shared by all the aw883* drivers that
need to select the corresponding Kconfig symbol. The newly added
aw88399 incorrectly selects SND_SOC_AW88399_LIB instead, which
is not defined anywhere in the kernel, causing a link failure when
the actual one is missing:

arm-linux-gnueabi-ld: sound/soc/codecs/aw88399.o: in function `aw88399_codec_probe':
aw88399.c:(.text+0xbc6): undefined reference to `aw88395_dev_load_acf_check'
arm-linux-gnueabi-ld: aw88399.c:(.text+0xbea): undefined reference to `aw88395_dev_cfg_load'

Fixes: 8ade6cc7e261 ("ASoC: codecs: Add aw88399 amplifier driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cc4026d93654..3429419ca694 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -687,7 +687,7 @@ config SND_SOC_AW88399
 	select CRC8
 	select REGMAP_I2C
 	select GPIOLIB
-	select SND_SOC_AW88399_LIB
+	select SND_SOC_AW88395_LIB
 	help
 	  This option enables support for aw88399 Smart PA.
 	  The awinic AW88399 is an I2S/TDM input, high efficiency
-- 
2.39.2

