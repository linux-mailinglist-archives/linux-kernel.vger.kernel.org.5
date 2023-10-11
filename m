Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34E7C4E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjJKJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjJKJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:05:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D506A7;
        Wed, 11 Oct 2023 02:05:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c7373cff01so5807845ad.1;
        Wed, 11 Oct 2023 02:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697015118; x=1697619918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73MtTHz2wZG8BeDtRimMkXrJ4nbT8Vxr+Vs93hyGOic=;
        b=QUsxm+MLnJ+PTPmUGZ2A5g33atbRCjBRTeHjoK6oK4PMhzqNFMgcb2uO9XQimkrK2W
         z32SvFO94ePrhfEkqLj6EpEcUgLsUV6QzGLKY7Q19+VKyJv0YHl4DtEjm+ogxWQchRFl
         nmPvxF/9fK4b09MFGe2ftr2jq2hH1ZSWIDvTd+iE3+9nDiIUC+ZiAWp0/Cgz+M1Un4Cx
         wvgNV51ADsyG0ECawEAR2GtNgUnWMHZ9PkAtwW/5vxsJDtnHoi5l5v2aEW80VpTpAZad
         O588WBTMyS+Fw9dwsnYY5ASdzWKSBy0739T4TlFwvZiM4PBOyq9pBaoK7UG85v37hMKK
         zX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015118; x=1697619918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73MtTHz2wZG8BeDtRimMkXrJ4nbT8Vxr+Vs93hyGOic=;
        b=arfl1YQUbJciUPS2XwY0m2JrfvpTOMoxxy6LJ4xqKed/zK+dIvDDYmsAZwH1g4dg4K
         nyrHmo6ej9JhL6O4ZVAfzci6hpgkFqlAxADCPl7EK6n2ttHAIoHoaFvQHL16trycw4yA
         /TevGTBnhgX01mLgUERPL5SbCGOwgWV/JvG85ykv4xkg44SW1R8c30XFHL0DyZjsgIy2
         pgvIelfAzEfvSKtR8GHUAqQwhRGVWjmq/BxObxuVku7SQ7ODpLMDXJOdFVdhRkdu4WGO
         inLYPQCGEK+tfUGdBuVHNfERyNPO3hvA85i5JLNZwyOkLjimlgYbKyZ5LGbY8XTYfx1k
         chzQ==
X-Gm-Message-State: AOJu0YyycusgIK+jnCdJ2O5QeaWcJIzhRvS552GyTjK5yBxSeonlg/EE
        F1MNVi3VdZSn9MuxXJbBY2M=
X-Google-Smtp-Source: AGHT+IHEQjexRYwH/0HsfnOSM0EVCDjcv2iJBzvmjmQ+W3H1vVklcort/osa7ERRw37aQNwW99Hy8g==
X-Received: by 2002:a17:902:da83:b0:1c6:e1d:8be0 with SMTP id j3-20020a170902da8300b001c60e1d8be0mr30460492plx.2.1697015117730;
        Wed, 11 Oct 2023 02:05:17 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001c61df93afdsm13346699plg.59.2023.10.11.02.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:05:17 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date:   Wed, 11 Oct 2023 09:05:07 +0000
Message-Id: <20231011090510.114476-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011090510.114476-1-ychuang570808@gmail.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add compatible 'syscon' to the system-management node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 34c5c1c08ec1..3ce7dcecd87a 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - const: nuvoton,ma35d1-reset
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -37,7 +38,7 @@ examples:
   - |
 
     system-management@40460000 {
-        compatible = "nuvoton,ma35d1-reset";
+        compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
     };
-- 
2.34.1

