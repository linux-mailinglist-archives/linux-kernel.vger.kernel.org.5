Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3389803BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjLDRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjLDRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:09 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64EEFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:15 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f055438492so2703687fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711315; x=1702316115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N1ldpj7qSULABUcURbREEv+jtlrcm2xYn7c9FK6Esc=;
        b=t62f/93WGiwsngUH2sUzn2zcoAvV7WrCN5iB23+MTgrEjXHEKSebP/lnImoIx9kuqs
         5TQag0fbT9cAqx2KXOE3mUbiSD0wDPkWKFU5DGAggVlvuoW6ttFgbyoluBUSiaeUt1Y2
         V0SsTKaKMLgHqCI0ERU7pdywfDnHQJZY4MZqr7bQpum0WcbFuk7aPc/BDVhydC9OOHeD
         QiQhOjkKiXdWXI7RMuf0+PyjEtqPAK+ML57Lhses+WlVEZ3270M3EYpP0nVilPMW1T/z
         Auy8gSLyLOEMQkrJyUF4DCOqbONgALYd4dK7AZ9LxJMOkOqVQI0W87VtvDN1Ei579qAA
         Cm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711315; x=1702316115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N1ldpj7qSULABUcURbREEv+jtlrcm2xYn7c9FK6Esc=;
        b=r69o3vJ/Fxkgwshf/AO19CBM+v1/bPsXTOKlYp9uMQsN2zQTK8ULetckaxRCW3i8O5
         vXLd2GihcG1d9ZKqmRrRGPWGBY6n65bAH83syY7IpHExROmN10okrSw/MWG3ughUwFEz
         1CEO2a92yfjda2aMAHW+9xk8QIxzWcxY557winIgRZ1XuHcWDzfBjDiWvw5yZAYzfwbg
         W7jiRR4kzhY+ZU7Fxg0wm5WUQ6T9l+txM6OhRHWz4KsinFGK8/AnSKUnnWpOG/aV8FIa
         CdqlHegCSiNrHRl9cjkcxwpuVn9LkEIDwEsog3SeJyMgYev5uOigk8cnnBtPSWAqLYt5
         h1KQ==
X-Gm-Message-State: AOJu0Yxi0pVDrdMIfMFIJX3LA7qHvk2Z2+LCeNaBZ5gRtfxocUv6u5HS
        fObDd5vYZiZXZ7Gsk6HiqEvc5kAInjNt6FZAmGc=
X-Google-Smtp-Source: AGHT+IFLgXbrPDcQ7k5zqmLeFlbqKW1SnS++SSir5JVeArkwx/BhZ+D10yN+nLAvf36eks4VoFaqhA==
X-Received: by 2002:a05:6870:558c:b0:1ef:b591:5733 with SMTP id qj12-20020a056870558c00b001efb5915733mr5110355oac.15.1701711315270;
        Mon, 04 Dec 2023 09:35:15 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:14 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
Date:   Mon,  4 Dec 2023 11:33:31 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-5-063672323fce@baylibre.com>
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

This replaces the xfer parameter of spi_engine_gen_sleep() in the AXI
SPI Engine driver with parameters for the delay in nanoseconds and the
SPI SCLK rate. This will allow this function to be used by callers in
the future that do not have a spi_transfer struct.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index b3e72308fcc5..84ec37732d8b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -168,17 +168,16 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_transfer *xfer)
+				 int delay_ns, u32 sclk_hz)
 {
 	unsigned int t;
-	int delay_ns;
 
-	delay_ns = spi_delay_to_ns(&xfer->delay, xfer);
+	/* negative delay indicates error, e.g. from spi_delay_to_ns() */
 	if (delay_ns <= 0)
 		return;
 
 	/* rounding down since executing the instruction adds a couple of ticks delay */
-	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * xfer->effective_speed_hz, NSEC_PER_SEC);
+	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * sclk_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -256,7 +255,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		}
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, xfer);
+		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
+				     xfer->effective_speed_hz);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {

-- 
2.43.0

