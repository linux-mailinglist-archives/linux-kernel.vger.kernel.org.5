Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1CA777494
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjHJJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjHJJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC715270B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so837294a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659933; x=1692264733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dbxV8jDAq1EoaltQOufp2JeN4AM753+j4I8xFIO03c=;
        b=a/mebC3vqRxsk9e1v8FTIdm9XQg37pDn0sUWwIs+DasXgmnpOUZv+E3+yNXDTn+nPT
         L+Wq4EwAy75iQwEklQsHlOG3xk3AiA4sUcOkZSKqmXUZkAZShG5sdt7Zv101JjG1db/N
         1cLYxwQxCRr6Cd8tLjMlZ+8rJjt7RR7Rr2z4sdaQkk2ETuoH08NC4x692Q9FWCbPzzzX
         vNdWLzrYiuH53yrtCwNk98laH1KrBxrl9vJ7ypNDG84iZZCV/p4g70r4/XwtlouqNKg5
         9UMhfcbs8VpwkySUumaVbxIRo2B7vbQF9SDoxHbKG+Dv8Sw7rCokfjPVS5orm6H6t7ZB
         3ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659933; x=1692264733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dbxV8jDAq1EoaltQOufp2JeN4AM753+j4I8xFIO03c=;
        b=dm3TddKVVnXE5Ms8rintvYqWGWxU7zNSb0TTApDGTl8m+CfWezLhWmiCNSyFV8xOVF
         zc/3xM9KRw3LMZL/4bmEl5ApXcjty03xch7yyvFiEjPJo5U+4E9Bm3T33ANulcFuujfo
         OMQPTTTfLB1M3MpsEYhzUOuXr2+xS0vxtqXSbmjilngSqAMI3UJG+PhlFEvbPEBTQdOn
         vBPB6ysF3Odu6DcQkHKfdveTnbjFVi12XM5oKcGbS4D6iShrvnROwFfrTpxCteZRh0ld
         i7pvWFsgooKhk+i4KFF3f4A2gWxfUSchy2YuDKL4+9np6Y5zbTnaYIDqwObTXEm/5vSY
         kx6A==
X-Gm-Message-State: AOJu0YzQ1VBhtHdShMJ+gSYQLDprpdZKDaSrZCs2+as4d7PdiJ11vVut
        fn9uE2f+T/bp9asf2EML2wZ9ag==
X-Google-Smtp-Source: AGHT+IG2az+RAiVp2KExWlf7/p/MwX3vfYCfcUUu9zYOMvNF3+CzvFrw09GKvHuTr/qMJrKkoz3zGg==
X-Received: by 2002:a17:907:7622:b0:993:d536:3cb8 with SMTP id jy2-20020a170907762200b00993d5363cb8mr1496599ejc.2.1691659933435;
        Thu, 10 Aug 2023 02:32:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/15] hwmon: (max20730) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:51 +0200
Message-Id: <20230810093157.94244-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'chip_id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  max20730.c:719:13: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/pmbus/max20730.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 6df4c5b75bdc..d56ec24764fd 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -716,7 +716,7 @@ static int max20730_probe(struct i2c_client *client)
 	}
 
 	if (client->dev.of_node)
-		chip_id = (enum chips)of_device_get_match_data(dev);
+		chip_id = (uintptr_t)of_device_get_match_data(dev);
 	else
 		chip_id = i2c_match_id(max20730_id, client)->driver_data;
 
-- 
2.34.1

