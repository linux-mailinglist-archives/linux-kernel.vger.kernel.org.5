Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA40777496
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjHJJcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjHJJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78B2709
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9936b3d0286so109488966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659935; x=1692264735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAPHq/2faQFRdHRdxnpVtoGa5K248Zp7jEovND6Y81A=;
        b=re6V8ITHblI7w78bDJokneVY+PC+NFRy1eshKTlyfmqn9rli8ias9Vn7D0SvNK65Uz
         brXj7fHpcGmZFEucTpyQBsvTuqXpDYoDx9xRMpdcx0IENOtbMJIxZCPCG5T7C3JtewOc
         PaLXDPMx26QqxGCNTAYPOqK8lNrj3zw2SQmZyckxf/yJzT1GzV/a3wnYaNNHT/IM7jSC
         LTv3ncISPr++B3Gc2eu2fGrUQwm5Jmxss0c66KYml/kI7k+xpfHWs0kn3x83JNGki+WP
         leyn0gxPs1EjKwxR2iruoCLdVcDJwz+LkXvmcxD7EY2E676VWL4nFPuXl6SjTBuCEjsw
         p8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659935; x=1692264735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAPHq/2faQFRdHRdxnpVtoGa5K248Zp7jEovND6Y81A=;
        b=JQAuhB2hiCaaUa/3YK1ERgsbVJdl+X8N86oBd697Ar1SrumVKchdV6dk2Be/dP04xY
         LClcDyz8UD7+i39dUzmbhoChTWPXmdh+pI4Za8wEZy4hDlljSxsowAgYcR24NF+FeIa5
         y9895sbjNAJqr/M1Z1FY/IJvRC+yZoiSot5SLWpB3Rqd3cZ6SbxIQ5fzt0JfsYGNhyGg
         gtaRK+99i7XiWVOsyZ7/UZLi+eu9re6QcSxM6Pe3x2w+9RFNNPhKtOxRPFgRAUj2o0JK
         ZlkWpcq16+bLSjEp1q3An+/4iawPRTtmBsYLJkWO0WCCmNkGknM/Pg0ukBJJFxuQdFkF
         KTDA==
X-Gm-Message-State: AOJu0Yzp32CWwen7KhT2tIlqnHN7TS07lQfxula16qH6ZcCG2TyC/q91
        fCt12KjxKT66vi4BSNCAtj86wgHOZ7AF4XaGzg16gQ==
X-Google-Smtp-Source: AGHT+IGXKlrxS0Q5Rl796sQlZfblf5KJ4MGAJVbPagX2emYOTc9mrjotrYOgLX7CAsWEGntK68/M5Q==
X-Received: by 2002:a17:906:cc0b:b0:991:bf04:2047 with SMTP id ml11-20020a170906cc0b00b00991bf042047mr1667208ejb.14.1691659934804;
        Thu, 10 Aug 2023 02:32:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/15] hwmon: (max6697) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:52 +0200
Message-Id: <20230810093157.94244-10-krzysztof.kozlowski@linaro.org>
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

  max6697.c:705:16: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/max6697.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index fe826fcf9990..7d10dd434f2e 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -702,7 +702,7 @@ static int max6697_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	if (client->dev.of_node)
-		data->type = (enum chips)of_device_get_match_data(&client->dev);
+		data->type = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		data->type = i2c_match_id(max6697_id, client)->driver_data;
 	data->chip = &max6697_chip_data[data->type];
-- 
2.34.1

