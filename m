Return-Path: <linux-kernel+bounces-129632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A180896D98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC071C25FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFB1419A0;
	Wed,  3 Apr 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="by+5wRSR"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBC139CEF;
	Wed,  3 Apr 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142221; cv=none; b=JiWj9HmazYYGctgbpyQZJm07zuKTD3t1sEexzNspRQ7AbQiU+LOhURhEIoNg5ZlzXcjMBfkZZO+FItNRXVeleNbgL6RRDPgdMDYtcZDw4OVYn3yLQYbjGI2xC8aK8Xi9zUPqaGZxE+fRphpxvAhFvXuLxEQ94z7x0qH3grkYe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142221; c=relaxed/simple;
	bh=4yTkXgWSnlXEICWMvYYyIkFxasxVZm6D0444mIba/B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMesQhP0INig+YPthRkSFo8FEVlDbZJmN0D2sX21sRo5pI1/SUj2bTAVuv5+r24bUE9DZpn+9UwJJrfEXyuYHu5wDDblvsfxGIATy/WBHeEWKMB4zKpLd/wfVxcErFyfTlXPUlEmYPYZy2H0wzYuspcPEjmDg9rV4Hc9S53MFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=by+5wRSR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B77E01C0007;
	Wed,  3 Apr 2024 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712142212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmN9FWxWfo4FfQqYYNRGmlgSAPDgsVfTz5LUGIcfzDQ=;
	b=by+5wRSRnfJBKDqqT66tYSQAcqlC8jXmhK7AzBtk2vv4AUnq7YYuDTvIUIJdh5daYIqieP
	heCDmFhWKoFxlMnh19pzhI81MEM6mWeLqCzOu16T6mCHLYzbXc0qEZgBTwWyCod4NdXG7m
	3unZnbH7b7X1KmUcZDtp/q0AtaNy9UFqoPOwU1Z31yr5dsM3+zE2OvY6hf3Jjc7MyE4nwO
	2/aTKojuEC9Dknssr5ODHFssKwAOMjjDpJHHeyZ2xUVsCoR1XeLsaBTYFsYUprGMgISSHt
	BvTyWiQQ77Ey+hDjYdkTK6DGct5sUxSJk3jYdB+Y7LbAq0hEnfRY0IDYV8DWig==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Apr 2024 13:03:18 +0200
Subject: [PATCH v2 1/2] ASoC: codecs: rk3308: fix "defined but not used"
 warning on !OF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rk3308-audio-codec-fix-warning-v2-1-816bae4c1dc5@bootlin.com>
References: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
In-Reply-To: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Building with CONFIG_OF=n triggers:

  warning: 'rk3308_codec_of_match' defined but not used [-Wunused-const-variable=]
  warning: unused variable 'rk3308_codec_of_match' [-Wunused-const-variable]

Even though OF is needed for probing, fix by declaring as __maybe_unused to
still allow building on non-OF configurations for build testing.

Fixes: 9fdd7b45da18 ("arm64: defconfig: enable Rockchip RK3308 internal audio codec driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403271905.BYbGJiPi-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403271907.0z0uuG5I-lkp@intel.com/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/codecs/rk3308_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
index 9d3e4691a7b5..74c3836995b1 100644
--- a/sound/soc/codecs/rk3308_codec.c
+++ b/sound/soc/codecs/rk3308_codec.c
@@ -953,7 +953,7 @@ static int rk3308_codec_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id rk3308_codec_of_match[] = {
+static const struct of_device_id __maybe_unused rk3308_codec_of_match[] = {
 	{ .compatible = "rockchip,rk3308-codec", },
 	{},
 };

-- 
2.34.1


