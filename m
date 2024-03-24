Return-Path: <linux-kernel+bounces-113893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47C888734
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607451F24568
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88D1ED0C3;
	Sun, 24 Mar 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6M55cjF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834B12BE96;
	Sun, 24 Mar 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320996; cv=none; b=R+ILK0euXvKikK8+7Jx6/CZHg1Qoib8tRhnywlTnG3pKWZUKxuLA956Po7hSD5FsQlivxLYMfG9laEHAVrZlP1413wsISGynvnSJJ1H2S9rRyawryQjZ/OMoNJQdHxUOGUlmoAgwEgKpeBdQvDuWHWzuNx72AGBiTrlJjKWCK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320996; c=relaxed/simple;
	bh=7wj8ZEH9eF/rvciTwJY3fQEtLoBzj6aYEvY8TxBcH3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/wQFNCyLzLjYcJwxFfYDCKNveMIL4R5tAgO2X+cLEy4rpOfiSctv75Ovfv9pAPQo3D3gJioYc8tioEPZ0Nc4DDmz3gbk5nmefyFNzum0J5mPHyiorWmbVxUs5eiFwsBqs6PlH9Fi0PzQ/1UdXMeWwn4sDJpQHhXrJSyDsIWyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6M55cjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51EEC433F1;
	Sun, 24 Mar 2024 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320995;
	bh=7wj8ZEH9eF/rvciTwJY3fQEtLoBzj6aYEvY8TxBcH3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6M55cjFo5Cm9avtKnHygvM+NuMKtHKCHwgjAEwBrCuCVGRNT/ziXkQm1FSIj5ujZ
	 aX/jdSpVxe3CR+bJGXFyz3qvQyZxZlL+KYW9yXr3r7LGzFXuD50Dbe7oXWB35LPU43
	 sclULqYSLEpv+zA1LBNi3gHFV7lwBulhsDLcoUDLRV4gs5IXnp+VDzN8rzTSdJa4Gb
	 zLfKyyq/RvfrRh7XRlv9/KQg9HkZLOq+yoFjEfZYioIwvHAdk1LOijdWeRaMG6d6Ww
	 iHxY97Y46OwCpOL21mn0PcKukYCon+mypIYbQkXPhh0lhwtN3XivJTcNRyKE0Q3zMt
	 lzfP0HaKojwFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 557/713] ALSA: hda/tas2781: add lock to system_suspend
Date: Sun, 24 Mar 2024 18:44:43 -0400
Message-ID: <20240324224720.1345309-558-sashal@kernel.org>
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
index c39a5404fb392..10b5624b1f1f0 100644
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


