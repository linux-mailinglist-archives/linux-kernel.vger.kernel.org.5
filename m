Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921FC7D9CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbjJ0PYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346287AbjJ0PYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:24:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E37D43;
        Fri, 27 Oct 2023 08:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE1DC433C7;
        Fri, 27 Oct 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698420282;
        bh=LySMjcb5ZeZeBpmsv8KiI7rJYVEnv2CzkA7+tr3Fe3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOFAHyuMJHa0w0v+mSF7AQWZxIU3NmIl8RsBWMGuDwWcZy9B8b8UNe4tmPw/i4Pl5
         bUci/EC3MAknaR6atH0pZEpvzlwaH7koG3cEal/5B0DMuFCPrYbMkQtpuRB2ZDJgJS
         3qVumWhfiJoxFZIoL++wdnqmzW7m5p8Ankx22pPBt09xwjiCc5im/rnVPzHbMZE3Jq
         bVZPybOIt6SKFlu2Ds6M31qxlZqONIMD1ColxfQgPciM+kdk4SgHB28wmsnt7Cb66d
         +1vxS1N9OL2azizro0pZVinPYa8nBt1Cw9AF9wCmUssk3oYqaHgO1YwHJleme0MrTj
         E2Db/6JU13SEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: amd: acp: select SND_SOC_AMD_ACP_LEGACY_COMMON for ACP63
Date:   Fri, 27 Oct 2023 17:23:54 +0200
Message-Id: <20231027152403.386257-3-arnd@kernel.org>
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

Without this dependency, acp63 fails to link:

x86_64-linux-ld: sound/soc/amd/acp/acp63.o: in function `acp63_audio_remove':
acp63.c:(.text+0x22): undefined reference to `acp_disable_interrupts'
x86_64-linux-ld: sound/soc/amd/acp/acp63.o: in function `acp63_i2s_master_clock_generate.isra.0':
acp63.c:(.text+0x6f): undefined reference to `smn_read'
x86_64-linux-ld: acp63.c:(.text+0x81): undefined reference to `smn_write'
x86_64-linux-ld: acp63.c:(.text+0x8e): undefined reference to `smn_read'
x86_64-linux-ld: sound/soc/amd/acp/acp63.o: in function `acp63_pcm_resume':
acp63.c:(.text+0x230): undefined reference to `restore_acp_i2s_params'
x86_64-linux-ld: acp63.c:(.text+0x23d): undefined reference to `restore_acp_pdm_params'
x86_64-linux-ld: sound/soc/amd/acp/acp63.o: in function `acp63_audio_probe':
acp63.c:(.text+0x474): undefined reference to `acp_enable_interrupts'

Fixes: d4c2d5391d7e ("ASoC: amd: acp: add Kconfig options for acp6.3 based platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note that the original Kconfig entry is also whitespace-damaged, which I'm
fixing in the same patch, as it didn't seem worth having two commits for
the same few lines.
---
 sound/soc/amd/acp/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index b0e4d5117b81..5fb322212938 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -61,15 +61,17 @@ config SND_AMD_ASOC_REMBRANDT
 	  If unsure select "N".
 
 config SND_AMD_ASOC_ACP63
-        tristate "AMD ACP ASOC ACP6.3 Support"
-        select SND_SOC_AMD_ACP_PCM
-        select SND_SOC_AMD_ACP_I2S
-        select SND_SOC_AMD_ACP_PDM
-        depends on X86 && PCI
-        help
-          This option enables Acp6.3 I2S support on AMD platform.
-          Say Y if you want to enable AUDIO on ACP6.3
-          If unsure select "N".
+	tristate "AMD ACP ASOC ACP6.3 Support"
+	depends on X86 && PCI
+	depends on ACPI
+	select SND_SOC_AMD_ACP_PCM
+	select SND_SOC_AMD_ACP_I2S
+	select SND_SOC_AMD_ACP_PDM
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
+	help
+	  This option enables Acp6.3 I2S support on AMD platform.
+	  Say Y if you want to enable AUDIO on ACP6.3
+	  If unsure select "N".
 
 config SND_SOC_AMD_MACH_COMMON
 	tristate
-- 
2.39.2

