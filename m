Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521827D38A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJWN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJWN6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:58:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E997103;
        Mon, 23 Oct 2023 06:58:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5210a1515so50303421fa.0;
        Mon, 23 Oct 2023 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698069509; x=1698674309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUDrbA7z4Yp0QmwWdKitAt1oZzrzXyIRbjMblpzWv7M=;
        b=IRhFfrypKU/9/J53PrS8feiYQA3RT4F4YNkr5pMuh8paex7gVCCJ7IyMxH6eXl0B2A
         Z8LSQjzyCIiLqssj+UWe5ScEuh5oE0pl7wPMzi2Sg93LrkxXQjAVyUHgs69Izr6L1yat
         HwgAyDgfygL48hQUjT9rLiswjJk/6hGjGc+VuuUdsr8fQJB54rs0jdyD1txKobFdcLVj
         D/++hDlF/1MDdKhvvhM4BIksw0Khek+QVHly5HRPJ0KqmufWXGWxMUTh32eiClWB51jt
         xm5ESSs5Z4uHXh79UmaDXl1uYF0W+DkXDqnO+YQNRamkhQ3ThwpkLjrqmM/ARH6Hmu9Q
         ALPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069509; x=1698674309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUDrbA7z4Yp0QmwWdKitAt1oZzrzXyIRbjMblpzWv7M=;
        b=Exl5ijBB51ZO3oRU7Wh2iZZkQl+yJid7jrOF2O/Fc0RYtiZviJvby2nZhU6bbkDZya
         U1Kk0Y/4QcxVTp44vK/LdG7sTQX6KLc3YJ3TA9cqHiS77y9C8eN8FBttduemmZEDDh2z
         69F6VQ9cQPHfkj9HxFVxvKJG7iiO7iZozNRLlREy/9U6NsNMHMK014FvfgG+Bn+Ud3Xb
         PMNFn+ekos3WcRigjw3uicq30VbaJE5vfG8TUhzwCupYm680bbSEu2RYV/m967E7rkG8
         CFbParldH0ZpdCBmm9TF57h/HLhhou94LOx3wUuScnnSVN4kwWY7inSegpkzRMLagPTf
         Qgeg==
X-Gm-Message-State: AOJu0Yw20mKikhaxHIY3pmHSndglIseoIS56nzRZo4iTA1orHZezqMTs
        D1DRDw9C37WrVAY3d3kugaw=
X-Google-Smtp-Source: AGHT+IFpxu0QqbHhBmob+AtbXLwBK+0npAGP23JsRvRxF7fN5/siyppzBnpZkSSr5gyoGQ5H1TUqnA==
X-Received: by 2002:a2e:9b87:0:b0:2c0:3186:8efa with SMTP id z7-20020a2e9b87000000b002c031868efamr6612649lji.11.1698069509129;
        Mon, 23 Oct 2023 06:58:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b00402d34ea099sm14316895wms.29.2023.10.23.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:58:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andre Werner <andre.werner@systec-electronic.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: HS3001: remove redundant store on division
Date:   Mon, 23 Oct 2023 14:58:28 +0100
Message-Id: <20231023135828.667297-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the local variable hum is being divided by a constant and
the results is being re-assigned back to hum before the value is being
returned to the caller. The assignment to hum is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/hwmon/hs3001.c:65:9: warning: Although the value stored to 'hum'
is used in the enclosing expression, the value is never actually read
from 'hum' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/hs3001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hs3001.c b/drivers/hwmon/hs3001.c
index ac574e46d069..01ea9a3062bc 100644
--- a/drivers/hwmon/hs3001.c
+++ b/drivers/hwmon/hs3001.c
@@ -62,7 +62,7 @@ static u32 hs3001_extract_humidity(u16 raw)
 {
 	u32 hum = (raw & HS3001_MASK_HUMIDITY_0X3FFF) * HS3001_FIXPOINT_ARITH * 100;
 
-	return hum /= (1 << 14) - 1;
+	return hum / (1 << 14) - 1;
 }
 
 static int hs3001_data_fetch_command(struct i2c_client *client,
-- 
2.39.2

