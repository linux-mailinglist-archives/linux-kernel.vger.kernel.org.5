Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A57C8C05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJMRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9ACA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697216887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzYU8tZrQoBUqhyJIMs+CkJlNvAKzLmyrsJLGqvx8lA=;
        b=MlWGA7jSIt/ownhnQ4IhqZRcSafeff2tBbR8VPXLwGaqllS+bvOIY+kl3NiSJ/ozC+v4lf
        myMBMa8kTZ7hONhv5Enc3GMLtwIGPPf95Noyw0gbM+ij0/naAkSpTUQB2RPNH42MySPKIk
        gpWbTFXX2l8/93gj0r3ofarKBPZ/dxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-mOnxf32-N0SiogJ9B7HHaA-1; Fri, 13 Oct 2023 13:08:02 -0400
X-MC-Unique: mOnxf32-N0SiogJ9B7HHaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86B7581D9E1;
        Fri, 13 Oct 2023 17:08:01 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20B4D1C060DF;
        Fri, 13 Oct 2023 17:08:00 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 2/5] i40e: Split and refactor i40e_nvm_version_str()
Date:   Fri, 13 Oct 2023 19:07:52 +0200
Message-ID: <20231013170755.2367410-3-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

The function formats NVM version string according adapter's
EETrackID value. If this value OEM specific (0xffffffff) then
the reported version is with format:
"<gen>.<snap>.<release>"
and in other case
"<nvm_maj>.<nvm_min> <eetrackid> <cvid_maj>.<cvid_bld>.<cvid_min>"

These versions are reported in the subsequent patch in this series
that implements devlink .info_get but separately.

So split the function into separate ones, refactor it to use them
and remove ugly static string buffer.
Additionally convert NVM/OEM version mask macros to use GENMASK and
use FIELD_GET/FIELD_PREP for them in i40e_nvm_version_str() and
i40e_get_oem_version(). This makes code more readable and allows
us to remove related shift macros.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 133 +++++++++++++-----
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  12 +-
 3 files changed, 105 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b7e20cea19c2..c4cd54aa4dd5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -49,23 +49,19 @@
 #define I40E_QUEUE_WAIT_RETRY_LIMIT	10
 #define I40E_INT_NAME_STR_LEN		(IFNAMSIZ + 16)
 
-#define I40E_NVM_VERSION_LO_SHIFT	0
-#define I40E_NVM_VERSION_LO_MASK	(0xff << I40E_NVM_VERSION_LO_SHIFT)
-#define I40E_NVM_VERSION_HI_SHIFT	12
-#define I40E_NVM_VERSION_HI_MASK	(0xf << I40E_NVM_VERSION_HI_SHIFT)
-#define I40E_OEM_VER_BUILD_MASK		0xffff
-#define I40E_OEM_VER_PATCH_MASK		0xff
-#define I40E_OEM_VER_BUILD_SHIFT	8
-#define I40E_OEM_VER_SHIFT		24
 #define I40E_PHY_DEBUG_ALL \
 	(I40E_AQ_PHY_DEBUG_DISABLE_LINK_FW | \
 	I40E_AQ_PHY_DEBUG_DISABLE_ALL_LINK_FW)
 
 #define I40E_OEM_EETRACK_ID		0xffffffff
-#define I40E_OEM_GEN_SHIFT		24
-#define I40E_OEM_SNAP_MASK		0x00ff0000
-#define I40E_OEM_SNAP_SHIFT		16
-#define I40E_OEM_RELEASE_MASK		0x0000ffff
+#define I40E_NVM_VERSION_LO_MASK	GENMASK(7, 0)
+#define I40E_NVM_VERSION_HI_MASK	GENMASK(15, 12)
+#define I40E_OEM_VER_BUILD_MASK		GENMASK(23, 8)
+#define I40E_OEM_VER_PATCH_MASK		GENMASK(7, 0)
+#define I40E_OEM_VER_MASK		GENMASK(31, 24)
+#define I40E_OEM_GEN_MASK		GENMASK(31, 24)
+#define I40E_OEM_SNAP_MASK		GENMASK(23, 16)
+#define I40E_OEM_RELEASE_MASK		GENMASK(15, 0)
 
 #define I40E_RX_DESC(R, i)	\
 	(&(((union i40e_rx_desc *)((R)->desc))[i]))
