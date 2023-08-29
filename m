Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9771578C5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjH2Ne3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjH2Ndh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6F1B7;
        Tue, 29 Aug 2023 06:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C906577C;
        Tue, 29 Aug 2023 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01CC433CC;
        Tue, 29 Aug 2023 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315976;
        bh=8A9HVwbG0lhe1zjrODO9hy3JO/qnRf1tmJiWu2sV0Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbEB3iZ4MBaQQ83hrsFbBMyEHR9bLwR3mv3ilsMWbo14/41TWFqUOs/Te4bgT3hXy
         xZBonHcVdE1Orud8FmB22CtklxZYYGfwSfCi3yte2u4TOUBPP6nh08C/RssnhbG7qn
         DN5zXiSJHZcc9As7hvtI/m22J3GnT/CU6aGnkTJhFoA/nfW3DgxIcQSE4J1xz9qyr6
         avnxGgulZp+bZbt+ez84N/8/ksgtDXacFFIyo/Nfhwy3x3iHMNj3Rie9GycM/1FsKA
         DWw0MScEA8oyweZenyPnKCluoOy3+n5AA5PLCneLVGlHxMj21sHI4zV1sf/NQyebCv
         9/+16O+qmsT7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 05/15] smb/client: print "Unknown" instead of bogus link speed value
Date:   Tue, 29 Aug 2023 09:32:35 -0400
Message-Id: <20230829133245.520176-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133245.520176-1-sashal@kernel.org>
References: <20230829133245.520176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.49
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 fs/smb/client/cifs_debug.c | 47 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index e41154ad96afc..492f9b11e9ad0 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/uaccess.h>
+#include <uapi/linux/ethtool.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -145,18 +146,62 @@ cifs_dump_channel(struct seq_file *m, int i, struct cifs_chan *chan)
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

