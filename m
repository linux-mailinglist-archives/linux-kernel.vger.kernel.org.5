Return-Path: <linux-kernel+bounces-99098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3E87836B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F4E281F71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA463105;
	Mon, 11 Mar 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3gqqxI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883B633EC;
	Mon, 11 Mar 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170049; cv=none; b=tx8bwHC9rZwiB2zNpR5/Bwj8zUpNUuUIJnAcqETqGkWWB+syUl5aiSe21BwLxMFmgNGiKSp8OQfJ3ENnNjoePoJTbPpGYXhYZa9tgmXBpclc9JTpMN/gqwCJYogk4uDRml5YKwHiq+2/gFmrK14XQfXZ/aIRKeJ2UWFF2FFxHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170049; c=relaxed/simple;
	bh=RGrOirHE3j084FyDubnAZGEumOuMaqgWe3b9VZ19Iww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW668D/CGqkgCTFFNm2MXeQr+F1S48bZ+cXiyxzX3F5mNUisQr1HLw7g5igq5mvsn/Gn2roYXDxjnMDenqpR6qdVIe/n7bKxd3wGePYC7JNJfWXBux/9ChVjs7eMDdPG7e3mUe8XkqK3QPREwgEzR/MKYUumib5obhH+0BzhW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3gqqxI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3F5C433F1;
	Mon, 11 Mar 2024 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170048;
	bh=RGrOirHE3j084FyDubnAZGEumOuMaqgWe3b9VZ19Iww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3gqqxI3OJqr73QPN93LWe9swFysqMiETNXRLMaTslfmJoQQ1y2sNLcUf/e8gdROs
	 QmXbXulHQ2Wh7hhKZfEs4fwY362myAYuiDQ4wAJSfTA2AmPRwjjECPrzAdcHDQDcTA
	 g2Xv/dliCnHgaX5ocip41W3WRt9DDt/8uyCuuoUWHpesFTazcM6Y0wXx1NlikuBalm
	 5zOWnO0tcqs/b0XjGfQiqldo8UctjZcd+2WiExL81sLi92oaoIfKUApVaziCWTFb8u
	 aLtEC5avYwoi6+xiN5lajTF1lFpHrAdbjVtaCutgVT6UK6GO1wGBqsRbTXcLInMCa/
	 3ItUUax8oCU6A==
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
Subject: [PATCH AUTOSEL 6.1 07/13] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Mon, 11 Mar 2024 11:13:42 -0400
Message-ID: <20240311151354.318293-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index 75bd7b2fa4ee6..ede3f8b273d79 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3681,6 +3681,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


