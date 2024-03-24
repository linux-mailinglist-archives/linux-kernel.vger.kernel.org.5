Return-Path: <linux-kernel+bounces-115719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0233889486
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945E71F32D45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF46D3608A7;
	Mon, 25 Mar 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfle2i8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EC217325;
	Sun, 24 Mar 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321773; cv=none; b=FUbWOVw7rzi94HMzB/fkSEy6Zv+iLuYXE+2ur9PrR8qwrPXQ1nJ9tnlDgJSOl1w0I2ANo5+1mT1LzGlXSsbJJX53A2Dkg4QqWshnQLBSonxL09rBvLzlAvqH5E//6pnh4x0z3yT7T4ADeKbt9J3A2rvw5U5V0cUXsOAuSqHnAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321773; c=relaxed/simple;
	bh=3dYrZziH9lphsQz9UAvpKmBtyVzqw4xqduJjZ/pf/gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPAgglBjeb/xyDgMZr/ov1dCQdrMuClzz9OplTMr8hqOx7kt6bIgfIYPDdnQmW2Mm7JaFh+iv/Phsoi2rKHB8hcrvsJ4BPWsEl7fo0qGIEDnHh1Y98izoXraSctpTxFMo1gnn/speKmrN3vdNl8/31deNwnAuuo6MG4nyDq2/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfle2i8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7303C43601;
	Sun, 24 Mar 2024 23:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321773;
	bh=3dYrZziH9lphsQz9UAvpKmBtyVzqw4xqduJjZ/pf/gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sfle2i8D8ZjinHaNNu3edPGJZQJj0eFKELLI8PfD2x9TPe1vBOtab3t6gPwfpIj1h
	 Dx5BJmndpKGgPb1zvnpUAK8PKTuMgGxUKMdPO5M8zCy8JGB6r/kneEeykCGlUKevea
	 W/0hiAyfYCZHZEQUBYNXBrqHEC3eh4F01J6XSMBJe/43Jtxf3GCoJcbk40NRJ/tZS4
	 9iIKjUTzH14+99VJkGP8EwHXDtaWIpt/Y5UQf3idGfmimVANtrXZUCKqlC5WlHuQzg
	 sR5JJdGLcUuJgPsDO8Wu+y01mECw0rpiluV6fp0NYqY3qY74LTzn13wSjuACd6yNak
	 sYeWNQaS2/kBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 500/638] ALSA: hda/tas2781: add lock to system_suspend
Date: Sun, 24 Mar 2024 18:58:57 -0400
Message-ID: <20240324230116.1348576-501-sashal@kernel.org>
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

[ Upstream commit c58e6ed55a1bb9811d6d936d001b068bb0419467 ]

Add the missing lock around tasdevice_tuning_switch().

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <c666da13d4bc48cd1ab1357479e0c6096541372c.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 1abe04e2685d9..afaa7ee171a7b 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -796,9 +796,13 @@ static int tas2781_system_suspend(struct device *dev)
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
2.43.0


