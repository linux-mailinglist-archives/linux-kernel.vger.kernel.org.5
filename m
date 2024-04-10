Return-Path: <linux-kernel+bounces-137743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8289E69A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5F6B21AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F437F;
	Wed, 10 Apr 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKMBP5R0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67064391
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707658; cv=none; b=qdgMeLV8LOvNV54zO84DkiWvYtWyJF2D3R2dMOTx5f3ioA7RYHgEwovix0X5JoJGy15Q+WdlL1y/NKsT9JIA3HRQU2V4bHl0otaTHruth3eBAU0pwp7U+gpEf2NkSVCh/hNx+QWmXx85KhEOt5X+Z5VkRROq3Ca0+RPxITNp96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707658; c=relaxed/simple;
	bh=44uw6vfVpAG554ds00c5KN20s6e5bH0vd+t3oNPky6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rb5VgRk5vx6LgTlp1C+0wn6MCxtHd+ko0vqNJxM8hY0B0TR+beHzPdqIIhPqJ4qetOqdZir9gCE8pIUqANpCakMlfCMel+rBGB9rK7FKI2NKroQ3dz49/O/OkURljV6HTU3rQVcagRcO6O+1TCbVU6B+s8LDYSW/BewXfI4jaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gKMBP5R0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2c725e234so36324365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712707657; x=1713312457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ryIE7f8ZtWuzluYZgPcDX89WKZsm70yqAukGanFYfc=;
        b=gKMBP5R0ip9cRqnivqR0jDYl5wyUfS2zeo+3nCXlGR+wO7g4+oZ7WJ+eVWSifB/dG3
         TUlzAK2lO7ZVdhOgh1CxIUPgvLnI3Qg54wcVoD/17kxsbKjdy1od0wMJNF197TJkXkfP
         DXfUpvIGwzqZWR8cb4ReMNH4qLkgOpnAMVZdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707657; x=1713312457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ryIE7f8ZtWuzluYZgPcDX89WKZsm70yqAukGanFYfc=;
        b=VlpYLzCMnVr+RKC69tzLMKJATLduMwsMT79mWwMczMsDM+UImS7EwF1arIhex1ZhIY
         RSRA8yBqjCTlMCG1H6pJ0REoamIhZDJ0jKNH+rdflauwqwuq8qr9M9ju/jGSxYqBLmCu
         JWzJhc4e6IaYL1KWCHr5NKop5UC/F9ZTH/Ubw5A4P8MtOgBhYlwOjSIUxWEgfNo38POA
         e6y+vWXhWTxAj1UIu5/k2vKHF6Q1mdOAH6wGIcU1XfFRy6u7Rhl2oenZFI595ydLR7rM
         /JIwjBI/VHUeHSiXKiH2MxoHQFGfg/Wh3SZDE0Jezq2S93ryZZrfxJ5XjuKOB2CWGhgy
         WFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWP3Qy3+PeVFMmCuhLrCryTg8EwokQocDz7oXh8IqdurX2ZK8mZBqtNhShMbi1EeUQwN8lMrA1cOEtWxLQHeBLpNpWCvqWmthsE9osl
X-Gm-Message-State: AOJu0YzobIIl+/yWoAG2fIg3Wbty7KjPRbYFNkARWXrgO7Sm9px182R7
	sIfJKSkQXnpwcG/SOCs3JJt15HNL0HNC2wNOtLRmXSDbu/X2LXmUqT0aygmoaw==
X-Google-Smtp-Source: AGHT+IGoDhFHXggG7UV/XM8syPMLRIRAsx+Q3uuIedkhsyiKSu/gHHPrWq5HHr51Yh0dVfPQfUt54g==
X-Received: by 2002:a17:902:a3c5:b0:1e4:39e0:660c with SMTP id q5-20020a170902a3c500b001e439e0660cmr5048130plb.23.1712707656662;
        Tue, 09 Apr 2024 17:07:36 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:1f93:f735:b4fc:3be2])
        by smtp.gmail.com with ESMTPSA id kn12-20020a170903078c00b001e0c91d448fsm9504939plb.112.2024.04.09.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:07:36 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Minjie Du <duminjie@vivo.com>,
	linux-pm@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Balsam CHIHI <bchihi@baylibre.com>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove redundant code in lvts_ctrl_configure
Date: Wed, 10 Apr 2024 08:07:28 +0800
Message-ID: <20240410000730.628043-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The removed variable assignment is never written to the register, so it
has no effect on the device behavior.  Mediatek has confirmed that it
is not required to initialize this register for current platforms, so
remove this segment to avoid confusion.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/thermal/mediatek/lvts_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a..48d2f8ba3f18 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -985,12 +985,6 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	value = LVTS_TSSEL_CONF;
 	writel(value, LVTS_TSSEL(lvts_ctrl->base));
 
-	/*
-	 * LVTS_CALSCALE : ADC voltage round
-	 */
-	value = 0x300;
-	value = LVTS_CALSCALE_CONF;
-
 	/*
 	 * LVTS_MSRCTL0 : Sensor filtering strategy
 	 *
-- 
2.44.0.478.gd926399ef9-goog


