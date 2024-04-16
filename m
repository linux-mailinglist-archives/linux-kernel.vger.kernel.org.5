Return-Path: <linux-kernel+bounces-147177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5A8A7092
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B99285B34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292C13A88D;
	Tue, 16 Apr 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kf2lhLU5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AC13A3F1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282822; cv=none; b=G2YlpSqR8A9LsQaBHwCBU3ogk+FBkw8PaX5mizB2yl7GBMDEUEH9vhhFyTN/z/JTOS84weVDhgffUveYyiai5B5XnJtxhigDWsf9VXCxhzofy+C7/8rviyMdDym4ABMGyltrieU12p7GuyHFbRyY8Lj3Ciaq8UcIr6KzzvZ4AL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282822; c=relaxed/simple;
	bh=2MnuLxaHZbaJPVARTKFt1rzwpEZuIuXZwcM1ZfvOkrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5cCao87/OgQ5KVawA/zRDC7S/dD4H/qJIYnPUSs6kwSkXiCAY3niFsEdPfqpTuaVRlHQBPV8o6JJI+Whe4llNNl3QQKoeCLOkDy0EfOOvUNlSKlNzQ3qqhuUP5yGhO9tlnaFVzhMZ4GHq88eQ3dHkyy5cewM1Oj0hQR8RJG2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kf2lhLU5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a450bedffdfso583334566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282819; x=1713887619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFmw2QUwgoo6nZ5hxL4W4XLY0gvCpX+AxZ6V2ssaQtQ=;
        b=Kf2lhLU5xD9oSq/ArBxuZzrIP1EoqehfOU2kBwmwakbmau2pRBQbQKnikbGZuCnO/J
         5IRjJAkIsVxgA4XX8jWdbOizA2WQbC3nADig+umOuUAPQ0SpIWLGk2W6QfJDW8UUj22A
         peC3Lf5JWItfaOpQvsHF1zz5+AjI3Hl4Jvsk6h1HcVYKkC/WGeXZNvR+/KE7IuF5R1zO
         5+8frP8Qcsfc+biJ+MnbHCI6hZcInhJN9Nw54bDSdFpSAioS8Aiz9E6wQnAlNRyoYkkr
         7DXF7tyn+mYnqNXzXqDAARz21+Sj8j3kGG9ftAr9Dksfzapp5rOxOlfrf9adz1tYZ3FH
         e4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282819; x=1713887619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFmw2QUwgoo6nZ5hxL4W4XLY0gvCpX+AxZ6V2ssaQtQ=;
        b=llOYkvcJMrAiiK1rfS+9XTN1p47HWxLbYpckB5Jn/THxPr66NzLnjaYlx1yz98PVeQ
         Nz1puUoEcVdgHi5l9lYSPGKZvpQlNmnc/mwNDNKeH69YlKGHu/nmGPenG8qTotpjbEvx
         TYA8qcPs0Q8+sQVzg/kJpn9xWny6lLhzzHxTiwh65xZf9opyWdU5XpxVqx6cPk8gXVAO
         InrMIFkEWkDToYP0uPDB5f3q4btJxHmdcL7sTngQoSha6cRiD1DQpLcXRf+Y6azvUBrL
         cvE581k5w5Y7bJHXXgDks77GQGi0uQcen9DNh6zss1e4Xx+1/1unpk6QzJejnWKGTEeP
         XK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ1s3a0HrlPsbABcQj0AxakTk08BZmzWmbuWzm1oIjFTO21vHivKgAxl3lEtBe0DnGThvE0//yIbIRD7M+xZ4ADYOmiBPsIO3EadT
X-Gm-Message-State: AOJu0Yx84mpaVdst/H+joFi1YbYG1vICgqeRcT+0UKd7LVIJ9nDaWA7F
	bAYFINPcxvne8bsYRgSKtjL3m2H278U5kqzZsSnYzXXL7ejHNUNx+6Wwe4OqtcE=
X-Google-Smtp-Source: AGHT+IFLuDathaTJ/JKT8tzf/JfCbHfCCiKvf02dGKCca6MyDMPKZyO9ZLGIiBsYtjUEtqmWCS3Ycg==
X-Received: by 2002:a17:906:d10a:b0:a52:71bf:2c4c with SMTP id b10-20020a170906d10a00b00a5271bf2c4cmr3533190ejz.0.1713282819612;
        Tue, 16 Apr 2024 08:53:39 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:39 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:14 +0200
Subject: [PATCH v2 13/18] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-13-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=2MnuLxaHZbaJPVARTKFt1rzwpEZuIuXZwcM1ZfvOkrE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qd8Sx/coFLTSFkDfsduMzD+AJNcJ4tDhOCv0h
 3ncqyFaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURdFBEA
 CJgnEAdPK62hUZxj5SmThZ5GkBCuZIyk3P52tbmYtB+jyZS+Tm9SamHgXoImaoOJxr2c/eLN6dvvPN
 RXqbf2LoKutEccLUvet1qjcG1VQ3Y97HO+Af0mpbAIXcckeiQWZEQAuASMUTjEOpyc8WYeFadNOFWY
 xpVRY+nVMyYX5MTFxrqlCzSgB0RGJYQnily350VHOpioNsNSS+M4n23mW4liEOaXow+a08pqBx4hC1
 ARNjftB0eGqrwymHP//U+jEA8HFu7aOnmkeqpQf1wv16F4hsqhDAQNxlaAe87s1p1fuk2E3MzMShm3
 h5C/GK45SLykya4NZfpzz8sFaln1av/ogexAQ3L64zlC8WrZapNXaf3rbnt5wH41KWvP9jCZGKJ/Eq
 liW/EqvlQGqHX+OWDejwMbtuxVdsPwBpQ9pVZiyzEjlpLz/aXtSl5NxFI0Tew83KmZbSIwrECeoqyU
 snhRMJNiEcf1Qx8EWqsQzdpYLd10GadAI6SF8toslrmcGUnlGAnV25AmCD/a48L6hKuAYcw/bO6jaF
 DfhzlGkbVb1mxLE07cd5xEqQqLpQljHkx4YqwGO5ZhFc/K3ECQ7xPQeeGlB1Z9hz21ZldwS1U/3tr1
 sHz2UEwm99UXyQnV+OmKp0j0n4LYTdJazChU72qVtzvtZca+boZXyAULWhyw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
before mtk_dsi_poweron. lanes_ready flag toggle to true during
mtk_dsi_lane_ready function, and the DSI module is set up during
mtk_dsi_poweron.

Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
nothing because lanes are considered ready. Unfortunately, when the panel
driver try to communicate, the DSI returns a timeout.

The solution found here is to put lanes_ready flag to false after the DSI
module setup into mtk_dsi_poweron to init the DSI lanes after the power /
setup of the DSI module.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 9501f4019199..b3f33d4d3d5c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -642,6 +642,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
 
+	dsi->lanes_ready = false;
+
 	return 0;
 err_disable_engine_clk:
 	clk_disable_unprepare(dsi->engine_clk);

-- 
2.25.1


