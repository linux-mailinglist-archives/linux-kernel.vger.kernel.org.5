Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99CE7D7195
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJYQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJYQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:20:46 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651C123;
        Wed, 25 Oct 2023 09:20:44 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e07e5f3aso532125b6e.0;
        Wed, 25 Oct 2023 09:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698250844; x=1698855644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTi1+MQ4t5FTtGD8dbognkLQKmg8VuTrouDfFHJxxvg=;
        b=jmHODSsUnCilpbO9SSx7d1k1sV7YWM5i+bpzgTEFOksiEKk0+cIZ8nV9+qeojJIL18
         fkoXvA/36oTO8Ug7SvSOmrMhXZ53Rc2vhUTIRX+lV+pkQb+F6uw+tAAlTLZ0FY1gWuGt
         PoRmCzkBBkTeiyCbQYiJPNU4730leGJFrwxMp14I0nxjpCJW0Tnu5EZzm5MMTmWR0UfE
         U/I+8AYiqRsuB5p5H9h8Rk6p40/N8X3K2Gw3X2BnrwFGNSDIAF0+D5eEeipxfvh6U3Ou
         q0uM1CuFXmDVB2YrxAaQ36LsD03AIyd3504l2jb20oTT9VrluJfdrpyPEbPM49BzXYCb
         mvKA==
X-Gm-Message-State: AOJu0YyzHTK+4GskYmtr6L+ufD3xudS8rr9DIZyRtCg3nJyIS+qx3NF4
        deYN3u0+wPcOn5e2z2LeAQ==
X-Google-Smtp-Source: AGHT+IFNkQAiovnifVoCOG0FDk5ccKTxGEA6hkgbVB3f+JzjJ2T/9bxxl6xbSMUFLnLq2Te8QIJqUA==
X-Received: by 2002:a54:4710:0:b0:3ad:fa4b:4875 with SMTP id k16-20020a544710000000b003adfa4b4875mr83648oik.11.1698250843735;
        Wed, 25 Oct 2023 09:20:43 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l17-20020a05683016d100b006cd093a0ea0sm2283200otr.5.2023.10.25.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 09:20:43 -0700 (PDT)
Received: (nullmailer pid 380335 invoked by uid 1000);
        Wed, 25 Oct 2023 16:20:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: ingenic: Replace of_device.h with explicit of.h include
Date:   Wed, 25 Oct 2023 11:20:34 -0500
Message-ID: <20231025162034.380152-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

of_device.h isn't needed, but of.h is and was implicitly included by it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/hw_random/ingenic-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/ingenic-rng.c b/drivers/char/hw_random/ingenic-rng.c
index 4f18c3fa5427..c74ded64fbe3 100644
--- a/drivers/char/hw_random/ingenic-rng.c
+++ b/drivers/char/hw_random/ingenic-rng.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.42.0

