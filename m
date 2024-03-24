Return-Path: <linux-kernel+bounces-114736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69A8890D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A6F298CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87021B676D;
	Mon, 25 Mar 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1V/Ccrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203562733DF;
	Sun, 24 Mar 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323323; cv=none; b=odJNhH6ljvuoOQzPaEy3CFRd7jHudn+jEQB6XgnmBzFZyM9ClxzilftYyxaPWt+C7Snkfu4/qFDW24gSpvqbJBc4cR9CSOqIg+coNGIaa7JJWeM8u9jBcXoAAvH30bMA1xUclCNuSOGBpvuLcEuZd0wd2gcdIANdFCjGA5Rr45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323323; c=relaxed/simple;
	bh=aRBHFszry3HcGlRYpmekn9zCgq6YZWmzqSZ5oA0DKuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpjEYczpwMYt2OLAsQhpf5TSfnFOSmk2ku7ZFeqgvC9ZDt6oR6IkaysoKLx3+sP6sE8KIqWKLE/QIwORVB26/g2VEtXESxSrfq8f6VjAuWFoaDxSgMAmba0BmezzQfVc5rwaX+B1ZfdF6xbWkL/ea+Xr+evDnres7GJOX0UtiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1V/Ccrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58831C43390;
	Sun, 24 Mar 2024 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323322;
	bh=aRBHFszry3HcGlRYpmekn9zCgq6YZWmzqSZ5oA0DKuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1V/CcrcV+tmaSsY37yxHCQj7EbPpW0rcmM0JR3+SclN2wp1iOe0Nrc8zRLgHoZxa
	 l9j8/uVOdWGqINm+sxpOyRv/Y/4li+O6ypNCyWAq7nRQcCOwm0UAb/CryluI+aqEAY
	 y35eSw+/z6AfFo8eToYMj5HoSywsn8oCr3p1hWucU1AAealH/D0NBKM8+ulu3yXgNZ
	 FY6uj8cQERLTbHnOS0lDT2jj1S/IhknpzMwFeAESL9WUx5Yi5jir5KznS2LoIVAMur
	 iKolMxr4TrQ3VONVR3G1KPVxMK1T7buSMFKTfOeCyYqX4gh72wBrc0SPg7ZrMUlNT1
	 /1+CqP0hYH/Bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 022/317] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Sun, 24 Mar 2024 19:30:02 -0400
Message-ID: <20240324233458.1352854-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a6e6ed1355abf..3a86f0fd78278 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3675,6 +3675,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


