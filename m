Return-Path: <linux-kernel+bounces-32380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82545835AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D145B26871
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209F63A6;
	Mon, 22 Jan 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlZ7zrgO"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F263D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904505; cv=none; b=jFSDux/IAllBWCO6PEzcxZ3eYL4Kxer3Xfvw7fsY4rgDhBcbkGhfAr96XQTT0HrplirCG5ldDwYH1N5F11/pjvwBgjAxY1NuNb5mmu8HGPj7TSQi9PG/rdMv0jghpNK51T8ihNRVKSOhzDQ/ZYPB/Mil1edYN0J4g9X8kvg5/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904505; c=relaxed/simple;
	bh=z0DhQ74I23LpCzfNU90saOifU6ICU81Zx1v2ffbAwbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvSONwrG14Y1iloikhEOr5g9emE4CZl6g4y5mrk2rYEaobeaxFOgs274WtlIaH7VUUKl6v6EUuODaxfx1UrDZQ5PN4Wm03b9OaPEU002iCjhLbDHBRQF4ykJMWzSQz86pC1xYuMCqwMXNp0iRTmKJtCCNJAIBm7ACQi1CCB5NXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZlZ7zrgO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58e256505f7so1502429eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705904502; x=1706509302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWX+6Hx9DA0gw8Icz4XnPpdw7Tg6JqdCSrJaZKV5w2Y=;
        b=ZlZ7zrgOI8/PrpfBaEdQLH4C6LO9YgQoX5/jLx1ihNjdu4BcjRoMbXIPOmGeaMms2n
         TQ9oIc4slew3xqZe1HsfNGQNHqJlqyaFwM9wfD77yauk0wJj81CtRgt+i4JjCih4bqH7
         HCBFu/ySnlnroXv/fmFTdSGKZLpwFxW+t4lig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904502; x=1706509302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWX+6Hx9DA0gw8Icz4XnPpdw7Tg6JqdCSrJaZKV5w2Y=;
        b=HZN1frqmgnM2r29S6KCnWPZ8TwkhnCdXK3J64fPJhefMuPIWW4Uub2N21RV0Gld7O+
         qUeHZNjm8e7bsGGmfNhxdVbqizKnGkEm2MUmFDDmTqDdYZ+4sTHC/v6bTUkZxORy+Bhb
         CBw0XQiPB28r5FSA/jzfBVfefx7M5WOPVsiOAhdozxBWixBfSpjpsqoudblaAXqhsksN
         IosPvnjo1gi/+bnI0VH8tK1j+X2nPWKsrokJ0aazmp6/yy0mSFZaxd9g6LkExTzbKXWa
         xIOSJ8ed/31/y02OVugzR40W3g1opWPH88aSVPfMym55/bIe9YjgJZ7Y+dsDnrtb74Q6
         LFVg==
X-Gm-Message-State: AOJu0YyeaCvpGT3vy7SOnDHRB5ZIDTiSrVgZKoGvpxe9MRhYtkDEFkLs
	m/5XnxI+fThfFZ2zNqvEoKOxAg+K2WBV84vpShx2OU8+uFUtMV7iV4PvcSQlPA==
X-Google-Smtp-Source: AGHT+IELmfF3o5DTiZfbSeuQZLzrFVr9vWKEU2iVV2tyv9Tduic2C8Fuiy6w8NEZen4LQJ1OzIoHyQ==
X-Received: by 2002:a05:6358:d181:b0:175:76bd:2c36 with SMTP id ka1-20020a056358d18100b0017576bd2c36mr1697587rwb.37.1705904502499;
        Sun, 21 Jan 2024 22:21:42 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:f43c:6707:f29f:6787])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78107000000b006dbd9501028sm1984401pfi.92.2024.01.21.22.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:21:42 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	Alexey Firago <a.firago@yadro.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zhu Ning <zhuning0077@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: codecs: ES8326: Remove executable bit
Date: Mon, 22 Jan 2024 14:20:27 +0800
Message-ID: <20240122062055.1673597-1-fshao@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the executable bit that was unintentionally turned on.

Fixes: ee09084fbf9f ("ASoC: codecs: ES8326: Add chip version flag")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 sound/soc/codecs/es8326.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/es8326.c

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
old mode 100755
new mode 100644
-- 
2.43.0.429.g432eaa2c6b-goog


