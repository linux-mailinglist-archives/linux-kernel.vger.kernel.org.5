Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2959A784A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjHVTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHVTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D370E51;
        Tue, 22 Aug 2023 12:20:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso7405943e87.2;
        Tue, 22 Aug 2023 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732051; x=1693336851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OSRGOC3tIaTalTuypinH2gqFn1Z3/HRcLvUrZ3+KSU=;
        b=Mrrh0aFPHqnQMzAOU7V6CCDtPVQT8A0Qx+6iQAwYtVbX079olKkPQ/bgSRhXgaTfsl
         Q75pc3gusYwzZNHZepV6uzqetmlvhNSO20FLpn1xw46OFXKJ4Bj/tciddpE5004sSPmp
         JQ1FfJHJu1fuRQ6qNl8SBVh0mzO8UuUh1eL/GHc+tar5fPuhvB9BY3o0EkABh89qNy1x
         4KTaIFppL1Bh/W0hlL23+D3PRb8unikZv1Nwk4nEdJiahHwJpnSrui8XBS+Wpms7XZc/
         FOy7P33M8NAzYRJkQ0JJi8wNkHXEVhpLYMi6obL7RkYXOXaPl/PzqpgV2UtOS5hY7lhG
         DsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732051; x=1693336851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OSRGOC3tIaTalTuypinH2gqFn1Z3/HRcLvUrZ3+KSU=;
        b=c4BVJVTbnDWo0zC10e5s5/P4r1HPJzJYZKS3UtiG/dajPaZvN76bksN0L35vZmkF0C
         G0UrMV284Y4so9hIHzgFTiCV4VBFT9jCmbxw7QQ1vOunIqUaMTEcdxcOtvbi1ooPz+Pb
         queMAX6uYWzAinvTMFVTaiOjdPksc0ImAwES4mYWkOPDutU7aHP8WexxspbPuA5eLn8K
         h0SyaXFaC5cxNOOW0Bb5xinuGeKfBCwieXtctZ4xcvN+UOxfuLlK9e0vd5rj7rknWIzs
         s9PSgVoKUw236Uje0SJjOHZZsxwcoyobgdDAKpKzjOyoD/DMjivqBN7TxZWIjMS0Fhff
         Cmtw==
X-Gm-Message-State: AOJu0YxD6hRq23ahnsjvEX0SGVVPUXer9z7bCijtvCSAQoMrTA2/l+8I
        swaIjyTAiIpEUHl3cIP2zDk=
X-Google-Smtp-Source: AGHT+IEIHIldbQUo4A2UA899/PBQjDUmJ8PoI96WAyy+lHMeca65fO76hQ/t6lBWxJ9sJgIfXG8VgA==
X-Received: by 2002:a05:6512:3241:b0:4f8:6dfd:faa0 with SMTP id c1-20020a056512324100b004f86dfdfaa0mr6538052lfr.2.1692732050628;
        Tue, 22 Aug 2023 12:20:50 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe89735f1asm450586lfi.34.2023.08.22.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:20:49 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/6] iio: adc: mcp3911: avoid ambiguity parameters in macros
Date:   Tue, 22 Aug 2023 21:22:58 +0200
Message-ID: <20230822192259.1125792-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name macro parameters after what they represent instead of 'x'
and make sure the evaluation of that will have no side effects.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - change 'ch' to '(ch)'
    v7:
        - Reword commit message
    v8:
        - No changes

 drivers/iio/adc/mcp3911.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f9db08813645..281cc1211fd6 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -29,8 +29,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
-#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
-#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
+#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * (ch))
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * (ch)) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ		BIT(12)
@@ -51,8 +51,8 @@
 #define MCP3911_REG_GAINCAL_CH1		0x17
 #define MCP3911_REG_VREFCAL		0x1a
 
-#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
-#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
+#define MCP3911_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + (ch) * 3)
+#define MCP3911_OFFCAL(ch)		(MCP3911_REG_OFFCAL_CH0 + (ch) * 6)
 
 /* Internal voltage reference in mV */
 #define MCP3911_INT_VREF_MV		1200
-- 
2.41.0

