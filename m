Return-Path: <linux-kernel+bounces-43443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BC8413F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A31C238B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223417602D;
	Mon, 29 Jan 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UP814CVC"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B56F099
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558178; cv=none; b=BETcR0tD4V/ZQFTyXr1SX6g9lhxBcKfVBgpmxX9Ibt4e8w7IvhcGr+wR3faQGg06Abo/mkANDdngbjPke3+2p4LPFNO9jpYfsnN56Vv4IyFHV6MzNn5xppo+sd9Fj3BZM8sOA91LmE5isuUH4ATsAA/BJo3GzIauD4FDTl0czes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558178; c=relaxed/simple;
	bh=oZHqo1ucDWB9pyoSuojibAK6SA+XCVw1HAeO06tsAhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDxJpQUa6zp8CtOho1Qqt1uxTE6O2joNxFZKesj2o5FtTBB7gO+BgZSdW+RJR8b8ArfzPlPukZX2EzXpNYc32fzXm7PRk1TiRL8FJs1YK17H2r/srzaBFH6qJNPgMVgYmPkQzogvzCbuB9agWMLyA/JINnCu/0aTGnZ/gDbF++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UP814CVC; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-204f50f305cso2352941fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706558175; x=1707162975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adx5Y3cgX71ZvwEi/qb8yz5ApFtROFIqpevhH+PdrQ4=;
        b=UP814CVCLf/uQmlsjYWNjPXjRHxkcY8pLJEFPbF/fIcQP/9qFM841xqqOGYreARf3V
         K17Dy0jfJYLAI5voOR5i6lnEThVqlEe1WX+XkY904h/7GjsCYmvnxHjz45xSoEIkb+/D
         xgh72qEObXa8FYHM7f2eZBvruHPJnQezKOEOJ0M7ziZau1i0tm8nfhgnZDe8o7ng2vkM
         bEvWJGyM40lUQFvBno0wwVj5xtuBcKnqaq8xoVjR0/6KSoTcVlfDAxKYQmkplZoN9uiV
         ri9cWlTW4QUywJVTjgYb9fu4vi7BVgPkFFN4zjQ7Gn6ld05t1bMSGAwWSpqwmYL9PBCW
         +xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558175; x=1707162975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adx5Y3cgX71ZvwEi/qb8yz5ApFtROFIqpevhH+PdrQ4=;
        b=ThIoPqZgU+Px/8+H0M8pMcxrZA/pOgj74KjBPyO3Sl67ZwhkARChKplzDntxs6U0Is
         hpMBuwHuic1pUaKO6Stj3uvFQK9WZ7Nm7hGgsVKYY9x3TbhXw/DSsDIurYikez3gfUVp
         AbkwuMkcgh4s6ktbzWRTAkbSnzwuTFmBGmwrIzIqSnJlhXREGSaqQPlIKc9qFwTy9iZx
         Fs96RWiJ75knFu3ruDnfVMT72pxBRtOE0qBhRlrKNcZ8niOi86nrkOol3M1ErFUeHOJ3
         PiYHc1hz1hxJoD43zOjmn5UDZgxbGl2s91lxSdoXIv3asNCtnpXYELaYs93A59U87peH
         1NTA==
X-Gm-Message-State: AOJu0YyL/s+qXljfSeB09zHxt/dRAMuYppbPKwp82VyHnwTFzjjCO3b/
	cr0BP4wd2N0NDp23zItchD4MU4g5X4qm/UG1uWWvI/fYNNaJfmJIjeHt2W9Vtqg=
X-Google-Smtp-Source: AGHT+IEBp/0NmwQKbLpJMtO4Ok4/RE6NyiQkuoJPvxFVoRV9yOyDR+b2mn7s4vgNN7r881/BhR1bZw==
X-Received: by 2002:a05:6870:470b:b0:210:96cf:b552 with SMTP id b11-20020a056870470b00b0021096cfb552mr6734292oaq.23.1706558175731;
        Mon, 29 Jan 2024 11:56:15 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id r11-20020a056830134b00b006e129d7b833sm641292otq.39.2024.01.29.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:56:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] iio: adc: ad7380: make ad7380_regmap_config static
Date: Mon, 29 Jan 2024 13:56:07 -0600
Message-ID: <20240129195611.701611-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129195611.701611-1-dlechner@baylibre.com>
References: <20240129195611.701611-1-dlechner@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad7380_regmap_config is not used outside of ad7380.c, so make it static.

Fixes sparse warning:

     drivers/iio/adc/ad7380.c:205:28: sparse: sparse: symbol
     'ad7380_regmap_config' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 80712aaa9548..44b8b18ab213 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -202,7 +202,7 @@ static int ad7380_regmap_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
-const struct regmap_config ad7380_regmap_config = {
+static const struct regmap_config ad7380_regmap_config = {
 	.reg_bits = 3,
 	.val_bits = 12,
 	.reg_read = ad7380_regmap_reg_read,
-- 
2.43.0


