Return-Path: <linux-kernel+bounces-4622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63177818010
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1391F242DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4B469D;
	Tue, 19 Dec 2023 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e+EXejdf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179E8460;
	Tue, 19 Dec 2023 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955261;
	bh=eAOckwuowQJQnjs/A4Z6ZYNvsznDRiqHV8PeUEbxstI=;
	h=From:To:Cc:Subject:Date:From;
	b=e+EXejdfIbiDQRJ9/4gMcQL9y2Jg7RG9sYINKaUOpQfe5J6IK1/cXV8dBdhBQRsFw
	 yvDfgvCmgRj42+d/YZTqkP1pBu1lyRoortu93onrevbTBL9xsF7ft0DGvSoPcp/AlY
	 UR3AHz7G4uivyo1zGKIY77B1U1zuNRNvEJ9/tQg2A4W02n1k3frsLdfwfbezvwJUaq
	 wGZNxGXt2XqgsRjcPhIKc/C64VKHuWSIfbzJzvbkJwcf0bxKgHL6R2fZ4vfkwyBZTR
	 tE7JIoqmRqQS4iCoZVqdlwwnzbc5k7s14dZpdXNFBkXBEuqlxVSWN0sJtjuZyvPiaN
	 FPgpYxZhXH/8w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CD1793781476;
	Tue, 19 Dec 2023 03:07:40 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
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
	Emil Velikov <emil.velikov@collabora.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	kernel@collabora.com
Subject: [PATCH v2 0/8] Improve SOF support for Steam Deck OLED
Date: Tue, 19 Dec 2023 05:07:18 +0200
Message-ID: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is a continuation of [1] to provide several fixes and
improvements to the SOF drivers targeting the Vangogh platform, as found on
Valve's Steam Deck OLED.  The previous series only handled the legacy ACP
drivers.

Also note that, since v2, this patch series requires an updated SOF
topology to provide a correct DAI link ID for the BT codec.  The binary
file should be located under:

  /usr/lib/firmware/amd/sof-tplg/sof-vangogh-nau8821-max.tplg

Alternatively, as a temporary workaround, patch [2] can be used to adapt
the driver to the broken topology.

Another requirement to get this functional is patch [3] from v1, which has
been dropped from the series to be upstreamed via the SOF development
workflow.

[1]: https://lore.kernel.org/all/20231209203229.878730-1-cristian.ciocaltea@collabora.com/
[2]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/
[3]: https://lore.kernel.org/all/20231209205351.880797-12-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Updated commit message in PATCH 3 according to Emil's review
 - Reworked PATCH 7 according to Péter's suggestion and dropped PATCH 8
   which is obsolete now
 - Dropped incorrect PATCH 10/11, according to Venkata the fw is broken and
   requires update
 - Dropped PATCH 11/11 which is handled via the SOF workflow
 - Added R-b from Emil too all remaining patches, except the reworked one
 - Rebased series onto next-20231218
 - v1:
   https://lore.kernel.org/all/20231209205351.880797-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (8):
  ASoC: amd: acp: Drop redundant initialization of machine driver data
  ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
  ASoC: amd: acp: Add missing error handling in sof-mach
  ASoC: amd: acp: Update MODULE_DESCRIPTION for sof-mach
  ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
  ASoC: SOF: amd: Optimize quirk for Valve Galileo
  ASoC: SOF: core: Skip firmware test for custom loaders
  ASoC: SOF: amd: Compute file paths on firmware load

 sound/soc/amd/acp/acp-mach-common.c |  6 +++---
 sound/soc/amd/acp/acp-sof-mach.c    | 26 +++++++----------------
 sound/soc/sof/amd/acp-loader.c      | 32 +++++++++++++++++++++++------
 sound/soc/sof/amd/acp.c             | 30 ++++++++++++++++-----------
 sound/soc/sof/fw-file-profile.c     | 18 +++++++++++++---
 5 files changed, 69 insertions(+), 43 deletions(-)

-- 
2.43.0


