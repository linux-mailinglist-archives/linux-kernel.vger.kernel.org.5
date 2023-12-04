Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1726803BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjLDRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjLDRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:06 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF3F3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:12 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fb4ee3d548so395449fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711311; x=1702316111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pv0Sz4KzlNYFahpj8BH/nxYNAhJ9uRGvkVtUS8FW+4=;
        b=JKwKrQyMs7k+9dJbDSGFVF7laLzGFiSRETaDr4sgOdJGIrLAu+CZODG2BlGyis0qyc
         s8/Gv14hOjBDqwpJigMXJ1Z0F8kDORBUBwDTefZ3KuX1nX4btCFaVVq969lOr3XQrmw+
         q+0Qafi7I+ANip73ythSvYc1HZPIKjWkQyOI5DiNmxjgXtTkebbGgrmHX5VhdHsT8mC/
         xWf+HVzTCgbtUSWtTI3EPnsvqERxMlgm1Pc5GGU2EUSEubZits7gDrZ8ftKFcrj/yphY
         0tSbl8hhB5DOxr9JARiE0vbvMrQLOKA49w+arxEM5ScBqwRJRkC59kcebI/6CSpUBfYr
         B0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711311; x=1702316111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pv0Sz4KzlNYFahpj8BH/nxYNAhJ9uRGvkVtUS8FW+4=;
        b=qr65O4PpUFEpT0tw7kNTbvP/9KjsOV0Ih8+sun2cryy095kN04eTya74NBqpV0JXrK
         rqCzPnxjVdm0eAJzLQJWx/oT2Egwpq2+B5WR3NOTHNZdP8KMLl9u6Ca7zagzI/NUq49U
         8fcQ3rfc+KuZns3AmmJT2oNuXLOTQN1Sr5MfAwNCIT305O6Fog28K2eBDO3xm4tZ5w6C
         X5TrwBGz1nTKl5E1VMVbv9QC/M52AEyV9qTtKfEsP3suHQXEQyVp7qYhJm3XsNw+ewZC
         AjfFyg4q7QJjh7did6V1BLq64cHMyVIrSBzJwzG47/fLYO7ANymD7VVxFKDzWI32YOWo
         U28Q==
X-Gm-Message-State: AOJu0Yz0idn9phTrth2UnAYAEmLTMOHJi/pKyvz61qMzlZHBQqxt0gsq
        p35/yln7QvSCyxcVjWY6LaDdyw==
X-Google-Smtp-Source: AGHT+IE5mZIXudGi6l7bGmA++q9TgAs/PhXMb1/fKQ7Ycnr8NW3MMYZ8DmVrknbpKNkBAWV+ZYC+Pg==
X-Received: by 2002:a05:6871:54b:b0:1fb:75a:de7d with SMTP id t11-20020a056871054b00b001fb075ade7dmr5558431oal.107.1701711311231;
        Mon, 04 Dec 2023 09:35:11 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:10 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] spi: axi-spi-engine: populate xfer->effective_speed_hz
Date:   Mon,  4 Dec 2023 11:33:28 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-2-063672323fce@baylibre.com>
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

This adds a new spi_engine_precompile_message() function to the ADI AXI
SPI Engine driver to populate the xfer->effective_speed_hz field since
the SPI core doesn't/can't do this for us.

This driver is already using spi_delay_to_ns() which depends on
effective_speed_hz to get an accurate value in some cases.
Having an effective_speed_hz value can also be used in future changes
to simplify other code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 982b37ac3063..ee7b904ae5cf 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -218,6 +218,27 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(1, mask));
 }
 
+/*
+ * Performs precompile steps on the message.
+ *
+ * The SPI core does most of the message/transfer validation and filling in
+ * fields for us via __spi_validate(). This fixes up anything remaining not
+ * done there.
+ *
+ * NB: This is separate from spi_engine_compile_message() because the latter
+ * is called twice and would otherwise result in double-evaluation.
+ */
+static void spi_engine_precompile_message(struct spi_message *msg)
+{
+	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
+	struct spi_transfer *xfer;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
+		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
+	}
+}
+
 static void spi_engine_compile_message(struct spi_engine *spi_engine,
 	struct spi_message *msg, bool dry, struct spi_engine_program *p)
 {
@@ -504,6 +525,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 	if (!st)
 		return -ENOMEM;
 
+	spi_engine_precompile_message(msg);
+
 	p_dry.length = 0;
 	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
 

-- 
2.43.0

