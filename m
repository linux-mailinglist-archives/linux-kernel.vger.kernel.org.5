Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DB7E4137
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjKGNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjKGNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:52:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6D30C5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699365093; x=1730901093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ok+C5VgX/V+ECchmrjizFZBWxdoj6QGhMwgM03J/+rE=;
  b=UQXXwmHm7Ryr8nkYuU+FDYLjDppQbmxhglkZmP69RT3NsGahOuVMnfK2
   af+GRzPmM5ir0QzkuWvZkFpM3b4Apv/BBbL7vDI0N5adPjxRYJZuD3uax
   iACefUcsX2ihpVz4KezwqXf88WhQJardq6hIEVBFOOqcjazy1t75sp2Wz
   dXgRv5qD6sjkWYzrU30BGA0fqIPBxjijCy4MFwbm8/vIjTXMU6dMgJgAX
   KNN+ApYI/5psangjbNEb7OiDgnRYrEOkJsgqQw9S6I7G3IiG7xcjNTGZB
   dATVhYP+1re7PIEUDnUBoR2D6JRuw4InAKjJepbDdgZqvLAmhR7Uwtr/1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420618983"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="420618983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762705126"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="762705126"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:30 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mei: pxp: match without driver name
Date:   Tue,  7 Nov 2023 15:46:04 +0200
Message-Id: <20231107134606.316651-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134606.316651-1-alexander.usyskin@intel.com>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dependency on i915 driver name in component_match function.
Use PCI header information to match Intel graphics device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 2dcb9169e404..e74b2facfdf9 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
@@ -154,12 +155,21 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
 				   void *data)
 {
 	struct device *base = data;
+	struct pci_dev *pdev;
 
 	if (!dev)
 		return 0;
 
-	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
-	    subcomponent != I915_COMPONENT_PXP)
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) ||
+	    pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (subcomponent != I915_COMPONENT_PXP)
 		return 0;
 
 	base = base->parent;
-- 
2.34.1

