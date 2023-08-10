Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1ED777490
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjHJJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHJJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8526B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf9252eddso106234966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659930; x=1692264730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHWdkbM+7ZfvxLvuZfyywN5injb4OO3pSMCFeNjZHaA=;
        b=YUvcmNo4jkdgvxoQpFTM+gxtuS72TueXZ0eCikzmByc+0NS7Mx7wLyX/E10H/Rc9PI
         1WmkWKv4Luv48o3x3m5mA6Jl8OeB31ZzNTLQ7g9XbpPDpfNb11FtawljY1nHd0FRJ7ym
         moekucrw7Nq806QSzXbHPlTcrhJrv+FCO/oP/RRu1BQaH78Jl8pIZeP3tnYM/mAg5uRN
         UsApW7tSmAYFhv0ACogECb1XS45TFbWWg2cz8XaqNlSQGEYEAP0MalwqzUb5HfKr02yf
         FO9xdJ+K/h/9Ueh2N74OvggOiyFAC8Lo89jbK/n2LK6moAtK9ozJ/3f175vcLh8pr+FV
         X3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659930; x=1692264730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHWdkbM+7ZfvxLvuZfyywN5injb4OO3pSMCFeNjZHaA=;
        b=denHyrmiabrJZvdt2tLjfeh1YuPgxKSqElNl+h2MJ45tq72CPMafg6/qk9vtn348g0
         H7X2+VM4xmeSMX217g79VSwRoHjr+tdtyQTQ+zeRZOIL6y1LuOdgbwXPpdvweBADSLUG
         yzighCtEFro1etVUqiXQz0Hr3gABhNO/Q2/d1so5JsJT+tQPzvYq7b20Uv4FU8IdR3Hh
         I/qTK4k6uMqzThtT3f7clXyy4jBsKj70L/OnwUHDbwS2rqALUjRsR2k7zMhUDPUuCFCp
         XTx03h7OICNF6XDFfWBQnh3aMj09iFN1cN8oqvoV1JSDtO7XuIy0puh7QCnlowhRo7s2
         dOCw==
X-Gm-Message-State: AOJu0Yy6VfaiZI4PI9c1XJthrqbrCcRskrPGa96BYAQT4itpx6xPRenV
        WzH3jBklv5plYJrW47C+yYZCTg==
X-Google-Smtp-Source: AGHT+IHuGUw8VTnexYXJT6jqzQbYroYWwFnDwwktZr3BzdgYhY2MKLkxj1JWQtIwgoSB8+sSJ6spyA==
X-Received: by 2002:a17:906:3085:b0:99b:f534:9bb6 with SMTP id 5-20020a170906308500b0099bf5349bb6mr1849287ejv.9.1691659930635;
        Thu, 10 Aug 2023 02:32:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/15] hwmon: (lm85) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:49 +0200
Message-Id: <20230810093157.94244-7-krzysztof.kozlowski@linaro.org>
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

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lm85.c:1562:16: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/lm85.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 2a62ea7b25a9..68c210002357 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1559,7 +1559,7 @@ static int lm85_probe(struct i2c_client *client)
 
 	data->client = client;
 	if (client->dev.of_node)
-		data->type = (enum chips)of_device_get_match_data(&client->dev);
+		data->type = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		data->type = i2c_match_id(lm85_id, client)->driver_data;
 	mutex_init(&data->update_lock);
-- 
2.34.1

