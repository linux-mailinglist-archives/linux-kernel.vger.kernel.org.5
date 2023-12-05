Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF38044C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbjLECYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjLECYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F1127;
        Mon,  4 Dec 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pNSHt1qjKkmun73NtHUBoqlH5TEknOWoQ/sbXTljCIM=; b=st/az1P9IBfHQEOiaH/Ly7oG9D
        Nh8if8F5zrtovJ0hWP1ItU2ZNK0tuZqelLLPkb5hNIeNW+rTpqp3AYLyOFtg5ll/J6T+WSxVyHBcD
        wcplkf9n4f88KDjQ3A5BkwzhDeAElwzq3R46bXZekBBd3ypL9XTOAwVkMWlyrtt1ExO40SmG2jRVE
        wijxzcqfqR/TjFZGsHWTlQ77+gXtIJsxO/RntMaqXgwpCV731sf4hVZrfAHSvlkSNi8ln9bsCNeDC
        g/+f75FxXsjcq72Z8bi93KGmjhbkTIo3HL4BHVpzAwYNLElaCapb/vCZ/RG5wnJjPWBl2oZzHuHWj
        jasouqBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6g-007922-33;
        Tue, 05 Dec 2023 02:24:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 02/18] get rid of asm/checksum.h includes outside of include/net/checksum.h and arch
Date:   Tue,  5 Dec 2023 02:23:54 +0000
Message-Id: <20231205022418.1703007-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in almost all cases include is redundant; zcore.c and checksum_kunit.c are the sole
exceptions and those got switched to net/checksum.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/ethernet/brocade/bna/bnad.h | 2 --
 drivers/net/ethernet/lantiq_etop.c      | 2 --
 drivers/net/vmxnet3/vmxnet3_int.h       | 1 -
 drivers/s390/char/zcore.c               | 2 +-
 include/net/ip6_checksum.h              | 1 -
 lib/checksum_kunit.c                    | 2 +-
 net/ipv6/ip6_checksum.c                 | 1 -
 7 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethernet/brocade/bna/bnad.h
index 10b1e534030e..0842a276dcf4 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.h
+++ b/drivers/net/ethernet/brocade/bna/bnad.h
@@ -18,8 +18,6 @@
 #include <linux/mutex.h>
 #include <linux/firmware.h>
 #include <linux/if_vlan.h>
-
-#include <asm/checksum.h>
 #include <net/ip6_checksum.h>
 
 #include <net/ip.h>
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 1d5b7bb6380f..f95bdb42b25f 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -27,8 +27,6 @@
 #include <linux/module.h>
 #include <linux/property.h>
 
-#include <asm/checksum.h>
-
 #include <lantiq_soc.h>
 #include <xway_dma.h>
 #include <lantiq_platform.h>
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 915aaf18c409..bef4cd73f06d 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -51,7 +51,6 @@
 #include <linux/ipv6.h>
 #include <linux/in.h>
 #include <linux/etherdevice.h>
-#include <asm/checksum.h>
 #include <linux/if_vlan.h>
 #include <linux/if_arp.h>
 #include <linux/inetdevice.h>
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index bc3be0330f1d..040b92ecaeab 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -18,6 +18,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/uio.h>
+#include <net/checksum.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -27,7 +28,6 @@
 #include <asm/debug.h>
 #include <asm/processor.h>
 #include <asm/irqflags.h>
-#include <asm/checksum.h>
 #include <asm/os_info.h>
 #include <asm/switch_to.h>
 #include <asm/maccess.h>
diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index c8a96b888277..6cc775357230 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -25,7 +25,6 @@
 #include <asm/types.h>
 #include <asm/byteorder.h>
 #include <net/ip.h>
-#include <asm/checksum.h>
 #include <linux/in6.h>
 #include <linux/tcp.h>
 #include <linux/ipv6.h>
diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 0eed92b77ba3..971e7824893b 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -4,7 +4,7 @@
  */
 
 #include <kunit/test.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 
 #define MAX_LEN 512
 #define MAX_ALIGN 64
diff --git a/net/ipv6/ip6_checksum.c b/net/ipv6/ip6_checksum.c
index 377717045f8f..7868163b8a24 100644
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -2,7 +2,6 @@
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/udplite.h>
-#include <asm/checksum.h>
 
 #ifndef _HAVE_ARCH_IPV6_CSUM
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-- 
2.39.2

