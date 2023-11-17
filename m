Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A87EF85B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjKQUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346154AbjKQUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:14:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D96510D9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:58 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b566ee5f1dso1446450b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252038; x=1700856838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npvMQYAJSwyILZ7IKukB/DvG7sNQ93TySYJ1U4gDkl4=;
        b=dF4HhDH2eqiJds+sz20xspLu3qG1xNOdNILpBOPIQlUyyAd/h6KZkNRbNNuCYrZuvG
         42zo54xPs/eko/hE5oub++KHHUkCnGYIbv4p+2xIgz/IPQ6e0KsOon+CTZn7MywympNu
         oYh8XdrJbK3gLKJIzbrlD3wX+DsY5Ll/opwJh9SJKt9JBpjKzhe12AWXCvlcXdkYVpxa
         GJSl4jWRDwE9c3vUto2rD5w3tFfh/g/c630723YIhpvthgo9nOo2waY3gx/BdmNOexZO
         7P2BZAidQZchZ5ouG7SqPpT64+d4u7uthtwRXC5M+KLgpoUxJasnS9SqQnHqWfXIHZw/
         Ckvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252038; x=1700856838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npvMQYAJSwyILZ7IKukB/DvG7sNQ93TySYJ1U4gDkl4=;
        b=arnrjCngIYOWQ/wrnXpvq07rL3xZ9sZ+hT7INJ+3qAgOsVmMcd0fW+Yg9BH4ZB5p/d
         VYppAg40Zn4Py/fJkx1Q3RMJEeuC00HcSzLnNr6Ak6FYZ21sGl/9mQy/uI2k/lwqSnOn
         Ud5pEI6cr7XvYYrO1RwaPKEgOJLgEdbSo0Xu3j3LZlJXHHq113sVspL62FWAGx+GcJHX
         q3RYgZS06ez+knUf60G7ZqP7byhUe2x1nZ+MQ53e/L3+fYNULATglCRxGV3VabkqPK28
         qE2tYKuln3/fOZhw1ClcbSV1u0vcMf+KDup78ESPIhVewzLdarbP1giqGezV81Y7wkaS
         tpEg==
X-Gm-Message-State: AOJu0YwtHjSIBAAWwX6Iv9GB0KjOGavnfHjXIN6eqLJgw7vGuiyO16EN
        Ij6S3HQJGGIEFXTjYAFayC8DVw==
X-Google-Smtp-Source: AGHT+IG/IrKsnh7EvBouduSI/F9prrBZP+rKdeDxzs2BynwF/hXH1i+4jAjYYRswiZ4KwgtdAuPN5A==
X-Received: by 2002:a05:6808:1288:b0:3ab:84f0:b49d with SMTP id a8-20020a056808128800b003ab84f0b49dmr594399oiw.3.1700252037854;
        Fri, 17 Nov 2023 12:13:57 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:57 -0800 (PST)
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
Subject: [PATCH 08/14] spi: axi-spi-engine: check for valid clock rate
Date:   Fri, 17 Nov 2023 14:12:59 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-8-cc59db999b87@baylibre.com>
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

This adds a check for a valid SCLK rate in the axi-spi-engine driver
during probe. A valid rate is required to get accurate timing for delays
and by not allowing 0 we can avoid divide by zero errors later without
additional checks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 819744246952..8a6fbb3bb3f1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -532,6 +532,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->transfer_one_message = spi_engine_transfer_one_message;
 	host->num_chipselect = 8;
 
+	if (host->max_speed_hz == 0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");
+
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		return ret;

-- 
2.42.0

