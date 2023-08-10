Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC4777497
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjHJJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjHJJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB783213F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso839863a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659936; x=1692264736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRt2wJT+y3TcPVT+A8n4hP2Nq8Fhpdk7oZd4Q1inZS8=;
        b=CimkTe7EIvNJBUwMLxH+aTzxbqFP6lv/uxA+9GH0SaWlE6VMOI3BDO+mnyPkxP8DSO
         QJ5RWQBrL7bx0HyGIELlKcreQUrp7MyHxMmkDmytP0ptLOk5tysPCdwmXWMOZeNuUtQ1
         bszfqFWvQEZNlnt51BRCFZMPphC449Sa6t3f6SqUvVXaZSLzWTbtcH54jTxW9RuChd0R
         VT5aUN5eietsVi41g+uAkLlP346IIqBEZyUvmlrRm9EyDQr3EEqsq9AAHFGQ+R37X0f3
         PVQBNP0/TOoZBhdoQVQKlMFVKRsNMzOrDt0M5fux5Bfd/IgqIL5mZEZP9kYKsqoM3NDq
         7BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659936; x=1692264736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRt2wJT+y3TcPVT+A8n4hP2Nq8Fhpdk7oZd4Q1inZS8=;
        b=deLisMOoksKgKXfYRo/2lpr2fBLpImLjeaxDRSfIqvC4KOR7Ca92s9Y60/ooQSwrJb
         X+mkeXuulTLwDamb6VTTbzVW3vJg4hB081TPI8LpIHlxiPBYHVyAiHCmfzsZFC3GEGK7
         cUESWSJ3BGMKImosfaoB29/HRw2RiwmOoKmGbvYZzsKM6xt7+ymLVsvyvmoh54Y3b0Ah
         qGyANmK39e1yxgF3XgGHUDO+VJe1TN2noQtp8Ccf3nvycjioYaerWG1OGwF/PBbu9Ogp
         q8H6BDii33fezvupWu5Rfhus9IsML/XEFzRsQEuvyeCcCVAzZ7cdrK9IBzsozBbV6rOY
         LeGQ==
X-Gm-Message-State: AOJu0YzPFMeHYJkepPOYF9VVXkOEQcwyHJYPk9Zz2bmAU4L4JvLzuAJe
        JtsIkzc0txLBVUgBvvIYQ56qHg==
X-Google-Smtp-Source: AGHT+IHCshYEE0RT24l9GzuoDNfzXKTEV3FWEYZU7QyVW43TzPBu8dIFF/ZkItjPZdyXdMal1SgZ/w==
X-Received: by 2002:a17:907:7841:b0:992:a836:a194 with SMTP id lb1-20020a170907784100b00992a836a194mr1624953ejc.59.1691659936251;
        Thu, 10 Aug 2023 02:32:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/15] hwmon: (tmp513) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:53 +0200
Message-Id: <20230810093157.94244-11-krzysztof.kozlowski@linaro.org>
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

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  tmp513.c:724:14: error: cast to smaller integer type 'enum tmp51x_ids' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index bff10f4b56e1..7db5d0fc24a4 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -721,7 +721,7 @@ static int tmp51x_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	if (client->dev.of_node)
-		data->id = (enum tmp51x_ids)device_get_match_data(&client->dev);
+		data->id = (uintptr_t)device_get_match_data(&client->dev);
 	else
 		data->id = i2c_match_id(tmp51x_id, client)->driver_data;
 
-- 
2.34.1

