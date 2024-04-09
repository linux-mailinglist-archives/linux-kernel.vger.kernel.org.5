Return-Path: <linux-kernel+bounces-137429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D289E1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C10A1F21952
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98822156998;
	Tue,  9 Apr 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RG5Vq7xE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC618156897;
	Tue,  9 Apr 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685403; cv=none; b=uASiEGDQdNoFdj3Nn3fb3NIf1eqshRNGRYqjS8OLbIsWIdOHUjwd0jjFIbWAAuMymSdSRqZskQvOFh+gRLmzAuNo0uN7fqhgkM4wDodeosv8yq61T5BmLU48v82JlBJU1c4BlthEy3kD/IHDyz/5HbAYtL0wkP+9mViVWKn8ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685403; c=relaxed/simple;
	bh=+ImLdF/rPS1W8RZhaAMn68UmLxKGpvIDQLVmitYV350=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwJL9rO8+OtrfF23MfVixLW6bwYulYB7mCZ37v1gH1hx7KXqeKehQ3fuHeqxBG2kGcNPfJZET7Z9DrtcpxDyXxP2FzE+vkU1GcYcFHXGDzWhlYONm2+4AIQsFlF8+fmr43pdblG/o5ruM/qQiDRoKadZGiV9mZrPGzA/qOXFlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RG5Vq7xE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712685400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mp691LpMMS/NnH46Pk6YFYILzDdopHOT6W8uUeHBmto=;
	b=RG5Vq7xEw1eRHdUxPfxqe8n6w7RUti8z+zcVoqo/Ai3zJwrnrs8taBGBf7/xAHmwu9yAPs
	pdyxXAgWmOcDYUBP+Eq5YVvkqe96rRR8lzMMw5bYPYUh2/VxB0ooC/3fybhIQvhXewogJR
	SOV1o3GL6DwwoCZlW1Bfj7/MzXVNkhNEUDxssPBc3QI0xxPxkQWjUuI4axAJIX1vL9l/lx
	5wvNwqs3UL7bP7bBXC4/jtRCusHn+PNZXTvNkjwdQwZPc7MH3Aw5CVhmD4JwZVYv5jM4jH
	ZdqCk/PvvkHkpm0YjdJk+IcVPm7T/pD+BuiubkRBqAbjhgd7W0CNuuMyMD0qzQ==
To: linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pcm: perform power-down delay checks a bit faster
Date: Tue,  9 Apr 2024 19:56:36 +0200
Message-Id: <90ae761a5b99640ece48363a7099ac2cf402bd37.1712684592.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When checking whether the power-down delay should be ignored for a specific
PCM runtime, there's no need to keep going through all DAI link components
after any of them is found to be configured to use the power-down delay.

While there, fix a small typo in one of the comment blocks.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 sound/soc/soc-pcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77ee103b7cd1..b0e1bd7f588b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -315,23 +315,24 @@ EXPORT_SYMBOL_GPL(snd_soc_runtime_action);
  * @rtd: The ASoC PCM runtime that should be checked.
  *
  * This function checks whether the power down delay should be ignored for a
- * specific PCM runtime. Returns true if the delay is 0, if it the DAI link has
+ * specific PCM runtime. Returns true if the delay is 0, if the DAI link has
  * been configured to ignore the delay, or if none of the components benefits
  * from having the delay.
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component;
-	bool ignore = true;
 	int i;
 
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
 	for_each_rtd_components(rtd, i, component)
-		ignore &= !component->driver->use_pmdown_time;
+		if (component->driver->use_pmdown_time)
+			/* No need to go through all components */
+			return false;
 
-	return ignore;
+	return true;
 }
 
 /**

