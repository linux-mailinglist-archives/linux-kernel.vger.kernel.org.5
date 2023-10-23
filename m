Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB67D39D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjJWOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJWOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A61BDC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:04 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2ea3a944so2387036a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072064; x=1698676864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH3GFq5D69xS1Tzi4QqCw1RIdz10bV1qyKuEWVVtejs=;
        b=prKJdHAHeZeCr6EWLPyJroloWdSm/JdWcrytG1aMhJ+2Uqj/qfwoPBijKk0D9BVB8u
         t+Nb8eio69BRQekkfb4aEo3HeQ60M2OvO07zqQDwJqoApQzTW0rZbNPkIKPPrxAzRBi7
         Xtq+bjYCisGp6/ujm6YT1oREiB8yjdA9Ft1LpQvgfw94A3/q6qjCzZ7ZAIqfPeC48NLZ
         L+jPgOMvcxEnAfypmw4ThWiZAXpZRJ8HAT1UCSycflIRvjb3WgMwxWJumkN67j//Y7NY
         X1UrLE2eu9dwZhzOf1/4gVCXYOB9MwPFAfVLvttd6nKfzF78dEDKvEIaA52tuPIBo3KI
         o+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072064; x=1698676864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH3GFq5D69xS1Tzi4QqCw1RIdz10bV1qyKuEWVVtejs=;
        b=lSIj6IOYEctadjZ/Gxeb3vA5ib6919zV5VjatbHdr+Pd7kVZxgQI9WK2L7vhIm3AF6
         ZY6SVLvN2rRJ9PlEjSOQVqjGZUyltOkhmd/83JSDy6z2j2VPYEevP7ytBiOc2Rp2eeGv
         yGrmdWlmmV8fTBEoXS9GQYm+bKahUnXgkvJ13kC5BgN7vKNCYnbiwDILQxLgFBdjuGF+
         fGEpboahaDUr0oFmIrcx/bkf3hNlj+3lzyXgJcNJGtBnyu2uPRG0HMaxBNuhH67hA5mk
         ElCKlRUmWfywVBnSyPvzhzF9jeBqN/wEs/X0KTpIvtD6bQU/eMr59OY0N87ysuFVbBtB
         LbMQ==
X-Gm-Message-State: AOJu0YzC7w/UNQocmzhxqcx86RaJsjRqYiKG8zGRd28URN+tbilLCYhZ
        ZGITQzQkciJf5KUVagI4JIwxOA==
X-Google-Smtp-Source: AGHT+IH1IkI6TnT+ttcmCoscPeOrIopE1WBAZEg4r9UimrR6CIMRAoo8nMxYKo95tMWEpnGtVl6eKw==
X-Received: by 2002:a9d:6188:0:b0:6bd:c8c2:b70f with SMTP id g8-20020a9d6188000000b006bdc8c2b70fmr9880668otk.34.1698072063987;
        Mon, 23 Oct 2023 07:41:03 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:41:03 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:13 +0200
Subject: [PATCH 13/18] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-13-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=M0lgMNEWbaoZ4qkfmFQ2d2c6SqYe0EzRwVFM4lhot+4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXP9F3RAu1ZKmUXEIyW8a/kP5CK+Jb3tGF7IdoH
 1RqcA3mJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURTPOD/
 9t+6pSLsY0qJ4yNYIAy8Yj64n+qV7yRH4vlC9ppkx91ePv2Sf/rsw1+QRG5hlj0j3d5dWf0ZGe/qPt
 DjapblIQRzzn7BcMUQD/gavAeQ+YuLMd4IOyVk4uXEBjys9STpAuYQuKC03y3NcyjL6JWTj2fmFXTq
 FSDDYsV/wNBpk5ALR2J7sE92+GGZXhthAmqro6CeVxpKs8z4H+c8lJOUUGaohZDWJkzoPl3QJssrhq
 XljafCvUMlRJYbGBRWHusF+de6q6F9tY7mJoX2udGUIrH/cZR16ydBWCpSVaFEKmGEioAQXsFQ1JpS
 3/FHHTBX2h2nfGJQ2eT5muUbMii7hB7u5QWiVCF3BFBfzU4ketZCF3bj5Dk9xLBskq1ddV951Z1VJq
 aWbuUgtjoALtwalhNzN12FffvNPsJIBz4z1TjRHf/cK4a6jaXgVBorbrdg3g+HRu0BH+uAGnC6c1j1
 BZhh5BAQvMKdxFZnbk/zwmdsmAwXbfIPVcs2R2rk5mriJ4BOy13/lj/L2c/671sxkorHAFPtQUsi9I
 4XIePB314S80C1hBbP4Le8sz3x/gPiLeaQOFxu1Y38FmqYPDFc9iZvDBov3qmHwo1awkx6YyeMuOrY
 kr/y4GCxn8tSG8oU6g3QQsh+p+1wUWzZ6V47BRTgBHkVb5pT5lxJo6zeFjNg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d8bfc2cce54d..81cf0ddcc399 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -668,6 +668,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
 
+	dsi->lanes_ready = false;
+
 	return 0;
 err_disable_engine_clk:
 	clk_disable_unprepare(dsi->engine_clk);

-- 
2.25.1

