Return-Path: <linux-kernel+bounces-113900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C488873E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE741C26533
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D5A13AA20;
	Sun, 24 Mar 2024 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djJvOCBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B912BEB0;
	Sun, 24 Mar 2024 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320998; cv=none; b=rZMIdAhhCTIhFo+lvAmOEZ5Z3NLdXSA3EXAT1OnDca+FAIDLtDS7SAi5ZmHsG3uNyzOKOojuBQbgR2ucJcVPwANRZdkt2hAgZvFHnUytuE9q8bg6o7LUvOdVdSw3+oh0EgavRJ5hzJ86zEv/AfaViv4if86nzSraCwBHsAFEwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320998; c=relaxed/simple;
	bh=nq8RQMG4qV7+MpmlYa1k9dX1o7EgIg46ZAyf/1G7jWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za9YV0Tp6w7gyDe995cAO0HhCCyxjYakvd3V7Sp3IuFV5P2rZWZcWg996uI/WLW0E44WtSEVpjfs3reyRBeWXhZI0+a8VgQ+BlTfg5siL4KO3P3hddh0oa09hoPaaE2E/13qzEZth0JEaqXjMlLc3EPggfq/dY7F4vjNJsJt4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djJvOCBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B9C433C7;
	Sun, 24 Mar 2024 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320998;
	bh=nq8RQMG4qV7+MpmlYa1k9dX1o7EgIg46ZAyf/1G7jWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djJvOCBDUzhzVnFIGPhnH4jSbDmPLoabGAb3ygCaYBA7Y0YX1asSA8Irgn62idCFo
	 yBJwxXxW1/mR1ghyJ/klYhD+2yvpOzQxOGqDggW2snngpfdkNEZT+9mBARqBQ9A16V
	 sbenZeGbJ+ks3s/oOEcm2cbj3cXkF7kDXVXQOxlxCIklFwIrYGm3rbHhw8/Aq1npEV
	 bfxGoTDFTnhSc+/Ye4gpKglJR/tCo/gmuwzjy05TIrVJo/8n5MTlTd5eFWW+KIe1hz
	 f80oCOYX7ljZAMbGaMl8ZswCaYTRnUhqCjy23/rdVXmjn4MvQxEU7AAoGvL80u1DyY
	 IrbVvNtCAfnGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 560/713] ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend
Date: Sun, 24 Mar 2024 18:44:46 -0400
Message-ID: <20240324224720.1345309-561-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 167ee2f89e9d0..0479ae6e3644a 100644
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


