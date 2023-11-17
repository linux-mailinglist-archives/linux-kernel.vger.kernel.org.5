Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8797EF862
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346261AbjKQUO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbjKQUOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:14:19 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287741727
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b3e13fc1f7so1496423b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252040; x=1700856840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zreOIPUyiZAgHTr9pZpsQXo6OBnZGTBQCaGdmdfM/3Q=;
        b=zoLAan9fa7rF1Edza9nm2jZE0ZBA2io3ee+yQtzpom8/qDZNmf1O2inL7rvBihiqXt
         uSKPLQcs1pynXpmq7QkhlUa/ts1LLe1MhE5Bq1Tejlu3WRjKEy1rybpUqZHtovTjacwF
         C+ROjK58rYm5bH32qxjS34t59j539+SG+xgAWf2388nKTANOJ12A21PlkuBP2bAtgi2x
         c5dl/2ktAwHeJL1RDvKxHGZSn7SPVfBWW4P13t3SRQsZO+W6CxmFJ/jTieWDYBSJIeQo
         CaGDwtT4JrG724a+zDuKoWV8iV8YjsVVAQEXvu9JAJPfkWV9aT1XPSAl/wcPgYo+wMCb
         qMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252040; x=1700856840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zreOIPUyiZAgHTr9pZpsQXo6OBnZGTBQCaGdmdfM/3Q=;
        b=ZcRZauHhZnv0YG7kgj1NmOlxJ8hcYkOkChCqnwmTYLOwWtXqxXyGyRcDEZJJTocvzh
         8K13W7qgKVIPjmoEr5xOuIkic9C9uCVymsJFh8BJPeA/E3JLLkjNP0ggwZUL4JjGuFET
         NVhCapDQ750LzST/rHlA2NI3w7DL7gnmsVShZ5ffCc2G8iCixwmR9A/c8H8KkYjZO+KX
         U51ByHyG/2tJFrktyX4KoDPMYvHU9/lQ743qsC6ntn6Ma4+rXNZO3iwl0D42yE3D0CL2
         FpswF8uhTj4eOnOM5L+d806MJtJ3jbkCtDZN9o19e9KEAO8EXBSnFy46D57NpP2rZJw1
         n37Q==
X-Gm-Message-State: AOJu0YyMJ6oe7OjcUqwu840bZ4xEcWjjJQDhBoAmkcnomFGZaCvxws2M
        L01uxjbs1kqvIOE+a/sUu39X4w==
X-Google-Smtp-Source: AGHT+IEqiwWYiN6HZnqgB/+CsCCnBfOkvomVsWS+AdUE9yqrHGAW/CfIPxPRNw63N4msQ3nIF68LFQ==
X-Received: by 2002:a05:6808:60b:b0:3b2:a9bd:c38f with SMTP id y11-20020a056808060b00b003b2a9bdc38fmr428452oih.37.1700252040479;
        Fri, 17 Nov 2023 12:14:00 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:59 -0800 (PST)
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
Subject: [PATCH 11/14] spi: axi-spi-engine: remove completed_id from driver state
Date:   Fri, 17 Nov 2023 14:13:02 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-11-cc59db999b87@baylibre.com>
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

In the AXI SPI Engine driver, the completed_id field in the driver
state is only used in one function and the value does not need to
persist between function calls. Therefore, it can be removed from the
driver state and made a local variable in the function where it is used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 210bea23f433..120001dbc4dc 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -115,7 +115,6 @@ struct spi_engine {
 
 	struct spi_message *msg;
 	struct ida sync_ida;
-	unsigned int completed_id;
 
 	unsigned int int_enable;
 };
@@ -380,13 +379,14 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int disable_int = 0;
 	unsigned int pending;
+	int completed_id = -1;
 
 	pending = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 
 	if (pending & SPI_ENGINE_INT_SYNC) {
 		writel_relaxed(SPI_ENGINE_INT_SYNC,
 			spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
-		spi_engine->completed_id = readl_relaxed(
+		completed_id = readl_relaxed(
 			spi_engine->base + SPI_ENGINE_REG_SYNC_ID);
 	}
 
@@ -410,7 +410,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	if (pending & SPI_ENGINE_INT_SYNC && spi_engine->msg) {
 		struct spi_engine_message_state *st = spi_engine->msg->state;
 
-		if (spi_engine->completed_id == st->sync_id) {
+		if (completed_id == st->sync_id) {
 			struct spi_message *msg = spi_engine->msg;
 
 			msg->status = 0;

-- 
2.42.0

