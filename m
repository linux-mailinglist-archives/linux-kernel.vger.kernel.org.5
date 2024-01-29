Return-Path: <linux-kernel+bounces-43221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B2841112
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A79C28735D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B26F093;
	Mon, 29 Jan 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KXAqSvKR"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922306F081
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550227; cv=none; b=Jyo+Fbj/jnjviWSEv3q5Pfzvo0iPSKCQNbid0pXH2ywKBGEKePH1Et3xfXeaZOoG88Wykh9CeomelHG+nG6RIg363HdQwO8t6I+MpTbnK++12166WB9WwsxNdpQjDuWPIGvJkL5i0uhTsaHV+FMCm9iTf3RR9wg6JmihBddw2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550227; c=relaxed/simple;
	bh=AaTVe4fPYxzhknQmWU6VukxDd0S4jZmIG3xhl/sR4DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2N2jBrL2QtNlKd0aQ8UCsUPBbQu/QIaDzSfjWzblqSyzIIgVJbRjeAsuZK+hHFNzlv8rmlBLcTcUJzzIIXCT84Sd8592CbO2UxkXtI49ERmndvhdeayZ1q5bLsSrP/yg+iNxpC6uUGkprPHC62xHOVjBQ30wnxHLug1Gf+df9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KXAqSvKR; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e1352dd653so395256a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706550223; x=1707155023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5ulVfKbqBJAfmRxrNqOUHB1AQ0ZU6Sxi0KpMVZxhwE=;
        b=KXAqSvKR/Sr1HYBeArPvAspzPsgutzHcVSHRglH2vcAru7NLZBbZwFzR3EPlk/n4AM
         7tmWuKXZKHuTK2cKihmZzDZA+CP//WLS5ezDAmWWWXyE7ggF667vkqJ0u2/3RW/YE17G
         4ZXyxbUTf+zsSZ6ho0b5+CPQVNTvpWXN8r8h3VPc1HxUQSQqpqnvw+9JdChnDk+4ZVuu
         2Thk1PJv4Cqf2MDswYKJpRNYyUFESBbmd4W0tBnP2odUtk1eufdG02s1CQqOJ3KjusJz
         tlPy0+U2KmpZdpblMyXkAz8Hz4Wvq+mJUpC72RAfo4IHTjDnGXP+Wz+/crsZXektdGJd
         oC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550223; x=1707155023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5ulVfKbqBJAfmRxrNqOUHB1AQ0ZU6Sxi0KpMVZxhwE=;
        b=EVPhvKpq+jPqoMimaK1Op3GrbkeNAKawSOaEj2LPsEWJ92taMVYvmzRO5tub7AG1yz
         DomeBczmo5Cbbl6tdEuiCsGQoI/8GojTtCXKbO3w4mAYm0oijyosopTOnbaj/MApTkPQ
         URp85MpM83hYlf89cfqtdTsACAgyPzD3CCVlM+1fof4tAL8cWSLOUN4+BEuuf4ZzYT2o
         +e0l0G5p/w/tPGmY6SUSBuOaoPKUQ1GLZsfN4/W0th0t0iMysmN8Mt3tqRmQ4zoS8vbd
         ZcMtWPwkK2kIbB9NTnO9jWSPG5KKfdbwEsbpbYKt/t8XvhTlQbDPNViqnYD72GCsgTTG
         rjfQ==
X-Gm-Message-State: AOJu0YwglrGpG+EGL5D8mxicfhh+Ig6l+iSZqdOXUpAeEO3hQTluJnYI
	ILXhQC/PoRt8JGO1DA7xsvO15v//rCqeb4MvUEAj9+tq7D/I1Nu2Yk2NIrOUosJ0X5cALWaZSdQ
	Y
X-Google-Smtp-Source: AGHT+IGd7td5McqP8pDdiV/7+x8HZlsSEOiTmLx+F37kcBYKvjMVsWnMmdpVi+HEutXWTTjDmANuFg==
X-Received: by 2002:a9d:7f85:0:b0:6e1:13c8:ca1 with SMTP id t5-20020a9d7f85000000b006e113c80ca1mr5005124otp.11.1706550223646;
        Mon, 29 Jan 2024 09:43:43 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p16-20020a9d6950000000b006e126e4b05esm661334oto.2.2024.01.29.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:43:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad7380: fix sparse warnings
Date: Mon, 29 Jan 2024 11:41:48 -0600
Message-ID: <20240129174150.655088-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the sparse warnings reported in [1].

[1] https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/

David Lechner (2):
  iio: adc: ad7380: make ad7380_regmap_config static
  iio: adc: ad7380: don't use bool in FIELD_PREP

 drivers/iio/adc/ad7380.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


