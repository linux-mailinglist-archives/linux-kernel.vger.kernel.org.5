Return-Path: <linux-kernel+bounces-113432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02975888448
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7256AB25F16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91B1AA937;
	Sun, 24 Mar 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVcV6r17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D51AA91A;
	Sun, 24 Mar 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320234; cv=none; b=kSfknYux/WV/pb4xGsMRpXNFcKIRf/iQg1m6Nknjcn6jmQGTw8G6P96lBpGflBy1yQHxSNHnhtn/fKjT6BJh1Txg+pqfZKJoy7qMfBtWdNwAV7Ot1DDy5qAn0nTtvq6zGEVRjOFsNi3z1dT2EqhpuC4iYLOdxGrDafZMxJ/MwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320234; c=relaxed/simple;
	bh=uqW+vHnpi3hn7/6lZ3eu8/qtdKpo23FfOc7EbGWzq+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnxC43rLgXCP0v5kmbNCRTELwCdaeapo8aR9Cxe/sgv6YnmSu7SAfk5gpBwliIXbrUEt5qFYN8a2g6mvw5Iatc1Bk71ABaEY/GIITrUyxDyOrqMjOXRCCeMF+9IxIT1dRkuo9uMd5uUIyQwKw+qXBRA56N7mDBMKm+IQ9GL74Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVcV6r17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15704C43399;
	Sun, 24 Mar 2024 22:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320234;
	bh=uqW+vHnpi3hn7/6lZ3eu8/qtdKpo23FfOc7EbGWzq+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVcV6r17B6zp2wcYCF01gUkiAcexe5EP0RXSzVz04PCpYkNwnratrjAuekhYWzYBD
	 9haCI65jcIYwYc5uRLFdJnawl6Sy6G84wIJyFV/Amu9ExtgV8hcp4rW9+iTgDaJGv6
	 USa7NynWKPe9mwQz3xSfPocZfIht7M5KQ5Ms/J9CGBOCOASvIImo14vSvX9Cr4ajtz
	 8c1jfHPv8aWUTMCHToFPBw5rH7jfJRmsvoWVkEq+I805IxfD7Rek74zg8dlfGXaXo/
	 VXTMzuVfzMLwQWuYkE6Zsv0AkdgcC2NWl3eCo9hWmaDWAuta887FN6aGVtEBzhAxhV
	 wwHV1SOPFT28A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 541/715] ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
Date: Sun, 24 Mar 2024 18:32:00 -0400
Message-ID: <20240324223455.1342824-542-sashal@kernel.org>
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

[ Upstream commit bec7760a6c5fa59593dac264fa0c628e46815986 ]

The amplifier doesn't loose register state in software shutdown mode, so
there is no need to reset the cur_* values.

Without these resets, the amplifier can be turned on after
runtime_suspend without waiting for the program and
profile to be restored.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <aa27ae084150988bf6a0ead7e3403bc485d790f8.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 750e49fbb91e5..0e61e872bb716 100644
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
2.43.0


