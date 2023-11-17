Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC67EF849
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjKQUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjKQUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:57 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA210E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b40d5ea323so1497219b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252033; x=1700856833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ldjfSGznOnPblU5dGC3l3g5toq9lO7sGMGu6CgtS3M=;
        b=a3T6+vYCIGb5Q//Z/lesLocw+DyzyxQIQXdyrbzc9cNj/QahPUsj2yjDirdjsw7FV7
         1Bm5vbLuiu2/pdkN5ZUyBl2QSygMoYWBTozG4IUYwR8xuGC7Z1sjn37OCM1/SjTZAPMB
         vxg2HXd3+TRGSAS+OpW5Y1YaX44jGZqmN9Mo+tZcQppikM73mmcIPNfJH22THUSMCiqr
         mwHQ1SqlyYfs6GTzGW9VdW4f7qdrWr4wKTSfXih/vgf6Fc6SprgzX9wFRvlJr1yb2CVN
         bKf0jBCcvcz3kJb3H+bGQBBUrv/fahRmCyB9RvY+0umlhAJD+lSDStQRixSGDiDrd8eY
         fD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252033; x=1700856833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ldjfSGznOnPblU5dGC3l3g5toq9lO7sGMGu6CgtS3M=;
        b=cP25IULSMNaY8IUSz3mbd0wfSQvqjHOAoV/BX2hIFBiWVAUctEQbsvD5iQbpEjJti5
         h/pMnFR9ZjC56mve6sd5owhKje2tWGDMrEHaM4CFczkGM8Ea5cLQj1DD5JT2PWVefJ4T
         YeVigSllkA+LMzC1E0E4ax4FpKFvLp3o7+zWL1OYiNCUI1lg2oOm0GEVDGHdrDzdgXoX
         tea5NYNdNk5NQGuCades+IPHqIO/t+DRXESoWJ3anbQR6q1Ax0aWOqCCJQsFyb9zOYgT
         l+TKAn4+VOUj81t/rjK+SklIpRdxaiffuvrmF4jjGlsjQQNXpgFbUZ3etMxm5Nmce9XA
         PVsg==
X-Gm-Message-State: AOJu0YyNXRImQrlettSQfzgtHhP4wQt/u8BjbqUdjBoE//F3YeRdjOEE
        QVLUAWN4h78OQGMhozBaLBdwfA==
X-Google-Smtp-Source: AGHT+IFkdcnKGb/veAHN78+zN7NC2qdGgVsEjtKNCmABZd6JhCDDXzUcWb6I51Glk8WhVK/eRrCtYw==
X-Received: by 2002:a05:6808:1718:b0:3b6:da98:437c with SMTP id bc24-20020a056808171800b003b6da98437cmr544507oib.0.1700252033671;
        Fri, 17 Nov 2023 12:13:53 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:53 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] spi: axi-spi-engine: simplify driver data allocation
Date:   Fri, 17 Nov 2023 14:12:54 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-3-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
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

This simplifies the private data allocation in the AXI SPI Engine driver
by making use of the feature built into the spi_alloc_host() function
instead of doing it manually.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index b96e55f59d1a..bdf0aa4ceb1d 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -473,15 +473,11 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	spi_engine = devm_kzalloc(&pdev->dev, sizeof(*spi_engine), GFP_KERNEL);
-	if (!spi_engine)
-		return -ENOMEM;
-
-	host = spi_alloc_host(&pdev->dev, 0);
+	host = spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
 	if (!host)
 		return -ENOMEM;
 
-	spi_controller_set_devdata(host, spi_engine);
+	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
 

-- 
2.42.0

