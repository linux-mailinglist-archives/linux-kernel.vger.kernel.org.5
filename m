Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEC80B64F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjLIUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjLIUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:40:25 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B920193;
        Sat,  9 Dec 2023 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702153978;
        bh=kMegneD4j4d96NVL/0K7rY3s/IkV/1Ctu1ANsfIwzRw=;
        h=From:To:Cc:Subject:Date:From;
        b=y+JhS/lw7iNrQqoCjm5vlmKGooyg8m+E6Mne27OVcbQrepZH7sfZqcGNg7IxfysMK
         cKYDmOB4TFfmy5nF8Vau8ou11gQhg8g7cLYVVDBvyav0jFEGybNrMz2KNj+hvCJE1V
         ynBKMmcNBJFa4yF1WeWxHwhF2sQJhkvqoJzYyHE0zaQHuJ6CERBo5/aeoqx0tlEu10
         YnvmevacIIu+15yVNKrjGf9deZXwiE4rTmrMLDP1spZ2w6vDh95Jh4Us6unGNXiZ2F
         fRAWWAVEJdjm9owGNJ9yvI4im/NgGWz6sAsyqXhUHz7qlD0+IZFgTXZWDTqWwj4vWJ
         NyF91YndjmZKg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9B463780C1A;
        Sat,  9 Dec 2023 20:32:57 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/5] Improve AMD ACP Vangogh audio support for Steam Deck OLED
Date:   Sat,  9 Dec 2023 22:32:18 +0200
Message-ID: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
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

This patch series provides several fixes and improvements to AMD ACP drivers
targeting the Vangogh platform, as found on the Valve's new Steam Deck OLED.

Although in theory the board should have been supported by both SOF and legacy
ACP drivers, as of next-20231208 the audio seems to be completely broken.

Please note this only restores the legacy support, while SOF will be handled in
a separate series.

Cristian Ciocaltea (5):
  ASoC: amd: vangogh: Drop conflicting ACPI-based probing
  ASoC: amd: vangogh: Allow probing ACP PCI when SOF is disabled
  ASoC: amd: vangogh: Switch to {RUNTIME,SYSTEM_SLEEP}_PM_OPS
  ASoC: amd: acp-config: Add missing MODULE_DESCRIPTION
  ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common

 sound/soc/amd/acp-config.c          |  1 +
 sound/soc/amd/acp/acp-mach-common.c |  1 +
 sound/soc/amd/vangogh/acp5x-mach.c  | 35 +++++++++++------------------
 sound/soc/amd/vangogh/pci-acp5x.c   | 19 +++++++++-------
 4 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.43.0

