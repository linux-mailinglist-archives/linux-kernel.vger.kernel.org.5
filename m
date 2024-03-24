Return-Path: <linux-kernel+bounces-113433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D075488844A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5082835B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9FE1AB180;
	Sun, 24 Mar 2024 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx6t6if6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024981A9F71;
	Sun, 24 Mar 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320236; cv=none; b=VuX1xTpATBZjqgTcjUUabgIGyyHCt/mZ+zGDKg+ceWfzBDCRiTtfa3eydiAWyQfTkgvy4AGwfB8/OiU37JbPq/HIZbOCotU9xmRlg5CHbd63saXbrGUPGmHLunLEyn/PVcFpZXm/0n9MTqkt7Oh/NtQZ/u/qi85ZUedbw7kxYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320236; c=relaxed/simple;
	bh=NFFchTp1Ml4DsB5DoHY8hVkJL0xymFD4TnxU8NfBies=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMWQBbhwEmTYd6V2ugTF27vWJhBeCApUDUf1JTriUhC3LfQKQU8s04g3tM6lo0TApJopcZv9hdSKUjLzyIFfnDN3Grvgpe6eYBIyBAnV9VyQHu0EHRStF6poavoiYXm1EYzJMl4MX5i13gNWQLOsnc8RSAYf+DjFNTY/Y1PPT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx6t6if6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F1CC433F1;
	Sun, 24 Mar 2024 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320235;
	bh=NFFchTp1Ml4DsB5DoHY8hVkJL0xymFD4TnxU8NfBies=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx6t6if6IItKnrqL4odgklgvhyWJ2e01nq9QMktfqYxaZz3f3+5dBQwOAX+u7h9u9
	 hR9nDGsOeXSFHUXYDdHjYwADSL3NIzMuq1x9yr/sJZhHHrOKiN58eqvSOTuOuot2X6
	 fCN+y+Jd5duoyxHAuTna2/z+CRN2ySNHlS4SEq4QFwa8oLc5k23UNZhYH/j4kWZLy0
	 WZXgJ9Avp6xJE0Q6PbGTeuAtnVl0X9vec4YcwPGTQS8QOLsl6hyz4PODtwEghU1w9o
	 Gld+H5t6jP/moiXUk2I+IpAFEf5x0Y7pITNEwkExoYxaafvg6jN41AU/JFw1oOb1J8
	 AR+y0pFzWi8Yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 542/715] ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend
Date: Sun, 24 Mar 2024 18:32:01 -0400
Message-ID: <20240324223455.1342824-543-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit 5f51de7e30c7282162a631af8a425b54a4576346 ]

The runtime_resume function calls prmg_load and apply_calibration
functions, but system_resume also calls them, so calling
pm_runtime_force_resume before reset is unnecessary.

For consistency, do not call the pm_runtime_force_suspend in
system_suspend, as runtime_suspend does the same.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <d0b4cc1248b9d375d59c009563da42d60d69eac3.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 0e61e872bb716..a99f490c6a234 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -870,14 +870,9 @@ static int tas2781_runtime_resume(struct device *dev)
 static int tas2781_system_suspend(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	int ret;
 
 	dev_dbg(tas_hda->priv->dev, "System Suspend\n");
 
-	ret = pm_runtime_force_suspend(dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&tas_hda->priv->codec_lock);
 
 	/* Shutdown chip before system suspend */
@@ -895,14 +890,10 @@ static int tas2781_system_suspend(struct device *dev)
 static int tas2781_system_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	int i, ret;
+	int i;
 
 	dev_dbg(tas_hda->priv->dev, "System Resume\n");
 
-	ret = pm_runtime_force_resume(dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&tas_hda->priv->codec_lock);
 
 	for (i = 0; i < tas_hda->priv->ndev; i++) {
-- 
2.43.0


