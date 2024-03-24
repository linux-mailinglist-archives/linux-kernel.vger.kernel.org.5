Return-Path: <linux-kernel+bounces-113437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554C888452
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07521F2A74E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130A1ABFAD;
	Sun, 24 Mar 2024 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4hvAIWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BE1AB8FA;
	Sun, 24 Mar 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320239; cv=none; b=fnSlcXModtlcGGdDJV9zgnPAMSIqvaq5aS2LVZSZJ0tIbM8E4qO4m+2eHXr2b3CEfSjSVS3ncdQAjzkPkKYxhvOa/OTgJgnJWSQCdXqUk5LrN9D+Tj3cN34z9+aJb7Ub7l0Rz955u1iD+NwMRHzrlhU+S0r9/q+5Aia8zL9tdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320239; c=relaxed/simple;
	bh=zU/rO6XE8qAJSa5ClpHRDF8bcja9FTesbxaqSZ165Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0ChPoN13YY5h4x7thhciW4xk1rEIwChSEJXwC50xMqwEBZ7WKvrCCfqEKiOFplaSSMdGXHzK72G+LDRb6v4zLLKC+Io1/N1GxYzXbzCIciV4AHotIE4Aa3Gpe/lU/OhsAK2JODzxLAK+xwIyEYNHorGUR6X1oxGMGIZKRtV5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4hvAIWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962DDC43390;
	Sun, 24 Mar 2024 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320239;
	bh=zU/rO6XE8qAJSa5ClpHRDF8bcja9FTesbxaqSZ165Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4hvAIWdAOe4lIhGNOcnKs6eW6oQXqhBMriM8qUgRZncBYgwopyl5fyd+oaBffSeO
	 CqL+L+kqc6vuwKF0wHIuEoSRKn6NOKVTrgV/6qqPrSQe2/Of4wve+XUFiCoUpvnDaP
	 KMfKYw2JWp4cWWnsLviKFBiy7/ICZevjbx9Yh4dQ0bxgFZsUwSRFCpFOrKrYLl+3IF
	 lLcKE4MjXNKMTkAMpmA1wR9C8F6dy+NuljsNz1KgWOb0oSmgE3cT58lToX9QlbZeGP
	 2+y+Q9bJiG2GOXwDh0uvlZ0FVRadfvOqtvII++paggxvP/s4Ds3dxAJGLWE6pi4yvs
	 r4z6tlEzDE8Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 546/715] ALSA: scarlett2: Fix Scarlett 4th Gen input gain range
Date: Sun, 24 Mar 2024 18:32:05 -0400
Message-ID: <20240324223455.1342824-547-sashal@kernel.org>
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

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit a45cf0a0834779c741ac204c0320469e9aaef006 ]

The input gain range TLV was declared as -70dB to 0dB, but the preamp
gain range is actually 0dB to +70dB. Rename SCARLETT2_GAIN_BIAS to
SCARLETT2_MAX_GAIN and update the TLV to fix.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Fixes: 0a995e38dc44 ("ALSA: scarlett2: Add support for software-controllable input gain")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <9168317b5ac5335943d3f14dbcd1cc2d9b2299d0.1710047969.git.g@b4.vu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 3815ce1d216e6..ffb8bcebf9ad6 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -173,7 +173,9 @@
 
 /* some gui mixers can't handle negative ctl values */
 #define SCARLETT2_VOLUME_BIAS 127
-#define SCARLETT2_GAIN_BIAS 70
+
+/* maximum preamp input gain */
+#define SCARLETT2_MAX_GAIN 70
 
 /* mixer range from -80dB to +6dB in 0.5dB steps */
 #define SCARLETT2_MIXER_MIN_DB -80
@@ -3464,7 +3466,7 @@ static int scarlett2_input_gain_ctl_info(struct snd_kcontrol *kctl,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = elem->channels;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = SCARLETT2_GAIN_BIAS;
+	uinfo->value.integer.max = SCARLETT2_MAX_GAIN;
 	uinfo->value.integer.step = 1;
 
 unlock:
@@ -3541,7 +3543,7 @@ static int scarlett2_input_gain_ctl_put(struct snd_kcontrol *kctl,
 }
 
 static const DECLARE_TLV_DB_MINMAX(
-	db_scale_scarlett2_gain, -SCARLETT2_GAIN_BIAS * 100, 0
+	db_scale_scarlett2_gain, 0, SCARLETT2_MAX_GAIN * 100
 );
 
 static const struct snd_kcontrol_new scarlett2_input_gain_ctl = {
-- 
2.43.0