@@ -954,43 +950,104 @@ struct i40e_device {
 };
 
 /**
- * i40e_nvm_version_str - format the NVM version strings
+ * i40e_info_nvm_ver - format the NVM version string
  * @hw: ptr to the hardware info
+ * @buf: string buffer to store
+ * @len: buffer size
+ *
+ * Formats NVM version string as:
+ * <gen>.<snap>.<release> when eetrackid == I40E_OEM_EETRACK_ID
+ * <nvm_major>.<nvm_minor> otherwise
  **/
-static inline char *i40e_nvm_version_str(struct i40e_hw *hw)
+static inline void i40e_info_nvm_ver(struct i40e_hw *hw, char *buf, size_t len)
 {
-	static char buf[32];
-	u32 full_ver;
+	struct i40e_nvm_info *nvm = &hw->nvm;
 
-	full_ver = hw->nvm.oem_ver;
-
-	if (hw->nvm.eetrack == I40E_OEM_EETRACK_ID) {
+	if (nvm->eetrack == I40E_OEM_EETRACK_ID) {
+		u32 full_ver = nvm->oem_ver;
 		u8 gen, snap;
 		u16 release;
 
-		gen = (u8)(full_ver >> I40E_OEM_GEN_SHIFT);
-		snap = (u8)((full_ver & I40E_OEM_SNAP_MASK) >>
-			I40E_OEM_SNAP_SHIFT);
-		release = (u16)(full_ver & I40E_OEM_RELEASE_MASK);
-
-		snprintf(buf, sizeof(buf), "%x.%x.%x", gen, snap, release);
+		gen = FIELD_GET(I40E_OEM_GEN_MASK, full_ver);
+		snap = FIELD_GET(I40E_OEM_SNAP_MASK, full_ver);
+		release = FIELD_GET(I40E_OEM_RELEASE_MASK, full_ver);
+		snprintf(buf, len, "%x.%x.%x", gen, snap, release);
 	} else {
-		u8 ver, patch;
+		u8 major, minor;
+
+		major = FIELD_GET(I40E_NVM_VERSION_HI_MASK, nvm->version);
+		minor = FIELD_GET(I40E_NVM_VERSION_LO_MASK, nvm->version);
+		snprintf(buf, len, "%x.%02x", major, minor);
+	}
+}
+
+/**
+ * i40e_info_eetrack - format the EETrackID string
+ * @hw: ptr to the hardware info
+ * @buf: string buffer to store
+ * @len: buffer size
+ *
+ * Returns hexadecimally formated EETrackID if it is
+ * different from I40E_OEM_EETRACK_ID or empty string.
+ **/
+static inline void i40e_info_eetrack(struct i40e_hw *hw, char *buf, size_t len)
+{
+	struct i40e_nvm_info *nvm = &hw->nvm;
+
+	buf[0] = '\0';
+	if (nvm->eetrack != I40E_OEM_EETRACK_ID)
+		snprintf(buf, len, "0x%08x", nvm->eetrack);
+}
+
+/**
+ * i40e_info_civd_ver - format the NVM version strings
+ * @hw: ptr to the hardware info
+ * @buf: string buffer to store
+ * @len: buffer size
+ *
+ * Returns formated combo image version if adapter's EETrackID is
+ * different from I40E_OEM_EETRACK_ID or empty string.
+ **/
+static inline void i40e_info_civd_ver(struct i40e_hw *hw, char *buf, size_t len)
+{
+	struct i40e_nvm_info *nvm = &hw->nvm;
+
+	buf[0] = '\0';
+	if (nvm->eetrack != I40E_OEM_EETRACK_ID) {
+		u32 full_ver = nvm->oem_ver;
+		u8 major, minor;
 		u16 build;
 
-		ver = (u8)(full_ver >> I40E_OEM_VER_SHIFT);
-		build = (u16)((full_ver >> I40E_OEM_VER_BUILD_SHIFT) &
-			 I40E_OEM_VER_BUILD_MASK);
-		patch = (u8)(full_ver & I40E_OEM_VER_PATCH_MASK);
-
-		snprintf(buf, sizeof(buf),
-			 "%x.%02x 0x%x %d.%d.%d",
-			 (hw->nvm.version & I40E_NVM_VERSION_HI_MASK) >>
-				I40E_NVM_VERSION_HI_SHIFT,
-			 (hw->nvm.version & I40E_NVM_VERSION_LO_MASK) >>
-				I40E_NVM_VERSION_LO_SHIFT,
-			 hw->nvm.eetrack, ver, build, patch);
+		major = FIELD_GET(I40E_OEM_VER_MASK, full_ver);
+		build = FIELD_GET(I40E_OEM_VER_BUILD_MASK, full_ver);
+		minor = FIELD_GET(I40E_OEM_VER_PATCH_MASK, full_ver);
+		snprintf(buf, len, "%d.%d.%d", major, build, minor);
 	}
+}
+
+/**
+ * i40e_nvm_version_str - format the NVM version strings
+ * @hw: ptr to the hardware info
+ * @buf: string buffer to store
+ * @len: buffer size
+ **/
+static inline char *i40e_nvm_version_str(struct i40e_hw *hw, char *buf,
+					 size_t len)
+{
+	char ver[16] = " ";
+
+	/* Get NVM version */
+	i40e_info_nvm_ver(hw, buf, len);
+
+	/* Append EETrackID if provided */
+	i40e_info_eetrack(hw, &ver[1], sizeof(ver) - 1);
+	if (strlen(ver) > 1)
+		strlcat(buf, ver, len);
+
+	/* Append combo image version if provided */
+	i40e_info_civd_ver(hw, &ver[1], sizeof(ver) - 1);
+	if (strlen(ver) > 1)
+		strlcat(buf, ver, len);
 
 	return buf;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a89f7ca510fd..ebf36f76c0d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2006,8 +2006,8 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 
 	strscpy(drvinfo->driver, i40e_driver_name, sizeof(drvinfo->driver));
-	strscpy(drvinfo->fw_version, i40e_nvm_version_str(&pf->hw),
-		sizeof(drvinfo->fw_version));
+	i40e_nvm_version_str(&pf->hw, drvinfo->fw_version,
+			     sizeof(drvinfo->fw_version));
 	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
 		sizeof(drvinfo->bus_info));
 	drvinfo->n_priv_flags = I40E_PRIV_FLAGS_STR_LEN;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f0e563a7f7b3..ba8fb0556216 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10798,7 +10798,9 @@ static void i40e_get_oem_version(struct i40e_hw *hw)
 			   &gen_snap);
 	i40e_read_nvm_word(hw, block_offset + I40E_NVM_OEM_RELEASE_OFFSET,
 			   &release);
