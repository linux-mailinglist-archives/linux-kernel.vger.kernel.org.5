Return-Path: <linux-kernel+bounces-93837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED5873566
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C731F1C21DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E577F36;
	Wed,  6 Mar 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5HD3iTG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEF77F03;
	Wed,  6 Mar 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723412; cv=none; b=jLu8CoSHDvSUiizo7YEjmGAVr8Ic+16ohTqi6wwwhEyRHiw4dRdLiJsEZRSUiTSAj9VYUd/oF6vEdboA5DKMmhJrk7+sZpsYx/J4GGM242NGs7V8UlOWS1afM4yNhlRczTnR29lvkCcg0s5K2cq+fOJCnXKGlQ3mZ88SjSfIdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723412; c=relaxed/simple;
	bh=gdocGrYkrRM1nLV5WBS3tkzTCIjByKexz8/GocXl1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJBEAiGwjkHaZMaZD1fniBHNimISf57S/l1tlwrghZz2iEA9t6S85jad0lUWSPTdq6xweHQTndlR0NiAFNBhaFVFSgn7g8fYsJn5XhYos2sH6AQn+pNdTzpTryiei7I0Lq4ul+UUkt4/zzcq3qz1YNJVjIrc5Bdlmzvy6GJxvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5HD3iTG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450615d1c4so124932866b.0;
        Wed, 06 Mar 2024 03:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709723408; x=1710328208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6EKGcI6FH4yAv8SzBRwbzyl3Aigjqoo6JxBUrx0dJI=;
        b=K5HD3iTGaLzA3DiBfST7bkr4pNureYqUFlQfAGAlzfhJaxMUJJ1OLWe2ZpwD6AsNyR
         I2PuxLGz2kbO5XVXT9Nb9LjBZM0SvgDhImUPDu/YqrKPf4am4ylRqBluyoI2oEezrkCR
         AIDmV5GPBktFjOFwiVn2zqm2TLmHIz4k+sQWlzurYo8X/bF/ARnjtSP+2KdAtD6OH+7F
         tOFBBCG/TG6AEpGwB9JSira+6JKWUZLqZZs/AZjQK/hn55TWsFW/1B8WpTw0IQUzrmGy
         APiHeoO/3GPNsGDUwjbL/D/efT5m/AhoFFYo/o4sQVHaF49yVFX0Mq+9F8WkP0Fnf3FZ
         iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709723408; x=1710328208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6EKGcI6FH4yAv8SzBRwbzyl3Aigjqoo6JxBUrx0dJI=;
        b=hW98K7RUIayH9+DalMZ8DuvAyVH/8CbMsgFEdfeH2EHNEPaiZVb84e6cJluNNN3XqZ
         4q0De7bNF7e9TcYARDcNCKtfZFHTEc2OkZyRS3joUU07eEEsr7+KooGrWUYu0b3EajIj
         Pi4d/6fHY/MKXUvmjA8SA+9FtBwd3fL340EXQDxQjF3XK9xCYSoIOMRjCbPkIvomEgIs
         VXwuuRj77v0G7QJAznkYWQmGmvYTaUugWAGCt9L/bLRsA4Oj+Rvz9u5YqWDsotOYy0K7
         TpP1WwAHKmMm5mOzvUEf5D75qkQJrp1Sot4ljqf4q6PKoryRgeHbJzKy2hqvw+4leb95
         WZRg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5UKvdyRYoSqtcu6pSoVkFwncz2oO0LY/SeFSw7tAyoq8QlyUrhFhxoCpga1hYpvffM6uCNZ2rsAnqq30wmPWSCB4ACjX1VnLHCHoFXiCaO+YfbcyB+5R4OynnyPZb8sqqrc+lm7ZBQ==
X-Gm-Message-State: AOJu0YzNqUWC1mg3pP51Ejw9IsrCmgfujq6lKzmKaivsB/J0cdxjDo6b
	V1KFzBNLdoUKpZZ/RDYEhZwTDDrEzsXn1ryx2YSsG1n/TSsQTtMQ
X-Google-Smtp-Source: AGHT+IF1pvWhteFyBZhhYjWmIxq/qOxxnOxV0Ym0Nwpq94bP0RWOc4R6jKmqnqQF2wGi9bupCA0OjQ==
X-Received: by 2002:a17:906:e252:b0:a45:8b1d:696 with SMTP id gq18-20020a170906e25200b00a458b1d0696mr5982096ejb.8.1709723407838;
        Wed, 06 Mar 2024 03:10:07 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w26-20020a170906385a00b00a4394f052cesm7002479ejc.150.2024.03.06.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:10:07 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: dumitru.ceclan@analog.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: ad7173: improve chip id's defines
Date: Wed,  6 Mar 2024 13:09:55 +0200
Message-ID: <20240306110956.13167-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306110956.13167-1-mitrutzceclan@gmail.com>
References: <20240306110956.13167-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename to AD7172_2_ID to avoid confusion with _4 model.
Reorder id's by reg value.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/adc/ad7173.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index b42fbe28a325..59a55d2944a7 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -61,10 +61,10 @@
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
 
-#define AD7172_ID			0x00d0
-#define AD7173_ID			0x30d0
+#define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
 #define AD7176_ID			0x0c90
+#define AD7173_ID			0x30d0
 #define AD7173_ID_MASK			GENMASK(15, 4)
 
 #define AD7173_ADC_MODE_REF_EN		BIT(15)
@@ -190,7 +190,7 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7172_2] = {
 		.name = "ad7172-2",
-		.id = AD7172_ID,
+		.id = AD7172_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
-- 
2.43.0


