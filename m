Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D507D1045
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377414AbjJTNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377410AbjJTNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8ABD66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:07:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE90C433C9;
        Fri, 20 Oct 2023 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697807245;
        bh=wNQVb7PLDPRN/789KQQ8f4+mbdFALdcAtpqplVs0G9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpRPnE5M2ye+1dOqHuel9GcdgmwuyV5hS2C7vr04oOI1DvF7WXPXKybloPw3+mD4u
         IRjbnZLvlFcchjX2BRjLF3i+Zw1vvLYrCfk1keITwRDF4VbaCyc1ONgJntwn4OCSWZ
         PEcHDWpEkFcDXDFypGcTfgoVI/iCMaJChPMeQ6QQ8osUx5VDIdUZN3IujbWafwyoSJ
         zIPzGc6+gJXS3i0W7wERZXO+RHgz+sY0AnLeg8BpHCzygUoPGRs0fmnTit3CdCeVpB
         O2NhSYdQmPRsKmyTs6/EVyL7hWBYQAsRpMbP59+KVXL2GOTlZilJxcAHUVEjWphne+
         Jnco2n6lpng5w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mike Christie <michael.christie@oracle.com>,
        Uday Shankar <ushankar@purestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme: keyring: fix conditional compilation
Date:   Fri, 20 Oct 2023 15:05:37 +0200
Message-Id: <20231020130644.485649-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020130644.485649-1-arnd@kernel.org>
References: <20231020130644.485649-1-arnd@kernel.org>
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

The keyring and auth functions can be called from both the host and
the target side and are controlled by Kconfig options for each of the
combinations, but the declarations are controlled by #ifdef checks
on the shared Kconfig symbols.

This leads to link failures in combinations where one of the frontends
is built-in and the other one is a module, and the keyring code
ends up in a module that is not reachable from the builtin code:

ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
ld: drivers/nvme/host/core.o: in function `nvme_core_init':
core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init

ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'

Address this by adding compile-time checks around the callers where
needed, based on whether the functionality is actually used for
the target and host side, respectively.

In Kconfig, this requires changing the 'select NVME_KEYRING'
since the keyring calls are done from the host core module,
which may be built-in even when the tcp front-end is in a loadable
module.

Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/Kconfig      |  2 +-
 drivers/nvme/host/core.c       | 16 +++++++++++-----
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 8fe2dd619e80e..2d53c23f0a483 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -2,6 +2,7 @@
 config NVME_CORE
 	tristate
 	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
+	select NVME_KEYRING if NVME_TCP_TLS
 
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
@@ -95,7 +96,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
 	help
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa2..ac92534f6da90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4724,16 +4724,20 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result = nvme_keyring_init();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		result = nvme_keyring_init();
 	if (result)
 		goto destroy_ns_chr;
-	result = nvme_init_auth();
+
+	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
+		result = nvme_init_auth();
 	if (result)
 		goto keyring_exit;
 	return 0;
 
 keyring_exit:
-	nvme_keyring_exit();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4756,8 +4760,10 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	nvme_exit_auth();
-	nvme_keyring_exit();
+	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
+		nvme_exit_auth();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4caa..e2b90789c0407 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1915,7 +1915,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (ctrl->opts->tls) {
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && ctrl->opts->tls) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
 		else
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9eed6e6765eaa..e307a044b1a1b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1893,7 +1893,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (nvme_keyring_id()) {
+	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
 			pr_warn("NVMe keyring not available, disabling TLS\n");
-- 
2.39.2

