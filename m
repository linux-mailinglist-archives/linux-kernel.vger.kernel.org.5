Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3E7DAC44
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJ2LsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2LsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:48:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB6BC;
        Sun, 29 Oct 2023 04:48:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-509109104e2so1205117e87.3;
        Sun, 29 Oct 2023 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698580094; x=1699184894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+v+Jv8cNfs1h2ATuX1rQpWp90XwNnzcTm+maLE/WR8=;
        b=B926cCAe3lfEz2qRCjhiHuqd9aFUPWwSGXLruEdunIHN7F1jPu7p9aBZmQmgh0b0GE
         Fyl3c2GmIKWdIlwFXk8nCLIsUGtlX6i44QBTeOaAxahJsObO1MH238Sz5BSB9SUd5Ete
         EPNTsQBTbGTp8HCMynwpu0afj8Dzz2ZoovEQF4jG5AjCilN5z2uLHW5kqVt5FebbFhX4
         V/hFQ6RY4MsAz6xz455iF/ez3TzgN5KgmWZeirIEiQj9xEKTM+nqPyoKfQ6xD4sMOVlh
         Ttw5a8Hf2LAJZqDvJUqBtmGcPmyskqM0g854vGfM2poWEUsbY3NcwWEZ3tYdwF02TALH
         tmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698580094; x=1699184894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+v+Jv8cNfs1h2ATuX1rQpWp90XwNnzcTm+maLE/WR8=;
        b=k0qt9Xq4S2AhuPglYsFArXiVsuWHWQBsPIU7cJxyE8z7sfMp/eCUDAjO2ymmOmQIxl
         EW5ASWFgJN3kNN0pOG0hX2ZbECzS6rcQRB4pLEdaV5Rv0iu+Da97njfEDqQupdAEDYnu
         5Nui2O8lfhUFCrVpFXBx9uBz4dwTXg/w1XRNIKs0VChLf0hDRRSA/AI9p7/oQCcDMIB8
         7l456bX2HzQcEZ3N5C1FPCi85EQMIZb0XF0PQkd3K+6WdFYrAIS93hbcoRfHbl5juwOC
         766Fh78k8NbAPwmStegPg6BiWtcrI4mKnJW36xqqB8AM8KcSpfHRyOM2P9xyz4+C14N2
         ceow==
X-Gm-Message-State: AOJu0YxaAAZ6L+iqFZcoKOq3XKMG1/yBY/UukHfVoJigtUDS0n2rU8+U
        eXUyqO9zEpuWBiBvCqtLRz1vC1kqdGs=
X-Google-Smtp-Source: AGHT+IFaczo3IbfhwgIe9Sza33bArtagm3Tkb0JFmxYq8G8NdkFj02bN5c69pTpkewiAkeUUGJBT0A==
X-Received: by 2002:a05:6512:2082:b0:507:b15b:8b99 with SMTP id t2-20020a056512208200b00507b15b8b99mr4396479lfr.60.1698580094240;
        Sun, 29 Oct 2023 04:48:14 -0700 (PDT)
Received: from localhost.localdomain (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b00502e0388846sm1016346lft.244.2023.10.29.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 04:48:13 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     tony@atomide.com, lee@kernel.org, robh@kernel.org
Cc:     wens@csie.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Date:   Sun, 29 Oct 2023 13:48:43 +0200
Message-ID: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

The core twl chip is probed via i2c and the dev->driver->of_match_table is
NULL, causing the driver to fail to probe.

This partially reverts commit 1e0c866887f4.

Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/mfd/twl6030-irq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index f9fce8408c2c..3c03681c124c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -24,10 +24,10 @@
 #include <linux/kthread.h>
 #include <linux/mfd/twl.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/of_device.h>
 
 #include "twl-core.h"
 
@@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
-	const int		*irq_tbl;
+	const struct of_device_id *of_id;
 
-	irq_tbl = device_get_match_data(dev);
-	if (!irq_tbl) {
+	of_id = of_match_device(twl6030_of_match, dev);
+	if (!of_id || !of_id->data) {
 		dev_err(dev, "Unknown TWL device model\n");
 		return -EINVAL;
 	}
@@ -409,7 +409,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 
 	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
 	atomic_set(&twl6030_irq->wakeirqs, 0);
-	twl6030_irq->irq_mapping_tbl = irq_tbl;
+	twl6030_irq->irq_mapping_tbl = of_id->data;
 
 	twl6030_irq->irq_domain =
 		irq_domain_add_linear(node, nr_irqs,
-- 
2.42.0

