Return-Path: <linux-kernel+bounces-132414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57289949B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F21F2351B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76F28E2;
	Fri,  5 Apr 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeONMByD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8E219F3;
	Fri,  5 Apr 2024 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292800; cv=none; b=roT/8gBjtlLlEu0dO8k/RrBAiF4PmUBU6zKzuBNVuSBeFKMrCZTkTFePJ2uv3TooL6RN1humXmZXWaa/YcIEiXxPMBz8MWeFL+KY9xxkihL2wA9BqicYEUe/3bUcFtqJsrN+TgYwv43vWXtg7rezdAYOA5MK6CnP0/Nmdt2YHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292800; c=relaxed/simple;
	bh=4PSIbJRAdwSQ+A2mcGfM0TGur5UUo2fSFeOm0iqbDH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiYaL+LhZ8oj9qFr8kL/bD3NJYW5c+qYNoPd0IA0idStEHeZb3qODdPurUw1KDIeSuxF6WbuDAFXszvn7fB3rDzbaiTremGm9JPMn2A9mDZwV1sP5gTjxT7bthderjduOuN21LgTvpOYUXQxaBwdok4joTJxunEjmRE1db6s/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeONMByD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4162ebc598fso2262485e9.2;
        Thu, 04 Apr 2024 21:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292796; x=1712897596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63ypm68bp6z/qvv7PrXhqzz9zbPfjRJbzDP7aqMQAKs=;
        b=DeONMByDaYc6wizVdaAaT61kU6sQwTZBu0uQUUF6dA+Q6OolYD2M0NFzyyfDYeNoFr
         0LwbGn6G3YqiLM07Ct7RvPZjHKbKG2rLqvTFUBgKPldroWA6ar8jgxhwol1SKZwFZ3ds
         3RaiwPpeAvex1YLdMiQVj+nRW6IvlRxlh0dUQKXjCl3wIYRVk8iMwkIsxH4Qr4e2Slk5
         49wQ980S5Nm8VHBH/7qVejSTtzeZTBNWFmFt3gAwUnalMFuF3cCh07BtuYXjwWdBAz0V
         AWbYtqCCEePg1EHAkqG3bZKUKcsK7QuEGMErgkSJXIYJFBjn/Xo6K1roqILueMrfUEJH
         XLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292796; x=1712897596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63ypm68bp6z/qvv7PrXhqzz9zbPfjRJbzDP7aqMQAKs=;
        b=cwMG7xxuwCjSaJ4mjT81Q+BuQ0fcewAGKoVWXhlrj6gRfQiHqULkqKT1xO3nk21Xge
         FlVEFjD752Ippi9pgrJEOxC3qnJdJRVva34+hBKOXOlTMCL0dvf77RSIA3W02L5HkgG3
         BtspPDnFPgo9Uxy2GWSVu4cYUj//0C15c3agfupWttiooOwdSgRhCVsTLVuWK0lQfTDV
         Cuf1DO0p5fMfH44YxyTakn4bzBzJylpCEwcm1FG28e1u0KhiAWmoSwKFjxF6nqogX95e
         ipbUNORC6BwQjJQdsHcPOb/aqz/hS1gzgqFc2EZFYQGoTaqIsT2LHt1iVjVdF0Sk/Baw
         1fYg==
X-Forwarded-Encrypted: i=1; AJvYcCUdWfUzKNkW4I5pAFLWZnBNMS7V2asQVBcrsuxYeDRxjRfzSvxPB95NjJ99jen68sQX9XhVcxGb70bo15zY8x6BmRhxgqVBZkBt
X-Gm-Message-State: AOJu0Yw2b83xzMVXX4U684DsZrE4A99+IHLo0AcAjecMSZpsktHusJOy
	CRWW1WRBC33scPcOC/kX6pqk31bysvXb4tm9p6CITpoo7zvYu63QyA0sQSZS
X-Google-Smtp-Source: AGHT+IGWAbFrNtztqpnta7IOaDzs0+Kzw40HXRJXLHn/bNsZ22E8aRIb0TdkVux+idCWEUHLrm3rAQ==
X-Received: by 2002:adf:ec0c:0:b0:33e:7133:ee31 with SMTP id x12-20020adfec0c000000b0033e7133ee31mr199970wrn.40.1712292796134;
        Thu, 04 Apr 2024 21:53:16 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:370e:900:9daf:1dd4:230e:4f59])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b00343e825d679sm488302wra.87.2024.04.04.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:53:14 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v2 1/1] iio:imu: adis16475: Fix sync mode setting
Date: Fri,  5 Apr 2024 07:53:09 +0300
Message-Id: <20240405045309.816328-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405045309.816328-1-ramona.bolboaca13@gmail.com>
References: <20240405045309.816328-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix sync mode setting by applying the necessary shift bits.

Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - added u16 value to call __adis_update_bits to fix build error
 drivers/iio/imu/adis16475.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..060a21c70460 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1289,6 +1289,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 val;

 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1350,8 +1351,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	 * I'm keeping this for simplicity and avoiding extra variables
 	 * in chip_info.
 	 */
+	val = ADIS16475_SYNC_MODE(sync->sync_mode);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
-				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
+				 ADIS16475_SYNC_MODE_MASK, val);
 	if (ret)
 		return ret;

--
2.34.1


