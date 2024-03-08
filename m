Return-Path: <linux-kernel+bounces-97409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EF0876A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A8E28194B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CF58230;
	Fri,  8 Mar 2024 17:42:18 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20E4C627;
	Fri,  8 Mar 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919738; cv=none; b=WRSKOadDL8VxTLPE82s6tKZBtUQdV44rTAk6OuOeVe3t8M1933BENz4ZANdFMfoMM5fttPe+q8EqRxSYtdTdc4XmQxRBAEQoDroY0/Wh9WO+sTBpWbo9uC8W/pfmvOK6vwPCK3ziBHWkVGz6lhqfSDUfV0qFB82ZqbnjUuhCuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919738; c=relaxed/simple;
	bh=CC0/RCTb+2f+2nhQeQ5oOucovLX12mdG/Mq7v006+JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dgFOLU/lBIVOEj24d+u8aLte768mInX4KHaPD1wVcScC0V2qAsjw8ipmQsG8dQtFQKjq/YGdDXmRzENe6PWhfnv9udqxF4fYgcqPk451e3bJfZS97j3Yy3/miL5aboZR5wGygVuGF6+bzT2NcnoL2SKtsBsgU748AZWfrtLfHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076811.0000000065EB4DF0.0020A5CD; Fri, 08 Mar 2024 18:42:07 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 3/5] ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
Date: Fri,  8 Mar 2024 18:41:42 +0100
Message-ID: <aa27ae084150988bf6a0ead7e3403bc485d790f8.1709918447.git.soyer@irl.hu>
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

The amplifier doesn't loose register state in software shutdown mode, so
there is no need to reset the cur_* values.

Without these resets, the amplifier can be turned on after
runtime_suspend without waiting for the program and
profile to be restored.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 750e49fbb91e..0e61e872bb71 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -832,7 +832,6 @@ static void tas2781_hda_i2c_remove(struct i2c_client *clt)
 static int tas2781_runtime_suspend(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	int i;
 
 	dev_dbg(tas_hda->dev, "Runtime Suspend\n");
 
@@ -843,12 +842,6 @@ static int tas2781_runtime_suspend(struct device *dev)
 		tas_hda->priv->playback_started = false;
 	}
 
-	for (i = 0; i < tas_hda->priv->ndev; i++) {
-		tas_hda->priv->tasdevice[i].cur_book = -1;
-		tas_hda->priv->tasdevice[i].cur_prog = -1;
-		tas_hda->priv->tasdevice[i].cur_conf = -1;
-	}
-
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
-- 
2.44.0


