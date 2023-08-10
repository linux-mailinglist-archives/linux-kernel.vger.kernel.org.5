Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C8778365
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjHJWBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHJWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:01:08 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E2A273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:01:06 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4872c3dff53so401222e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691704866; x=1692309666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaWOwFxP8NeV5qZedju52jWrRv0oTxVWbWYYg0K/4Gg=;
        b=YMahL25m3XKqYTF4tno5ua0W4dOvsnqIBvCUMy2x8KZZyTsT8BlW54NZUHEQ30RPdB
         4TcVqCTYMgn7zpITd125wpcm2gqyyyD78jEnJ6l2ZqROunAxjFi8jtY/8BPih8B2ObZi
         Uxx7U7CZJL9+yG0d8RC6Doh5QmiZjfMYs419H8f4W8MYmVhrLSSdQFyl8VWtsjWcN5qa
         8DEsnl57f08go0qLD6ck5Ods4ap+675acDCdGvyqqctEkRBwuXjM/viFqix8LOyUrQnS
         zxOe7SOwZDKJ7wXziY6SHf7jttqli38B+OsUKIB1iiWu8Vl2Unh5BKb+T6iIwKMV902k
         7fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704866; x=1692309666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaWOwFxP8NeV5qZedju52jWrRv0oTxVWbWYYg0K/4Gg=;
        b=G0x+i78mwfMRzJqkQV8yHU7lJ1Ic+N+5LXprbBgAuOJbPZOPGNEwvRSv/K9Dk+Vrw6
         ZppU5aGByx8j2Aa47C3IDL2wzVyhgtt5SKqy4OzQ2nVpr42dTeraGIJeaEtWdS2OOYSG
         Zrl7/gDr6W6yIqMcC3CLFzJZRkZp1TcN4wOzLIq8QnDL2U4dfjK4kIbCUdVNKbE1JhMN
         CThXzPAwA+1kjoVbSz8mpUE1iVn2KIk9YDdaaFbCB8jymXmGBfUoNDHLtg6S9PWVGuAI
         PXFD29JAiEw7EBGRE/MVX2E1n2+Klwp08DrbZldBIgHKBvDXK662JaFT7RJpu93CIXGb
         oTaQ==
X-Gm-Message-State: AOJu0YzLBqCjCtuFKS50Py2ZNkUDNSCjVIfRGf7nEPEEuaXPTk2jRj7A
        r0WqwJkbjbd/Y3tQDoVDkkb0cg==
X-Google-Smtp-Source: AGHT+IEYwVf7B0V1B4z6z76aZNmEVOl6H78RqiHn2wkqhFTp4uAfBB2ZrQMHIsgHiejBcL6+A1R0vQ==
X-Received: by 2002:a1f:c305:0:b0:486:de54:b11 with SMTP id t5-20020a1fc305000000b00486de540b11mr158396vkf.16.1691704866069;
        Thu, 10 Aug 2023 15:01:06 -0700 (PDT)
Received: from fedora.. (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id r17-20020a056122009100b004872b997d3bsm387105vka.1.2023.08.10.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:01:05 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: [RESEND PATCH 7/7] gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent
Date:   Thu, 10 Aug 2023 18:00:44 -0400
Message-ID: <f20243853e94264534927f2cdf9288b869e7e03b.1691703928.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691703927.git.william.gray@linaro.org>
References: <cover.1691703927.git.william.gray@linaro.org>
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

The WinSystems WS16C48 I/O address region spans offsets 0x0 through 0xA,
which is a total of 11 bytes. Fix the WS16C48_EXTENT define to the
correct value of 11 so that access to necessary device registers is
properly requested in the ws16c48_probe() callback by the
devm_request_region() function call.

Fixes: 2c05a0f29f41 ("gpio: ws16c48: Implement and utilize register structures")
Cc: stable@vger.kernel.org
Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-ws16c48.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 701847508e94..6289b0510cf2 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -17,7 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#define WS16C48_EXTENT 10
+#define WS16C48_EXTENT 11
 #define MAX_NUM_WS16C48 max_num_isa_dev(WS16C48_EXTENT)
 
 static unsigned int base[MAX_NUM_WS16C48];
-- 
2.41.0

