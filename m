Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92A177748D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjHJJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjHJJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB78212B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so146732166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659927; x=1692264727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F09i0l4UP7Na+o2GZohTzvzQnZZ+3AbJJIDPlfRmGcQ=;
        b=mjlORp3OXj9jM0kA2FBRiItuE1/D5V5qjXlouH0IvN9DXGZ4JKLVPdreyMcxyiopMp
         GUHg7goI7Knq9sKzVj2doslyJZvKQgAkLvcjZkv1bThPmvV/hT3jlh5GxxpLF/K15Z+K
         Rs4G2mQ1b3AIScmblA1OfrAJbJmNZTJ+zUvbqAcrmiUY3dONspdxRzB3edccAQJLraHG
         Peyccqh5Chievi/wZ1y8LDhNbZj2jw2E6g0AyOjQDz66GfKhfzwNAjk+EjOANgBp/2Kh
         9q3Fu/S5PcqXra30SFTAGb25E0Z6inUTUspsdSvDlsIMt3lZ120iWURKvgcyUQ1fawr5
         UbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659927; x=1692264727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F09i0l4UP7Na+o2GZohTzvzQnZZ+3AbJJIDPlfRmGcQ=;
        b=gtbgiedDjJrO9iGDLvEqgKBiOTr7y445Z8cEzWah/OzIOZ/aR+vuxdxvK2GlNDrsRP
         PbKLknZJndcvvbtuzZwIdhKb1F0huQ9J9o2bZa8kMzOSzpKSGxOgNVrykIiXWMU8FH6K
         ivnR658q8W05dGGObpFnut7E4N9zWttjJY2c75LGyzBVKwddsuaJOZPd7o+x4IOPfekY
         QOUo4IiUAvsladw7hCPAYA519RCkecDe3X+ko7tuGy8tjNOJbaY3kpw1/fNi0OtoIOeD
         hQpt8Bly6eOCBjR+fZNQskZxVVUwXxw+oRmkpwouoNCGf3CLuhJYh5DdStSUegfqt6N+
         fupA==
X-Gm-Message-State: AOJu0Yy6X67aiAzyScYa1XaA2g6SepYUQa8OIZnlIB7VmFkC8XjjYEHE
        /PU2gtGDYRhhJBBpavMA30OjXQ==
X-Google-Smtp-Source: AGHT+IFGFwiQLw2MG/nnXOafiu7HJHisVwW+BYILR1XuAKW9+6kNSj2ag4qYnHdaQHjPqRps5ims/A==
X-Received: by 2002:a17:907:75f0:b0:99c:602b:6a6d with SMTP id jz16-20020a17090775f000b0099c602b6a6dmr1849253ejc.11.1691659927402;
        Thu, 10 Aug 2023 02:32:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/15] hwmon: (lm63) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:47 +0200
Message-Id: <20230810093157.94244-5-krzysztof.kozlowski@linaro.org>
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

'kind' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lm63.c:1108:16: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/lm63.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 562c94c7d831..0878a044dd8e 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -1105,7 +1105,7 @@ static int lm63_probe(struct i2c_client *client)
 
 	/* Set the device type */
 	if (client->dev.of_node)
-		data->kind = (enum chips)of_device_get_match_data(&client->dev);
+		data->kind = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		data->kind = i2c_match_id(lm63_id, client)->driver_data;
 	if (data->kind == lm64)
-- 
2.34.1

