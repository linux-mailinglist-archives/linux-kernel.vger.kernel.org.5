Return-Path: <linux-kernel+bounces-115720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA68889D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D091F36B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892DB3608A5;
	Mon, 25 Mar 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTpmdVZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56521733D;
	Sun, 24 Mar 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321776; cv=none; b=ZWWKcEjVO3BEav+Lfw1R6RdLvQtCBknLaqz1hMPtZdYTTquVDB7kLnNGcSbZPYgn3wUobkMYE8Tmbgk8tmVUhZbJX5opRPuhOGYYExIG05BmUDMslxOR9XLu5yDfHdx9bF2Qm4reRHt3bfYgJsScbG3jXrrtVr4th5jmgQXl7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321776; c=relaxed/simple;
	bh=NscB8Hb75iHlIWlZdTBzabvJYmQiMpj8CO1/I7bIhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfFhiKEqwA4ftPf5eeZe97j9IJs+wC/SHrnLxvsymzP3kGrO5XxGSO+mVRTgqRlgaf7+IdC2F3G+jzg6QNqeZn0SS3DDYZ89EgDnzdBeGiHMEKFDRO1KALesNS2JuMnFNamoo8q1ZT73ipIkyDpiB0zzRGM11zjmyNBCGL3oeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTpmdVZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A4C43390;
	Sun, 24 Mar 2024 23:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321776;
	bh=NscB8Hb75iHlIWlZdTBzabvJYmQiMpj8CO1/I7bIhLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTpmdVZEmduP9fXmGHBLwFkhW6JhLwwc+jTvnkqs+Yf77vQqBZhYbXreHyaw4Q3h5
	 XUcxiMLxAA6v6iQAMu76HEYMnOQJFO3AFrpnBRRJfqORHT7Cj7wyu2pRtAGC1smkc3
	 JFGyCzsLYyduIanEsHY3cs/B7fAERHSAbf8jGNWoHvyDQWoy/mKh7HsZASGON90Bhm
	 /0Jp3vE2BI7zzlFfzAkPENxsL/54W3SROyC2hZXpScv8ptKr7q8UDDn2VY3wau5dp1
	 oV+TfYmtd3Mn/x1A86M4jEHugvrPD2aNGjWDkcwKgnNeDb+b7R6UOxkOd/Xvz+Vcje
	 +6QCjhLJ7BnKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 503/638] ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend
Date: Sun, 24 Mar 2024 18:59:00 -0400
Message-ID: <20240324230116.1348576-504-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 663a7a56832fa..57070a1364dd0 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -781,14 +781,9 @@ static int tas2781_runtime_resume(struct device *dev)
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
@@ -806,14 +801,10 @@ static int tas2781_system_suspend(struct device *dev)
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


