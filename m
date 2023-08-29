Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7B78CABF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjH2RSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbjH2RSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9810C1;
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so71463511fa.1;
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329446; x=1693934246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FenEPRzkF+fCLIr+dUsskF7AjB/E9ox5j4UlAbRUoQo=;
        b=Yo/oKwwdBrMUMDkG5wvtSq8crhNn4CVhpsSAkfHlafXQiHFiaNCwXonEMR1ZDxCS5m
         8YMbkPO77M/H+V8eGgHCiLqFyL8qhL3LoN424+kSeFvcy4Iw6OTRIVTpSCSdd9tCwDyf
         wK/8ORLWL2an1MTEX9kBbYFORB1c6srfOFu6kASEukKSZlOVd+rDH0qqXHzVYYUbjidp
         vAaJcoC5HbbSkmGx74F2zL0RGWprs9ssIYNMNeCUn3cIqf34INO4z4cFqNir0FJsujPG
         QLxlsOanjUlDMPVQsbzFmL8MlsHmUnyQ97SW1Iqn7dN1mY4qZODbo9MMtiCx+VK0783S
         3AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329446; x=1693934246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FenEPRzkF+fCLIr+dUsskF7AjB/E9ox5j4UlAbRUoQo=;
        b=HWi6FW/xfOrucfw6+Cfqi0r5pBS1jh5YwOoPsyl0Gw5f+LFzsTRi2kQXCZm8lKSP+K
         64Hw/ErwXeAdv/qi7inGDkxMEkYBfO3m20UyngAHC1NcoEXtDm83UwLuqplGAdZjBtV1
         3n3hRgTZ4Wkh3AID5Gl39O3IgZ5I1mbNKbfFU4nlfk2d5qmMXo8UqpTP8EnBJwLhnYhp
         v78t9HYa+LcMsGSMcTa0Nlt0+GNk1QF9m9RfdYib/rcQY3aVbY/qPbcwIIevZawnCHpy
         22Smf5MjiFDgH5O36LJm/GHQiHVTwUPc+gA3m5ONusYKgqID6TsUbH2k7PDXa1CgmhpD
         2b/w==
X-Gm-Message-State: AOJu0YzZ6aids1t8wvWI9d+WqQOM9OjDRg5RFmScrZ1YfwcjpEL4XN/q
        nyoVeogFFn7Xfg2U9LruqA==
X-Google-Smtp-Source: AGHT+IHBPt21/CoYA6gAD1CvzSK0qv2qopqh1SeqIwu0FZaxDbZLhuYzC+CMcy5Il7uIpCQK4RaODA==
X-Received: by 2002:a05:651c:1315:b0:2bd:1394:583f with SMTP id u21-20020a05651c131500b002bd1394583fmr3610948lja.3.1693329446179;
        Tue, 29 Aug 2023 10:17:26 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:25 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 02/31] dt-bindings: gpu: mali-utgard: Add Rockchip RK3128 compatible
Date:   Tue, 29 Aug 2023 19:16:18 +0200
Message-ID: <20230829171647.187787-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK312x SoC family has a Mali400 MP2.
Add a compatible for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 0fae1ef013be..abd4aa335fbc 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -29,6 +29,7 @@ properties:
               - allwinner,sun50i-a64-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
+              - rockchip,rk3128-mali
               - rockchip,rk3188-mali
               - rockchip,rk3228-mali
               - samsung,exynos4210-mali
-- 
2.42.0

