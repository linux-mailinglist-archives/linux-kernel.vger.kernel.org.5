Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6A7F53AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbjKVWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjKVWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43592
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:47:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADF4C433CA;
        Wed, 22 Nov 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700693251;
        bh=9ZYZZkr3I5hnymOVMd0KFdtSw5PNdjLQfrciVWD6egI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0Ll4JW9tS/EGX5GtWauX3N3e0xBMe2+rvzFXjJizYae6g08d5AOtIUQdHAYH4r3j
         miRPhXbgooUsZmqDaFwTIzizmKrjwCvSL6EsAjpWFXVaB1JOMlqq+Id82oY9eJWD79
         MiyaP8PV6qFHRPchKcdC0wxoXcbOutpDU85RFFRiHVckcMqOZaR93oQj4+/8yGlhP/
         HDiEzsRWpQZ3suv0Ed6pqdU8CJ6tn0lcmC5PBh3DKwbln5NrzA5wnGi0csKYTIHb9o
         AouSbelHAd+ju3CJkgO7Tld8h5ecegxq5WwoxE/x5v3xY0Hfw3QAobcADR+4LearDf
         Zy7uciJ+6VNwg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-nvme@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] nvme: target: fix Kconfig select statements
Date:   Wed, 22 Nov 2023 23:47:18 +0100
Message-Id: <20231122224719.4042108-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the NVME target code is built-in but its TCP frontend is a loadable
module, enabling keyring support causes a link failure:

x86_64-linux-ld: vmlinux.o: in function `nvmet_ports_make':
configfs.c:(.text+0x100a211): undefined reference to `nvme_keyring_id'

The problem is that CONFIG_NVME_TARGET_TCP_TLS is a 'bool' symbol that
depends on the tristate CONFIG_NVME_TARGET_TCP, so any 'select' from
it inherits the state of the tristate symbol rather than the intended
CONFIG_NVME_TARGET one that contains the actual call.

The same thing is true for CONFIG_KEYS, which itself is required for
NVME_KEYRING.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 31633da9427c..e1ebc73f3e5e 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -4,6 +4,8 @@ config NVME_TARGET
 	tristate "NVMe Target support"
 	depends on BLOCK
 	depends on CONFIGFS_FS
+	select NVME_KEYRING if NVME_TARGET_TCP_TLS
+	select KEYS if NVME_TARGET_TCP_TLS
 	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
 	select SGL_ALLOC
 	help
@@ -87,9 +89,7 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
-	select KEYS
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
-- 
2.39.2

