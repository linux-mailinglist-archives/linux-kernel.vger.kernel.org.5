Return-Path: <linux-kernel+bounces-144317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734948A448B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21576281582
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDA13699E;
	Sun, 14 Apr 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Wd0IIGb4"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CC136987;
	Sun, 14 Apr 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117480; cv=none; b=V1LR6XbZT50HDCA+1uUMaBbbzg5gmSqyA2ijzWqck5HMMq9zE5GjxcT3nVuV0TFqsoMgFQhRhelRgBtpXxkTLMMJIB2iGkZnjoOPZnldDcpmE2yqMxydArZezVIvAycKKzoZ6wmoHBh/iRvkAMc/9yULkw+J7RT/HXEQxjSb4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117480; c=relaxed/simple;
	bh=4J7f19EVJH9G9Gk1UvLU7uM++6o9NhyjBZv3kYWUl54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4Nl7UMgvuQPEc48w1SmWyw4mi3ZQz3KOPg+31Ru4bAlOJTxIraC+2rBbgDSlWc81/IlcE4v0XFfO8Ly+/0C+mJHyrbJsqiMEJjURScnf7TMT6tcOyRRrYCXedGNOPPnrkbqiQ7pZDjniRIZ2f6IzuSH4v6Q90/Ik2mdDBIJZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Wd0IIGb4; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 93FFB477A3;
	Sun, 14 Apr 2024 17:57:56 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: [PATCH 3/4] iio: light: stk3310: log error if reading the chip id fails
Date: Sun, 14 Apr 2024 13:57:15 -0400
Message-ID: <20240414175716.958831-3-aren@peacevolution.org>
In-Reply-To: <20240414175716.958831-1-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713117477;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=mSyThA18ConajLRbOxnTiXskFDN8zF2RJ8eodogp9aI=;
	b=Wd0IIGb4UF+4/RrNlJGIPlj2aYp24AY7lM6c471i2R/h3KubNP+F2SPPos44PXxcVOKZkn
	5oWvrEd1gPsGkpKek5sM3J5dg1MFE/GReG8LyEMVwSKIbPhOjidt5Ddnbb6TFIMyRFH2+X
	JamfRiETlmwufCuwjHaQ3hAbAU5MFNo=

If the chip isn't powered, this call is likely to return an error.
Without a log here the driver will silently fail to probe. Common errors
are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
isn't powered).

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
 drivers/iio/light/stk3310.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index bfa090538df7..c0954a63a143 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -472,8 +472,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	struct i2c_client *client = data->client;
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read chip id: %d", ret);
 		return ret;
+	}
 
 	if (chipid != STK3310_CHIP_ID_VAL &&
 	    chipid != STK3311_CHIP_ID_VAL &&
-- 
2.44.0


