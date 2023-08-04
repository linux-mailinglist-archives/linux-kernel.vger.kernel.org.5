Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1B770183
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHDN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHDN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECBE4C37
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F36B61FCF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E903C433C7;
        Fri,  4 Aug 2023 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691155738;
        bh=lvUDRw4p634vjK9st2933Fwt4UHM/GIodcYQmJQCOqw=;
        h=From:To:Cc:Subject:Date:From;
        b=DnQnp7U6H/286DwMyobjb04gICdFk2v9JsJ7V4pAgQpGWPDx6qSP5Cv6LcN/3FXbW
         H9Do0beaHzK2YbPKdInZkR/rKFw35h0Vh2/sZQ/2jrQ5zQRqoB+BCqT76/se9JxeI9
         KXJKilVVabs1sbXa6Qx7hQwFhX7zkGHJ/hIiyg3f/mxtgrEyYJ/IfuEGkWjBoL2wQl
         XBZgIkXbI8uZhKdzGlzVg3CYgmNkuWK53yIGZkh/nZamOJGc7MmYp6Kzb0SXeJKiUF
         /taqdYI8q9ihNQq5Lh5mvIBkT98fD0bFpTXKjEItr0vDloo4gJtgupdY8yibuTA6Zc
         BuQ3x1um89NOQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: cht_wc: add POWER_SUPPLY dependency
Date:   Fri,  4 Aug 2023 15:28:49 +0200
Message-Id: <20230804132853.2300155-1-arnd@kernel.org>
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

The driver fails to link when CONFIG_POWER_SUPPLY is disabled:

x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_psy_get_prop':
extcon-intel-cht-wc.c:(.text+0x15ccda7): undefined reference to `power_supply_get_drvdata'
x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_pwrsrc_event':
extcon-intel-cht-wc.c:(.text+0x15cd3e9): undefined reference to `power_supply_changed'
x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_probe':
extcon-intel-cht-wc.c:(.text+0x15cd596): undefined reference to `devm_power_supply_register'

It should be possible to change the driver to not require this at
compile time and still provide other functions, but adding a hard
Kconfig dependency does not seem to have any practical downsides
and is simpler since the option is normally enabled anyway.

Fixes: 66e31186cd2aa ("extcon: intel-cht-wc: Add support for registering a power_supply class-device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/extcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 0ef1971d22bb0..8de9023c2a387 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -62,6 +62,7 @@ config EXTCON_INTEL_CHT_WC
 	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
 	depends on INTEL_SOC_PMIC_CHTWC
 	depends on USB_SUPPORT
+	depends on POWER_SUPPLY
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable extcon support for charger detection / control
-- 
2.39.2

