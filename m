Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4E7AFE99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjI0IdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjI0Icp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1F11D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZyPgXAelO+Y3ZPRMCaBbQ33LpF+p/D81QUX6pcDGzU=;
        b=XRD0Whhveh7fzS2nPvWhnI2v0PBYeSx5zQVAStN07jihY3XnVhRy7K0troFzzmbupnV1C8
        z0+bDP5BdPnYrMDg+Ofsz5NJL91WFNZ4N2/oqCyfqprJYfD1PBqc90aGr3EOyjbUUtYWhR
        Lvrbtu0AVXBzEBbKCtV7R/CL4e96HHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617--DK6aMBoOYiv5nBb92jg3w-1; Wed, 27 Sep 2023 04:31:54 -0400
X-MC-Unique: -DK6aMBoOYiv5nBb92jg3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FD048039C8;
        Wed, 27 Sep 2023 08:31:54 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 387642156702;
        Wed, 27 Sep 2023 08:31:52 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 8/9] i40e: Remove circular header dependencies and fix headers
Date:   Wed, 27 Sep 2023 10:31:34 +0200
Message-ID: <20230927083135.3237206-9-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly as for ice driver [1] there are also circular header
dependencies in i40e driver:
i40e.h -> i40e_virtchnl_pf.h -> i40e.h

Another issue is that i40e header files does not contain their own
depenencies on other header files (both private and standard) so their
inclusion in .c file require to add these deps in certain order to
that .c file to make it compilable.

Fix both issues by removal the mentioned circular dependency, by filling
i40e headers with their dependencies so they can be placed anywhere in
a source code. Additionally remove bunch of includes from i40e.h super
header file that are not necessary and include i40e.h only in .c files
that really require it.

[1] 649c87c6ff52 ("ice: remove circular header dependencies on ice.h")

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 43 ++++---------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +
 drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c | 11 +++--
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |  2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 ++-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 ++
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  8 ++--
 .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 ++++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  2 +
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 +--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  7 +--
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 ++
 27 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7f79d5929be6..107826c040c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,47 +4,20 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
-#include <net/tcp.h>
-#include <net/udp.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/netdevice.h>
-#include <linux/ioport.h>
-#include <linux/iommu.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/hashtable.h>
-#include <linux/string.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/sctp.h>
-#include <linux/pkt_sched.h>
-#include <linux/ipv6.h>
-#include <net/checksum.h>
-#include <net/ip6_checksum.h>
 #include <linux/ethtool.h>
-#include <linux/if_vlan.h>
-#include <linux/if_macvlan.h>
-#include <linux/if_bridge.h>
-#include <linux/clocksource.h>
-#include <linux/net_tstamp.h>
+#include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/types.h>
+#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/i40e_client.h>
 #include <net/pkt_cls.h>
-#include <net/pkt_sched.h>
-#include <net/tc_act/tc_gact.h>
-#include <net/tc_act/tc_mirred.h>
 #include <net/udp_tunnel.h>
-#include <net/xdp_sock.h>
-#include <linux/bitfield.h>
-#include "i40e_type.h"
+#include "i40e_dcb.h"
+#include "i40e_debug.h"
+#include "i40e_io.h"
 #include "i40e_prototype.h"
-#include <linux/net/intel/i40e_client.h>
-#include <linux/avf/virtchnl.h>
-#include "i40e_virtchnl_pf.h"
+#include "i40e_register.h"
 #include "i40e_txrx.h"
-#include "i40e_dcb.h"
 
 /* Useful i40e defaults */
 #define I40E_MAX_VEB			16
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index e72cfe587c89..9ce6e633cc2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e_type.h"
+#include <linux/delay.h>
+#include "i40e_alloc.h"
 #include "i40e_register.h"
