Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D580817C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjLGHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377877AbjLGHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:08:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C1510F6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:08:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c74b3cd4cso1291246a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701932902; x=1702537702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUjigMyhPNILQVeiYoNrETQoN43+wjidRPsdTz48dao=;
        b=AWSw5Ym3VuWuvTyH8QEwBdn5nP1tXgvzsHEla1/bif8o68OyTKIS0ncA3XA7uv86N2
         qbCWqUgSYuR8V9odKpfQhi6orPmlR7CTztxBZ8TrFAvyQVHApmbwdb+VDQ7V4y5xxRWh
         LU7Sc3/A1PlysM8ANQ/7M5rmIBeNDQnWoAnrpjMSHkwgKjYYblPiGNQtDxfoJVXGSBhT
         G3MCjoJnwvCYgxwzKX4xz1thcQvl870kt/+639XvuI6uF0Vy5rrLrVZ55Q/6AjrZiS/5
         PoVEnYNqn3rM2b3+uWZbgu/fmtvTRLiM1pe94Dl2Jv/HiKdPAb8UosNwF8AUoFH74kR0
         9gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701932902; x=1702537702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUjigMyhPNILQVeiYoNrETQoN43+wjidRPsdTz48dao=;
        b=Xq1vkNdWbgjxITUcODCmhajbY78AqxkvzqGbihKclOwHwKz2JhN+XopXlxJPFVGtCX
         G/jsbkB9rAeMfkq/7h/0tX810lUszYAYznQZ5gljoHgVHSEGSVc7tZhJ7VBdz+TWAPrd
         8F2U6khGHBgkDCsTvnobC81dkN9nsp3DtI7+H6L5plbv1ASJQ0ynDOtrt+7djkmAJhdb
         2K2E5IW8ct1+DNKeNJPYTPH94R4DYkF9Gf0p/bKKzUDg/v3k53M6EFUpJtSYBXUo922e
         TP5Bp3ToggT5tMJGdAc85hoHr2Jj/+su/hhuypqvpSvFpXPhoBLRHUTuAQXZSK8elOOn
         PpTg==
X-Gm-Message-State: AOJu0YxqiT4ffFSqoVpTOu+ntE/Nw5ZAmZPqnuG9zrLUsRyn5WiG/p57
        jfyGw6jGpT1gQ4VLCcO3alirmQ==
X-Google-Smtp-Source: AGHT+IFk46iDHgu7ETFLNBvmcvrvOXwvdapV6HeLC5q18UEGLhbhcwKim2TNZ/s0F3jsOomMkpUCuw==
X-Received: by 2002:a05:6402:26d3:b0:54d:8bf1:a24b with SMTP id x19-20020a05640226d300b0054d8bf1a24bmr2862520edd.1.1701932902012;
        Wed, 06 Dec 2023 23:08:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id b41-20020a509f2c000000b0054cb88a353dsm420818edf.14.2023.12.06.23.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:08:21 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 08/11] dt-bindings: net: renesas,etheravb: Document RZ/G3S support
Date:   Thu,  7 Dec 2023 09:06:57 +0200
Message-Id: <20231207070700.4156557-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document Ethernet RZ/G3S support. Ethernet IP is similar to the one
available on RZ/G2L devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- collected tags


 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index d3306b186000..890f7858d0dc 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -58,6 +58,7 @@ properties:
               - renesas,r9a07g043-gbeth # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-gbeth # RZ/G2{L,LC}
               - renesas,r9a07g054-gbeth # RZ/V2L
+              - renesas,r9a08g045-gbeth # RZ/G3S
           - const: renesas,rzg2l-gbeth  # RZ/{G2L,G2UL,V2L} family
 
   reg: true
-- 
2.39.2

