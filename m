Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAC79C5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjILE5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjILE4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:56:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CDB2D69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so3133615a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494408; x=1695099208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HrAWyXhc5UGvYEw5qJFkd5OTzrOQsZQW/aP2QXdEbI=;
        b=oqFbiMph+6Jz6LwNzix3kouJN/OsYu60xIYcFQ39FGPrX8geom7BfXVSJBi4w3n+G6
         ct/bJGPORX7q8UL9+PxQmcBh8sjcSRzL/r8JHcM+5Uz3/Kko1KKMfduBdpTxG9nCOWVb
         pICtwEasm94F31QZ6Smw9psN5LulQFsNLTaWk1eICJ5O0K/3vE9qBh3Qa6ENyw5aRXjs
         n5N5IZ/VBpiTU4SkO6iFaI3WgFL1RXu3EgB0pLnagNGtNwD++yRNu/o3s2AVs7KTUnVs
         A9Ip0hRmYOZXzvAeUzcY2bmidrXOdHT5R9mlIT1sadMa+RTluyD2wSPGJzclyLTKBKcF
         iHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494408; x=1695099208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HrAWyXhc5UGvYEw5qJFkd5OTzrOQsZQW/aP2QXdEbI=;
        b=HEDpnSk3dyG2u64EfiJpx0iuNB+newOJX6Frkt8qBfPZEnS31qUY3eWRiSpcztATA7
         cvEmD1v5AVa24aLqJPCyyZxWPOFSQ2SdJ4dIA1Z+u4IBAW6zcLee3SgoFypDjlxEQ/Pw
         71Xyr2UTvQ0UShPAZ2FGz+jiMhBu/ZcykZT75+sLD9F5HyOaIqJriDB9aY3Sqo1+rq4a
         XjPYXkD8mTIhoTAiO8KPL3MhfjDIO9ZSNTnqcJxPGHrOTxjbt4fNAt+MW/Cozfu/E5cS
         ANuPxKN3Zr5BfYQzimZBBZBYYy387MjGvD6KxN3McJFYo33rzIb1wd+ooeMgQY3CTbUg
         ipSQ==
X-Gm-Message-State: AOJu0YyWWbXVHGe4W1fcIVbIYruyyCshpESdClgvL8eEq6F+HxlkmMeP
        JTPC7ECzMi4GqSmllNij5Owgbg==
X-Google-Smtp-Source: AGHT+IH22ThlXZ066/WgQ1RS8s0YoZtqWi+0Y9CXjLCSgIoSVA//0jNCDN0arlPG3DiSxDc98oDDqw==
X-Received: by 2002:a05:6402:b30:b0:525:73dd:4f71 with SMTP id bo16-20020a0564020b3000b0052573dd4f71mr9067069edb.14.1694494408526;
        Mon, 11 Sep 2023 21:53:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:28 -0700 (PDT)
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
Subject: [PATCH 35/37] dt-bindings: arm: renesas: document SMARC Carrier-II EVK
Date:   Tue, 12 Sep 2023 07:51:55 +0300
Message-Id: <20230912045157.177966-36-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document Renesas SMARC Carrier-II EVK board which is based on RZ/G3S
(R9A08G045) SoC. The SMARC Carrier-II EVK consists of RZ/G3S SoM module and
SMARC Carrier-II carrier board, the SoM module sits on top of carrier
board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 822faf081e84..f4964445e5ab 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -476,6 +476,8 @@ properties:
 
       - description: RZ/G3S (R9A08G045)
         items:
+          - enum:
+              - renesas,smarc2-evk # SMARC Carrier-II EVK
           - enum:
               - renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
-- 
2.39.2

