Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17547C8C10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjJMRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjJMRI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01CBF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697216897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xsezFWFByy4rpS2ZiIdJ03gAqw56BIfXZENvTM4VoQ=;
        b=YAV2RuiwIsdm1QO22vrZK4TirbeizCKj/ykKBKhYlcQAuAGHpt73gkecBMBtHYJJ7ws9wm
        xCccs+vVEDYlYUQ3AjMV4Lg4xzV8ZyePjU50oAa+4ip75p3YXgFvRKx6F7Vta3dsy4xKfp
        BmktJyh1FJ7pDBETBx1OvFBwcz1wKho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-Nf45X2WpPnS7TiydF3ZteA-1; Fri, 13 Oct 2023 13:08:04 -0400
X-MC-Unique: Nf45X2WpPnS7TiydF3ZteA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0B7800B23;
        Fri, 13 Oct 2023 17:08:03 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE5831C060DF;
        Fri, 13 Oct 2023 17:08:01 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Date:   Fri, 13 Oct 2023 19:07:53 +0200
Message-ID: <20231013170755.2367410-4-ivecera@redhat.com>
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

Provide devlink .info_get callback to allow the driver to report
detailed version information. The following info is reported:

 "serial_number" -> The PCI DSN of the adapter
 "fw.mgmt" -> The version of the firmware
 "fw.mgmt.api" -> The API version of interface exposed over the AdminQ
 "fw.psid" -> The version of the NVM image
 "fw.bundle_id" -> Unique identifier for the combined flash image
 "fw.undi" -> The combo image version

With this, 'devlink dev info' provides at least the same amount
information as is reported by ETHTOOL_GDRVINFO:

$ ethtool -i enp2s0f0 | egrep '(driver|firmware)'
driver: i40e
firmware-version: 9.30 0x8000e5f3 1.3429.0

$ devlink dev info pci/0000:02:00.0
pci/0000:02:00.0:
  driver i40e
  serial_number c0-de-b7-ff-ff-ef-ec-3c
  versions:
      running:
        fw.mgmt 9.130.73618
        fw.mgmt.api 1.15
        fw.psid 9.30
        fw.bundle_id 0x8000e5f3
        fw.undi 1.3429.0

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 66b7f5be45ae..fb6144d74c98 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -5,7 +5,97 @@
 #include "i40e.h"
 #include "i40e_devlink.h"
 
+static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
+{
+	u8 dsn[8];
+
+	put_unaligned_be64(pci_get_dsn(pf->pdev), dsn);
+
+	snprintf(buf, len, "%8phD", dsn);
+}
+
+static void i40e_info_fw_mgmt(struct i40e_hw *hw, char *buf, size_t len)
+{
+	struct i40e_adminq_info *aq = &hw->aq;
+
+	snprintf(buf, len, "%u.%u.%05d",
+		 aq->fw_maj_ver, aq->fw_min_ver, aq->fw_build);
+}
+
+static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
+{
+	struct i40e_adminq_info *aq = &hw->aq;
+
+	snprintf(buf, len, "%u.%u", aq->api_maj_ver, aq->api_min_ver);
+}
+
+enum i40e_devlink_version_type {
+	I40E_DL_VERSION_RUNNING,
+};
+
+static int i40e_devlink_info_put(struct devlink_info_req *req,
+				 enum i40e_devlink_version_type type,
+				 const char *key, const char *value)
+{
+	if (!strlen(value))
+		return 0;
+
+	switch (type) {
+	case I40E_DL_VERSION_RUNNING:
+		return devlink_info_version_running_put(req, key, value);
+	}
+	return 0;
+}
+
+static int i40e_devlink_info_get(struct devlink *dl,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(dl);
+	struct i40e_hw *hw = &pf->hw;
+	char buf[32];
+	int err;
+
+	i40e_info_get_dsn(pf, buf, sizeof(buf));
+	err = devlink_info_serial_number_put(req, buf);
+	if (err)
+		return err;
+
+	i40e_info_fw_mgmt(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, buf);
+	if (err)
+		return err;
+
+	i40e_info_fw_api(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+				    buf);
+	if (err)
+		return err;
+
+	i40e_info_nvm_ver(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    DEVLINK_INFO_VERSION_GENERIC_FW_PSID, buf);
+	if (err)
+		return err;
+
+	i40e_info_eetrack(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
+				    buf);
+	if (err)
+		return err;
+
+	i40e_info_civd_ver(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
+				    DEVLINK_INFO_VERSION_GENERIC_FW_UNDI, buf);
+
+	return err;
+}
+
 static const struct devlink_ops i40e_devlink_ops = {
+	.info_get = i40e_devlink_info_get,
 };
 
 /**
-- 
2.41.0

