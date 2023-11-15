Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD407ED3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjKOUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjKOUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:53:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1819B;
        Wed, 15 Nov 2023 12:53:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859c466efso359795e9.3;
        Wed, 15 Nov 2023 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700081627; x=1700686427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PYtEKMR8Lcx2AJuXC/XT3diCjxIMZbSWA19LgiBkn0=;
        b=LjzsJQtGwNQJAlRoORXDYZYNyfqEDCGbwhP7pFIZXGLWJkjD+vh+1YMzyUcUDW4kRA
         VgBMeih2oXEg0fj/WBagerf89hD/8NTo88hRY7SKW4tnN+LewzzYk4ywbvjB4Dd+iBZU
         kq9QCRKJqRAUx17Fm9uaiSYMaMJl9/hfSJpqVme3fCDp5JO6m7xwiXOYKIJnEB8pkoZX
         zPFCosHgmcyEucq3Q5n7fQSK3K4AZ2p5GDRd91y1rWdYxMjCx3iksy3jASObw2fDOIuI
         +xD7LV3WVIAYf1uyTQypxzvHNXh1Ne0wYlH8asLr4Foed83VEQu+1zmo3DNUympZPAzr
         w6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081627; x=1700686427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PYtEKMR8Lcx2AJuXC/XT3diCjxIMZbSWA19LgiBkn0=;
        b=LoFOOFuZbyFlFLioOXmp0wZ65d8QXfWZygy6czSwzgeN8kQrg0kCAaAko5yYK0y1h+
         AQPokbjd5+ecQUQzGTAWdd8IN9Dt31ns1Ffs4UJS/umbaQGnDbr9qG/2Sh1BVWy2mjNF
         6Pj8mMSqIpoV5R/RBuwynhE2usBoaADZ8T2OqVFQrE51IiIqz1QPLlIfyUrR2f7AXmJM
         /9Z7tBNs6KtYnZnP6bE6OQx6aLsQ/HjLlX3Lm2HqGlNTjBGtyPYQgp2OLVOsUr57mpId
         Ydhk3C/c5gg7eQ8X5FqDYwxkI7Y7G/kVACFvgR1dxuddz7saGhhXruckkN569mEBHie5
         NXJQ==
X-Gm-Message-State: AOJu0Yzwmz3KwryQKEcHihlNpmiywcB3arccK/61MYF4UrRFvMYXr3kj
        tMkLJj0E6VvugI1MNP2UdFg=
X-Google-Smtp-Source: AGHT+IGBhIjettvz+xuqMppFRXJa0VPar5Slww77XeBNE9okbEw1eOXeU0gM18HaYf+k+Tig7zIZtQ==
X-Received: by 2002:a05:600c:1f87:b0:40a:55a6:793a with SMTP id je7-20020a05600c1f8700b0040a55a6793amr6941368wmb.21.1700081626862;
        Wed, 15 Nov 2023 12:53:46 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id dd19-20020a0560001e9300b0032da4c98ab2sm11438277wrb.35.2023.11.15.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:53:46 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 20:53:33 +0000
Message-Id: <20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RSPI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-rspi" compatible string will be used on the
RZ/Five SoC so to make this clear and to keep this file consistent, update
the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rspi-rz" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index 4d8ec69214c9..0ef3f8421986 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -21,7 +21,7 @@ properties:
           - enum:
               - renesas,rspi-r7s72100  # RZ/A1H
               - renesas,rspi-r7s9210   # RZ/A2
-              - renesas,r9a07g043-rspi # RZ/G2UL
+              - renesas,r9a07g043-rspi # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-rspi # RZ/G2{L,LC}
               - renesas,r9a07g054-rspi # RZ/V2L
           - const: renesas,rspi-rz
-- 
2.34.1

