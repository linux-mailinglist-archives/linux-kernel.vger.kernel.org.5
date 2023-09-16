Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47B7A2EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjIPJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbjIPJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:11:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD2173C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:11:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B56C433C8;
        Sat, 16 Sep 2023 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694855499;
        bh=covprlx2zu7EStEAq1dkZceiipg+g+xBDyRtgZg9lEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L20Zf8ShTCrxx+h6ckh03Od5+HOYHYbXqncrkJFqcHhMf9IrBOY8fGUP42lmwZ8hg
         +G68JIxSWkJsBBX5C+H8XG84fNggO1Xd9HeIFddmEarKb+almvYUrq+QPAscJPy7Y+
         ZJnlCfgb8qXzGMGbhN0lIJhBmiToMaL7ftQJkb3YYY/ZfJm1nO1Pj48Yi++ke1Toye
         QHRhiZU6m+MbTyEqctSauNs/Td80++HpiH1UAypN0HYsbET1CqRyu3QmBMa6b17yq0
         IdZ7RgYG5mTRGTWuqX10IzfF9CEBeEJolpaPYvdHps1I4CKZY1nkXS73+GVSy95iMV
         zojbBd90U/DSw==
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/2] vlynq: remove bus driver
Date:   Sat, 16 Sep 2023 11:11:24 +0200
Message-Id: <20230916091125.3221-3-wsa@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230916091125.3221-1-wsa@kernel.org>
References: <20230916091125.3221-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There are no users with a vlynq_driver in the Kernel tree. So, remove
the bus driver which hardly has seen any activity since 2009. It was
even marked EXPERIMENTAL as long as that symbol existed. OpenWRT had
some out-of-tree drivers which they probably intended to upport, but AR7
devices are not supported anymore because they are "stuck with Kernel
3.18" [1]. So, this code can go nowadays.

[1] https://openwrt.org/docs/techref/targets/ar7

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS            |   7 -
 drivers/Kconfig        |   2 -
 drivers/Makefile       |   1 -
 drivers/vlynq/Kconfig  |  21 --
 drivers/vlynq/Makefile |   6 -
 drivers/vlynq/vlynq.c  | 799 -----------------------------------------
 include/linux/vlynq.h  | 149 --------
 7 files changed, 985 deletions(-)
 delete mode 100644 drivers/vlynq/Kconfig
 delete mode 100644 drivers/vlynq/Makefile
 delete mode 100644 drivers/vlynq/vlynq.c
 delete mode 100644 include/linux/vlynq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..02b83539a5ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22962,13 +22962,6 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/test-drivers/vivid/*
 
-VLYNQ BUS
-M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	openwrt-devel@lists.openwrt.org (subscribers-only)
-S:	Maintained
-F:	drivers/vlynq/vlynq.c
-F:	include/linux/vlynq.h
-
 VM SOCKETS (AF_VSOCK)
 M:	Stefano Garzarella <sgarzare@redhat.com>
 L:	virtualization@lists.linux-foundation.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index efb66e25fa2d..9c8b82ddebfe 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -135,8 +135,6 @@ source "drivers/uio/Kconfig"
 
 source "drivers/vfio/Kconfig"
 
-source "drivers/vlynq/Kconfig"
-
 source "drivers/virt/Kconfig"
 
 source "drivers/virtio/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index cb0afca2e4a0..2ec0005bb840 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -151,7 +151,6 @@ obj-$(CONFIG_BCMA)		+= bcma/
 obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
-obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_STAGING)		+= staging/
diff --git a/drivers/vlynq/Kconfig b/drivers/vlynq/Kconfig
deleted file mode 100644
index e7f9492a0b04..000000000000
diff --git a/drivers/vlynq/Makefile b/drivers/vlynq/Makefile
deleted file mode 100644
index d9ce5b2b5ce0..000000000000
diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
deleted file mode 100644
index 4af6615808cc..000000000000
diff --git a/include/linux/vlynq.h b/include/linux/vlynq.h
deleted file mode 100644
index e9c0cd36c48a..000000000000
-- 
2.35.1