-#include "i40e_adminq.h"
 #include "i40e_prototype.h"
 
 static void i40e_resume_aq(struct i40e_hw *hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 3357d65a906b..18a1c3b6d72c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_ADMINQ_CMD_H_
 #define _I40E_ADMINQ_CMD_H_
 
+#include <linux/bits.h>
+
 /* This header file defines the i40e Admin Queue commands and is shared between
  * i40e Firmware and Software.
  *
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 639c5a1ca853..306758428aef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -6,7 +6,6 @@
 #include <linux/net/intel/i40e_client.h>
 
 #include "i40e.h"
-#include "i40e_prototype.h"
 
 static LIST_HEAD(i40e_devices);
 static DEFINE_MUTEX(i40e_device_mutex);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index eeef20f77106..6d1042ca0317 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_type.h"
-#include "i40e_adminq.h"
-#include "i40e_prototype.h"
 #include <linux/avf/virtchnl.h>
+#include <linux/delay.h>
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+#include "i40e_adminq_cmd.h"
+#include "i40e_devids.h"
+#include "i40e_prototype.h"
+#include "i40e_register.h"
 
 /**
  * i40e_set_mac_type - Sets MAC type
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index f81e744c0fb3..68602fc375f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include "i40e_adminq.h"
-#include "i40e_prototype.h"
+#include "i40e_alloc.h"
 #include "i40e_dcb.h"
+#include "i40e_prototype.h"
 
 /**
  * i40e_get_dcbx_status
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 195421d863ab..077a95dad32c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -2,8 +2,8 @@
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
 #ifdef CONFIG_I40E_DCB
-#include "i40e.h"
 #include <net/dcbnl.h>
+#include "i40e.h"
 
 #define I40E_DCBNL_STATUS_SUCCESS	0
 #define I40E_DCBNL_STATUS_ERROR		1
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 0e72abd178ae..21b3518c4096 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/firmware.h>
 #include "i40e.h"
 
-#include <linux/firmware.h>
 
 /**
  * i40e_ddp_profiles_eq - checks if DDP profiles are the equivalent
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 1a497cb07710..999c9708def5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -5,8 +5,9 @@
 
 #include <linux/fs.h>
 #include <linux/debugfs.h>
-
+#include <linux/if_bridge.h>
 #include "i40e.h"
+#include "i40e_virtchnl_pf.h"
 
 static struct dentry *i40e_dbg_root;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index c3ce5f35211f..ece3a6b9a5c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -4,7 +4,10 @@
 #ifndef _I40E_DIAG_H_
 #define _I40E_DIAG_H_
 
-#include "i40e_type.h"
+#include "i40e_adminq_cmd.h"
+
+/* forward-declare the HW struct for the compiler */
+struct i40e_hw;
 
 enum i40e_lb_mode {
 	I40E_LB_MODE_NONE       = 0x0,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bd1321bf7e26..4e90570ba780 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3,9 +3,10 @@
 
 /* ethtool support for i40e */
 
-#include "i40e.h"
+#include "i40e_devids.h"
 #include "i40e_diag.h"
 #include "i40e_txrx_common.h"
+#include "i40e_virtchnl_pf.h"
 
 /* ethtool statistics helpers */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index b383aea652f3..1742624ca62e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_register.h"
 #include "i40e_alloc.h"
+#include "i40e_debug.h"
 #include "i40e_hmc.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 9960da07a573..480e3a883cc7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,10 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include "i40e_alloc.h"
+#include "i40e_io.h"
+#include "i40e_register.h"
+
 #define I40E_HMC_MAX_BP_COUNT 512
 
 /* forward-declare the HW struct for the compiler */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 830f1de254ef..beaaf5c309d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_register.h"
-#include "i40e_type.h"
-#include "i40e_hmc.h"
+#include "i40e_alloc.h"
+#include "i40e_debug.h"
 #include "i40e_lan_hmc.h"
-#include "i40e_prototype.h"
+#include "i40e_type.h"
 
 /* lan specific interface functions */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
index 9f960404c2b3..305a276953b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_LAN_HMC_H_
 #define _I40E_LAN_HMC_H_
 
+#include "i40e_hmc.h"
+
 /* forward-declare the HW struct for the compiler */
 struct i40e_hw;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 40237c778c63..69606db341eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1,19 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/etherdevice.h>
-#include <linux/of_net.h>
-#include <linux/pci.h>
-#include <linux/bpf.h>
 #include <generated/utsrelease.h>
 #include <linux/crash_dump.h>
+#include <linux/if_bridge.h>
+#include <linux/if_macvlan.h>
+#include <linux/module.h>
+#include <net/pkt_cls.h>
+#include <net/xdp_sock_drv.h>
 
 /* Local includes */
 #include "i40e.h"
+#include "i40e_devids.h"
 #include "i40e_diag.h"
+#include "i40e_lan_hmc.h"
+#include "i40e_virtchnl_pf.h"
 #include "i40e_xsk.h"
-#include <net/udp_tunnel.h>
-#include <net/xdp_sock_drv.h>
+
 /* All i40e tracepoints are defined by the include below, which
  * must be included exactly once across the whole kernel with
  * CREATE_TRACE_POINTS defined
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 07a46adeab38..77cdbfc19d47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/delay.h>
+#include "i40e_alloc.h"
 #include "i40e_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 9c9234c0706f..2001fefa0c52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -4,10 +4,9 @@
 #ifndef _I40E_PROTOTYPE_H_
 #define _I40E_PROTOTYPE_H_
 
-#include "i40e_type.h"
-#include "i40e_alloc.h"
-#include "i40e_debug.h"
 #include <linux/avf/virtchnl.h>
+#include "i40e_debug.h"
+#include "i40e_type.h"
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 8a26811140b4..20b77398f060 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
 #include <linux/ptp_classify.h>
 #include <linux/posix-clock.h>
+#include "i40e.h"
+#include "i40e_devids.h"
 
 /* The XL710 timesync is very much like Intel's 82599 design when it comes to
  * the fundamental clock design. However, the clock operations are much simpler
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb..636ce49d4e79 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1,14 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/prefetch.h>
 #include <linux/bpf_trace.h>
+#include <linux/prefetch.h>
+#include <linux/sctp.h>
 #include <net/mpls.h>
 #include <net/xdp.h>
-#include "i40e.h"
-#include "i40e_trace.h"
-#include "i40e_prototype.h"
 #include "i40e_txrx_common.h"
+#include "i40e_trace.h"
 #include "i40e_xsk.h"
 
 #define I40E_TXD_CMD (I40E_TX_DESC_CMD_EOP | I40E_TX_DESC_CMD_RS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 900b0d9ede9f..421fe5675584 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -5,6 +5,7 @@
 #define _I40E_TXRX_H_
 
 #include <net/xdp.h>
+#include "i40e_type.h"
 
 /* Interrupt Throttling and Rate Limiting Goodies */
 #define I40E_DEFAULT_IRQ_WORK      256
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 8c5118c8baaf..e26807fd2123 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -4,6 +4,8 @@
 #ifndef I40E_TXRX_COMMON_
 #define I40E_TXRX_COMMON_
 
+#include "i40e.h"
+
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
 void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
 				   u64 qword1);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index b3980b5b6919..dc7cd16ad8fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -4,14 +4,9 @@
 #ifndef _I40E_TYPE_H_
 #define _I40E_TYPE_H_
 
-#include <linux/delay.h>
-#include <linux/if_ether.h>
-#include "i40e_io.h"
-#include "i40e_register.h"
+#include <uapi/linux/if_ether.h>
 #include "i40e_adminq.h"
 #include "i40e_hmc.h"
-#include "i40e_lan_hmc.h"
-#include "i40e_devids.h"
 
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			4
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d3d6415553ed..438948720716 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "i40e.h"
+#include "i40e_lan_hmc.h"
+#include "i40e_virtchnl_pf.h"
 
 /*********************notification routines***********************/
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 895b8feb2567..2ee0f8a23248 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,9 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include "i40e.h"
+#include <linux/avf/virtchnl.h>
+#include <linux/netdevice.h>
+#include "i40e_type.h"
 
 #define I40E_MAX_VLANID 4095
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 37f41c8a682f..4a49848f7781 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -2,11 +2,7 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <linux/stringify.h>
 #include <net/xdp_sock_drv.h>
-#include <net/xdp.h>
-
-#include "i40e.h"
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index 821df248f8be..ef156fad52f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_XSK_H_
 #define _I40E_XSK_H_
 
+#include <linux/types.h>
+
 /* This value should match the pragma in the loop_unrolled_for
  * macro. Why 4? It is strictly empirical. It seems to be a good
  * compromise between the advantage of having simultaneous outstanding
@@ -20,7 +22,9 @@
 #define loop_unrolled_for for
 #endif
 
+struct i40e_ring;
 struct i40e_vsi;
+struct net_device;
 struct xsk_buff_pool;
 
 int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair);
-- 
2.41.0

