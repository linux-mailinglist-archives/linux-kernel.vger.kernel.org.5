Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C877748A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjHJJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjHJJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42023211F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so143622966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659926; x=1692264726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q43IRXyNbrBIwroOAlFtG5izxl0H/94YCjrUhPAxdw=;
        b=ywaS8tWeRtAjsVEaSdvCAxAIP6EmjKFfZMbZXfScIzvFOi0f2cgMIlyPNBRa5gms4e
         4MpRrBPEcOS4LTVal9/lLNpo7FKDMaM1Xov5ioFCCbwKED2Z1n1+38fa2C8spTDwDEF3
         9xeVNtxfridVUcFzFM69wBk5kh0v+qyCgRK94S/tWhsvqCspmb0J/xHtX2qsL8222F25
         2SLCwrJRs4gqYXH0LUktYImwEfXtifb2Cx1arZiZkIxkBFefMyiLWahMIInbrOWFrz0c
         uMfk0r1sHtDQe8Jl5NtZ73kRSZdKjwGmZyj8R1pFJOdG7yCRAPN3EaG6mqlNU/LBGuKP
         GmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659926; x=1692264726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q43IRXyNbrBIwroOAlFtG5izxl0H/94YCjrUhPAxdw=;
        b=h7BqkbjepuvEaGY/wW0Q870zzHKzl/0waxa5ZTdjQQ0KZIoVneU+sST0nXUlLve08A
         N10FBL6MGi9251dqgC+OVAYhOmsJfZvF20y/bDH+L3nPNrE6maVthl2IqodvdxvLrcFD
         j+EvKABe54xexVXPMTusVRAgDRQEyTRrZYo3Cqxb687bK9U+ahkFxvf6Fb2WZQR50G4N
         svPLfugTN2sqTrl44kMHt+n6PObn3pM18ZilLw5gjmgOqBzWulk0X/nviL/qndMseMZN
         G3mBDzTD2JXP1h1VrBAfvGAAAdplVURM6t38Fp8Q6DECZ4VNiVSkgxZzVAy99r1Sq5MV
         hUqw==
X-Gm-Message-State: AOJu0Yw/LvmojhnvL2Z00PZp3dkkgZzfhDOdz4fFGitXtFehPsdRtkRU
        7N/BAlxcpsaknomn2Bd5nDHIwg==
X-Google-Smtp-Source: AGHT+IG4f8sdYrymJmlh3DGEKzR89+ejP8EA/xmsdDxbX4Ig/rrClWihBKkwsv2QB5CbAjyw3AmDkg==
X-Received: by 2002:a17:907:2bf9:b0:98e:370c:be69 with SMTP id gv57-20020a1709072bf900b0098e370cbe69mr1877295ejc.6.1691659925827;
        Thu, 10 Aug 2023 02:32:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/15] hwmon: (ina2xx) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:46 +0200
Message-Id: <20230810093157.94244-4-krzysztof.kozlowski@linaro.org>
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

  ina2xx.c:627:10: error: cast to smaller integer type 'enum ina2xx_ids' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/ina2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index a47973e2d606..d8415d1f21fc 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -624,7 +624,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	enum ina2xx_ids chip;
 
 	if (client->dev.of_node)
-		chip = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		chip = i2c_match_id(ina2xx_id, client)->driver_data;
 
-- 
2.34.1

