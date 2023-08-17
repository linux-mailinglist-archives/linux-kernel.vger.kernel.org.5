Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74177F5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350651AbjHQMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350630AbjHQMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:03:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B8273C;
        Thu, 17 Aug 2023 05:03:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so121390431fa.3;
        Thu, 17 Aug 2023 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273784; x=1692878584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdwRwKvnz3Z20+s9tNz6mtV9CNaQwcE4bakky09bUQU=;
        b=haqmKJNllfHprykmSlGVEYKvCV+U4b0WzYKXVtO0ZJ8iCy5QYVUxWVq31HdDUIz3h1
         dvWOx0oiJfAI00Pmv/ZeLiLZ9B8FNR4ug1CkubsSBD5PZjXTQ6GrwZapCXw2eFz5tyPN
         pgzgzQFWyunbdvNt/fg5M1lmccJHvFT/lp1JKHpYNWloX7+UAv92c07Q2sXsMbAuEZOS
         dYQDcckkKlhp9g8k/uUEpHj7pz6v0W5vbbt1Cmr6XTP+fyO+9IEqFmtUYZCZm/prO0aX
         hebzWuq+IbU7MR4mfXe0Z70TKbU3XqVXXxy2RDUlp39q634pDIXXiSWrXzEYaY29+mzj
         Vzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273784; x=1692878584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdwRwKvnz3Z20+s9tNz6mtV9CNaQwcE4bakky09bUQU=;
        b=L26sr+hi3TIzlvbsHxX/gaSMYBxaWpOVu7SP+4uQwITjyOr3Z5Cu/37fyM5Sz0QKAm
         6BUWan8Vikf0VtkX/ktvtnGpDVU7Uap2rbPUDcY78KD/gTbLIIcOslutW00M31RSfuaz
         6od1rQkE7FIe5POxGXLfhfH2CH5KS0ms6P2iS1JqGqikFAf5Gc8BC/IX0JGZ2OaQgyt7
         32PMAc+AKipSrZe1V6+1eM9k6XXqmSolnjA3bzTszhp8XQ12IanJ606oW2gczrYsY8U/
         nCt4U1+rajTRynmKb3vd2r0xm890XWLIKXhQWOTuwDJreOQYhjXthBlGaGu5xGyKCPVz
         wyZg==
X-Gm-Message-State: AOJu0YyxBbHG4wMPBdM9E60gKmlgALiXuvNWNGjEEGJrxKfJaKR8XK7O
        xd4PIM1DOLIdOnseud0fZbuGAMQoGJbvGsZn
X-Google-Smtp-Source: AGHT+IFUFbj2Oz9yjX58UklqRWkJ8XBlw1BmWkcFAw/EtvA+pIm8BJbDg3KlcLTucS9jGvyDSuUHVg==
X-Received: by 2002:a2e:9bd0:0:b0:2b6:e361:4b3c with SMTP id w16-20020a2e9bd0000000b002b6e3614b3cmr3710501ljj.14.1692273784228;
        Thu, 17 Aug 2023 05:03:04 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm3981213lji.123.2023.08.17.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:03:02 -0700 (PDT)
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
Subject: [PATCH v6 5/6] iio: adc: mcp3911: avoid ambiguity parameters in macros
Date:   Thu, 17 Aug 2023 14:05:17 +0200
Message-ID: <20230817120518.153728-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
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

Name macro parameters after what they represent instead of 'x'.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - change 'ch' to '(ch)'

 drivers/iio/adc/mcp3911.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 06c8c5ac7781..9167f0ffa4e3 100644
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

