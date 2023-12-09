Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55480B65B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjLIUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:53:57 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3ADE1;
        Sat,  9 Dec 2023 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155242;
        bh=I69yofRInENg2Oy9+9NHwAKvDNRysPthJcXn80JrEQE=;
        h=From:To:Cc:Subject:Date:From;
        b=Nlo0p7yhFd5BTjEjYW+ZPJaXwexSbYOC3V1otiSjBvr7qv5TlriHJI9uxDDPQgTqv
         t1LUSAELpUneX+oSyxRdLojBByKK1mhta+D6hWZoBEgPx9/4wjJXmnkJzylWTqZzzI
         /tcjPeFgHO5U0qe2q3MYrKJY8912ma1wh9AtN+Yir9TBKOx/GCikJlpIbFuonCX7hG
         ZVMtHj4PQKxCe9sm5QcRDFodAgmwlZYlmLj8fWaI5pPv/AAw3Pz1gMxhqtl2ED5ETn
         66eBum3WB4/XeSzEnJAr4BxffDMNfYzfFwyWayePILG23cKeaYxBvvQiX60+Fdh0pX
         fxLyy7N7Wj+6w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE61F3780C1A;
        Sat,  9 Dec 2023 20:54:01 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 00/11] Improve SOF support for Steam Deck OLED
Date:   Sat,  9 Dec 2023 22:53:39 +0200
Message-ID: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a continuation of [1] to provide fixes and improvements to
SOF drivers targeting the Vangogh platform, as found on the Valve's Steam Deck
OLED.

The previous series only handled the legacy ACP drivers.

[1]: https://lore.kernel.org/all/20231209203229.878730-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (11):
  ASoC: amd: acp: Drop redundant initialization of machine driver data
  ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
  ASoC: amd: acp: Add missing error handling in sof-mach
  ASoC: amd: acp: Update MODULE_DESCRIPTION for sof-mach
  ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
  ASoC: SOF: amd: Optimize quirk for Valve Galileo
  ASoC: SOF: core: Skip firmware test for undefined fw_name
  ASoC: SOF: amd: Override default fw name for Valve Galileo
  ASoC: SOF: amd: Compute file paths on firmware load
  ASoC: amd: acp: Use correct DAI link ID for BT codec
  ASoC: SOF: topology: Add new DAI type entry for SOF_DAI_AMD_BT

 sound/soc/amd/acp/acp-mach-common.c |  6 +++---
 sound/soc/amd/acp/acp-mach.h        |  2 +-
 sound/soc/amd/acp/acp-sof-mach.c    | 26 +++++++----------------
 sound/soc/sof/amd/acp-loader.c      | 32 +++++++++++++++++++++++------
 sound/soc/sof/amd/acp.c             | 30 ++++++++++++++++-----------
 sound/soc/sof/amd/vangogh.c         |  8 +++++++-
 sound/soc/sof/fw-file-profile.c     |  3 +++
 sound/soc/sof/topology.c            |  1 +
 8 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.43.0

