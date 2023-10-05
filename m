Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4727BA66A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjJEQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjJEQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CE196
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:59:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c7a4735a30so92743a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696474770; x=1697079570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10JswCDtKjfsgUgjTt05ZkVWjMO4ZebDQWE8d7lo6tc=;
        b=VKUQsTLhCArnRioaPv2u3UlcoY7e8nqdOs9Fb8algbw+e/Qb7F1MxBH78hSGbgQeN1
         TwlbgeZPvk3tZQ7Lq8E6ic5XwdO/8VtzCHs1nfuxFf+Sw7/p8277olzuPDWtgoIFuGNn
         qHw0a1+iIxDAu2HGCyUgI4HJ8wQkn8ADY4recjFsosL/9dYBfb14a2x3Gk115QhSo2z7
         DE9EzsnfoW6uLCk6ubnPJ4tilrCnrOPxFYiD6zYXGZ+kF/Y1eX2AAHjoaQhsnxF0bg3i
         Sazzd3ecdU00wp6MoWT9BsqGzcmwqGrT+wb5AO1OPrrQPxBu8AyFISFRW2OzSSoc25yl
         vUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474770; x=1697079570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10JswCDtKjfsgUgjTt05ZkVWjMO4ZebDQWE8d7lo6tc=;
        b=ZFN64OFqlHYL+a6FtGIAVLHe5VTxaMfYQyKtXfuuy+bBBIo2FErUHbL0EIhyWRNKUP
         MmwmxGoURTmwjpp7j3sID1oIToDbyN8VMY+TOJ4QexPQaEonv3+Cs0mbDGOp/0wv3Ni4
         OqaQQIj/DoC3jJp3QzezQLpxz2rMfdNbTyURiCZgIwUR3CZmnoMTD+73p2jSrEg0ooXz
         Ne9wpHNJGp46KNNfLZZQIEoXXm97vLq5kzsgDBlt05PurFVKTkKVDFCscSfmifJbTXg7
         EU5C/3Noc43fq7EGUozGi6xfqntYGrqonbgjG9NMJmTUcYPZRNuGX5trY7MIL5N9pl5a
         /Krg==
X-Gm-Message-State: AOJu0YzfURc57MXq2anWz+GupF3oVhkpU/1gJYaPFxzLbPC277AvLhP3
        d4UC2BiaTn4jDE2/WIG+oCdzgw==
X-Google-Smtp-Source: AGHT+IFVHEUYGWZTaKBOTIg0Zt8j6bgzzj5zfngX59+MW1xuz8QaG4UOkQ4Qt1xPSuv/ln7C4yvMeg==
X-Received: by 2002:a05:6808:15a8:b0:3ad:f3c0:5da3 with SMTP id t40-20020a05680815a800b003adf3c05da3mr4643158oiw.3.1696474770489;
        Wed, 04 Oct 2023 19:59:30 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:a16d:fce2:497:afb7])
        by smtp.gmail.com with ESMTPSA id b18-20020a637152000000b005782ad723casm269265pgn.27.2023.10.04.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:59:30 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC v2 3/5] pinctrl: add pinctrl_gpio_get_config()
Date:   Thu,  5 Oct 2023 11:58:41 +0900
Message-Id: <20231005025843.508689-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005025843.508689-1-takahiro.akashi@linaro.org>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a counterpart of pinctrl_gpio_set_config() which will be used,
at least initially, to implement gpio_get interface in pin controller
based generic gpio driver.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
RFC (Oct 2, 2023)
---
 drivers/pinctrl/core.c           | 19 +++++++++++++++++++
 include/linux/pinctrl/consumer.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e9dc9638120a..2f9c2efdfe0e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -926,6 +926,25 @@ int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 
+int pinctrl_gpio_get_config(unsigned int gpio, unsigned long *config)
+{
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
+	if (ret)
+		return ret;
+
+	mutex_lock(&pctldev->mutex);
+	pin = gpio_to_pin(range, gpio);
+	ret = pin_config_get_for_pin(pctldev, pin, config);
+	mutex_unlock(&pctldev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_get_config);
+
 static struct pinctrl_state *find_state(struct pinctrl *p,
 					const char *name)
 {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4729d54e8995..852fac97a79b 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -31,6 +31,8 @@ extern void pinctrl_gpio_free(unsigned gpio);
 extern int pinctrl_gpio_direction_input(unsigned gpio);
 extern int pinctrl_gpio_direction_output(unsigned gpio);
 extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
+extern int pinctrl_gpio_get_config(unsigned int gpio,
+				   unsigned long *config);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
 extern void pinctrl_put(struct pinctrl *p);
@@ -92,6 +94,12 @@ static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 	return 0;
 }
 
+static inline int pinctrl_gpio_get_config(unsigned int gpio,
+					  unsigned long *config)
+{
+	return 0;
+}
+
 static inline struct pinctrl * __must_check pinctrl_get(struct device *dev)
 {
 	return NULL;
-- 
2.34.1

