Return-Path: <linux-kernel+bounces-124715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5D891BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C111F2137D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B3137753;
	Fri, 29 Mar 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRYbjh0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AB145B00;
	Fri, 29 Mar 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715973; cv=none; b=Yyeryb0xUW3S67Oavg6Cj281PpzOPmY0nwSCyx2tO7oMt11IfEtHjE2HgR0Er2BaUtgkhC7+Dx++50nQDbYO6fV1WxWMMCXCzsYtMglckVPTqAxqlng+V2NZ11ZGxmSYiKEkLLHZ1mZA5wHSnxIa0uZG/KgMqllZ/fMYMvRpV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715973; c=relaxed/simple;
	bh=OAWyBA7iMNPfP1ZPwLMADM0LatMIAyAS5d/vWVbn0Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMW+M3eaijfPpPYTKfbKVuD1dIRiTwAjE979kYKI10aQ3VTU0pgktvkSeNlFO8fGWny5N55AGbP+B7u/a61OZ9Jl7cWHLKx7V4HmsNhKcZ3Zr/csl354X2gibtP7WLm43JYtnoFS6coap3SY1uwNsXPPBqC8D1ZozwmcMveTx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRYbjh0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EBAC433C7;
	Fri, 29 Mar 2024 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715973;
	bh=OAWyBA7iMNPfP1ZPwLMADM0LatMIAyAS5d/vWVbn0Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRYbjh0zpPDmk0igJMT0RkX3RO34WvycQTyCr5Jy+pNdQ61JhFb54HFAnwssLOZoi
	 qyLUNPhb7/jsYZcmYVtS3zbY0FjhvOd0ce2rt2+faYwkfY01nif5LlLUCTS09zGo/T
	 u4W/tX/XhTxe0+1YrFlqvu65KdYJ8dFXiF4xWSB4V2Xkk6qUOHGw6uxBM8+4h7RCGU
	 8ghNUk4HPPu71K26ZmcHwbafcs7jCbHqqw51ZZzcYaHswBFpBuDu2qa8DlFeIaJjKf
	 +lv40E5KcUgThODxn6FpXWyj//jJmo30lgt1NYNbGIU6iJBxohD84SF4Skn9irDjHl
	 4poxTByZ7SKAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vijendar.Mukunda@amd.com,
	venkataprasad.potturu@amd.com,
	Mastan.Katragadda@amd.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 06/98] ASoC: SOF: amd: Optimize quirk for Valve Galileo
Date: Fri, 29 Mar 2024 08:36:37 -0400
Message-ID: <20240329123919.3087149-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit a13f0c3c0e8fb3e61fbfd99c6b350cf9be0c4660 ]

Valve's Steam Deck OLED is uniquely identified by vendor and product
name (Galileo) DMI fields.

Simplify the quirk by removing the unnecessary match on product family.

Additionally, fix the related comment as it points to the old product
variant.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Link: https://msgid.link/r/20231219030728.2431640-7-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 07632ae6ccf5e..7bf5a12da1cea 100644
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


