Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51A803BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjLDRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjLDRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:12 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A04FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d852e06b07so1659044a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711318; x=1702316118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELMbPJ/Bj4zA9agSl3Q4pw6/j7PM/9NebqfxKhnmMvI=;
        b=OurRTAy2zoeSTxwWrdD6QQgXqylbWVvtku3UbpESXxggK0Ajxy+jAomAtFYlqnhkw/
         HANVRaQagfVWm5wGuZEnmymwwixQz3+RO0/7TG0Sx4EuTVLjqC3GRN7yj6xu4sfyqJUv
         z68b3m4n8rGvjtS1/eaTmLhbPgyRb7UEHgneNSfQKzri/0V9CeUQKncdr14RPyY9Rwjo
         MWxC2llIhsXJey4BWclkviQNFTX+/yVNNu2rS2eoPJQBGZ4HjYZJH7xj/u6eTWFglDtg
         e3SkdZI32zayiq+w1yvDyfQD3EEHg5rjbAkHOY3erLQ9QaNC5ynRQ7JGkfBttMKsHoPC
         xZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711318; x=1702316118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELMbPJ/Bj4zA9agSl3Q4pw6/j7PM/9NebqfxKhnmMvI=;
        b=gcEEAb2T+VUEcuaNLs5aiqZ7wpLDJZUF0nwz/Ad2EtwOPFhuAbTHb29rI7YLOOdR1m
         2nYgLLEgs7b/JCX4UKrJGBBqcpTjiyzbiEM8ZFTDB1Y5qcokT91IyPFCPmJHhhvvRchR
         GUNNH4vykKHrRppbGyKmifi6xPiVwoWM50YgTSwBRleLjVzYpEwmgev0gH+4Ts2+1M9/
         nGP8mG+uqKsKAa4OqwjN2JX3Y+YJBXBEzqAPA9YMkMdW7bOk8XiFTQIqrjrGebs6fFG6
         WBDumvCNk7fW4c6mA8dF0RE3C3db9k+Zq1mUa5tOjwFTGOjbjt7JZmxMPKNGONkFH7Qb
         elVQ==
X-Gm-Message-State: AOJu0YyXpe1kDmLeidPBRIvtbYVfFADv/JfZTiZ/se4pITUZKXQs9JMh
        nx+8kkWY1cLtR+wF7gqGH2zoqQ==
X-Google-Smtp-Source: AGHT+IE/yqFGcXWPTu15sUzxJUaPpuQBk/n79TXrMWam1gnscCWERXd110HIkAly/WudmFOVbxPZIQ==
X-Received: by 2002:a9d:768f:0:b0:6d8:7571:b6d9 with SMTP id j15-20020a9d768f000000b006d87571b6d9mr2147675otl.43.1701711317917;
        Mon, 04 Dec 2023 09:35:17 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:17 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] spi: axi-spi-engine: restore clkdiv at end of message
Date:   Mon,  4 Dec 2023 11:33:33 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-7-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modifies the ADI AXI SPI Engine driver to restore the clkdiv
configuration register at the end of a SPI message. Having the clkdiv in
a known state is needed to be able to add a new command in the future
that only performs a delay without any SPI transfers. Furthermore having
that state be the smallest possible divider will allow these delays to
have the highest possible precision.

Changing the initial value of clk_div from -1 to 1 is now possible
because we know the function will always be called with a known clkdiv
config register state. Making this change will also have the effect of
not emitting a clkdiv configuration register instruction in cases where
the maximum sclk rate is used. Having one less instruction to process
reduces delays on the bus which will be beneficial when we implement
offload support to enable reading data from devices at very high rates.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3437829ef8b1..3798f96da586 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -228,7 +228,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
-	clk_div = -1;
+	clk_div = 1;
 
 	spi_engine_program_add_cmd(p, dry,
 		SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -280,6 +280,14 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 
 	if (!keep_cs)
 		spi_engine_gen_cs(p, dry, spi, false);
+
+	/*
+	 * Restore clockdiv to default so that future gen_sleep commands don't
+	 * have to be aware of the current register state.
+	 */
+	if (clk_div != 1)
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,

-- 
2.43.0

