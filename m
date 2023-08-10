Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7477749A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjHJJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHJJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA52D40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bed101b70so102714566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659937; x=1692264737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7z4Syk6Kc3ZzVPMxaba4/zHmV32qqbPQTetDpsNyfg=;
        b=GkX2UOPCjS5i4pCGriaKQrDIrthcnHQzBJI063ghyBphmn7uLsR/zwgt0qdZFvJK3u
         ja8la5nmD3V/LZsAzWHRSCW9CPnrk1K6CT2dNRM/OBP12GDNhLof9IsMuHxSjm+Eyis3
         KdrrCLglWakMyijgEU3w4NxgMQ90TlIeHmL0x/w9zHvwJcMkPP7Qt5wWy5+EKaNsL6DS
         crnywPkQ20rDByE+ueturRU72Opbxbnk4nrDNOmQ5BmGjfEZMtLJQAbg2wyXpztUXm2c
         jhWrPPetG7TEmcCuh6aNFN0T59nDRu180tuPQ2PmSXc30GW/ablJdsW9qDpLyAzfinsi
         /G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659937; x=1692264737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7z4Syk6Kc3ZzVPMxaba4/zHmV32qqbPQTetDpsNyfg=;
        b=MH2DGuCyGuVBPtEZxDOZIVDUld0G/Rm4XU9cd0QGL558pI2IVsLGLO0caYgj+WKRe0
         I1wEYGqlQy9NBihlc6Ls07LV6PosRAR0usVm1c/g3cUWO7mTEZqHbKoQ8v7enV4UExzo
         cfCVIItNQ9CR5xEk6AXdrSXZ2rf905OUZm8cvoCIpBHfNXrh8Lhm3AOYd8xsgRUvYPT8
         Yr4hpig/xCmMVNv2aKK+CTPuDPg/XHD4BR+qO7JVS/+i1rQ2NRmI6ufxdPyG6UEkp2fr
         NS2l6cAhLXLHosJzywvufDtyuZPibi6S60a0warFe021Rqdhtib3dKiy+JJRZ9vby4XY
         be6Q==
X-Gm-Message-State: AOJu0YzpDf6ORQjOk8Ji5yNH7/9gHQW49hLWtPfVdblb9GBZiFcOYfwZ
        FIJ0AnAADgpevZK+HoHRqTWSFA==
X-Google-Smtp-Source: AGHT+IGfkD1OBaq0SF/L7Hmb6rUDvdLJKCcLd0lwn6cW8ToP7m/fkwTkVwiGv2XmSu8FuLTXaVnwew==
X-Received: by 2002:a17:906:5daa:b0:993:f996:52d2 with SMTP id n10-20020a1709065daa00b00993f99652d2mr1511716ejv.20.1691659937736;
        Thu, 10 Aug 2023 02:32:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/15] hwmon: (pmbus/ibm-cffps) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:54 +0200
Message-Id: <20230810093157.94244-12-krzysztof.kozlowski@linaro.org>
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

'vs' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ibm-cffps.c:492:8: error: cast to smaller integer type 'enum versions' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 5b11aacda4d2..1ba4c5e95820 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -489,7 +489,7 @@ static int ibm_cffps_probe(struct i2c_client *client)
 	const struct i2c_device_id *id;
 
 	if (md) {
-		vs = (enum versions)md;
+		vs = (uintptr_t)md;
 	} else {
 		id = i2c_match_id(ibm_cffps_id, client);
 		if (id)
-- 
2.34.1

