Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E857BB559
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjJFKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjJFKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:35:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17575AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:35:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so17236045e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696588506; x=1697193306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V91cYRIt8yJYSOx2f4FKH7CFK9UttvFj+gUpHbgWKyw=;
        b=3bTDWfMJ/ZA1h0aVqI0+KMnfnzjc+HodY+Tx7A1e+zWuIhAR/G/6kNUGpnK4RJYVCh
         bMCmBrxUSinIuGYebS0O1PsMJMryDzni9JfQabvDvK1bgTWjKwiuplv+ZU0+B20wDYjW
         Ywex8LRVP4rLOVEuGk6SdNLit0clQ23xa+cPV17mCi+uWwd+scAOW4Yw0QKeG0VRSHrv
         n3pBGUZQ4g6Gtb5Di0W8k8MVMF+A9cP1Y/PIZrda1CIWForQ9OaadpG92S2wGnM09nSz
         fE7sOw7hZc0bKbIW15bi0L4GaZkfFyokVoWIbWe501zUl2sPO8x3Rob/V46SgeqhgxM1
         OXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588506; x=1697193306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V91cYRIt8yJYSOx2f4FKH7CFK9UttvFj+gUpHbgWKyw=;
        b=LT1jHvDqjqkCPDpZDKTF9/zuTHn2tSkgZ5eqR+Um5qTOt9d1aFf6Fij7VbYbSoCpZF
         m3cscry1PNUhwh/vTz03Z0Rcq9M3ZC5q42wvj5g+im2Y2mMdXznyCSKumLtngwtWpUoT
         80/2ZMJPhsMNMYQiOQ5fdWSGyU1EyARjKmRdKKANHeYmbutV0ctx7kFFOZG/F8O4crdK
         6bFpAjSxo6CahIdhvcbmK4Lc/RKjGS5/rnevLl1O+3OnuvlopzPa0vddbD6OQFzOGzQi
         4UvNznTax8jTmL87L+8Zlr8y6nuWK5JP5NkV6ToW6+c1hhRrCNlA+SII0SOocoTyVaA7
         HWuw==
X-Gm-Message-State: AOJu0Yy6TWhzCuvBxL5hSNypkJByMoDmSmBJ3zDrDbcf+rrsWyBosMuf
        r1eIljY0P5C59HNU9bDC4veB0A==
X-Google-Smtp-Source: AGHT+IEQKHQgyycikSC7e7mcqZlld91WP9kvs3yOFJCB+Q8m/eHcWr/vhaYkfmAAiW9jIkih+kTaaw==
X-Received: by 2002:a05:600c:224a:b0:3fe:dcd0:2e32 with SMTP id a10-20020a05600c224a00b003fedcd02e32mr7104492wmm.19.1696588506308;
        Fri, 06 Oct 2023 03:35:06 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8f44:72b3:5bcb:6c6b])
        by smtp.googlemail.com with ESMTPSA id l9-20020a1c7909000000b00401b242e2e6sm5664963wme.47.2023.10.06.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:35:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add libretech cottonwood support
Date:   Fri,  6 Oct 2023 12:34:59 +0200
Message-Id: <20231006103500.2015183-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006103500.2015183-1-jbrunet@baylibre.com>
References: <20231006103500.2015183-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Libretech cottonwood board family

Co-developed-by: Da Xue <da.xue@libretech.co>
Signed-off-by: Da Xue <da.xue@libretech.co>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b7b0eda4164a..caab7ceeda45 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -155,6 +155,7 @@ properties:
           - enum:
               - bananapi,bpi-m2s
               - khadas,vim3
+              - libretech,aml-a311d-cc
               - radxa,zero2
           - const: amlogic,a311d
           - const: amlogic,g12b
@@ -196,6 +197,7 @@ properties:
               - hardkernel,odroid-hc4
               - haochuangyi,h96-max
               - khadas,vim3l
+              - libretech,aml-s905d3-cc
               - seirobotics,sei610
           - const: amlogic,sm1
 
-- 
2.40.1

