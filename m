Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7697D2F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJWKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjJWKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:22:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D003D70
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso23339895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698056571; x=1698661371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pww7da1n7UWS02L2LkSYEEM6OsT/YObeILUz4Nv4Nyo=;
        b=Zg1PMzYSY/svIeo1uSb0GBD5CVAGdmQ3IvbbI7HUGWnQbWtwscgLGpPJ/zgrdWv+sV
         tfPBRQBTFTBHpfQcUWgGQcaLydfbPwhNrkTqF8KG9ZstcnmD+Uuwu1r0Za6dp5Ez4Q1v
         oWkmRNvMNu4+LxeHmXxvPrKZlWa9UYK9ausu8lAcEfumSaR9LuzOYiYdbJSCzyafo7uR
         MdHs6yF3z7JKhk0WxyN9SvLFx6tkXozwjyC3dSD1jp1yN8d4JhR2OXN0nUuze+y+aQdG
         bozQ/Q7ltCmwda4+b0nryhPC7GHli4+BURsbJy10uKe2Xgd06j9h+TZndOhnKR9IMcns
         vLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056571; x=1698661371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pww7da1n7UWS02L2LkSYEEM6OsT/YObeILUz4Nv4Nyo=;
        b=e9q4C8No1yMm0CsRCd7ZPBooAqU3bWGNpwF8EqfAh08on7D5kv4q+AHtGpeiPyk8JQ
         CzUrSNoTbFPQ9qqtPuJZVm79/lRHNOUxD0mVskYUMNlSiu0YRSB+kURI/Yrhxet8ls23
         PuJW4p5PiNHfcmuJXnuGR082/fMxl96+rZrMDQbHEgQ14Xt5Oll964fm90EaSuV7QTk7
         EjHEcc/L++3spdYBoLgwvjNqJAhR3ND6W5Zi84g5/re0CIirct3ukFCGA4DF96iHES2K
         aOJCuxmmxHJ2K6V5/g9t18aBAthX4rgZgoGAnh3/ljakHwZcOpK4OziYrTsuDDcYcobA
         VgnA==
X-Gm-Message-State: AOJu0YzFn8KjZV+yCBZOmG5iMbNkGSVNzuMr3IUzIKkocplSKUCmQBud
        uTbL7xPFqg8+DstqtIy/nzl+Eo7i73cNQtQkf/Q=
X-Google-Smtp-Source: AGHT+IHG+ByNpckXdtbAjkLS73leG1MuuYY26azOQjkLbervqzdsRg3e+b+9MLQ7/FEaNzlIse/tiw==
X-Received: by 2002:a05:600c:4fc6:b0:405:19dd:ad82 with SMTP id o6-20020a05600c4fc600b0040519ddad82mr8563116wmq.16.1698056570768;
        Mon, 23 Oct 2023 03:22:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm13593275wmf.5.2023.10.23.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:22:50 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/7] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: document RZ/G3S
Date:   Mon, 23 Oct 2023 13:22:17 +0300
Message-Id: <20231023102223.1309614-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document RZ/G3S (R9108G045) interrupt controller. This has few extra
functionalities compared with RZ/G2UL but the already existing driver
could still be used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 2ef3081eaaf3..d3b5aec0a3f7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
+          - renesas,r9a08g045-irqc    # RZ/G3S
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
@@ -167,7 +168,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g043u-irqc
+            enum:
+              - renesas,r9a07g043u-irqc
+              - renesas,r9a08g045-irqc
     then:
       properties:
         interrupts:
-- 
2.39.2