-	hw->nvm.oem_ver = (gen_snap << I40E_OEM_SNAP_SHIFT) | release;
+	hw->nvm.oem_ver =
+		FIELD_PREP(I40E_OEM_GEN_MASK | I40E_OEM_SNAP_MASK, gen_snap) |
+		FIELD_PREP(I40E_OEM_RELEASE_MASK, release);
 	hw->nvm.eetrack = I40E_OEM_EETRACK_ID;
 }
 
@@ -15674,6 +15676,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct i40e_hw *hw;
 	static u16 pfs_found;
 	u16 wol_nvm_bits;
+	char nvm_ver[32];
 	u16 link_status;
 #ifdef CONFIG_I40E_DCB
 	int status;
@@ -15845,11 +15848,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_get_oem_version(hw);
 
 	/* provide nvm, fw, api versions, vendor:device id, subsys vendor:device id */
+	i40e_nvm_version_str(hw, nvm_ver, sizeof(nvm_ver));
 	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s [%04x:%04x] [%04x:%04x]\n",
 		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build,
-		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
-		 i40e_nvm_version_str(hw), hw->vendor_id, hw->device_id,
-		 hw->subsystem_vendor_id, hw->subsystem_device_id);
+		 hw->aq.api_maj_ver, hw->aq.api_min_ver, nvm_ver,
+		 hw->vendor_id, hw->device_id, hw->subsystem_vendor_id,
+		 hw->subsystem_device_id);
 
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
-- 
2.41.0

