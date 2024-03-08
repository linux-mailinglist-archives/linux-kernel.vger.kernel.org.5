Return-Path: <linux-kernel+bounces-97408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52853876A19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1E281C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DF56B7F;
	Fri,  8 Mar 2024 17:42:18 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AF3FBB9;
	Fri,  8 Mar 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919737; cv=none; b=TcIqi76Duk9shKgUyQZnZ9vWi9U1UkJ/0gnQGuUl7smI39Jg3cIUziecm6LrsqTFP0YyP3Mb47xuAz4fNQdMe4/Bp+Vs/mGzOLtPbXlkkn/kx+TU84M+hLDxMMeQvCUeqWIJ/5XPTo+jt/oZ4+v7f18oRE7z/0NjA3qywHkovWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919737; c=relaxed/simple;
	bh=Jw6H/X0CX/61elARNUFXKlsTxT779kTCRm/xhTeM5I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iUPQvX3JcYQNzI49bTpKblIPQe//lbm//G4Mg8FGVrfXpF0G83vyzU2UJnvqBqR/4DezVNhxEg7Qtbt2BnyVovt8o2Ih1gUJqzhbcEr3PyW9NPBXyPbxxWLBDO9Yy2ERSiwxRnFcBg/Rd1CB5JNkPGRc5ORXJu+ZP0yZ35F79CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007680E.0000000065EB4DEF.0020A5B8; Fri, 08 Mar 2024 18:42:07 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 2/5] ALSA: hda/tas2781: add lock to system_suspend
Date: Fri,  8 Mar 2024 18:41:41 +0100
Message-ID: <c666da13d4bc48cd1ab1357479e0c6096541372c.1709918447.git.soyer@irl.hu>
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

Add the missing lock around tasdevice_tuning_switch().

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index ee3e0afc9b31..750e49fbb91e 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -885,9 +885,13 @@ static int tas2781_system_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	mutex_lock(&tas_hda->priv->codec_lock);
+
 	/* Shutdown chip before system suspend */
 	tasdevice_tuning_switch(tas_hda->priv, 1);
 
+	mutex_unlock(&tas_hda->priv->codec_lock);
+
 	/*
 	 * Reset GPIO may be shared, so cannot reset here.
 	 * However beyond this point, amps may be powered down.
-- 
2.44.0


