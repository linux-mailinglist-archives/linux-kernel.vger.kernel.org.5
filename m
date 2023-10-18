Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9227CDBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJRMhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjJRMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82C11B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697632566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aPx8egapRZzyiG5lm1UPqh0dzOQ1EzfFBnJkY2r5zdM=;
        b=MIqKNmSLxoO5MLLa+L7P0IMtoJbvWD0DNyv1pQ27wA5Ao7G+OiYrcy0ZVv7erACO1NpFzk
        Kaumg8Gtg0xBs8UV6dhOQU1zuF4vqvvKJVM4alC5/ngfTVQ8d4EnIFUdspmGJy3oSJrh11
        ANzzSDmfgXecYT4Ia1Zfjf/QYxt43os=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-29pT3JhJOnSXy1dqd0TGlA-1; Wed, 18 Oct 2023 08:36:02 -0400
X-MC-Unique: 29pT3JhJOnSXy1dqd0TGlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0D7B1C05AB2;
        Wed, 18 Oct 2023 12:36:01 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E48A2166B26;
        Wed, 18 Oct 2023 12:35:58 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH net-next] i40e: Align devlink info versions with ice driver and add docs
Date:   Wed, 18 Oct 2023 14:35:55 +0200
Message-ID: <20231018123558.552453-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align devlink info versions with ice driver so change 'fw.mgmt'
version to be 2-digit version [major.minor], add 'fw.mgmt.build'
that reports mgmt firmware build number and use '"fw.psid.api'
for NVM format version instead of incorrect '"fw.psid'.
Additionally add missing i40e devlink documentation.

Fixes: 5a423552e0d9 ("i40e: Add handler for devlink .info_get")
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 59 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 18 +++++-
 3 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/i40e.rst

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
new file mode 100644
index 000000000000..d3cb5bb5197e
--- /dev/null
+++ b/Documentation/networking/devlink/i40e.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+i40e devlink support
+====================
+
+This document describes the devlink features implemented by the ``i40e``
+device driver.
+
+Info versions
+=============
+
+The ``i40e`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``board.id``
+      - fixed
+      - K15190-000
+      - The Product Board Assembly (PBA) identifier of the board.
+    * - ``fw.mgmt``
+      - running
+      - 9.130
+      - 2-digit version number of the management firmware that controls the
+        PHY, link, etc.
+    * - ``fw.mgmt.api``
+      - running
+      - 1.15
+      - 2-digit version number of the API exported over the AdminQ by the
+        management firmware. Used by the driver to identify what commands
+        are supported.
+    * - ``fw.mgmt.build``
+      - running
+      - 73618
+      - Build number of the source for the management firmware.
+    * - ``fw.undi``
+      - running
+      - 1.3429.0
+      - Version of the Option ROM containing the UEFI driver. The version is
+        reported in ``major.minor.patch`` format. The major version is
+        incremented whenever a major breaking change occurs, or when the
+        minor version would overflow. The minor version is incremented for
+        non-breaking changes and reset to 1 when the major version is
+        incremented. The patch version is normally 0 but is incremented when
+        a fix is delivered as a patch against an older base Option ROM.
+    * - ``fw.psid.api``
+      - running
+      - 9.30
+      - Version defining the format of the flash contents.
+    * - ``fw.bundle_id``
+      - running
+      - 0x8000e5f3
+      - Unique identifier of the firmware image file that was loaded onto
+        the device. Also referred to as the EETRACK identifier of the NVM.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index b49749e2b9a6..2b78060aaa58 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -52,6 +52,7 @@ parameters, info versions, and other features it supports.
    bnxt
    etas_es58x
    hns3
+   i40e
    ionic
    ice
    mlx4
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 9168ade8da47..74bc111b4849 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -18,8 +18,14 @@ static void i40e_info_fw_mgmt(struct i40e_hw *hw, char *buf, size_t len)
 {
 	struct i40e_adminq_info *aq = &hw->aq;
 
-	snprintf(buf, len, "%u.%u.%05d",
-		 aq->fw_maj_ver, aq->fw_min_ver, aq->fw_build);
+	snprintf(buf, len, "%u.%u", aq->fw_maj_ver, aq->fw_min_ver);
+}
+
+static void i40e_info_fw_mgmt_build(struct i40e_hw *hw, char *buf, size_t len)
+{
+	struct i40e_adminq_info *aq = &hw->aq;
+
+	snprintf(buf, len, "%05d", aq->fw_build);
 }
 
 static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
@@ -77,6 +83,12 @@ static int i40e_devlink_info_get(struct devlink *dl,
 	if (err)
 		return err;
 
+	i40e_info_fw_mgmt_build(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    "fw.mgmt.build", buf);
+	if (err)
+		return err;
+
 	i40e_info_fw_api(hw, buf, sizeof(buf));
 	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
 				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
@@ -86,7 +98,7 @@ static int i40e_devlink_info_get(struct devlink *dl,
 
 	i40e_info_nvm_ver(hw, buf, sizeof(buf));
 	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
-				    DEVLINK_INFO_VERSION_GENERIC_FW_PSID, buf);
+				    "fw.psid.api", buf);
 	if (err)
 		return err;
 
-- 
2.41.0

