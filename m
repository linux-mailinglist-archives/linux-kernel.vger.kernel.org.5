Return-Path: <linux-kernel+bounces-114374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF3888A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F71F2BD98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E9217710;
	Sun, 24 Mar 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg56eQaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994013BAFB;
	Sun, 24 Mar 2024 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321775; cv=none; b=jonf90Qj3wFiYRGaQIhIcjiRoIFsj2jqAGP6nd7tGjZFaLTHFHwEGwUEo3k3+euos8Azq6/iiN510hJ8eOV+8wwe4zi6x4S+zlXQqCgHQB/Cv93bnHItgImbGyUH7yk6T7LHTXzgSpt9I5LABdBQzar+FlNooTe3XLUq7stn1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321775; c=relaxed/simple;
	bh=P6vbMeX6o8eJ8sBSv/YPicVYaBwT0SOMHXroJlUJkyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvqLEIQJAWmLeb0/+BfnxR/NFNWWCc07mDPBmWZlKM9Hyx1wNW1QO8EkCS6v2RoUNPhB05SwDA2WaptRUN2VLolHvJadrvTsKjgC4NPLMk45lUSTLK/A6ayVjw3gq7JzhmjHQG4G9H7o4JSzMyZGFhe4Md9KvmFuAlcfWZgtx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg56eQaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC58C433C7;
	Sun, 24 Mar 2024 23:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321774;
	bh=P6vbMeX6o8eJ8sBSv/YPicVYaBwT0SOMHXroJlUJkyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg56eQaL8SzR7q3vz1VVrXEYlpDyF24TLbtL0ozQDx/FHgWmwkWt82HqWzjJ9ftGm
	 7oitGitHY6axN/yKi7HgLgJsCklmUryLAVYJIgvr18ax/Y2vQujG5WJGluWT11CgnE
	 8bt49NyIU61A3cKxQH6BPJuH+5w4qyWMez9MamT8A+Sg5Lu2q/7iKUK2jTn+iW4pCp
	 e+EmB+0dPseLuFya+FLOCgLx/qUg+mvjEqYGRPx+Fut/iDz1Qj68++bKUd7xxjnn0W
	 Z2XJWqLYPzAmSpy9MtYqRKLw08q/ITcbH7PrP5O5bBNIHQjoCsuERSmacZS9sbKF6v
	 fi9DGQa9hBaGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 501/638] ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
Date: Sun, 24 Mar 2024 18:58:58 -0400
Message-ID: <20240324230116.1348576-502-sashal@kernel.org>
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
index afaa7ee171a7b..5d6083ffa40c3 100644
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


