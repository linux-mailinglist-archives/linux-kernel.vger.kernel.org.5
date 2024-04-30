Return-Path: <linux-kernel+bounces-163871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9788B74F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD51C21492
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3213D2BF;
	Tue, 30 Apr 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jOZ2ihVM"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C613D247
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478083; cv=none; b=EWo2/CsgBtsQG2PVVRibFucf0hSNqmr0oMM60AA4XwCKaG/3ODFPsy8F7JikF/+eESLKiXl9Csfw5tfaGiiO01iNG3iVr4HApjyCJBlT7/ZqfDVjSRfR6d7Vf1fxlWSxzu4GRv1sOXcvNzQG2cfmMFN3QFXt5KAj6V3S4s0r03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478083; c=relaxed/simple;
	bh=1ukMYFxzPfY1qsmq+J1Ewq78TfiLOMOqhtd5od5EB0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehs41bZfERymN/7HNFILDRJp4/k+hax2WoPUO0AlHyiAxNRBkwZg7cNeY4PEP7sjc72CCmFHXqpcmBlocPWMJk9hVI6roCsVRsxODI5SV0f0nxVn+mYuKXPJ9J1FlgIN3Ti/Acvr3iuOWOZBU1GKquxj6s9ig01jelm59xV2tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jOZ2ihVM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zwiSUDPpKEKl2A0JVQtlH+c9e9Co8VShhAKYP5+ABCA=; b=jOZ2ih
	VMtj+LpEO83K4WUH05bZJkKW2aIENuvPgJj6kMqSJkUJwVNzWGkBeQHzdS6Cwbtb
	LblUrnd60FpBxtCcNegap7qS86svKc+82Q4tGgaxOVbn6i9EXWK3psAGrvSv9aA2
	gwePwEmqHPskdH3WSR6bwODgDdCOHPCn6+f4QFR3wSb98qJVPtQ/aZnZ7T1bw+SJ
	hcR2MswKtdaJOwTYlMf3iywl6kzN+nz30CNAkYPP+KEtvT6XKdaduFDELqKS7OSc
	xnT3A6EUSYGvqHIssmN0A8x120NvmnsX0xgfbV5KihL3uBn+lcUZ6W/Q8cVzf0ht
	5SB0ql11qSVI3zeQ==
Received: (qmail 2621497 invoked from network); 30 Apr 2024 13:54:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:54:39 +0200
X-UD-Smtp-Session: l3s3148p1@ds3jCE8XMqtehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: codecs: wm8962: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:54:34 +0200
Message-ID: <20240430115438.29134-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
References: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/codecs/wm8962.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7c6ed2983128..3856e7a8eeff 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2886,7 +2886,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
 	struct _fll_div fll_div;
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 	int fll1 = 0;
 
@@ -2974,14 +2974,14 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	 * higher if we'll error out
 	 */
 	if (wm8962->irq)
-		timeout = msecs_to_jiffies(5);
+		time_left = msecs_to_jiffies(5);
 	else
-		timeout = msecs_to_jiffies(1);
+		time_left = msecs_to_jiffies(1);
 
-	timeout = wait_for_completion_timeout(&wm8962->fll_lock,
-					      timeout);
+	time_left = wait_for_completion_timeout(&wm8962->fll_lock,
+						time_left);
 
-	if (timeout == 0 && wm8962->irq) {
+	if (time_left == 0 && wm8962->irq) {
 		dev_err(component->dev, "FLL lock timed out");
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
 				    WM8962_FLL_ENA, 0);
-- 
2.43.0


