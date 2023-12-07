Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8BE808DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjLGQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:26:32 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F5E9;
        Thu,  7 Dec 2023 08:26:39 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9d2f2b25aso679890a34.1;
        Thu, 07 Dec 2023 08:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966399; x=1702571199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ph0+mVciTk2L9HwyQnIvdszce9Yoav2XwfCrXeti/VE=;
        b=kKQNvj9sYoFXM0InCdTUn73Aer9NmWkO3FepPdRyvFBDce4GNMtTn4NRnz1RtkO6IY
         99wUAWUARQuohOrcozmFQNB0F2TzX5k01J8fxr9isQe/y9zSsAOVnWV0cXCCYl4oFcFJ
         /mN8QJL+RpGJ1NUKHsYfus0EVuxX3VBaZlkc9XjyYM9Pe6fdCxh7CWnt2djOoaGbsJ0b
         iCnwviAkq0DUdE/JH3jL7CDl1lqbPAEqVtgh2zwC6ZADowv+OGmN71LOoBuMQa5tus73
         1TKIaY+G3UmpHW4U/kn1wzkqScucSbXkeh4MYP1mRZpq55fefKPkbh7NK5kH7WIK3jbS
         cK+Q==
X-Gm-Message-State: AOJu0YwlZdON00ONR+6xwXnHhgQxa2IxT9gfuy0qtSvYbG63tWU3KJZu
        1g04B/J7v5BssYxEu+mu1ZQo5oKv+A==
X-Google-Smtp-Source: AGHT+IEXl7eslY1gBHfYTYLmCZbhMAY3tRvs5E79h6G5UmdsKRDOvg3+HBcbtQ7lZ3CdsyMhR1v5pw==
X-Received: by 2002:a05:6830:150a:b0:6d9:df71:9fc2 with SMTP id k10-20020a056830150a00b006d9df719fc2mr704750otp.8.1701966398685;
        Thu, 07 Dec 2023 08:26:38 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z21-20020a05683020d500b006d99dd7492csm20233otq.42.2023.12.07.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:26:37 -0800 (PST)
Received: (nullmailer pid 2651456 invoked by uid 1000);
        Thu, 07 Dec 2023 16:26:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: esp32_acm: Add explicit platform_device.h include
Date:   Thu,  7 Dec 2023 10:26:30 -0600
Message-ID: <20231207162632.2650356-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. Soon the implicit includes are going to be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/esp32_acm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
index a4cbaedb5170..d4e8bdb1cdef 100644
--- a/drivers/tty/serial/esp32_acm.c
+++ b/drivers/tty/serial/esp32_acm.c
@@ -8,7 +8,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
-- 
2.42.0

