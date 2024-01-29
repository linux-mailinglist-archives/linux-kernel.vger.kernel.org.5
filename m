Return-Path: <linux-kernel+bounces-43220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF3841111
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A173B2531C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C86F08B;
	Mon, 29 Jan 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JLZwfpAP"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4666F082
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550227; cv=none; b=eG3aIoC3Zpp5zMyBpUmrfSZc5R3iTdwJE515c+aid71Z9zpKJi3zwvXbgI8Ln8/4PoGyjBA4ATn50IDzuEbAqZcN/pj5r6DZEf0DJT5/ycO51DJkBmf2Kc0RUAwt4isF+u39zkDyww4ib4qqIs8MD3weCvifW9FbH818epuDPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550227; c=relaxed/simple;
	bh=oZHqo1ucDWB9pyoSuojibAK6SA+XCVw1HAeO06tsAhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im5Pqq2u/onaF2TTfjJ7Pqq2T4+7KA0Xs3kouYxxtlVDje1nGNF4ra5qC3p/9TBnrpyJ1KS100XA6ATZHIpHqQk3Y8eSCBY8Kw4pcmehABFcbMLnKHTcgxMiKVlO7RPIssBCFogiQRLkcp/MNcCXaCe65JnTMhW2EkjnLr8woLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JLZwfpAP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e125818649so906482a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706550224; x=1707155024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adx5Y3cgX71ZvwEi/qb8yz5ApFtROFIqpevhH+PdrQ4=;
        b=JLZwfpAPFpLY2cpYnKaGArBrxow7WREvTPinscspsQOy6M7aK8Nlvcx5MuxVMHfMiv
         KunmJ4UQSj1Cy5GggXdCLthjHGmrCjaFj5pwBx4aJY4JCCBSStZo5JIJ3meyHvIU5V4n
         9iyFWX+FL3eUe6L3VQrG/f3f5bERHVj0QpvkHbWihTSHMjPA9QWj1hYI6QWiw1S0AXsa
         eqiI+UYe6FMv5eYRuoQoY26qc/UH+inmpKWYLLa6G0ikGXm44K6+YMtnSDxdHwRlPe9A
         1vlQw46ob0OfbjGhRsuNlvhjE70Ef1ziH/ol6ktda4GhXVrXH7R5Y0LzaHCTpI4020D9
         H6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550224; x=1707155024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adx5Y3cgX71ZvwEi/qb8yz5ApFtROFIqpevhH+PdrQ4=;
        b=vSUBrCzc3DRrpn0+xO4EQwhlJxt1ceUqAakcA20/XP7KjCnmp7OKbItHadAKf40ter
         yb7BKRdomlEy+24FExcbruziBFBqfJQH8//DM6rO+6kdOHGWVzlsTxgIyvRPi5wh0yHv
         XfY3ylgo6VDjN863I2Q79vSTVxW2zmIJFRO/LUJMrQkBzOJE8DNFUnlrxksP6RVqlIfF
         46glGXlVwdAnTj5uxaUslLpo6JG/DP/b0Xwr7lUePyJu0eT5Byyqj9OZJOWzY2441xQJ
         zm8ggQR+2nw5YcjRYZFbhaVkQnzGN+tbVIqxgf6oeo17qthQIDUYmKWKr3zoWGpfxeDX
         xlIw==
X-Gm-Message-State: AOJu0YyYY6Vo4zoNjSdwNMwgFraUqhUnKsz3IIyJ1FEvK1j6zjMyMeHT
	O0YZ5vNkRF8jY87RZq2hZssDh+sMZovdfaX7uheI+T0mA/AO/tL82lbMphT/knQ=
X-Google-Smtp-Source: AGHT+IGQshWRbXn4ps1VaNtDU6whOzWZuqVKxJ/Ocqpa5Bduzty/1vDy7xXCYcG0GcBjf7fDw2nq+g==
X-Received: by 2002:a9d:665a:0:b0:6e1:5dd:72af with SMTP id q26-20020a9d665a000000b006e105dd72afmr6735710otm.17.1706550224537;
        Mon, 29 Jan 2024 09:43:44 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p16-20020a9d6950000000b006e126e4b05esm661334oto.2.2024.01.29.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:43:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] iio: adc: ad7380: make ad7380_regmap_config static
Date: Mon, 29 Jan 2024 11:41:49 -0600
Message-ID: <20240129174150.655088-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129174150.655088-1-dlechner@baylibre.com>
References: <20240129174150.655088-1-dlechner@baylibre.com>
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


