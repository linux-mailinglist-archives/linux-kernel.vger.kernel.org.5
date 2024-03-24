Return-Path: <linux-kernel+bounces-113438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCE888455
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AC4B21936
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48B1ABFCB;
	Sun, 24 Mar 2024 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9qq7RsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381811ABFB0;
	Sun, 24 Mar 2024 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320240; cv=none; b=eDcPDdYE0rk5UuD4S2/mMJ70Fke2Zd3yNW1ZtlpiXXQf0Qcc/9rv+psudcfEhRmbRA7r6v1dtQfKF15g4/bNpOFSyYL96sGbg9Epg+CAoZseQp2Xg5W0JMxTmBDmtpcc3Zk/3JHi/HmnguCpYgbXnJ/BZmYwTCJY0OEppurOucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320240; c=relaxed/simple;
	bh=/RrPDt3RBZ5vCXq3RjEptFMbnXEyFkroPNjaYog9vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNd8II55psr97/IZcKQzX21UtI40qvG/TqbNSjPgbSeYosetsiJVq9C+sNmU/F6MAeDJ2OgyY1Z1i2Dl9cZUpNI5+4gVI2h63+pTQmnYdXZmLdqQ6yr4LxakaW22exoFHRkQTEP6CSWAXdlaZA1ILjDypgW1xnNupZN6+Mj1YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9qq7RsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A089C43399;
	Sun, 24 Mar 2024 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320240;
	bh=/RrPDt3RBZ5vCXq3RjEptFMbnXEyFkroPNjaYog9vs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9qq7RsFJj2Qv2c8BeXXef2C/VkS1CoZJL3J+WALruuE76wy8TT6rUaxDeXxK17L6
	 1GuaQWZxBUVdlDe+5MQyuBzkuz16956FOG97EAcqaFLwfILnprBWUKSg2xp2IZdpKm
	 aOt612VjOjnRfsX9BH0II94615rPKV9jg4NuOCAv7WToxIg1RfBmtqIK4hS/OkYh5D
	 9GPEKX/qGJofcyHZwjnHTngoRovrr6shHqlvmMEtekzo8aJ2GgGuV8OS6ksefc2mdn
	 iyGrnzPRLfkKwU8G0L093ZghB06fHhr7CwVzDQwVS9kIkgjF2uI2Uu5+TW0LBWoA3T
	 2tLiPdb//LM9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 547/715] ALSA: scarlett2: Fix Scarlett 4th Gen input gain range again
Date: Sun, 24 Mar 2024 18:32:06 -0400
Message-ID: <20240324223455.1342824-548-sashal@kernel.org>
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

[ Upstream commit 6719cd5e45111449f4021e08f2e488f17a9b292b ]

The 4th Gen input preamp gain range is 0dB to +69dB, although the
control values range from 0 to 70. Replace SCARLETT2_MAX_GAIN with
SCARLETT2_MAX_GAIN_VALUE and SCARLETT2_MAX_GAIN_DB, and update the TLV
again.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Fixes: a45cf0a08347 ("ALSA: scarlett2: Fix Scarlett 4th Gen input gain range")
Message-ID: <Ze7OMA8ntG7KteGa@m.b4.vu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index ffb8bcebf9ad6..bd114be537d7a 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -174,8 +174,11 @@
 /* some gui mixers can't handle negative ctl values */
 #define SCARLETT2_VOLUME_BIAS 127
 
-/* maximum preamp input gain */
-#define SCARLETT2_MAX_GAIN 70
+/* maximum preamp input gain and value
+ * values are from 0 to 70, preamp gain is from 0 to 69 dB
+ */
+#define SCARLETT2_MAX_GAIN_VALUE 70
+#define SCARLETT2_MAX_GAIN_DB 69
 
 /* mixer range from -80dB to +6dB in 0.5dB steps */
 #define SCARLETT2_MIXER_MIN_DB -80
@@ -3466,7 +3469,7 @@ static int scarlett2_input_gain_ctl_info(struct snd_kcontrol *kctl,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = elem->channels;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = SCARLETT2_MAX_GAIN;
+	uinfo->value.integer.max = SCARLETT2_MAX_GAIN_VALUE;
 	uinfo->value.integer.step = 1;
 
 unlock:
@@ -3543,7 +3546,7 @@ static int scarlett2_input_gain_ctl_put(struct snd_kcontrol *kctl,
 }
 
 static const DECLARE_TLV_DB_MINMAX(
-	db_scale_scarlett2_gain, 0, SCARLETT2_MAX_GAIN * 100
+	db_scale_scarlett2_gain, 0, SCARLETT2_MAX_GAIN_DB * 100
 );
 
 static const struct snd_kcontrol_new scarlett2_input_gain_ctl = {
-- 
2.43.0


