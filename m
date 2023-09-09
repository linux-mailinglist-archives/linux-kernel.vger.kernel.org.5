Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AA79969C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbjIIGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbjIIGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:36:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBA1BD3;
        Fri,  8 Sep 2023 23:36:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so5796556a12.1;
        Fri, 08 Sep 2023 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694241377; x=1694846177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iki1B+UVY8QtKWRaiKUBi6caCXXzC+9RSfzALEjfpWg=;
        b=qQjULGVg7sG/LhdC9EHRZASfWrJCQMrbiK7LonFMMZaAeBn4DE9hKxifERey++fRmd
         Q65xY0Bhr4oTP2smv6wH0XNGdOwpZvsAQWXwI58DGXkdH0iEr5Mel1QWnRDJOC3gNcxi
         rmd9sozKO8oukWTM6W1yosFecZEPQxKL8lR5IsExuZn6zjqwFaSxRWYfXSdTqqiAMyiZ
         LpSHe4fnfcffU91TUlkn8oQHFN6aT5wDRPIL8eF0EnJ1rvy5x4Fp2DXBUCwjIK3Ai2S0
         q8ABgI04R0D5Sm0sQkmpnnzcP1x0DgHDcr+zGGHNu2Ku7qhySOGNEnXBuImm0yrtClhS
         1BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694241377; x=1694846177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iki1B+UVY8QtKWRaiKUBi6caCXXzC+9RSfzALEjfpWg=;
        b=GHT9nC6KHxlCF87ByFenj0ps8AkqO2yBIa84npEuaJxygNsVwUxBBkU4gOiBh321Z5
         Xb9/jFZ1Ln/SUdH0NQn0kdEJfpaQfisr2CEKWY6uLEJpY+xOiLUNAT2WJrq+tPxz4qCE
         jP8ZMLGeFRZyfy2y8wrP4UN09xxD2oulGqLwZ4Y3InUWZ+Ugu+h9NuFg7xHl9Lje1KFO
         JyVDpcrF4j3pl143fHIFOHUnZA/Y8ShQswq35N9vADk4It6iGjjYvZiI4igAfF7bywMa
         /2IUIDT7a+9/tXGcV00udvKJnkSCkths4K/3FEcZt8ZY5Yn8srtw00OSVyWhu12NalnZ
         jzLQ==
X-Gm-Message-State: AOJu0YzSmZq51UrxFFU7tlplTBE7PNnnWsJHKWczO5IO54WNMR3du/Ht
        8fhL9iot7khQ+qDoRb4yYYwddJ8qWZrnRA==
X-Google-Smtp-Source: AGHT+IH56wl7tfjV0QivCeTVZmUk0hnENTgwi9AMRXH6MYjpOvcwkeKM4shOdI9gRtSbg623OvDPWg==
X-Received: by 2002:aa7:ce0e:0:b0:522:2add:5841 with SMTP id d14-20020aa7ce0e000000b005222add5841mr5676078edv.7.1694241377279;
        Fri, 08 Sep 2023 23:36:17 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z26-20020aa7cf9a000000b005232c051605sm1817525edx.19.2023.09.08.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:36:16 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] pinctrl: pinmux: Remove duplicate error message in pin_request()
Date:   Sat,  9 Sep 2023 08:36:12 +0200
Message-ID: <20230909063613.2867-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909063613.2867-1-jernej.skrabec@gmail.com>
References: <20230909063613.2867-1-jernej.skrabec@gmail.com>
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

