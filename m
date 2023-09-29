Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2C7B38D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjI2R0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjI2R0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:15 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1052CFB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c4bf619b57so7215707a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008361; x=1696613161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjPcJpinx/2oZi6yDOcic02ZSonPgH6LaRKRfAMz/Qo=;
        b=NTaAZ/ElMlLTaST/8bI5S/fYU3n/AKHJEy6EdJja37MJzbEos/gy2vWsQVS6GlyF+6
         glBThJ8t7HBFflhb0N9nAbYYRTOQYEuhxJ3+5o62Lh4ONCjOhSIs9kpXBWvW1u0eYxTt
         eUblPkxkf1RJtiRXdFfCSd1skxjXmr/TjAOysHJ+QiP6ldwL2+byPx7E1iRlekBmwm79
         QHGHbH+HyIfDElxYeOWeQltAlbuYPL0HDAaUPIuV3SIlJbUyUAoRmPMR09ed+64GPbUb
         KVcELnr5c0+hvmE0hbVaACs6gW6ZaqH4Pq47GuP2iovitLlCUqsBkOcRBFJGcTAJJvv9
         Nb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008361; x=1696613161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjPcJpinx/2oZi6yDOcic02ZSonPgH6LaRKRfAMz/Qo=;
        b=AXq9VaIiuqeM437z8d7A5TF7CDO37ha5TgMsI3CKUIjMj28A79ZUkUWSM6oVQbF6b8
         g7UFRtjPzgauaIJHphfVU58E7jgJTHk20o4f51l5OjYgbRqRe64cOvfrle+zQlDzdn2B
         aTmYr0dsAAO4hqjRhOmMwsuGUuNxweGnn3tpIehUNwMFsgGmMfe4Ph8p/2uBnWolEgyv
         w/i5c/YJXWSMWIHJz8lgriZLvRWY2zJTt4n7mqdN2MS6xvl0V0ZHpUvXIo7Qn40QU2ax
         h6reS+5xyjpRJwxb9xO40pn/ZHBnAeN2mBx/AHEmDoM0bkt/l36v+ASkHjG/+uNZxNs0
         8lAQ==
X-Gm-Message-State: AOJu0Ywm84OYK3LdhlKPM1D/UA1OArg0xFTDjhiMoF3whMYsQizW9ucE
        XVBEktTg8afis6EXxwN/X/rbfQ==
X-Google-Smtp-Source: AGHT+IEU7xTxC2XhMOwTtgm0vgklQ781pNwhnGaa2Z5tu0SKY+s5O96AmKgrtXu11x/eKzuKi97bUg==
X-Received: by 2002:a05:6830:11c6:b0:6bc:de9b:a3e6 with SMTP id v6-20020a05683011c600b006bcde9ba3e6mr5194286otq.24.1696008361316;
        Fri, 29 Sep 2023 10:26:01 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:00 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 16/27] staging: iio: resolver: ad2s1210: read excitation frequency from control register
Date:   Fri, 29 Sep 2023 12:23:21 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-16-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This modifies the ad2s1210_show_fexcit() function to read the excitation
frequency from the control register. This way we don't have to keep
track of the value and don't risk returning a stale value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes: None

 drivers/staging/iio/resolver/ad2s1210.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 28ab877e1bc0..b15d71b17266 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -76,7 +76,6 @@ struct ad2s1210_state {
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long clkin_hz;
-	unsigned int fexcit;
 	u8 resolution;
 	/** For reading raw sample value via SPI. */
 	__be16 sample __aligned(IIO_DMA_MINALIGN);
@@ -206,8 +205,6 @@ static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
 	if (ret < 0)
 		return ret;
 
-	st->fexcit = fexcit;
-
 	/*
 	 * Software reset reinitializes the excitation frequency output.
 	 * It does not reset any of the configuration registers.
@@ -232,8 +229,22 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
+	u16 fexcit;
+	int ret;
 
-	return sprintf(buf, "%u\n", st->fexcit);
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &value);
+	if (ret < 0)
+		goto error_ret;
+
+	fexcit = value * st->clkin_hz / (1 << 15);
+
+	ret = sprintf(buf, "%u\n", fexcit);
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
 }
 
 static ssize_t ad2s1210_store_fexcit(struct device *dev,

-- 
2.42.0

