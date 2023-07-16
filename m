Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D26754DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGPILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:11:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6410CE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689495083; x=1721031083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VnsxLYvCvyCBABoIYzKpNH9e1ZYoWD8xZygRXctFTw=;
  b=fc55kHY1TXl3Ctzc94hxBfBBbuwM46JcqBGT3yHJPm92Gk1bfk/7c9xz
   16V2wZ0LN618v6I4TIJDEPBvc0NmrioGTMGj9PJ1ebPbpV/FqsObh6QJx
   6VtKQjLrVLxy4gxmVHas2pBRriu8khkk0xo036MZ0hxyxQxSak0QkuB5O
   q0DLieGt4NPdkNTc/Oks43o3UVfB48DPH76kzeesM3pF/pDaPDT4QWHlk
   pG3U+ecJ08lI9nH7vk1tBVRstI3NlSw+KDIpLDsTWZ9cK1ILJcwx8BQfG
   zSOjWWrvaTIlgASXSe74sKCGUUjPBZE+28QVTudEcGV2fPuuMziJD0NOe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="368381704"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="368381704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="716823137"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="716823137"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:15 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/4] mei: obtain firmware version only on gsc.
Date:   Sun, 16 Jul 2023 11:10:42 +0300
Message-ID: <20230716081043.3092690-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716081043.3092690-1-tomas.winkler@intel.com>
References: <20230716081043.3092690-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Modern GSC firmwares have both static and dynamic MKHI clients.
Avoid expensive dynamic client call for firmware version retrieval,
in case the firmware version is already retrieved from the fix address
client in bus_fixup().

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 10 +++++++---
 drivers/misc/mei/init.c      |  3 +++
 drivers/misc/mei/mei_dev.h   |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index b8b716faf1921914fad9fcc7..2733070acf39eabfd606da38 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -184,6 +184,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 		cldev->bus->fw_ver[i].hotfix = fwver->ver[i].hotfix;
 		cldev->bus->fw_ver[i].buildno = fwver->ver[i].buildno;
 	}
+	cldev->bus->fw_ver_received = 1;
 
 	return ret;
 }
@@ -237,8 +238,11 @@ static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
 {
 	int ret;
 
-	/* No need to enable the client if nothing is needed from it */
-	if (!cldev->bus->fw_f_fw_ver_supported)
+	/*
+	 * No need to enable the client if nothing is needed from it.
+	 * No need to fill in version if it is already filled in by the fix address client.
+	 */
+	if (!cldev->bus->fw_f_fw_ver_supported || cldev->bus->fw_ver_received)
 		return;
 
 	ret = mei_cldev_enable(cldev);
@@ -555,8 +559,8 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_NFC_HCI, mei_nfc),
 	MEI_FIXUP(MEI_UUID_WD, mei_wd),
 	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
-	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
 	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_fix_ver),
+	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
 	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
 	MEI_FIXUP(MEI_UUID_ANY, vt_support),
 	MEI_FIXUP(MEI_UUID_PAVP, pxp_is_ready),
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 5cc75a3314a6482e64a1c809..c35e005b26be4fb81f7d0748 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -142,6 +142,9 @@ int mei_reset(struct mei_device *dev)
 
 	mei_hbm_reset(dev);
 
+	/* clean stale FW version */
+	dev->fw_ver_received = 0;
+
 	memset(dev->rd_msg_hdr, 0, sizeof(dev->rd_msg_hdr));
 
 	if (ret) {
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 895011b7a0bfa223a5e97403..cdf8a2edf0b32b7dd6a0af53 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -512,6 +512,7 @@ struct mei_dev_timeouts {
  * @fw_ver : FW versions
  *
  * @fw_f_fw_ver_supported : fw feature: fw version supported
+ * @fw_ver_received : fw version received
  *
  * @me_clients_rwsem: rw lock over me_clients list
  * @me_clients  : list of FW clients
@@ -604,6 +605,7 @@ struct mei_device {
 	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
 
 	unsigned int fw_f_fw_ver_supported:1;
+	unsigned int fw_ver_received:1;
 
 	struct rw_semaphore me_clients_rwsem;
 	struct list_head me_clients;
-- 
2.41.0

