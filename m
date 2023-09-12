Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080179C4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjILEw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjILEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96048E5A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f737b8b69so4700979f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494339; x=1695099139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70blZEKYbPkUhjmz5mQWqO3PukYEZHU7HfQH/TSApUo=;
        b=kqfJUrg1n+l53/ypRls1jEYBEQS1yM5qC72Ce83Pw3OSGQAkUGD1/8DxeiKx6pKL/O
         75RwVZ/Cjwgs4HQ29MeiI6n4d/Uf4TNyT9rjxyNDXvIUNLxIqi+hBQF/bKYlEm2/fI1B
         +NhCoUqXP4M1WfChUkI0cXzUF5x/R+IK4VYTJTi7s+N/5aBee5ULv/ySPuOaoRd5u3DB
         RgL15fkwQRAfR2VdN2rR4nWFzjT8bILkCynNm4MVv3C4/JiWV/nqdjm3sx1IJHWaCQg/
         8eINlhMZo/fDx1fPojLruX7ffY9YNj87/N1wKYRNmfTvTXc9N5s3pDXGcjQF1IbjTGTa
         od4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494339; x=1695099139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70blZEKYbPkUhjmz5mQWqO3PukYEZHU7HfQH/TSApUo=;
        b=jzxn9oOA4fckbG0BsLzvLFPq4Zrmx35hmanm2beaRqbSXAoVPLy0MbKkggGfphWuzl
         zaz7vKav2j7Vy48uGQDwZtYvT/8HgTZNYbJD9m2+K86YqIR9YD05eunhu/aPKVQzHKWd
         8zSV+y0GaiKWfa++Z3Ns33Qv2LY4IXiHoKl6xNOYzvdMPrr7pfiFLYUPuX+0Ca5e7NWx
         uKGAnYTgcssO20TiBxBccYp0kHYvtGVlZeKSiJfImZgVzAR445Ez5QTqcjfHXxsvU39h
         iAtDKZ1g8qlalYQieK6MEOMYYrDUnEuqgjzuN6bRr8w4Bxhc4LGZZEDd7TgHQ9ALPziI
         oCwA==
X-Gm-Message-State: AOJu0Yyw3qHfCPl+a50in8OU/prlyNwFrLaDEq+YDy/JniWRYzQFz3vX
        w7cCZczma/UVbYLtf1RdqibZMw==
X-Google-Smtp-Source: AGHT+IHq4NsElZT5XJXLX6atbe5JezA+r31z/sk8n97Du/yTxrrOfNS/FcxRiNTwh32QYFqy3lq2Eg==
X-Received: by 2002:a05:6000:ca:b0:319:8a21:6f9a with SMTP id q10-20020a05600000ca00b003198a216f9amr8919668wrx.63.1694494338959;
        Mon, 11 Sep 2023 21:52:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:18 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 01/37] dt-bindings: serial: renesas,scif: document r9a08g045 support
Date:   Tue, 12 Sep 2023 07:51:21 +0300
Message-Id: <20230912045157.177966-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
Renesas RZ/G3S is similar to the one available in RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 99030fc18c45..4610a5bd580c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
+              - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
-- 
2.39.2

