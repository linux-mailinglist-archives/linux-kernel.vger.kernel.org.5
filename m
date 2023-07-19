Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86C75963D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGSNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGSNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F5113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0F461638
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1798C433C9;
        Wed, 19 Jul 2023 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689772132;
        bh=2AeP1o2C0s+VtApribmRvaqu3jF42vhryG4ijMmv2go=;
        h=From:To:Cc:Subject:Date:From;
        b=AIHV9nDxCVaxPnNI+SDmaRrWI4nURA9lMT6vJL5B4yMGXuon3wVEXexvNQyP0Yyin
         aXaFsGLqKuNOAVOlHldfIDydCH/LJExbaax0LwS+IZEG+JyFfRd8Zn2eh5EpT+NGZG
         CyHQGcuy1bpTzDQGNQAXzvA9flK4Rjyymr1poHUlV+DYhh1LBP54/Q8DMXE4Z6FRmi
         8J8ChaxiPtyt4wCXRbiHX3dIj1h3+wTfPHy5uBJSKpHHP/MDtfEmn6PBszHGB1jfg4
         Ns1DrHpcZMkN5oelIou64RvukNB1AZ2mTfGtGmZnlyHdFuiPiWaEx+0SwfdH6S09Fp
         DP07jt2vx/cyg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: fix SND_SOC_AMD_ACP_PCI depdenencies
Date:   Wed, 19 Jul 2023 15:08:37 +0200
Message-Id: <20230719130846.633701-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new PM functions require code that is part of the snd-acp-legacy-common
module:

x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `snd_acp_resume':
acp-pci.c:(.text+0x23): undefined reference to `acp_init'
x86_64-linux-ld: acp-pci.c:(.text+0x58): undefined reference to `acp_enable_interrupts'
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `snd_acp_suspend':
acp-pci.c:(.text+0x89): undefined reference to `acp_deinit'
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `acp_pci_remove':
acp-pci.c:(.text+0xec): undefined reference to `acp_deinit'
x86_64-linux-ld: sound/soc/amd/acp/acp-pci.o: in function `acp_pci_probe':
acp-pci.c:(.text+0x26b): undefined reference to `acp_init'

Select that Kconfig symbol as is done for the other frontends.

Fixes: 088a40980efbc ("ASoC: amd: acp: add pm ops support for acp pci driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/acp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 9e31b5d167908..631cdf96d6376 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -30,6 +30,7 @@ config SND_SOC_AMD_ACP_PCM
 
 config SND_SOC_AMD_ACP_PCI
 	tristate "AMD ACP PCI Driver Support"
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	depends on X86 && PCI
 	help
 	  This options enables generic PCI driver for ACP device.
-- 
2.39.2

