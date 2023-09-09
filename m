Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE27999F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbjIIQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346440AbjIIOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:35:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECC18E;
        Sat,  9 Sep 2023 07:35:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so52381981fa.0;
        Sat, 09 Sep 2023 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694270101; x=1694874901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iki1B+UVY8QtKWRaiKUBi6caCXXzC+9RSfzALEjfpWg=;
        b=Hke38LqH/seqsZ3Nv23kTm/xrlmuNO2TxryXv7YjBftMTcRkZaHXAp0g2viIksTfU1
         WrptBmd+44SdFUR1tG0zrweIHlPJ5Ngz1lGtSPArCIvW++o2jCd3N3wRlCBykzsOfyLs
         YVefjjKzBXlPMDfhEDJihuILWfomXARf4RugvnRv9CxXmvt7v+Gred1UlXICChUBWJ0k
         /7oi79hCBfHRaEjIs9BHYePPkSaC19Z+MQn0r6f/8fboegw860Ajm95Q8PywDyF4vQHA
         a8wpZzF+o754gdZCgqBx1/Nlm2i2YFlT1ccpQqlhG5P/7DFX3kGmc4dix2bptACYXVq2
         vGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694270101; x=1694874901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iki1B+UVY8QtKWRaiKUBi6caCXXzC+9RSfzALEjfpWg=;
        b=nmpXkrtszslRqE7FN4mZaIs9IobtKw0dvdEE3OKKspXRL+PZWdvESDae/IZ60+BzhZ
         8pqGJwCdIs+vzDNWN5zjL9lK3Uj5c/UlRPabLSw9RX7AVLjfQj0BXGHiU8bAUyX/Ha48
         r/d13aJ9muzs3l8DOENu7/KXfssm+Kp9LGdgbM9PYJ+79nVsLDa0EiWlRfuDjmlZVgIv
         e8KsuLzLwQ2kpYG6QboHf7oa5YvRstnCuWyKB/2rVq4ChrMb1tNsb0wWf3n0Q1fKUIj/
         bNgx7SBivpWd/1vxa7S8ejes4QBY6JarRrpQ2PQcdEYIZi46xD5fhDJDd7IRSter4xWP
         w3lQ==
X-Gm-Message-State: AOJu0YxctMJ5SC5HX56+GHiQBkbmJJDudKtzHvKfnUqQ7FTW25luNR2H
        nK62VVdp5bDSmyYkCDKqM30=
X-Google-Smtp-Source: AGHT+IHxPBbjRmcU9UUxIkNPf7aH/Onjp+K36K4TO618MMh3FEVtGgL/hVdmq16BuXaoCrtvWQiIvQ==
X-Received: by 2002:a2e:a168:0:b0:2bd:19c5:3950 with SMTP id u8-20020a2ea168000000b002bd19c53950mr4189535ljl.33.1694270101202;
        Sat, 09 Sep 2023 07:35:01 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0099bc8bd9066sm2433945ejy.150.2023.09.09.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:35:00 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 1/2] pinctrl: pinmux: Remove duplicate error message in pin_request()
Date:   Sat,  9 Sep 2023 16:34:56 +0200
Message-ID: <20230909143457.9149-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909143457.9149-1-jernej.skrabec@gmail.com>
References: <20230909143457.9149-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detailed error message is already printed at the end of the function, so
drop redundant one a few lines earlier.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/pinctrl/pinmux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 2a180a5d64a4..301fe0157b02 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -173,10 +173,8 @@ static int pin_request(struct pinctrl_dev *pctldev,
 	else
 		status = 0;
 
-	if (status) {
-		dev_err(pctldev->dev, "request() failed for pin %d\n", pin);
+	if (status)
 		module_put(pctldev->owner);
-	}
 
 out_free_pin:
 	if (status) {
-- 
2.42.0

