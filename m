Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FB76574D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjG0PUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjG0PUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:20:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30E273D;
        Thu, 27 Jul 2023 08:20:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so16018811fa.1;
        Thu, 27 Jul 2023 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471212; x=1691076012;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqcR5puT1EdjGVb9gAZcFyu524POY6u1/1h9aOnJT20=;
        b=jdUPxzFmOULUSJLp83KqTEH/h3lYyK43L109D1E6yQjWYLI954sm4kWvl9m8/FbbAd
         BdBGjtT4a8CVfzQX7LRW1u2JI4K3g5o/sMadm3ES/IOVS7qHp013VOA88l7ISDMQCAxe
         ZgiNzRb4gNZGJ+Wz7kJ/bMHulECqFAbu9OTU4SRcYhIZBey3heGIDswup7Tt/qDlzJie
         oDiAeaOoYYbKxVIumiBw92dH5bDpIdUfRVjWq3cMdZDZUulWDNV30BqfmR6Wu0a+Oivo
         tKl3o3Ak+xs8GPUOUGGBL8ehytXnjjiYCSrR9KqBZnINk8UypQdEA0yz58zRg+G16SH1
         DkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471212; x=1691076012;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqcR5puT1EdjGVb9gAZcFyu524POY6u1/1h9aOnJT20=;
        b=FVDVJw7gK6ddPVlh42zsee2yGU4uEbkBZTmRlBFgZZk4ul4gqxW0jDPidCRHD0DzTL
         Ic11iirfQ44xJ7I4Oumc1DLRkuAI1zilNtlSycVNBNs9/pt/qRa0jmSutff+zB/BxMKv
         Hb7dvR0hEtitKuM13Mq7ZC8PjgZwQng3fHKVGnebqzLWOV+UooG1LW85wYkCd1c8SXk/
         7vW7AnNNDFkwl0mtdAnEAjILkdmSg431mDOESjFZH7T16eDIqck04HED3v9a4aG9PkiH
         Z8dXvqEvMLyOMYki1mO6E5v6xlHr0b8p0uifkSTKQxHGRbBG9zYzHZjlNVJ0dwwQYqji
         BmTQ==
X-Gm-Message-State: ABy/qLZMCE93HUX5XsBpnJZsvFTAnijuUos2v+7DcTjVPTkTX1h1Nnzl
        kdrYLQXIpgJjpEO76K12ONA=
X-Google-Smtp-Source: APBJJlEcRhmgBfbGju1s6tRonzry+Bh+VpjleHGlMg7sjPKOjD8O5gHV3wzbJi3LlD67/nOGr9f4zw==
X-Received: by 2002:a2e:a1ca:0:b0:2b9:5b46:2107 with SMTP id c10-20020a2ea1ca000000b002b95b462107mr1972980ljm.9.1690471212218;
        Thu, 27 Jul 2023 08:20:12 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d4b4a000000b003176c6e87b1sm2247664wrs.81.2023.07.27.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:20:11 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:19:57 +0200
Subject: [PATCH] Input: ads7846 - don't set ABS_PRESSURE when min == max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-ads7846-pressure-v1-1-fa74c7680191@skidata.com>
X-B4-Tracking: v=1; b=H4sIAByLwmQC/x2MywqAIBAAf0X2nKD2UPqV6GC51l4sXIpA+vek4
 zDMFGDMhAyjKJDxJqYjVdCNgHX3aUNJoTIYZVpljZU+sHXdIM+MzFdGqXoMcVHaORuhZlVEev7
 lNL/vB6SDDEViAAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

When the optional fields "pressure_min" and "pressure_max" are not set,
both fall back to 0, which results to the following libinput error:

ADS7846 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE

Avoid it by only setting ABS_PRESSURE if the values differ.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index faea40dd66d0..2535424a5630 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1281,7 +1281,7 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	if (ts->model != 7845)
+	if (ts->model != 7845 && pdata->pressure_min != pdata->pressure_max)
 		input_set_abs_params(input_dev, ABS_PRESSURE,
 				pdata->pressure_min, pdata->pressure_max, 0, 0);
 

---
base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
change-id: 20230727-ads7846-pressure-05edfb01887f

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

