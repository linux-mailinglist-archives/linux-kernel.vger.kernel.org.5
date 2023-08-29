Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F402078C5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjH2Neq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjH2Ndj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDECCD8;
        Tue, 29 Aug 2023 06:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE2765768;
        Tue, 29 Aug 2023 13:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3536C433CA;
        Tue, 29 Aug 2023 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316004;
        bh=zedgukbbYToy89QkCAHIwSs/LEmKvP2tRYSnc3jeda0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc/JU1obF5SkgOa3/2WHJdXD0oriOWF/J5ou5jPo+mKPWuQb8ic2ttLgovjmEFwKt
         y//SE+M+rQJGi9VH909KSjRx4y8btLgDeQq19THW4pZ373fh0y9idKksXhGl+IApnV
         bcom4VOslRZqH/IbuuHJm4mFqRf2oWnCHF4SYFkcdKUdeP6poeAU62uHt5IMlKx6VQ
         eCltF9itfpBsrTFsp/woWxJ454+A8o/b5urGwO/rxmq8WED+8EVCveHkJySJ2akvr2
         TyZSnfj42+C5puJzYZTnQsJ/IoXfV9G+PQXdnq4z2Gg/NUdjjIH2/Mdisa68bEhY3h
         K0LzlkuZOsd0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        pc@manguebit.com, linkinjeon@kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] smb/client: print "Unknown" instead of bogus link speed value
Date:   Tue, 29 Aug 2023 09:33:10 -0400
Message-Id: <20230829133316.520410-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133316.520410-1-sashal@kernel.org>
References: <20230829133316.520410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.128
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit 50e63d6db6fd30a6dd9a33c49aa5b0bba36e1a92 ]

The virtio driver for Linux guests will not set a link speed to its
paravirtualized NICs.  This will be seen as -1 in the ethernet layer, and
when some servers (e.g. samba) fetches it, it's converted to an unsigned
value (and multiplied by 1000 * 1000), so in client side we end up with:

1)      Speed: 4294967295000000 bps

in DebugData.

This patch introduces a helper that returns a speed string (in Mbps or
Gbps) if interface speed is valid (>= SPEED_10 and <= SPEED_800000), or
"Unknown" otherwise.

The reason to not change the value in iface->speed is because we don't
know the real speed of the HW backing the server NIC, so let's keep
considering these as the fastest NICs available.

Also print "Capabilities: None" when the interface doesn't support any.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_debug.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index e7501533c2ec9..8294e8be16661 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/uaccess.h>
+#include <uapi/linux/ethtool.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -144,18 +145,62 @@ cifs_dump_channel(struct seq_file *m, int i, struct cifs_chan *chan)
 		   atomic_read(&server->num_waiters));
 }
 
+static inline const char *smb_speed_to_str(size_t bps)
+{
+	size_t mbps = bps / 1000 / 1000;
+
+	switch (mbps) {
+	case SPEED_10:
+		return "10Mbps";
+	case SPEED_100:
+		return "100Mbps";
+	case SPEED_1000:
+		return "1Gbps";
+	case SPEED_2500:
+		return "2.5Gbps";
+	case SPEED_5000:
+		return "5Gbps";
+	case SPEED_10000:
+		return "10Gbps";
+	case SPEED_14000:
+		return "14Gbps";
+	case SPEED_20000:
+		return "20Gbps";
+	case SPEED_25000:
+		return "25Gbps";
+	case SPEED_40000:
+		return "40Gbps";
+	case SPEED_50000:
+		return "50Gbps";
+	case SPEED_56000:
+		return "56Gbps";
+	case SPEED_100000:
+		return "100Gbps";
+	case SPEED_200000:
+		return "200Gbps";
+	case SPEED_400000:
+		return "400Gbps";
+	case SPEED_800000:
+		return "800Gbps";
+	default:
+		return "Unknown";
+	}
+}
+
 static void
 cifs_dump_iface(struct seq_file *m, struct cifs_server_iface *iface)
 {
 	struct sockaddr_in *ipv4 = (struct sockaddr_in *)&iface->sockaddr;
 	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)&iface->sockaddr;
 
-	seq_printf(m, "\tSpeed: %zu bps\n", iface->speed);
+	seq_printf(m, "\tSpeed: %s\n", smb_speed_to_str(iface->speed));
 	seq_puts(m, "\t\tCapabilities: ");
 	if (iface->rdma_capable)
 		seq_puts(m, "rdma ");
 	if (iface->rss_capable)
 		seq_puts(m, "rss ");
+	if (!iface->rdma_capable && !iface->rss_capable)
+		seq_puts(m, "None");
 	seq_putc(m, '\n');
 	if (iface->sockaddr.ss_family == AF_INET)
 		seq_printf(m, "\t\tIPv4: %pI4\n", &ipv4->sin_addr);
-- 
2.40.1

