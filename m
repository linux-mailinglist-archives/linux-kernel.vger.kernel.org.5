Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794A78CAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbjH2RSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjH2RSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77710C0;
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso601746966b.1;
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329445; x=1693934245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21iVkiyaMhIOgRnviPspvm+tAmKdNHJ4HpDL49p+DgE=;
        b=NKjq2NpTIzwWtsb4WQ8JGYvGWyLJPvx0NmmkaWHXoHsK2bUZZOLSZlh09hYMZQjyNe
         YRJebTQvSlvRhwarjHsEhi0stN7D8UajKYGCZ3BbcZfLWAg1RK5gHyP0IqpmY0cDuAU4
         aRbXPvPTgdpOt7wC7BTaeD6lmV+1idIhZ3g3RGmvQYqFI+CrnXPcrkLweYOID+NGHEK0
         DRBRLt+Bdc5LLin7QH6zusukVIw5lnnj3z/4E/VDQxPCdazNNIdrT7quG/nRuF3Z/XWt
         gj9SKxmkGlyI3H22Mf9FhJKBQhVJqGWFmcuHK0PaZwCl5qNDJY2RuX5Mr/GDdzGX5RL4
         9TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329445; x=1693934245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21iVkiyaMhIOgRnviPspvm+tAmKdNHJ4HpDL49p+DgE=;
        b=S5dOstpDRZNdmMSfvnUXVJRAas6rVe0I2vEuzfL2a2Ch6C1+SXtGydMY08X6XB+3Bp
         Pc9RCbDuV/+Bc+aaPqtlaLX9G3TIJEZXTkDEIJGbKts6u/FCeUCKNmUxjPvcbF1NDXgW
         annkeBJrN8q5GbAFTMOIdTrAkCuY/MYNX9Z3cms6BHOKKQJMz2UrgJ9ufRrLhOSu+xwF
         9N3+jSABB6oGUyf5P8QfnCw439VSfUnlz+i9PjV3JKndfwHand6a4hFVohTCGpY4b+sz
         V+yFQPaBfUPKY+Q0x2Z/9U4nDV1R7YRYVEPeJqEgEOgN70dJ+Ysz2QyuIj3P/S0klrMl
         c++Q==
X-Gm-Message-State: AOJu0Yw7CXCmXZejrWXv+xS+KdTUUZWdVrcNwSpRLz1LnO7yzCZEmPV2
        ubgst5s0hSgO79Yc1Yg31g==
X-Google-Smtp-Source: AGHT+IE47kgzk515LSlCQdCMRZcljVGwTMt+S3yLZvAE50B+UB6aWy1SLTFd1oolF0G2c8xX/aHgtw==
X-Received: by 2002:a17:907:7788:b0:993:d617:bdc5 with SMTP id ky8-20020a170907778800b00993d617bdc5mr22834649ejc.37.1693329444970;
        Tue, 29 Aug 2023 10:17:24 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:24 -0700 (PDT)
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
Subject: [PATCH 01/31] dt-bindings: mfd: syscon: Add rockchip,rk3128-qos compatible
Date:   Tue, 29 Aug 2023 19:16:17 +0200
Message-ID: <20230829171647.187787-2-knaerzche@gmail.com>
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

Document Rockchip RK3128 SoC compatible for qos registers.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8103154bbb52..089ad6bf58c5 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -61,6 +61,7 @@ properties:
               - rockchip,px30-qos
               - rockchip,rk3036-qos
               - rockchip,rk3066-qos
+              - rockchip,rk3128-qos
               - rockchip,rk3228-qos
               - rockchip,rk3288-qos
               - rockchip,rk3368-qos
-- 
2.42.0

