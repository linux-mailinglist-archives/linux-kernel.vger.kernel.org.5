Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4036478CAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjH2RSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbjH2RSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EEC10C6;
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c353a395cso601423566b.2;
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329448; x=1693934248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlz17GtutNw1PX6avQfyxd2FJLVbt0FbIToHal1G+vU=;
        b=UIFYLrNe0gh2pAwnM5MUnuNxEI2N+C+hDeO1RoxlyGw+Dv05W/dM9XAythdMCRIY6K
         Z9nxj4tt6ACJ68ny5AJEt3T2+Td3iRnGFXuDpEEGOKu1ZCi0/xj3r9ftMwbIkD3G91Uu
         U+ldak5sol1qkR+3XD7+yUG1TLmaye0xeGMRwwNqpywQVNXSCXTHRVBbLJQJvccZ/LA9
         LfsLtbCwvE6VCGJqblgyPJH3fqOZ+8kAGnBFIBXvtLQwOoeNKDHvfHDNfwl+3UeJYtEU
         h2pnzMnciPjnl0iSQaYBcpSKtOHjUkwuAJ9DiY+9OzRXC+sMbSIofwBZCO86tFcfg3tY
         qkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329448; x=1693934248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlz17GtutNw1PX6avQfyxd2FJLVbt0FbIToHal1G+vU=;
        b=UonFUDCNVTk7n4Zxxruq3Td7Pv3W0kodNBBPVkzpJobuVf0Fr9WzZrSq9WxG3Q0GoW
         h1gX7b/Ui9WjGxLfOBZj/H4/JutUAvARhVH/zGvmp0+lgxC6d+Ltty1l0GG4IstZohXg
         EAKzHsDVJUGb+VW/a032nmDKxHzzrYHCG+uaMLpALApB504X7mOqy40uXX6d6cRbGNek
         WKKch/phs2+yFFhOP6cJf6aeLAXb4RTj39Y5OxKWthXLl5a9tJEANngyC463EkXA045/
         Eag9FE/shWZBj/pXAU/ABT9jYMOcccqeVNy6AroixV/yevDpT1ZnmazXgObAY4HwAFec
         E3nw==
X-Gm-Message-State: AOJu0YwA6wSpJZ+W0i2eoaGpcz7K/wdeJsc/TRNCDJancm7FNnKtwLMA
        JbNOaHylLAkoDs+E2E/csg==
X-Google-Smtp-Source: AGHT+IFFkEkxU6fLi6B7Qfna18QFEfdVNppGwFK63NpwdhfSCbGPZ5uGzoW6mAq0vfuONXZvjcBGNA==
X-Received: by 2002:a17:906:8462:b0:9a5:81cf:57b5 with SMTP id hx2-20020a170906846200b009a581cf57b5mr8395816ejc.2.1693329448163;
        Tue, 29 Aug 2023 10:17:28 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:27 -0700 (PDT)
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
Subject: [PATCH 04/31] dt-bindings: arm: rockchip: Add Geniatech XPI-3128
Date:   Tue, 29 Aug 2023 19:16:20 +0200
Message-ID: <20230829171647.187787-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Geniatech XPI-3128, a RK3128 based single board computer.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ecdb72a519cb..e4c1af691b7a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -227,6 +227,11 @@ properties:
           - const: geekbuying,geekbox
           - const: rockchip,rk3368
 
+      - description: Geniatech XPI-3128
+        items:
+          - const: geniatech,xpi-3128
+          - const: rockchip,rk3128
+
       - description: Google Bob (Asus Chromebook Flip C101PA)
         items:
           - const: google,bob-rev13
-- 
2.42.0

