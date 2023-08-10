Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF37777488
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHJJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjHJJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825E211F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99d6d5054bcso48834466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659923; x=1692264723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkJrp3SblDfFtU8UBVulMVwaS++B4Gjz65+AhL9Je5g=;
        b=p5Co+QHcKXiDm16tv14B+MoVn/yRUUsXSvj3aaV5MWoDdZkAeZ7lDRgQFUqTPo0ZHp
         osWCAWtP37rTALTSqyLgoBS2i+xhwifE4yAduqGXfN6fwJmINcCeVZu0oya1vUwzgsH+
         yEBJIhV2FTneqtFf5ins4phhXALmafN3gN8jpVjrRV10D+K22ctPOVjwKdDugCCl4aaQ
         5jQVvS4aL6nAlqjC37R+BLsR5VcBjjee2BVq1ufcoBZ3rROeOyNPyCbUNKyRjRbwCYvB
         +pRECRzwP9DfSMbb8CpLqpYckjyyOPzCoOVA4KvLoFfWZIbdL+QJFp1Ski/oIQ/nn7DQ
         vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659923; x=1692264723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkJrp3SblDfFtU8UBVulMVwaS++B4Gjz65+AhL9Je5g=;
        b=SvhsMjQ5ccQZxhFTwLuUOFdaZDM71HY1vXZTDNLDMiIrN7BpV8TzBOOKJpgfnYC5Bm
         29KG0xFwntikq3QhCtHdXkPRQK2u36nS3L/emzqQuN7CpWe0aemBz7/U0+btFAzoTt/y
         lT36MKo/vvYMC/cfD/bJtyjAw9dKo2ePIwkrWPtr5yNI6SXrOdwQZbq0i7M7aY28m6fI
         4zsReJcryYnDZMMLdiHn5/Ti8BsGvtvcEcGt+FXoz1pcJYi2LXEXBuHGJmPO4gtoMknA
         S3/IUAS9mSW/7oCxfD82Qc2Bs9ruIWy5ExarRpgoFxzbCGa/Bg4tF7DDLyImzSUrMbMa
         LiYg==
X-Gm-Message-State: AOJu0YwCOM+A/L5M2FyTp2Mm3Ki+tP4ptRDVd9djNKMEQdYoQMdxAmFH
        mxyifl3QOIlcb3xODPIwEOI6uBYMmC3S9fKz4fJiBA==
X-Google-Smtp-Source: AGHT+IHcbnF8r8JpNPNsUEVv2dwzGbMLuNzvjnp9AGlmJq39aZJBhXg5iIpgJf7cYShzcKhcWsMT0w==
X-Received: by 2002:a17:907:75f0:b0:99c:602b:6a6d with SMTP id jz16-20020a17090775f000b0099c602b6a6dmr1849004ejc.11.1691659923274;
        Thu, 10 Aug 2023 02:32:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/15] hwmon: (ad7418) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:44 +0200
Message-Id: <20230810093157.94244-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ad7418.c:256:16: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/ad7418.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index bcea66eac82b..4829f83ff52e 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -253,7 +253,7 @@ static int ad7418_probe(struct i2c_client *client)
 	mutex_init(&data->lock);
 	data->client = client;
 	if (dev->of_node)
-		data->type = (enum chips)of_device_get_match_data(dev);
+		data->type = (uintptr_t)of_device_get_match_data(dev);
 	else
 		data->type = i2c_match_id(ad7418_id, client)->driver_data;
 
-- 
2.34.1

