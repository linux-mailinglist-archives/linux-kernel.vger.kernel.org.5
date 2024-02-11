Return-Path: <linux-kernel+bounces-60690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90A85088A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3131AB21B55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D3659B47;
	Sun, 11 Feb 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AUKG70va"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC845917C;
	Sun, 11 Feb 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645538; cv=none; b=PlDwj83rXqKJTQYjdNPd6eY6e5Gr05vZJMV9L8ECyoe01mxfZZRN34r1Lkw+HtDfL3jds1L+UqxT824m+WHWnSAkOBlCwhIDX/0BK6eGv1EWjWQQ/K5N4LoFhqpbqqS79ZpTg8SPpUNyFcA/hkgXsJDHWDIkg4rcauQBaB0ymiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645538; c=relaxed/simple;
	bh=gkwPc7vWc+CTySu0S5dUqZvQFI8Fe0o8D0d6k2H5zvY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S3H8/j39SWZydQIpiAY3kMeLXOHzk7FbJUxOzdhvgzgW/NSws9Z/I+i/wQUwG2P3+kg/Ts+VJQa6c2yu25zY5GRyYvjqonLnxUn8tJXXh2QCjtgGaTQoGNKUy88u9UfzfehpNnUl9mSXkdHPB0cEjx4vaWKLkWWLr0fLoWPwEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AUKG70va; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from hednb3.intra.ispras.ru (unknown [185.145.125.130])
	by mail.ispras.ru (Postfix) with ESMTPSA id E189840F1DE1;
	Sun, 11 Feb 2024 09:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E189840F1DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707645532;
	bh=zrAKU1WmIFdoyV8NLPmCBMZM/75kinMpwCN70VT5DHA=;
	h=From:To:Cc:Subject:Date:From;
	b=AUKG70vaNyi4rsCTVK8t9s4etGlkQQDHnvD6420e3DwkVzN29g2Dl5YzaQfOoK56k
	 jTF5rzNO7cCaHujDTvDuBPNsHQESVbnwah5fllBTt86PqOvlaEUpCSjLiNWcXcjKIj
	 5Z8L0SrH3uaGQCz8+q6yRPrjeHuzQDJixmriY06Q=
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuming Fan <shumingf@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()
Date: Sun, 11 Feb 2024 12:58:34 +0300
Message-Id: <1707645514-21196-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is a path in rt5645_jack_detect_work(), where rt5645->jd_mutex
is left locked forever. That may lead to deadlock
when rt5645_jack_detect_work() is called for the second time.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cdba4301adda ("ASoC: rt5650: add mutex to avoid the jack detection failure")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 5150d6ee3748..0cc2fa131d48 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3317,6 +3317,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
+		mutex_unlock(&rt5645->jd_mutex);
 		return;
 	case 4:
 		val = snd_soc_component_read(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
-- 
2.7.4


