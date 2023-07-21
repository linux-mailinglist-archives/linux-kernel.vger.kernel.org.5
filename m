Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13E75C100
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGUIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGUIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:13:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963782708;
        Fri, 21 Jul 2023 01:13:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso2675098e87.1;
        Fri, 21 Jul 2023 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689927236; x=1690532036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYe6nFf1Fg/E2zN93SnKee2EKKNwvg4JPl5fMA3VVG8=;
        b=qesp3CNk/Kaby1oOM+4Mfq2Dw+MTDE9+R2616ksyRNgIGwEtmGK1BIdEaKbbskkUHL
         Bu9vP4+Fkg/BjxSA0ojTNEasmXIwAuip3gbNGlvx6Bn397scWpKoYNMrU0vqGLaoLawc
         JhGjdODAjXvryKx8qTYD89yGRkVEAzhgDxgFyaTPk4miXmD/pqgATSR0xsURYK1Byyiv
         SniAf8g7Fhr0wUmeggPLnnSLldpasghB9TPy7QUB0f7ZftXS+S2mUWFf2ClHkWnvymmc
         cu5KohhVhCFSE8i6rMRwYyCDZgzk7+s3yCv1TbF1U3xK4Om45ajovEFDk2er23u1yRcl
         uOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927236; x=1690532036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYe6nFf1Fg/E2zN93SnKee2EKKNwvg4JPl5fMA3VVG8=;
        b=MIxSCepIW7twDNVBPwIjpMAdvqD1DiT/J3kUgoVfHOlOVXiA5YJsxIdfFaWHGJWAZ2
         cPQigyzY5lb1/wVoorJOji+UoPpqp2DZJ+miYGkawMtlkH6sNkIRclJnZotHllw4VQSs
         wSCIg3PzjOiBpMhnq3qpwtp4+H/kIdqAYemxrpIx+ozwuas53qVNSdHmTfm4d+n0P7di
         ImAwsXuOCvrQR8wA1FD7+Hk4lZMPJ6FsqE6icipC9yW0WCzVmJFA95bxjyqTbLcOBSYR
         ZjndhLmQE4fRcRPJEx5YrDazIAj0ZP7oQFg6eaLzm5k34U3ZC08i/7vneqsu5xeLQc78
         WvNQ==
X-Gm-Message-State: ABy/qLajqEV/ZyolAndh2NwHm9EyCBiCwcI8KR/7repfvyJmOiaU7rQ5
        8GsruuOP2R9Oadm99WgxFzVXLC9K/XCcaw==
X-Google-Smtp-Source: APBJJlFpTE1Yeu/FApmOfFcPQWS10aORSCq/Co/nDyHcgcgJzPdzVQ4G6l/1ZnZDxZ7BtGDFNqYSsA==
X-Received: by 2002:ac2:4f13:0:b0:4f9:5711:2eb6 with SMTP id k19-20020ac24f13000000b004f957112eb6mr941058lfr.28.1689927235525;
        Fri, 21 Jul 2023 01:13:55 -0700 (PDT)
Received: from localhost.localdomain ([109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fb40f5f553sm5677049wmf.31.2023.07.21.01.13.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jul 2023 01:13:55 -0700 (PDT)
From:   Florent CARLI <fcarli@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florent CARLI <fcarli@gmail.com>,
        Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] watchdog: advantech_ec_wdt: fix Kconfig dependencies
Date:   Fri, 21 Jul 2023 10:13:47 +0200
Message-Id: <20230721081347.52069-1-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses the WATCHDOG_CORE framework and ISA_BUS_API.
This commit has these dependencies correctly selected.

Signed-off-by: Florent CARLI <fcarli@gmail.com>
Co-authored-by: Yoann Congal <yoann.congal@smile.fr>
---
 drivers/watchdog/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..2108283b438c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1075,6 +1075,8 @@ config ADVANTECH_WDT
 config ADVANTECH_EC_WDT
 	tristate "Advantech Embedded Controller Watchdog Timer"
 	depends on X86
+	select ISA_BUS_API
+	select WATCHDOG_CORE
 	help
 		This driver supports Advantech products with ITE based Embedded Controller.
 		It does not support Advantech products with other ECs or without EC.
-- 
2.39.2 (Apple Git-143)

