Return-Path: <linux-kernel+bounces-155965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCC8AFC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0C7B23AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0453373;
	Tue, 23 Apr 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="ABT0QfHC"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994D2E859;
	Tue, 23 Apr 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912080; cv=none; b=iP1wR/XMEhUSjo56ZQCFKZGc+ADDh7Eg/mg9i+IbVMHpFp2XPrvPiMWARYeE3EtrlXsaUAOYWvM8ccO/00cHXJnjp0g67RMV5NkeRuVWE4t6Lyrc56Dnjgts3Menvr4QZUPuSKFf9nWgelLdqmhgTyfGQ78dJIUS/Bdp9O2eiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912080; c=relaxed/simple;
	bh=9N73cNhfVQaoSJ0DN5ep872w+52N5ZGu7OsFMCg9whc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9q6sfe41cKqAzRC/tgObFGoMiDAMv2gOa6GaLcNhaqLu1HK8HK0Edp1uTAs8sp6hPNFUgwy1kr0v+WVfxhfPr2WCc8rSX+O21yOzG65oGk7UMHnIxJks3lFbx7WEVmvmv+6JVeaYy95Mnz3yXjzfxauMHQfoCyfYtBV0DVcfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=ABT0QfHC; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 045F847A5D;
	Tue, 23 Apr 2024 22:41:14 +0000 (UTC)
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
Subject: [PATCH v2 5/6] iio: light: stk3310: log error if reading the chip id fails
Date: Tue, 23 Apr 2024 18:33:08 -0400
Message-ID: <20240423223309.1468198-7-aren@peacevolution.org>
In-Reply-To: <20240423223309.1468198-2-aren@peacevolution.org>
References: <20240423223309.1468198-2-aren@peacevolution.org>
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
	s=dkim; t=1713912076;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=UWXpr+mFtuZWn0I9z7i9pNE5fb1S4ZmF1FsSOEaCDY8=;
	b=ABT0QfHCstWYlhb5huxIJr/n4qDSVSFsxksisDcoy3ke6S+gPj0FLQ37n2R9UXskuwaobf
	y6Nk9MNPJNNQr8PC1RVGVYnxF5Wb1UCfumq6VIxnyBxM2yJ7+VMnjFW0nXYR4ooduh1sVD
	6ImTZmNEn0X9UhpNjNfl71M4isz1flk=

If the chip isn't powered, this call is likely to return an error.
Without a log here the driver will silently fail to probe. Common errors
are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
isn't powered).

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v2:
     - use dev_err_probe

 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index c56c6298d292..6ee6f145a6d5 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -475,7 +475,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&client->dev, ret, "failed to read chip id\n");
 
 	if (chipid != STK3310_CHIP_ID_VAL &&
 	    chipid != STK3311_CHIP_ID_VAL &&
-- 
2.44.0


