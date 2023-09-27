Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214B7AFE97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI0IdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjI0Icj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188A139
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ale7t5nl21L3c6+f7HGf39TkfmwA9pSSLTtCbVSuLOg=;
        b=etwyQr0K8p1yQQFMYL9Q7PR40lIp+5B6afE+UO7C/FThkJatCHlMDdTnfZUIbR5SHRi7MB
        RhcQyxFCKnJiQcYsiEQAqc9rLrzyTD2/eelDH60w6J0bBKUs/VQqlTlM2dZccQvhnwi80c
        +7Oq8wmW7Yzp784chw3g6qqlBxh+9D4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-JaT273wkOba_BfGclRbSbw-1; Wed, 27 Sep 2023 04:31:56 -0400
X-MC-Unique: JaT273wkOba_BfGclRbSbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01216185A797;
        Wed, 27 Sep 2023 08:31:56 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4417B200A6D2;
        Wed, 27 Sep 2023 08:31:54 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 9/9] i40e: Move DDP specific macros and structures to i40e_ddp.c
Date:   Wed, 27 Sep 2023 10:31:35 +0200
Message-ID: <20230927083135.3237206-10-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move several DDP related macros and structures from i40e.h header
to i40e_ddp.c where are privately used. Make static i40e_ddp_load()
function that is also used only in i40e_ddp and move declaration of
i40e_ddp_flash() used by i40e_ethtool.c to i40e_prototype.h

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 24 -------------------
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 22 +++++++++++++++--
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 ++++
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 107826c040c1..214744de120d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,7 +4,6 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
-#include <linux/ethtool.h>
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
@@ -296,29 +295,6 @@ struct i40e_udp_port_config {
 	u8 filter_index;
 };
 
-#define I40_DDP_FLASH_REGION 100
-#define I40E_PROFILE_INFO_SIZE 48
-#define I40E_MAX_PROFILE_NUM 16
-#define I40E_PROFILE_LIST_SIZE \
-	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
-#define I40E_DDP_PROFILE_PATH "intel/i40e/ddp/"
-#define I40E_DDP_PROFILE_NAME_MAX 64
-
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add);
-int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
-
-struct i40e_ddp_profile_list {
-	u32 p_count;
-	struct i40e_profile_info p_info[];
-};
-
-struct i40e_ddp_old_profile_list {
-	struct list_head list;
-	size_t old_ddp_size;
-	u8 old_ddp_buf[];
-};
-
 /* macros related to FLX_PIT */
 #define I40E_FLEX_SET_FSIZE(fsize) (((fsize) << \
 				    I40E_PRTQF_FLX_PIT_FSIZE_SHIFT) & \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 21b3518c4096..6b68b6575a1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -4,6 +4,24 @@
 #include <linux/firmware.h>
 #include "i40e.h"
 
+#define I40_DDP_FLASH_REGION		100
+#define I40E_PROFILE_INFO_SIZE		48
+#define I40E_MAX_PROFILE_NUM		16
+#define I40E_PROFILE_LIST_SIZE		\
+	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
+#define I40E_DDP_PROFILE_PATH		"intel/i40e/ddp/"
+#define I40E_DDP_PROFILE_NAME_MAX	64
+
+struct i40e_ddp_profile_list {
+	u32 p_count;
+	struct i40e_profile_info p_info[];
+};
+
+struct i40e_ddp_old_profile_list {
+	struct list_head list;
+	size_t old_ddp_size;
+	u8 old_ddp_buf[];
+};
 
 /**
  * i40e_ddp_profiles_eq - checks if DDP profiles are the equivalent
@@ -261,8 +279,8 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
  * Checks correctness and loads DDP profile to the NIC. The function is
  * also used for rolling back previously loaded profile.
  **/
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add)
+static int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
+			 bool is_add)
 {
 	u8 profile_info_sec[sizeof(struct i40e_profile_section_header) +
 			    sizeof(struct i40e_profile_info)];
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 2001fefa0c52..46b9a05ceb91 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_PROTOTYPE_H_
 #define _I40E_PROTOTYPE_H_
 
+#include <linux/ethtool.h>
 #include <linux/avf/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
@@ -497,4 +498,8 @@ int
 i40e_add_pinfo_to_list(struct i40e_hw *hw,
 		       struct i40e_profile_segment *profile,
 		       u8 *profile_info_sec, u32 track_id);
+
+/* i40e_ddp */
+int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
+
 #endif /* _I40E_PROTOTYPE_H_ */
-- 
2.41.0

