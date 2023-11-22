Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D217F53AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjKVWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjKVWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:47:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397712A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:47:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1FDC433C7;
        Wed, 22 Nov 2023 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700693248;
        bh=zAaMHwAz6fQIMNy0cpFdvF6MYVuva8LCFObd/51W7U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9ASBCAxjepYSLCKpUhXqOTcz8HeeVQG9sJv//XEYxWgYrMZO5tnjra4JeXJZ6+xu
         a/gXdFIsEm9KLJvYS4P2s9yLX4eBX0GTq18NjC/79OAuUSjXqihSeEsuz/jXu/7l+O
         0tFo1EYPYxovDTaRaXJ5hNqWdN9ds0cEd0FFzGRuRPtuAormWPk2aUDiRE2EGCl/Zv
         KEd0NI+TOy59khYiULMv+fT2nLAqhqlNI+YMNS1J3lavvcMwH2/GuitmY6F/VIXS1/
         J3HBYsTuW+ZXE/jrw1uyIqBcwjGyv+xEpr8IQ6kAa2z7+F2dvfpcMIezbJtI5h8GWb
         /h1X7fs6VAVUw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-nvme@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] nvme: target: fix nvme_keyring_id() references
Date:   Wed, 22 Nov 2023 23:47:17 +0100
Message-Id: <20231122224719.4042108-2-arnd@kernel.org>
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

In configurations without CONFIG_NVME_TARGET_TCP_TLS, the keyring
code might not be available, or using it will result in a runtime
failure:

x86_64-linux-ld: vmlinux.o: in function `nvmet_ports_make':
configfs.c:(.text+0x100a211): undefined reference to `nvme_keyring_id'

Add a check to ensure we only check the keyring if there is a chance
of it being used, which avoids both the runtime and link-time
problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9eed6e6765ea..e307a044b1a1 100644
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

