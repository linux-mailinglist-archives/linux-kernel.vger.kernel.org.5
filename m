Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415F3810FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377289AbjLMLVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjLMLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:21:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F47D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso69646425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702466486; x=1703071286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev6Cfv6nDG3qQtZztAusOez9MHzFknUz32Jp+6osCws=;
        b=pRfBouSmfIk7+UkwhgR6609sL0nJpVqW53h8QK576q/yEA96HUnIwioeKgyH0wVWOo
         C46X4jqbdAgx75E3WHQknWSFL+qX43jnM8x7fp9Ufvg+fTlN0c3YICO/LbePONGc6bjx
         vnhG28i8msV7nixLZAq+1N0UUT7r+Tu70gvF+va9yol/ld93W7NfQTxHzHT0xdDILB8d
         twryLQxoIs8n9sJg9XOpm290IcycOYkctr+/gWJRRlZKKuzg3phz6A7pMic9D61AK5B/
         SBh8olhH2Gqh02XMFuz+jkHr/yD2lYJPGtkNNaddltnHd3VL5w9/ENzPcFJxTLXKzkVr
         OjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466486; x=1703071286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev6Cfv6nDG3qQtZztAusOez9MHzFknUz32Jp+6osCws=;
        b=xLCuLgnslFI/EpoBAjSGcwMYOIL/SldMXiVgh0X+rfae3q+Mv6HBhtFvz2mkbvNaeF
         eAJib6sr+6xhJmi66Ljh8iY1R6dFn7gxLsXT04ntA5YwVDsgrO8KH8VC6Ak0oJj6J27/
         GaR8S7C/nAw0/Ir44pcWbhjizQ1LNX9tPa/Z1piYqnG+H8QD0XhCsV92orKXLMYQzZ/7
         xMg/OB1VqXXYOfgZVe3CxE8/bfw/cJYDUuofMdogrO2m4Ke4HTrDaIYRhNyJM22Iip7e
         HgBUzkfPDd6vKwoVoTzXZUkhC0qT2m2UVZ3clnv4DyZ/kH4ycVSBZnVgwdJ4bn5nnoBm
         xogQ==
X-Gm-Message-State: AOJu0Yzzngyrc03dN1SDZUWNUPcAu0qrL3XdvqJBMfDD8tEXXYaAJVKo
        Yp/1XnoUqnRuFkdDeOiAg/526A==
X-Google-Smtp-Source: AGHT+IFYo7bTOfdzgxtVdb4EObLHhLYJD6yACWy15D89wzsOa/LZSsHgFmB0kezYkUnbcrxwBEtHeg==
X-Received: by 2002:a05:600c:21c7:b0:40b:5e59:c56d with SMTP id x7-20020a05600c21c700b0040b5e59c56dmr3727083wmj.151.1702466486079;
        Wed, 13 Dec 2023 03:21:26 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm20097617wms.7.2023.12.13.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:21:25 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: spi: add spi-rx-bus-channels peripheral property
Date:   Wed, 13 Dec 2023 05:21:18 -0600
Message-Id: <20231213-ad7380-mainline-v2-1-cd32150d84a3@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new spi-rx-bus-channels property to the generic spi
peripheral property bindings. This property is used to describe
devices that have parallel data output channels.

This property is different from spi-rx-bus-width in that the latter
means that we are reading multiple bits of a single word at one time
while the former means that we are reading single bits of multiple words
at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes: new patch in v2

 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce..1c8e71c18234 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -67,6 +67,18 @@ properties:
     enum: [0, 1, 2, 4, 8]
     default: 1
 
+  spi-rx-bus-channels:
+    description:
+      The number of parallel channels for read transfers. The difference between
+      this and spi-rx-bus-width is that a value N for spi-rx-bus-channels means
+      the SPI bus is receiving one bit each of N different words at the same
+      time whereas a value M for spi-rx-bus-width means that the bus is
+      receiving M bits of a single word at the same time. It is also possible to
+      use both properties at the same time, meaning the bus is receiving M bits
+      of N different words at the same time.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+
   spi-rx-delay-us:
     description:
       Delay, in microseconds, after a read transfer.

-- 
2.34.1

