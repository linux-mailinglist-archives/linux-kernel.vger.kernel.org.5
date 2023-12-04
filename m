Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B8803BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjLDRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjLDRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:04 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A9187
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:10 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b84402923fso1176185b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711309; x=1702316109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OsS81iJjdYUrIfnnQHE8YiK9lvPvbcglqw48PfjFs=;
        b=Vf2jlxV2tdLEracv5icB41+YhoaMg0csMVqjjn5oCpubGiykjPXSNUSUbLnIC+DnGQ
         PQ/bxseS8omyABCSKDikrlQsfJIlrAzo88/pAbcBhEA454UU5yXlnjGdXPjghraLfUD3
         xphSQPyEyO1HwRtvXFsl2xbjqp/vKbkpTGZmmcOS97iifeIVEfGrYNnR3w2/R7u2hwei
         N25dc4Vckh2E5jnrJPFN/rGyA76t71XNnLhQ7pwfZ/I8DLz+WPkliDKUh8119PYG/kja
         yx4lrdZKA8ZDTfntdE5EnshHQ2a/i1y2sCqzUYH3vVX0+OyS3Pa6wOpC3n/Qqu2Ofu5Q
         y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711309; x=1702316109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98OsS81iJjdYUrIfnnQHE8YiK9lvPvbcglqw48PfjFs=;
        b=Ms9SHV+PGw8yLhOe9yNOmuyaZ8nt28wu7mWhFVIIkULwN/g6L8lcY1gMQ8OV2lOnBk
         rIS26Zi2Y9mjaaUaIL/16lAIOj4bbqtxK3iCmnexc2uU+0aC9jsYYZuFdnqRrm4tSORJ
         2DThqfQVrPDn+c94RDnktzUFOguTJikz9v7k/Q/2+wNCMmB1ZWp0h8HOn8nO7K5b1VU5
         UWXnTQsZ6rRmW099THkiwpgmcU7eDNFz4fnVENU3K320CME+T4I54ZZoNAMTaw6KwYIj
         yrffKvmeTmMIdckYUutqAhfj+yJLosFK1MPI5UqQT+aZtZc7EeMFo8Dtd7qcvt+dFNTA
         TqPw==
X-Gm-Message-State: AOJu0Yz9UbgJsPNoI2h1+KGtM3lq76m07GKvg7iQWwDMBBKl0Dry2qwR
        eS5zXXQZ0k6Gbmz8CbuE/Icoig==
X-Google-Smtp-Source: AGHT+IHg4kzcTZPdowMqqYULC4Xk7Q2T1h9G0+l78eNSUSIGdCPrDTXYGvub/SVq0Dprt3xJgcdH6w==
X-Received: by 2002:a9d:6e0f:0:b0:6d9:aac1:228 with SMTP id e15-20020a9d6e0f000000b006d9aac10228mr767563otr.40.1701711309599;
        Mon, 04 Dec 2023 09:35:09 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:09 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] spi: axi-spi-engine: return void from spi_engine_compile_message()
Date:   Mon,  4 Dec 2023 11:33:27 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-1-063672323fce@baylibre.com>
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

In the AXI SPI Engine driver, the spi_engine_compile_message() function
does not return any error and none of the callers check the return
value. So we can change the return type to void and drop the return 0.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index cbca783830ea..982b37ac3063 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -218,7 +218,7 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(1, mask));
 }
 
-static int spi_engine_compile_message(struct spi_engine *spi_engine,
+static void spi_engine_compile_message(struct spi_engine *spi_engine,
 	struct spi_message *msg, bool dry, struct spi_engine_program *p)
 {
 	struct spi_device *spi = msg->spi;
@@ -273,8 +273,6 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 
 	if (!keep_cs)
 		spi_engine_gen_cs(p, dry, spi, false);
-
-	return 0;
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,

-- 
2.43.0

