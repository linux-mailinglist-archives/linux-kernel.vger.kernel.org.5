Return-Path: <linux-kernel+bounces-124813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244E891CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8E288598
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF71494DE;
	Fri, 29 Mar 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvZ2ztwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364B1494D7;
	Fri, 29 Mar 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716219; cv=none; b=boBr+ycvwiXEtjsIDWPpQudsDnGMRUsMi+fbtrD/Cc+/5dHE67W/1U1gV28efrP7QZwe7WIyBI8lxe4MYZiKj9N18oATL9hm3k6zKfAR44iUndTcQv8PeYUlUHuAQ/mgR37xodk1Zz/xUOOiOW//AWVkhamEVbN931i7gkrLmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716219; c=relaxed/simple;
	bh=f9a8hiAIfNjFchr3MPnrQke3V+MD8iEbkKl7otahWz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPNzKhmLOhPQoWAgHo7avfvZDErLWW1yqOaKLlWTOFsnLmLVZsxtilIILCe5rzghON0oYsLSh8qPKQSjCJaIidhmmp3HGstmpiwisz8HpEDUDIg64s9s7Du93iTWaS9IkN/b+8p4r4Ri1we56GnZ2GjkIMeLJptPX7vpQcPoDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvZ2ztwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D86C433A6;
	Fri, 29 Mar 2024 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716219;
	bh=f9a8hiAIfNjFchr3MPnrQke3V+MD8iEbkKl7otahWz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvZ2ztwMb+UtcV3+17oV/Pb/Rcr3aWLEIHSUDp7cjXpxaG1jk5MyRwP3WDLS0vG3V
	 t1yOSiFC9lXRmuaVRX/XB6yn1xF09nuJ+mj+ZehTtXZd4nL+G+hIanYwY4+vRMbCNa
	 vSjxM1iZiCKO67LRhcDZ5dqgUUQaQ5tmjmrfgeEi/gILk5SICjDcYuxA7lTlC0xWIe
	 bFOdvR2jLjTp/U0mMCYYPVR5vcEgiEDYJ3UcGLPGAH4PrnCxfsRX7KTzaYH8xjmis3
	 KRuKvABUVvH6ibRIwbAhZ6CXAUYYdBIi7prjVeod8aVgnZM/4PMqtHmvaEv2CNHHwU
	 EPFbVQRxTuYhw==
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
Subject: [PATCH AUTOSEL 6.6 04/75] ASoC: SOF: amd: Optimize quirk for Valve Galileo
Date: Fri, 29 Mar 2024 08:41:45 -0400
Message-ID: <20240329124330.3089520-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 19a801908b56d..f3768651d6fd8 100644
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


