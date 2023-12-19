Return-Path: <linux-kernel+bounces-4628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C549B818017
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98941C23175
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383501171C;
	Tue, 19 Dec 2023 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dce2mjRJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB41C14E;
	Tue, 19 Dec 2023 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955267;
	bh=K6fLPyb8myohyHdMlG17XVZDsmGSbtI/ME/7hz5T6vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dce2mjRJLcFuUGCE0QzEQzkyGWU3LcFkM5ozorMtjoBsLVx/JmKrgJ/n3iTL83vE5
	 SoVmG05Gw0G1nu18HE3GrWz9UmnbdUclgw5Hi48kYV/uNYoJALLWbw8PKWOczYuUPc
	 Ql57zQ2NqdHAP7aw4V0jjqs2EHCjMzX2YAJgBBQ12S2UIE0QfScbdSzAQx/0vXfyiS
	 c3nrmDmVaz5Np9FS3DwEpcjCjMZdo/kIcdM8lo/HFuZHhZAb3n231k200ZSazZbi1u
	 /NYz6EIOVlaPB8DdB7b4hhNdII3WwnA3Eaa0ta/Zn2wMHUMPFm9laH02sI6TSJJU6z
	 cOUyHSDWJmFcA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 55C443781476;
	Tue, 19 Dec 2023 03:07:47 +0000 (UTC)
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
Subject: [PATCH v2 6/8] ASoC: SOF: amd: Optimize quirk for Valve Galileo
Date: Tue, 19 Dec 2023 05:07:24 +0200
Message-ID: <20231219030728.2431640-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
References: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valve's Steam Deck OLED is uniquely identified by vendor and product
name (Galileo) DMI fields.

Simplify the quirk by removing the unnecessary match on product family.

Additionally, fix the related comment as it points to the old product
variant.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/sof/amd/acp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c6f637f29847..1e9840ae8938 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -28,11 +28,10 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
 const struct dmi_system_id acp_sof_quirk_table[] = {
 	{
-		/* Valve Jupiter device */
+		/* Steam Deck OLED device */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
 		},
 		.driver_data = (void *)SECURED_FIRMWARE,
 	},
-- 
2.43.0


