Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272F97B38BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjI2R0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjI2RZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:25:52 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59DC1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57ba5f05395so5984411eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008350; x=1696613150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZs7RCyHEDyjwo9BM8JVP9aWGPKGhSjAg7KPK55tj0w=;
        b=jWcHhfOsleOJfNNW0K3SQhI2r+yv+Ryh5Q5h8c6w1qEIqM0OOPC0fpet4vidV0wQHW
         wM7Bn5y9FD1ehMufk1m0FEJGWEfauqpicIiIDOvdc+2DLHjP3j0SyYJbLCHo1Hz/mNZH
         Tw33MXuDjCE0c83riFFl754mWZhwOsVwKqHzUm7pNTQiMG/1xvWbxH19EgGNOFRMbU9q
         gE2aJFoyaciX/V9PiukCWEvgM4on1hWVG/7HodI88oIRjqo5gWTjN0sMtICTPD/In/HL
         Y+NblSQZQyKkCX1LudXIOxvdrl6nU/flo1oeLlTuxoAL+pYsueFvUCg+CdALBYWSzhz/
         oXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008350; x=1696613150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZs7RCyHEDyjwo9BM8JVP9aWGPKGhSjAg7KPK55tj0w=;
        b=VETpIFbQdgjFpQpZkV9EharrUkWnrYtxlLOKv3YPZro9jet5yX/gzRbU9pcM/r43wT
         5TYMRkjkG6/mMMRfAtnT4/cAlw0d9M9BdvK6LTzbR78X/S45u2k2SfDcOotBjPu17fcP
         Ogloeh4udL5NofwS/ARW1xUHo3egAX/iEzTXPnukyeLHJbsQVeKD36XqPKcyrCXMMVI9
         aQulOJqV2DvmHQWk7y76ep4Az5EshnbH8U5pBZbsXDxWdfhx0LiAUKkO/dR8Wil2fgAm
         PTwdL72PRV0E1fdjnTDu7KX601A5sv1BzLx8syBHvrF1+cTnkjb+9prTCvzntZem9+00
         vmig==
X-Gm-Message-State: AOJu0YwL7fWilIZ3LGMWzS0GY1m2ECDtBwB4+2fzzSVFFmR7ha/zGtbJ
        0SbxF8Is5poBeYtge//9Jrfgkg==
X-Google-Smtp-Source: AGHT+IEV4b51ilWN++n/0+rU+iGp7VHyBLZBDmjeuTWYmnl26MZ3t8X5p2iE4s9s18GyLz1K/SQJLg==
X-Received: by 2002:a4a:9257:0:b0:57b:63a6:306d with SMTP id g23-20020a4a9257000000b0057b63a6306dmr5249640ooh.6.1696008350202;
        Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:49 -0700 (PDT)
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
Subject: [PATCH v3 04/27] staging: iio: resolver: ad2s1210: check return of ad2s1210_initial()
Date:   Fri, 29 Sep 2023 12:23:09 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-4-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This adds a check to the return value of ad2s1210_initial() since it
can fail. The call is also moved before devm_iio_device_register() so
that we don't have to unregister the device if it fails.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a new patch split out from "staging: iio: resolver: ad2s1210:
 fix probe"

 drivers/staging/iio/resolver/ad2s1210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 8fde08887f7f..b5e071d7c5fd 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -672,6 +672,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = ad2s1210_initial(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
@@ -683,7 +687,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 		return ret;
 
 	st->fclkin = spi->max_speed_hz;
-	ad2s1210_initial(st);
 
 	return 0;
 }

-- 
2.42.0

