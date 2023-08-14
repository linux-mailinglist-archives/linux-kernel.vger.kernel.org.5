Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E626477B84E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjHNMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjHNMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1410C8;
        Mon, 14 Aug 2023 05:08:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bccc9ec02so596902466b.2;
        Mon, 14 Aug 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014901; x=1692619701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT352OCfGqxNoSXE4tEzqZSBsrlAMyuuOuSC5iE2eEk=;
        b=UosjdDXyxRwPJi3LPPHT3lxTKoR3noG1MC1VabZGS0tD/EPLGaFO/zaXIu/UgP1lK4
         wHTdXZ0WG3TsnuA5b1DrP2/Ct3d0Bmacj8FdNy7A3DJyOISk6FsAX7M1r99TwoRqGpzs
         BETlwjQv4CVC0ENdlzKHrXqN2sa4bSLMHhX8a7HtmqrLB2DuiXS4BuZc+esn0/FFFYx4
         XD6+w0xmtsf/F13ogTkekcQrY+SWQz1lAff9zbdWUZwvzuLB9AuwrsfVJ1kwseBD8x0k
         Y2Gd59EgTrjnXHNwZFeKoKhnG0Hd0bAaR+sM1MahDjT/tnnOx3FQaJcKTJuXr/zLHFp4
         qxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014901; x=1692619701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT352OCfGqxNoSXE4tEzqZSBsrlAMyuuOuSC5iE2eEk=;
        b=dxhROhr7lzkCzjrBCuZCw0poA8NP6q74tUNdanwM/6qiu2kXIvrx3kesTW4dI7nc59
         dDbSc/N2COJMB3zEt1ATGxqmSToFu9BDEL53IfDjCSMVtGYzqAR1a3moO95c6L+atC8c
         7XLC89HE05Rhoi/5cUsYWPGE58C5OdH/dojF3i1ubS6uNsIZ7rsksxdTBooHW+z7G+4e
         mE3ZA4l7Oyd8oHC2+Sc4n0RM5GwvZzAXnyEjZTGo4SAmesfip/7+/rqYp346mMLv/pMY
         aPxXc3t7/jlYiqZ+AjQlwSj1NjSD1r7H488KnaGTCZyeJY221jkxI4szsTl1rQxMVZyK
         Tlaw==
X-Gm-Message-State: AOJu0Yxaps5DdDUCrv9sjp85AQWHEa2eitauqpGPT6+veVD0Hs2qCrRj
        amq7tpRGNvO1eeuLxzEfQFo=
X-Google-Smtp-Source: AGHT+IEKHKaVSNs5xWjy2HLxnFU6M5Dy86Ska1BeiQ9nMI2joTggQkC0yoT+cONJVT7NjI1+tj74zw==
X-Received: by 2002:a17:907:78c5:b0:991:bf04:2047 with SMTP id kv5-20020a17090778c500b00991bf042047mr7977773ejc.14.1692014901409;
        Mon, 14 Aug 2023 05:08:21 -0700 (PDT)
Received: from goliat.isc.local (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b009930042510csm5600433ejf.222.2023.08.14.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:08:20 -0700 (PDT)
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
Subject: [PATCH v5 5/6] iio: adc: mcp3911: avoid ambiguity parameters in macros
Date:   Mon, 14 Aug 2023 14:10:09 +0200
Message-ID: <20230814121010.184842-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814121010.184842-1-marcus.folkesson@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
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

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series

 drivers/iio/adc/mcp3911.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1648eaa878eb..f1e02aa14e93 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -51,8 +51,8 @@
 #define MCP3911_REG_GAINCAL_CH1		0x17
 #define MCP3911_REG_VREFCAL		0x1a
 
-#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
-#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
+#define MCP3911_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + ch * 3)
+#define MCP3911_OFFCAL(ch)		(MCP3911_REG_OFFCAL_CH0 + ch * 6)
 
 /* Internal voltage reference in mV */
 #define MCP3911_INT_VREF_MV		1200
-- 
2.41.0

