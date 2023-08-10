Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98EF77749E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjHJJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjHJJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE92D74
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso861099a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659942; x=1692264742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6MccEidlFrbXaCtF9Hw+fIgxQgYPx1+FTmvr+egMSA=;
        b=lTlsdFPpOrk1PmhRa6o5gwo+xV+lOGLPDHQbkbSIhi0hopb3J1UOxKupM8ToyN7hMu
         wtCr/r79A8SAFpahPqEp850BHLZSlvU+wEiCPtTLzISouSaGr92sZzsEyxlNH/RzO8PR
         ZoMpWaRZsWMpSyq9gAwyE8Db6yM/7hvA2eqWqrQef9Cr2lm3jsOAJ9KBkrR6yK7wIsd0
         AnUbcBGqetkpXrQR4I+DwtbpBN5NqnAsoSPH22pbFI+Nu8kNg5YRK5zu15TAqVbHe0yD
         eZaS6vS/cRUVQuSdQenjJC78wxeXvxOP6yftX99JkbCVms6olyipb87PGcyC6Iw6usq0
         PWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659942; x=1692264742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6MccEidlFrbXaCtF9Hw+fIgxQgYPx1+FTmvr+egMSA=;
        b=B3vqVxzu1AGe8/1WSeCsFrGM6VchkErWb0hhJlIlrfqJ02XBTSpOwbi6WXdjSnNWUh
         NvhcGAmu9JFQmwsYbewzKyuH5RHC43sL34E4XbG6OAaoR+X2p5nrpNZK6v91Z6o8XiSh
         +Zp5XYH+7XNgIkvTO8GGDGDKdLnZXLLzhtRLvOabhLbUyQUsjA8fr8uLNaMaF6SJbxZH
         3oJgWMXL1AbjTvPYnWp1ClMpj0uqZ2YNc2oqFjwvazv7rPYF5EL46f+7ZMOxnci7Sp14
         zh7JQxknZ6sozDGuM7RKAevCv/LuPyXbXUKocKdOImrPtHN0FB7PJxc+C+OH2WJvh1Qw
         WALw==
X-Gm-Message-State: AOJu0YwuzPE9dQufOdcdQ7BKcjlrb0niscbwiBjLXIRXyRAWJAgsTSXg
        +ocw0e3L2+5wYZ1caQMUyBEJSg==
X-Google-Smtp-Source: AGHT+IHK3Y7A+Uts3kdFgZJKKp9q6BtdcjNZ3xC7gdcT/zFV6kGQdOs1+X9Qni3xs6DKHL9qoAzk3w==
X-Received: by 2002:a17:906:23e9:b0:999:80cf:82fd with SMTP id j9-20020a17090623e900b0099980cf82fdmr1508234ejg.18.1691659942681;
        Thu, 10 Aug 2023 02:32:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 15/15] hwmon: (pmbus/ucd9200) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:57 +0200
Message-Id: <20230810093157.94244-15-krzysztof.kozlowski@linaro.org>
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

'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ucd9200.c:106:10: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/pmbus/ucd9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index e4aad64b2d94..7920d1c06df0 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -103,7 +103,7 @@ static int ucd9200_probe(struct i2c_client *client)
 	}
 
 	if (client->dev.of_node)
-		chip = (enum chips)of_device_get_match_data(&client->dev);
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		chip = mid->driver_data;
 
-- 
2.34.1

