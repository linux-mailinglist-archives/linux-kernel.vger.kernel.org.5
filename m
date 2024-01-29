Return-Path: <linux-kernel+bounces-43444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A148E8413F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18FEFB25933
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C1157E67;
	Mon, 29 Jan 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ukC9dun5"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7676022
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558179; cv=none; b=SvLOXorRhSPv47UPBUWxxK0MutCdu7/yvK02kvUoImJIzfhTgd+tDV+Y9bdzrhYIzf+FPF4WF5EGcQ7BGF7xJLTWOmij395BnKz248iXAKlsXFbNdGfkajLS+ahDHF8Q0/RN6G7v8UNkxh7js2hpR5XH9j3JJM2Cqj3FvzbSr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558179; c=relaxed/simple;
	bh=DyCOayE1NQTevHqWf5WsQyEq5fQg+GhRZMLesWeEPWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luQFinz5ahIjf4VkjFV+56LSZuiPGo0dD8P6ohshjEzuJHcxgMNaq3+uk6mFnUyl+d5QJ1jEpFoDCqcwTyVk5gV1/949cr54VltTasnlGtp28o8EAZPtfhAFMYE4H76OUfQWVCmIKBwLW5UsRSb9U6qrBr+Yc7u5z2DVWtQ/ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukC9dun5; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21428d99395so1834843fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706558176; x=1707162976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5JH9Myv9q/YceQqu54f5uK3uimdtGRsRM4S57PMLa0=;
        b=ukC9dun5AzyEdhqG6DI+/CsqaNa+3ej4pH0epVuFO/6LUsvvuuePVLKpYk0HoQP/8k
         RIZ9UHVr7fKkYtg4WEBvkjBc3/DtY49OmpoY2zhDX+caC4ky2aG/bfiYMz3UrmOYm+sj
         MFdrOLOVEUngmRf4ZQJfwdzZgaimb2bkidNTwUpzhuYQ96Z4pVG+JDSXca2Rh412Eg7y
         OT9dDIEarggRs4hoTxo5uuP44sv2/svWElgd3wamOh0gQeTlM3zBtU/d6pX7dGc5TNSf
         XgeGcO4eUXhEb52+gBp6uAQ/OQ6+AAJPdrykrBzrVOXBFvlsxJ1SarOOQ+Hlcx95ykVA
         wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558176; x=1707162976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5JH9Myv9q/YceQqu54f5uK3uimdtGRsRM4S57PMLa0=;
        b=MyExFjfjmhJbwhMatL1oz9w1gejwz50dAg7MEMIFa7hcaU867ShJ6yylnT5lJMkvSL
         ZixHogiftbc78SrtNEcxVAsX/5GoP/60ZPyScpDdmw2E61bAzPnQpjihPYyOrdu8WkHr
         udqLACkePWyjAtdGofXD0Y73E4fDTTH055CpPWgsElbEa2Sz5GPi2Ok1KlfujR9NJogO
         Fw+4Orc1Ua/UAZ38HQRh3W8wT7/puWlzBl90/NYWselp5uZGnMlQFsrA5g7obqSAyt10
         9TBDmHtvtgY0GqSG4IS9M72XwzNlIuwutgGqsoPY+Lr7y2Q3l/G/FRJec1X1rAkuGoxz
         0l/Q==
X-Gm-Message-State: AOJu0YzwezPQUJS3+Bsw59DPsHndKpsWh3Jqoi4enRi67KpDf5H4pTKh
	Ye36oSp/ks7CVKF4hunKa5L3PGIpm2gtWDPlCO4GPaJqGTUxPCiHKCzs+4a9qIY=
X-Google-Smtp-Source: AGHT+IHusY2C8eKcPshu5O5SvIUxdfAVnpxkUCC5P/6GXbDFqfj4QS54L/3CUOqQysdxYQBxyqiqFw==
X-Received: by 2002:a05:6870:a40e:b0:218:4a68:eea9 with SMTP id m14-20020a056870a40e00b002184a68eea9mr2226546oal.12.1706558176544;
        Mon, 29 Jan 2024 11:56:16 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id r11-20020a056830134b00b006e129d7b833sm641292otq.39.2024.01.29.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:56:16 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] iio: adc: ad7380: don't use bool in FIELD_PREP
Date: Mon, 29 Jan 2024 13:56:08 -0600
Message-ID: <20240129195611.701611-3-dlechner@baylibre.com>
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

Although this technically works, it is better to avoid using bool as
a bit value.

Fixes sparse warning:

     drivers/iio/adc/ad7380.c:353:34: sparse: sparse: dubious: x & !y

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* use correct terinary operator syntax (had typo of : instead of ?)

 drivers/iio/adc/ad7380.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 44b8b18ab213..abd746aef868 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -350,7 +350,8 @@ static int ad7380_init(struct ad7380_state *st)
 	/* select internal or external reference voltage */
 	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
 				 AD7380_CONFIG1_REFSEL,
-				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
+				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
+					    st->vref ? 1 : 0));
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


