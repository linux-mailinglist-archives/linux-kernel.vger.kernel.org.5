Return-Path: <linux-kernel+bounces-113906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296488874A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE871F25BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369315380A;
	Sun, 24 Mar 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3XILv9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575D12BF01;
	Sun, 24 Mar 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321000; cv=none; b=sif5Q+Wof81LpYlc12OMkIEnTjmvkGZd29TsPNaVk4AbBjXB9wTNH5ipDA53KLwsYr7X9aqVtUo4zSF/6otPIgogDOW9ZrlGcgLjNwBuLuJlpXh5F6jVShB42RQGDv2JXobe1i+0gVB+RhDA8+oY+IKr2mT2J2uU5yvLOUFIbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321000; c=relaxed/simple;
	bh=Er6TzvvPYNoY5/r2QLkDuptsOdwRHm97r7RkQrI39vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+A/VlLaXTpjOFZH344u9QD3J4DZpIE12XD+clVChZjCLJ/scYQUo0daSPpvCGGXoGLD04ybYILRCL2v3bfAo2WC5owL2D81laygAloK5mSuetue4QPs9Y5PJJ9MEQbgljJfC8MyDbfX3OoGnwn69Nq+uPmYn4gjZ9nDmL7m0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3XILv9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB52C433F1;
	Sun, 24 Mar 2024 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320999;
	bh=Er6TzvvPYNoY5/r2QLkDuptsOdwRHm97r7RkQrI39vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3XILv9rnYl7bYy/3/HoKIlaAm+V8CYPLV57pTCOKSRTOPNTLxxCI7Wpi9RxKcp0e
	 TqnnGtlvSAi/RU092MT6OmR3ISUsHUpP2dk0piLyVg9cHJiUKcNUePt3M+8v/y5bRU
	 2V4qKZ10hj8L0YdqehyYVIIcj8gp/GAGu5i5njdFnmD4b0j07hIlhpEcLfMEci4zed
	 g9OT0mSRljWfbckxyjRYGqqgDQKwBcmKHp3w+q3VRYyf7MT+qXONyirXSa8qJTsCug
	 IrLkHWCvs/08yqcou6R/MYa0Ob+dK2ZGSaArjKnKwDA03+bGAM1MpWkDV1NA7Xeioy
	 DUGbzPFZFqY6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 561/713] ALSA: hda/tas2781: configure the amp after firmware load
Date: Sun, 24 Mar 2024 18:44:47 -0400
Message-ID: <20240324224720.1345309-562-sashal@kernel.org>
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

[ Upstream commit 68f7f3ff6c2a0998be9dc07622bd0d16fd1fda20 ]

Make the amp available immediately after a module
load to avoid having to wait for a PCM hook action.
(eg. unloading & loading the module while listening
music)

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/7f2f65d9212aa16edd4db8725489ae59dbe74c66.1703895108.git.soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 9fc91a6fe37c ("ALSA: hda/tas2781: restore power state after system_resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 0479ae6e3644a..4b6e22a4b0c11 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -584,6 +584,8 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	 */
 	tasdevice_save_calibration(tas_priv);
 
+	tasdevice_tuning_switch(tas_hda->priv, 0);
+
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
 	if (fmw)
-- 
2.43.0


