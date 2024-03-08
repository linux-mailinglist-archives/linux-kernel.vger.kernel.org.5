Return-Path: <linux-kernel+bounces-97410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3147876A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72213281671
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472655A792;
	Fri,  8 Mar 2024 17:42:19 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF540861;
	Fri,  8 Mar 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919738; cv=none; b=GRqWiTe4cs2MeJgz5oFd8br/77itwfKBMK84bpCwMKzvBmwbYg6MTmu1n6iEUExoVHjl+Tsb6BF4jO5hvCJRjBXofL7mSJPZk02xgPgUHreLFTWhrnNPKeQSpxCM+oZ1MczRPVhvN49ubhvfdy8+ZpDP305p5Vie91JV+ggCmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919738; c=relaxed/simple;
	bh=O2CrALeJMZN9i7u3qt4or2kEq0HlxKtNqWa/kAbEuNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=srGqW/mspf0AFu1grvyQbCxJjBeYvo+qdbpCA/vJAhrPtL0oRF88AZsrjGBSBOJITvKdlI1P4rjPPpFjWwfSoIadDcbiqR7qoY/Fvyte2jqTkp9rrHaL7e45zks0/8vlkenmaBacqv89T01YnA+41SWABMKhnGOIv7f1uD7f5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076814.0000000065EB4DF1.0020A5D8; Fri, 08 Mar 2024 18:42:08 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 4/5] ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend
Date: Fri,  8 Mar 2024 18:41:43 +0100
Message-ID: <d0b4cc1248b9d375d59c009563da42d60d69eac3.1709918447.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709918447.git.soyer@irl.hu>
References: <cover.1709918447.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The runtime_resume function calls prmg_load and apply_calibration
functions, but system_resume also calls them, so calling
pm_runtime_force_resume before reset is unnecessary.

For consistency, do not call the pm_runtime_force_suspend in
system_suspend, as runtime_suspend does the same.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 0e61e872bb71..a99f490c6a23 100644
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
2.44.0


