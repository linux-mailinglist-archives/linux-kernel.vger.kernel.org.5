Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4A7D9CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbjJ0PYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjJ0PYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:24:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC3C1;
        Fri, 27 Oct 2023 08:24:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD276C433C7;
        Fri, 27 Oct 2023 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698420249;
        bh=kEkw3mT5ax9TK4lledPH/qOgSDVWEicwbZhmX0r6WA0=;
        h=From:To:Cc:Subject:Date:From;
        b=s7aS4m3AextXHTYeOf7pTDE+cmH03DexsvUQmfE4zI5I/scVBQA2mgziEJ8CU2y3H
         +hKzuNQpja4BeT9nxPOEpJCvdoUQ+gHLY4seVpQOWqtmjJn5WPBcC51b0BAfeoew+X
         Xn9hRIrbfyzsIykS25M4iTO7Ac5p962wOukK/cgjb/AVhRcRbg+CVf2ugXHFTD0nLN
         9tX709Sx7UGwF6vv53UITcxZpe7sWwfY0+2uqzRdSUGt7ZV0K4ZWP+/Vdcde0nk/Sv
         p60oVpM/tlltIB5+SZ6yFRXCOQECWkv6Gmyx4KIcbDdXrtzhUrwzSNkQBpPRbhfe5s
         4//numtfGvoYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: amd: acp: add ACPI dependency
Date:   Fri, 27 Oct 2023 17:23:52 +0200
Message-Id: <20231027152403.386257-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

A newly added function requires CONFIG_ACPI to avoid a build error:

sound/soc/amd/acp/acp-legacy-common.c: In function 'check_acp_pdm':
sound/soc/amd/acp/acp-legacy-common.c:401:19: error: implicit declaration of function 'acpi_find_child_device'; did you mean 'acpi_match_device'? [-Werror=implicit-function-declaration]
  401 |         pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
      |                   ^~~~~~~~~~~~~~~~~~~~~~
      |                   acpi_match_device

The acp drivers really only work when ACPI is enabled already, so just
avoid the build failure with hard dependency in everything that
enables the acp-legacy-common portion.

Fixes: 3a94c8ad0aae ("ASoC: amd: acp: add code for scanning acp pdm controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/acp/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index c0b2a2df8f80..b0e4d5117b81 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -30,13 +30,15 @@ config SND_SOC_AMD_ACP_PCM
 
 config SND_SOC_AMD_ACP_PCI
 	tristate "AMD ACP PCI Driver Support"
-	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	depends on X86 && PCI
+	depends on ACPI
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	help
 	  This options enables generic PCI driver for ACP device.
 
 config SND_AMD_ASOC_RENOIR
 	tristate "AMD ACP ASOC Renoir Support"
+	depends on ACPI
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
@@ -47,6 +49,7 @@ config SND_AMD_ASOC_RENOIR
 
 config SND_AMD_ASOC_REMBRANDT
 	tristate "AMD ACP ASOC Rembrandt Support"
+	depends on ACPI
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
-- 
2.39.2

