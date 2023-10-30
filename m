Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B427DBBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjJ3O11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3O10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:27:26 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C18B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:27:24 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-586beb5e6a7so2301279eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676043; x=1699280843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqGE+grehw3xbV0zDjPAo9aiOxbRmWUNIDFRm/VPJr4=;
        b=OgTsuHkDKYHmB3MV2aL0puWkJXxemae+TDAS+/UVduLzpTP/ZlnOa1GKrG4HvIe+HR
         RCmYrC8w0DHoiup/1RrzM4fDsMuX/nTWNRbK0j3Fb4Ob7gAOgIALr/w9UBSDhzCc+rIj
         vks0xdq9nXhAWEgv47ZmCaxBIvgK9LNi7x6UbhROwlML2BFe1N13DP55SXhxm4YS3TpE
         VcnuaRTp+V4WbpxP/NhSyn390cgrtuC/hUiuuO25gQ0EPUNmL6kNc8ESenhqN1Mldfe7
         gZAXiTWpHkG/fjO3vPx4N5hPCbFeNB0CHV7k8SlCeBZ8kAblCZ8ha1M21tVccWvfMISN
         0m9g==
X-Gm-Message-State: AOJu0YwtdpVQZBjcsput7xf2MGDemXoYxaw1CXJr8u/67lgC5RBrewXq
        hJY91S2Wsf5x6Zgsx/YUvfXHB/GneQ==
X-Google-Smtp-Source: AGHT+IE7d3qTe9TNfkTKRFaPOQ39ZwkuT78GxUML3FSSbwJlzlCcjSZP7s6lwOkd/N4/eLj9LKppqw==
X-Received: by 2002:a05:6870:815:b0:1e9:9c39:a580 with SMTP id fw21-20020a056870081500b001e99c39a580mr11847037oab.7.1698676043410;
        Mon, 30 Oct 2023 07:27:23 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q5-20020a9d6305000000b006ce32816a35sm1445877otk.81.2023.10.30.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:27:22 -0700 (PDT)
Received: (nullmailer pid 822774 invoked by uid 1000);
        Mon, 30 Oct 2023 14:27:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     soc@kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] soc: apple: mailbox: Add explicit include of platform_device.h
Date:   Mon, 30 Oct 2023 09:26:21 -0500
Message-ID: <20231030142620.818663-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

platform_device.h is implicitly included by of_platform.h, but that's going
to be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note this was added in the merge window and missed the last round.

Arnd, Can you apply this directly.

---
 drivers/soc/apple/mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 0cbd172f435e..780199bf351e 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-- 
2.42.0

