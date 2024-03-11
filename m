Return-Path: <linux-kernel+bounces-99063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0396878309
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EEC1F220D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DC54BFE;
	Mon, 11 Mar 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j20kLSyk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896054F91;
	Mon, 11 Mar 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169970; cv=none; b=Q5Gpkz1phbqwDQK/JQ3wjGXS+67Gv3msxWBQNig6D6hMPyBnqqbIyMeGc+8sqyMo2c2GbXXDmzjYlOyAtcIGm4rplmebnjlQGQb9fvDuC5HRUoGD6zBiUGqxT8/imreztt5ayXISrl16xUh9lt3E1ap7EX7SJSUFymb6vLdqmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169970; c=relaxed/simple;
	bh=qExPU8C2HXd+ID3W+ZzNQdWxRTKsDvz5q7M7trnFqHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEFD2s0vnhGgO0eZvvfVw52mZK4WpjTmVmJy2FRuuFTeMz4i5Vmeblhcn9XQz+10ImQizlSZKY59cK1qoF/69fnnu+oB7eJpg96m9TYpKUp7pvxgjrnpKW4FnKqsIsDo4MqmwJbluU58afDzkRJ3ZPuqpo0Uk6TwwFe5ps5ynag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j20kLSyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D02C43390;
	Mon, 11 Mar 2024 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169970;
	bh=qExPU8C2HXd+ID3W+ZzNQdWxRTKsDvz5q7M7trnFqHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j20kLSyku3e9Kl1tjAucxhaBW/DjMKsUAJKUseKuDyPE3hCZHZYnlvLoYolVUhqAk
	 sGijBZZOuO79m6q249LyKmBWEwXartX7/+lIdHQlNgvXkfAyz4QREQAhJvfAFQUV2N
	 7X4csblkkeplxFvPdo3rtyCFEUOtaLVX6yypWDIqPcBivoCtf9ZZX48B1whTf2GrRL
	 +aVFAiI0GzErTPdCZKH8fwhpk/n0uH72Aip4oTpnrzz2o7kdnuQgUz3c9jisYnOdfA
	 fr4qKorV0CcP4nPCmJnoAnE7yw51hptW82Su4xz9NVm6/GjrchB60hW3Fb5NyIFvnR
	 dKDLU90tHX6Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 15/23] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Mon, 11 Mar 2024 11:11:55 -0400
Message-ID: <20240311151217.317068-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit b34bf65838f7c6e785f62681605a538b73c2808c ]

It had pop noise from Headphone port when system reboot state.
If NID 58h Index 0x0 to fill default value, it will reduce pop noise.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/7493e207919a4fb3a0599324fd010e3e@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eb45e5c3db8c6..ebde2ea8fa812 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3684,6 +3684,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


