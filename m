Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D767EADB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjKNKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjKNKOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:14:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542F19F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699956840; x=1731492840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vxaiLcGzfNk0ddfcrq6pq99BkBv8gE1W9AOZ6yAzypg=;
  b=TxTSKYPBQo0AIJ1FHiQXlix7v/sH0Zwgh6GLahDQq6LGNZj+fzozSap2
   sZ8hJj490eJpJ+OsGklxJ86R2ueMAce7RrdJV9LiO3/m8nZQrSAlVfCmF
   mx6Xd6zXgdb5P9cuUWUSnX8V7Q6cehUejeE0TLXjWJ2FYeYQXQ7mmnUxr
   YSClDoAqTXUgTepo7mU3r9xT/IB2de1X4EEjDJslPq4fGYYoGS1FKtVzW
   duA9YGHaoUXaoTUxYvZuQYFZggcI4lH3L+iQwgHWq/YKOFjYPg/zvHasK
   dIqgifI7G8MQiH9AQk656vJs/KWtq5+YF9OAhAODwUJUhzbpIACEo2vGP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375669087"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="375669087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="5974150"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:13:58 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mei: hdcp: match without driver name
Date:   Tue, 14 Nov 2023 12:08:40 +0200
Message-Id: <20231114100843.1923977-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100843.1923977-1-alexander.usyskin@intel.com>
References: <20231114100843.1923977-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dependency on i915 driver name in component_match function.
Use PCI header information to match Intel graphics device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 51359cc5ece9..f8759a6c9ed3 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
@@ -781,9 +782,18 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
 				    void *data)
 {
 	struct device *base = data;
+	struct pci_dev *pdev;
 
-	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
-	    subcomponent != I915_COMPONENT_HDCP)
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) ||
+	    pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (subcomponent != I915_COMPONENT_HDCP)
 		return 0;
 
 	base = base->parent;
-- 
2.34.1

