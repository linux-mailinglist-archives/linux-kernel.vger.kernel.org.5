Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3B7D1042
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377332AbjJTNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377137AbjJTNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:06:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A839F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:06:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE8C433C7;
        Fri, 20 Oct 2023 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697807210;
        bh=uIjXzeVXzA8EnjCxAvZ97JSiutk5X18H+VL0S6ZqDV4=;
        h=From:To:Cc:Subject:Date:From;
        b=XEVLCGtZK5qOvOOD/jof56nAfpYXeAiLzHwwY1703KyPZB1tWze6MJ6yK0Em7evWz
         Yb+sh4wYLoXFF8mw4M1Jz7WhQx0YOlYltUb9gsy2gkU1eSaJz9WFZBh1I2QLyDBQla
         d48JGh5gygM5Zvj/+K/w60sixsRAeSoT6YKHwLSBX9aNdHp1QPtKdrZb/grs63mKM3
         kp4P1eWbv5raHvv/12p2HnN4H/20y3xZA/i9aIz1YO++GmzGDUanN9Sn+duyExl5pu
         UHilWKqEcOu9VKO1mR2SuCmTjvAJYQ1aH4U12P+95DjmDD3xvw88eGy0Rxwi7nzYqD
         +Njva24BcE2WA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: common: make keyring and auth separate modules
Date:   Fri, 20 Oct 2023 15:05:36 +0200
Message-Id: <20231020130644.485649-1-arnd@kernel.org>
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

When only the keyring module is included but auth is not, modpost
complains about the lack of a module license tag:

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o

Address this by making both modules buildable standalone,
removing the now unnecessary CONFIG_NVME_COMMON symbol
in the process.

Fixes: 9d77eb5277849 ("nvme-keyring: register '.nvme' keyring")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/Makefile         | 2 +-
 drivers/nvme/common/Kconfig   | 4 ++--
 drivers/nvme/common/Makefile  | 7 ++++---
 drivers/nvme/common/keyring.c | 2 ++
 drivers/nvme/host/Kconfig     | 2 --
 drivers/nvme/target/Kconfig   | 2 --
 include/linux/nvme-keyring.h  | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index eedca8c720983..74f59ceed3d5a 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_NVME_COMMON)		+= common/
+obj-y		+= common/
 obj-y		+= host/
 obj-y		+= target/
diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 06c8df00d1e21..63d4fd45999dc 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -4,11 +4,11 @@ config NVME_COMMON
        tristate
 
 config NVME_KEYRING
-       bool
+       tristate
        select KEYS
 
 config NVME_AUTH
-	bool
+	tristate
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 0cbd0b0b8d499..681514cf2e2f5 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -2,7 +2,8 @@
 
 ccflags-y			+= -I$(src)
 
-obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
+obj-$(CONFIG_NVME_AUTH)		+= nvme-auth.o
+obj-$(CONFIG_NVME_KEYRING)	+= nvme-keyring.o
 
-nvme-common-$(CONFIG_NVME_AUTH)	+= auth.o
-nvme-common-$(CONFIG_NVME_KEYRING) += keyring.o
+nvme-auth-y			+= auth.o
+nvme-keyring-y			+= keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index f8d9a208397b4..46d7a537dbc2e 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
 	key_put(nvme_keyring);
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 48f7d72de5e9a..8fe2dd619e80e 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -95,7 +95,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_COMMON
 	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
@@ -110,7 +109,6 @@ config NVME_TCP_TLS
 config NVME_HOST_AUTH
 	bool "NVM Express over Fabrics In-Band Authentication"
 	depends on NVME_CORE
-	select NVME_COMMON
 	select NVME_AUTH
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication.
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fa479c9f5c3d3..31633da9427c7 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -87,7 +87,6 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
-	select NVME_COMMON
 	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
@@ -102,7 +101,6 @@ config NVME_TARGET_TCP_TLS
 config NVME_TARGET_AUTH
 	bool "NVMe over Fabrics In-band Authentication support"
 	depends on NVME_TARGET
-	select NVME_COMMON
 	select NVME_AUTH
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 4efea9dd967c1..6cc0696625f36 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,7 +6,7 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
-#ifdef CONFIG_NVME_KEYRING
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
-- 
2.39.2

