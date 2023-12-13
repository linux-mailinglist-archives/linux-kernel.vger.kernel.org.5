Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B7810E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjLMJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjLMJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:40:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C9BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702460461; x=1733996461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lRVhHhVXAAxjuEI/zpKu1TQpBCIc9AVRkLnPeZrmsUI=;
  b=S2oJTkOwBgHTWiECIhqcksRTJC6xp4TE6Dlj27DsaRzy8IgK+MwEj69t
   ek6To0WU6U+O4XkEM5R14t0aU9FadYjFsIpxSVozXGX4P0GvW89kXL3Bi
   bP5m6D4gKxR9CK6yPVqOe1jLgluIY7ehuQEqdzmaQ5fHlQA9keSm4j3NF
   bY8nlPuVHV3PI4kKFAVgxP7ssuTstdPjEEe9clm3jNXQwFyEs6kCUiQiA
   xVhMtwXgKNrDo22pYvkhXEvfyUIGe7XQR7X0UZzKZ0EzjCQdodUqPvrBM
   UPpEIMrsNhrujeRu/kAh8aE7ZFV1FhmwRRx0aMg0MDhLJskhktICXkIk4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481140632"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481140632"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 01:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839799931"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839799931"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 01:40:59 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id A685411F7E4;
        Wed, 13 Dec 2023 11:40:55 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, alexander.usyskin@intel.com,
        tomas.winkler@intel.com, Arnd Bergmann <arnd@arndb.de>,
        wentong.wu@intel.com
Subject: [PATCH 1/1] mei: vsc: Rework firmware image names
Date:   Wed, 13 Dec 2023 11:40:55 +0200
Message-Id: <20231213094055.446611-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework firmware image names with the users in mind---there's no need for
variation between firmware names, apart from connected sensors. All
supported SoCs use the same firmware, too.

Use a single set of firmware binaries and assume they'll be found under
intel/vsc directory.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Wentong Wu <wentong.wu@intel.com>
---
Hi folks,

The firmware isn't in linux-firmware yet (I'm working on it). The name can
still be changed as this hasn't made its way to a release yet.

 drivers/misc/mei/vsc-fw-loader.c | 72 +++++---------------------------
 1 file changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 3e151f06e85b..ffa4ccd96a10 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -27,9 +27,6 @@
 #define VSC_EFUSE_ADDR			(VSC_ADDR_BASE + 0x038)
 #define VSC_STRAP_ADDR			(VSC_ADDR_BASE + 0x100)
 
-#define VSC_STRAP_KEY_SRC_MASK		BIT(0)
-#define VSC_STRAP_KEY_SRC_PRODUCT	1
-
 #define VSC_MAINSTEPPING_VERSION_MASK	GENMASK(7, 4)
 #define VSC_MAINSTEPPING_VERSION_A	0
 
@@ -49,22 +46,15 @@
 #define VSC_ROM_PKG_SIZE		256u
 #define VSC_FW_PKG_SIZE			512u
 
-#define VSC_CSI_IMAGE_NAME_FMT		"ivsc_fw_a1.bin"
-#define VSC_CSI_IMAGE_NAME_FMT_PROD	"ivsc_fw_a1_%s.bin"
-#define VSC_ACE_IMAGE_NAME_FMT		"ivsc_pkg_%s_0_a1.bin"
-#define VSC_ACE_IMAGE_NAME_FMT_PROD	"ivsc_pkg_%s_0_a1_%s.bin"
-#define VSC_CFG_IMAGE_NAME_FMT		"ivsc_skucfg_%s_0_1_a1.bin"
-#define VSC_CFG_IMAGE_NAME_FMT_PROD	"ivsc_skucfg_%s_0_1_a1_%s.bin"
+#define VSC_IMAGE_DIR			"intel/vsc/"
 
-#define VSC_IMAGE_FOLDER_FMT		"vsc/soc_a1"
-#define VSC_IMAGE_FOLDER_FMT_PROD	"vsc/soc_a1_%s"
+#define VSC_CSI_IMAGE_NAME		VSC_IMAGE_DIR "ivsc_fw.bin"
+#define VSC_ACE_IMAGE_NAME_FMT		VSC_IMAGE_DIR "ivsc_pkg_%s_0.bin"
+#define VSC_CFG_IMAGE_NAME_FMT		VSC_IMAGE_DIR "ivsc_skucfg_%s_0_1.bin"
 
-#define VSC_IMAGE_NAME_MAX_LEN		64
-#define VSC_IMAGE_PATH_MAX_LEN		128
+#define VSC_IMAGE_PATH_MAX_LEN		64
 
 #define VSC_SENSOR_NAME_MAX_LEN		16
