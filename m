Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398C77906E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHKNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjHKNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DFE3C1F;
        Fri, 11 Aug 2023 06:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9437467295;
        Fri, 11 Aug 2023 13:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A8C433C7;
        Fri, 11 Aug 2023 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691759395;
        bh=CV4wAGvRkjepbUTkalcJWPc/2oFP4dLVTcUCixdAodI=;
        h=From:To:Cc:Subject:Date:From;
        b=KMd5/yq/KlkT3JiCOLEwWROCjAVlvG0Bdh5KsKwgU4+4FLtpGzFIPS1I0NnN8aERC
         mzSf1EamTYcpYPQAqNsFqljdmPll8PF+Y1jOtDd+4YPL9fOiwEQkq9Y+u+wE5F/RGT
         VDHcT7Rk1T/PTNhkr9zbt353jdxV4HpV7xr93sjDLbiXHKE2iVnzx0djSdVCeO6wE+
         qD9Dp7eq2rHWnMfWMrzKqoi6eeKzoOMosd2K+Y5Gej1LmMBwT10aYOG4YrFzOTxQPP
         l6/zjRHojkOImfwvYTHrqYhs61Hu0XaAXwj1Cd1R8TBNQ93p86woOUBmDWjjxfiNA0
         sXqkgSqfDSIWg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "xingtong.wu" <xingtong.wu@siemens.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] platform/x86/siemens: simatic-ipc: fix nonsensical condition
Date:   Fri, 11 Aug 2023 15:09:34 +0200
Message-Id: <20230811130948.2211800-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The condition checking for a constant SIMATIC_IPC_DEVICE_BX_59A value
clearly makes no sense, as clang warns:

drivers/platform/x86/siemens/simatic-ipc.c:132:42: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
                if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
                                                       ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/siemens/simatic-ipc-batt.c:197:49: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
                if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
                                                              ^  ~~~~~~~~~~~~~~~~~~~~~~~~~

Most likely, this was meant to check ledmode to be one of the two values,
so change it to that.

Fixes: b8af77951941e ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
Fixes: c56beff203754 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
 drivers/platform/x86/siemens/simatic-ipc.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index d66b9969234bf..e6c12c52843ca 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -194,7 +194,8 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 
 	if (table->table[2].key) {
 		flags = GPIOD_OUT_HIGH;
-		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
+		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A ||
+		    priv.devmode == SIMATIC_IPC_DEVICE_BX_59A)
 			flags = GPIOD_OUT_LOW;
 		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
 		if (IS_ERR(priv.gpios[2])) {
diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 02c540cf40702..e11d28ffac604 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -129,7 +129,8 @@ static int register_platform_devices(u32 station_id)
 		pdevname = KBUILD_MODNAME "_leds";
 		if (ledmode == SIMATIC_IPC_DEVICE_127E)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
-		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
+		if (ledmode == SIMATIC_IPC_DEVICE_227G ||
+		    ledmode == SIMATIC_IPC_DEVICE_BX_59A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
-- 
2.39.2

