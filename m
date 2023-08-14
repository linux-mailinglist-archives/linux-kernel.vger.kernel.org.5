Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C192B77B2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjHNHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjHNHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546D115;
        Mon, 14 Aug 2023 00:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B0A641EA;
        Mon, 14 Aug 2023 07:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DA5C433C7;
        Mon, 14 Aug 2023 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998774;
        bh=kjg4TBwaNAs7v3/kzjzI7ssu51NWiAz4yaBXH6sVnzA=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9n6wBSpeCAmsniOpaTf36ptveR2UoXu9MK6Mg9csJErcjWWaZ0gtQktyJK1gNf/h
         WwY2PMo9Qq4DkFDKsASy57be6NJtijZma9cXeMQspZmRhdy3g5c0qZt25Zu8Q1ztaw
         03Gve2RcnhifH0vYp3NucfkqXMk4gkYxqmWEJON5KmHtNjQRFnzpsZCdzwQXbSFPdy
         ny1PuHu0F+ywtghptl2tMgzy5pXmvjjebtmonM9B5mtdzHCVcC7vB99LDryG0tgq4F
         4Hx3r9yZQDscCgcF6QwomrwgO5nB1NMYiuy5uk8l8KBRugKEioKRNeSzknjWE9wB9J
         xHoKHHTrBc+wA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henning Schild <henning.schild@siemens.com>
Cc:     "xingtong . wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: simatic: add PCI dependency
Date:   Mon, 14 Aug 2023 09:38:50 +0200
Message-Id: <20230814073924.1066390-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The simatic-ipc driver no longer depends on PCI, but its watchdog portion
still needs it, otherwise P2SB runs into a build  failure:

WARNING: unmet direct dependencies detected for P2SB
  Depends on [n]: PCI [=n] && X86 [=y]
  Selected by [m]:
  - SIEMENS_SIMATIC_IPC_WDT [=m] && WATCHDOG [=y] && SIEMENS_SIMATIC_IPC [=y]

drivers/platform/x86/p2sb.c:121:3: error: call to undeclared function 'pci_bus_write_config_dword'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);

Add back the minimum dependendency to make it build in random configurations
again.

Fixes: b72da71ce24b0 ("platform/x86: simatic-ipc: drop PCI runtime depends and header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 04e9b40cf7d53..09452384221a4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1680,7 +1680,7 @@ config NIC7018_WDT
 
 config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
-	depends on SIEMENS_SIMATIC_IPC
+	depends on SIEMENS_SIMATIC_IPC && PCI
 	default y
 	select WATCHDOG_CORE
 	select P2SB
-- 
2.39.2