-#define VSC_IMAGE_FOLDER_NAME_MAX_LEN	32
-#define VSC_IMAGE_NAME_SUFFIX_MAX_LEN	8
 
 /* command id */
 enum {
@@ -223,10 +213,7 @@ struct vsc_img_frag {
  * @rx_buf: rx buffer
  * @option: command option
  * @count: total image count
- * @key_src: key source
- * @folder: image folder
  * @sensor_name: camera sensor name
- * @suffix: image name suffix
  * @frags: image fragments
  */
 struct vsc_fw_loader {
@@ -242,11 +229,8 @@ struct vsc_fw_loader {
 
 	u16 option;
 	u16 count;
-	u32 key_src;
 
-	char folder[VSC_IMAGE_FOLDER_NAME_MAX_LEN];
 	char sensor_name[VSC_SENSOR_NAME_MAX_LEN];
-	char suffix[VSC_IMAGE_NAME_SUFFIX_MAX_LEN];
 
 	struct vsc_img_frag frags[VSC_IMG_FRAG_MAX];
 };
@@ -378,33 +362,18 @@ static int vsc_identify_silicon(struct vsc_fw_loader *fw_loader)
 	if (ack->token != VSC_TOKEN_DUMP_RESP)
 		return -EINVAL;
 
-	fw_loader->key_src = FIELD_GET(VSC_STRAP_KEY_SRC_MASK, ack->payload[2]);
-
-	if (fw_loader->key_src == VSC_STRAP_KEY_SRC_PRODUCT)
-		strscpy(fw_loader->suffix, "prod", sizeof(fw_loader->suffix));
-
 	return 0;
 }
 
 static int vsc_identify_csi_image(struct vsc_fw_loader *fw_loader)
 {
-	char path[VSC_IMAGE_PATH_MAX_LEN];
-	char name[VSC_IMAGE_NAME_MAX_LEN];
 	const struct firmware *image;
 	struct vsc_fw_sign *sign;
 	struct vsc_img *img;
 	unsigned int i;
 	int ret;
 
-	if (fw_loader->key_src == VSC_STRAP_KEY_SRC_PRODUCT)
-		snprintf(name, sizeof(name), VSC_CSI_IMAGE_NAME_FMT_PROD,
-			 fw_loader->suffix);
-	else
-		snprintf(name, sizeof(name), VSC_CSI_IMAGE_NAME_FMT);
-
-	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
-
-	ret = request_firmware(&image, path, fw_loader->dev);
+	ret = request_firmware(&image, VSC_CSI_IMAGE_NAME, fw_loader->dev);
 	if (ret)
 		return ret;
 
@@ -480,21 +449,14 @@ static int vsc_identify_csi_image(struct vsc_fw_loader *fw_loader)
 static int vsc_identify_ace_image(struct vsc_fw_loader *fw_loader)
 {
 	char path[VSC_IMAGE_PATH_MAX_LEN];
-	char name[VSC_IMAGE_NAME_MAX_LEN];
 	const struct firmware *image;
 	struct vsc_fw_sign *sign;
 	struct vsc_img *img;
 	unsigned int i;
 	int ret;
 
-	if (fw_loader->key_src == VSC_STRAP_KEY_SRC_PRODUCT)
-		snprintf(name, sizeof(name), VSC_ACE_IMAGE_NAME_FMT_PROD,
-			 fw_loader->sensor_name, fw_loader->suffix);
-	else
-		snprintf(name, sizeof(name), VSC_ACE_IMAGE_NAME_FMT,
-			 fw_loader->sensor_name);
-
-	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
+	snprintf(path, sizeof(path), VSC_ACE_IMAGE_NAME_FMT,
+		 fw_loader->sensor_name);
 
 	ret = request_firmware(&image, path, fw_loader->dev);
 	if (ret)
@@ -571,19 +533,12 @@ static int vsc_identify_cfg_image(struct vsc_fw_loader *fw_loader)
 {
 	struct vsc_img_frag *frag = &fw_loader->frags[VSC_IMG_SKU_CFG_FRAG];
 	char path[VSC_IMAGE_PATH_MAX_LEN];
-	char name[VSC_IMAGE_NAME_MAX_LEN];
 	const struct firmware *image;
 	u32 size;
 	int ret;
 
-	if (fw_loader->key_src == VSC_STRAP_KEY_SRC_PRODUCT)
-		snprintf(name, sizeof(name), VSC_CFG_IMAGE_NAME_FMT_PROD,
-			 fw_loader->sensor_name, fw_loader->suffix);
-	else
-		snprintf(name, sizeof(name), VSC_CFG_IMAGE_NAME_FMT,
-			 fw_loader->sensor_name);
-
-	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
+	snprintf(path, sizeof(path), VSC_CFG_IMAGE_NAME_FMT,
+		 fw_loader->sensor_name);
 
 	ret = request_firmware(&image, path, fw_loader->dev);
 	if (ret)
@@ -786,13 +741,6 @@ int vsc_tp_init(struct vsc_tp *tp, struct device *dev)
 	if (ret)
 		return ret;
 
-	if (fw_loader->key_src == VSC_STRAP_KEY_SRC_PRODUCT)
-		snprintf(fw_loader->folder, sizeof(fw_loader->folder),
-			 VSC_IMAGE_FOLDER_FMT_PROD, fw_loader->suffix);
-	else
-		snprintf(fw_loader->folder, sizeof(fw_loader->folder),
-			 VSC_IMAGE_FOLDER_FMT);
-
 	ret = vsc_identify_csi_image(fw_loader);
 	if (ret)
 		return ret;
-- 
2.39.2

