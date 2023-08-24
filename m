Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E178762C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjHXQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242786AbjHXQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:07 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DC19B7;
        Thu, 24 Aug 2023 09:56:05 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44ac60aa8f7so13172137.2;
        Thu, 24 Aug 2023 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692896164; x=1693500964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esBF13BrUv5y+F3I1Lk1p6aSN6Vu/6bv2mS80/UFBRg=;
        b=EFTYlIoo2fZy9R0Lg+/OzPtUx67rvcjQBHw3wNJr6p9XkfSWbLk39w14Oe4Y7o/eDL
         KsCCOfqXFhhtNtLD0IaCDYWXhQ9IxZ9AzPjw9xeIk40xZTOzb/i0gHXcOmuZE9+LGcqv
         fm2aQ5uRbpxO0MT4SKp81kAJFK1OlLxVOLFnUp65UwuyVyoOxk4a4SQ8NAuhusseVNyf
         jccNwsXHyC4iwuLKOdiINy5kYLhg9YYbUAdJEKoejKndPCPsYfFrhoYNhLoqvrxTOIph
         F2dWxvHQvT+YoHva9cr1eMhy5Y8duLutqqHl+3jhghclHqT/DGTWfAHvICjNURlScII2
         95Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896164; x=1693500964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esBF13BrUv5y+F3I1Lk1p6aSN6Vu/6bv2mS80/UFBRg=;
        b=OG19C3wsOvbjQXyVyi6hwhP30/f/vJfkJ2WtkNwSJy4AeIU0lK8stYhBvIm2wPHoB1
         ObqX0arSTOYoAaOKRKeKOuFIGRHb4LEjuT3RgfujEb+Oeq2e+qjF5xeMkXWDDXb57HZq
         DohxBrMHpQuRiyAF8rnpX7ifPXfKTQfC26gnCztkl6FCIdNzcwesBiGhNEB2mGtopGB5
         445YsrNQFpJ8d/SwmnNMlFEY8rabuq7f49xq/AZW8U7/NsOKj604/k8toAomN+f6CEEL
         xs2g+TqG4tMLrLzn05em8YOhhaQIZmrfx0NsCVULc+XZo0HIH3t18vW9+exk/1b0CQYz
         Eidg==
X-Gm-Message-State: AOJu0YyQFpod1QUyrAeEcstipYMOcVSTyLYNZJcyIrSHnJW1NWNMvwpv
        a7V8w3tR3lZ9H0dFSA+f2iQ=
X-Google-Smtp-Source: AGHT+IH+IOnAXB4bItQzRWgzgRkDLFgsJlCdkX7ibkmGiNc80oFTtJxWAl4DeBE63+mngGENfxNb3w==
X-Received: by 2002:a67:fd45:0:b0:444:6b9f:5229 with SMTP id g5-20020a67fd45000000b004446b9f5229mr14493701vsr.29.1692896164441;
        Thu, 24 Aug 2023 09:56:04 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b0064f4f14aecesm2225654qvl.24.2023.08.24.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:56:04 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Thu, 24 Aug 2023 12:55:31 -0400
Subject: [PATCH 2/3] iio: adc: ltc2309: switch to new .probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-ltc2309-v1-2-b87b4eb8030c@gmail.com>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
In-Reply-To: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692896161; l=844;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=sPlyQAKx4JrWIw52pWeEPQsyzqXWhAaeyfAAnEALZkQ=;
 b=OCr9J7ENvXsdhyaI83HE2LBhQ5XGjTEZMK/SL58b0xBr+esP9SS67fXHooRCiQ5ZGlE5cPpUb
 LQFnpah+LX8BCXtA0P2Q/se1Y8tPOVTbZIqNl8GaohmgLS8Q/gb7NqY
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the I2C subsystem removed the id parameter of the
probe function. Update driver to use the new prototype, and keep this as
an independent commit to facilitate backporting.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index ee1fd9b82e2a..d26bbd70b0ff 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -158,8 +158,7 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
-static int ltc2309_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;

-- 
2.39.0

