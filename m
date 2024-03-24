Return-Path: <linux-kernel+bounces-115532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB6A889C38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39CB1F36115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4887243418;
	Mon, 25 Mar 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnbeueR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6112BEA0;
	Sun, 24 Mar 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320997; cv=none; b=W8y8vE7lyow8oUoAHOgqi94SU4u382hXYcKjul6ayI7ZWpCPO2lbCkvIK1/bCDJYkelLbSFmHWoNzc9shbkbBLnlIYpoUWgCSGbAeRbJpUbLiidoS9vbSe12g7vZnD43+NFYov8grjbpRhk4e6+0ZlglsBvQkPcYdw+EuJMX5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320997; c=relaxed/simple;
	bh=fB2nfPMH+KLTxl+hhss0EaTEKIN5o3V9KbVoZ8TJfL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFUZ2KvJK8mIkr8FrdNFXKFYrmyFNGvQ6x4VRaO8j2gzz8RWQ+SHGZNddFScrmSY5jI88jOphIIMsQHHR1A5i029d7137Y0Q8O57+m0xcDFNE1gQxDbl9v9Kvx/w0rc9DfcmhGbntUExZXaIz5dHCKPh0zGYpmD5Uei2j7Yk6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnbeueR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D239C43399;
	Sun, 24 Mar 2024 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320996;
	bh=fB2nfPMH+KLTxl+hhss0EaTEKIN5o3V9KbVoZ8TJfL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnbeueR6csObj9ukHhp+TIwSqbajjbVY1kyzAxQVkrBE9238P6lvC+2/U41Bb/dBs
	 2BgJAFLlClCr84m6O8jeW0eJpe+2rafRSu+Q+CdhHgJTzqDcH2z+wnf97CCRuWxHtB
	 7H42xEhyaIiP+CmVga82fcaK35zELOYxt7FuFjVzW0mDF99jjP/p9gfaekRo+SIW9H
	 J00d8VhwhYrwNGYu7kMxy0hncIihgn9nDJa+RkTC/E1NojGyHR1DXM8qf4984I68NB
	 5jrfXb8x1EWYryz+EhCiUNipGwU0iGKF2z+g0GOrVwaYIdwDHxbv0AtYe/vB4y18aX
	 8gGYHyLOFW1rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 558/713] ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
Date: Sun, 24 Mar 2024 18:44:44 -0400
Message-ID: <20240324224720.1345309-559-sashal@kernel.org>
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
index 10b5624b1f1f0..04539abf9e716 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -740,7 +740,6 @@ static void tas2781_hda_i2c_remove(struct i2c_client *clt)
 static int tas2781_runtime_suspend(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	int i;
 
 	dev_dbg(tas_hda->dev, "Runtime Suspend\n");
 
@@ -751,12 +750,6 @@ static int tas2781_runtime_suspend(struct device *dev)
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


