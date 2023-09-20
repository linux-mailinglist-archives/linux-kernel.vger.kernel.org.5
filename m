Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1A7A8D88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjITULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjITUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:10:53 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295CAB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=VQKOrsOQY3kT1v4EL/KY2u2jCcRiHXjGrkrknpskVE8=; b=FG4r4u
        DMIOJcUbq+oESypBrD/jP7jbitOHGTGgHMi8WLJERH/AdkavuLjbLAo8Fw7uZCOg
        QBvX/uP/ypBFSGI6M+7/8ObaDyKrpDuUo8mWx1Ie8MHqQnt5EoMXDBqXlPQ17OUQ
        lXmkvr4Go0ZnEGwiCPEf7h0Dp6RJa5YbKYqTao3nkUtQwYPTmlvLfqjb7unwniVx
        Y0MEmUx3C5JZG7JLQIHJw1cN2eTO2nKmeUgnsYlzdW5r2Zgch9a5R0e3NJXG+v3e
        OLbWXX6KKhGhLGsOjO2+5coC1F5PywD/8j7rjJK2wU2TFS2YWWqY4yl4ic0dQFfS
        hNhGxR+PHZSwsKrw==
Received: (qmail 720278 invoked from network); 20 Sep 2023 22:10:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:43 +0200
X-UD-Smtp-Session: l3s3148p1@cA5a+M8F7tgujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] vlynq: remove bus driver
Date:   Wed, 20 Sep 2023 22:10:29 +0200
Message-Id: <20230920201035.3445-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users with a vlynq_driver in the Kernel tree. Also, only
the AR7 platform ever initialized a VLYNQ bus, but AR7 is going to be
removed from the Kernel. OpenWRT had some out-of-tree drivers which they
probably intended to upport, but AR7 devices are even there not
supported anymore because they are "stuck with Kernel
3.18" [1]. This code can go.

[1] https://openwrt.org/docs/techref/targets/ar7

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
index bf0f54c24f81..bdd6e7ce962d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22961,13 +22961,6 @@ W:	https://linuxtv.org
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
index 1bec7819a837..f7eeec79ef66 100644
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

