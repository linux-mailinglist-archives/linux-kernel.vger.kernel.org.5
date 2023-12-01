Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05B8013F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379605AbjLAULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379591AbjLAUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:10:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482AF103;
        Fri,  1 Dec 2023 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701461463; x=1732997463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buoGPdrkkKx4hhUIceeTcYHbzYQ9xgtGVojseC0ReWs=;
  b=C5uqzDXJOig6els6eSQNIsYQ2lgRZi4t8SJhob8WhbWElTM/cJq9NqYD
   e18jEd66G/gVWAafZyDQlt2x24Kt09CQmjzJrcLf6Z9aBAc+1/0p2/STG
   4BUS6f2zdFD5ZRbg9qLTrBs40oS4l7m0l6V8ErANfzh+PPf+/7qsztzEX
   gwAg5yjGZzFqw9Aqn7xB3dS+vyHwgB864F2Ou3E5sPWjU5GxPG2kpe5cn
   x/Kpwi/gR53Qd/H5aG0S3KmrMOeBIeDT3h0WVii8f/tsvy8gwcmeOEtfN
   WG8P2++S1EYdDuzutkNtKjs91dUE7WAeywN8haCBEzUWKV8vQ2PDUWkEQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="427749"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="427749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860671125"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="860671125"
Received: from temersox-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.166.197])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:10:41 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v11 01/14] dmaengine: idxd: add external module driver support for dsa_bus_type
Date:   Fri,  1 Dec 2023 14:10:22 -0600
Message-Id: <20231201201035.172465-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
References: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add support to allow an external driver to be registered to the
dsa_bus_type and also auto-loaded.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/bus.c  | 6 ++++++
 drivers/dma/idxd/idxd.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
index 6f84621053c6..0c9e689a2e77 100644
--- a/drivers/dma/idxd/bus.c
+++ b/drivers/dma/idxd/bus.c
@@ -67,11 +67,17 @@ static void idxd_config_bus_remove(struct device *dev)
 	idxd_drv->remove(idxd_dev);
 }
 
+static int idxd_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	return add_uevent_var(env, "MODALIAS=" IDXD_DEVICES_MODALIAS_FMT, 0);
+}
+
 struct bus_type dsa_bus_type = {
 	.name = "dsa",
 	.match = idxd_config_bus_match,
 	.probe = idxd_config_bus_probe,
 	.remove = idxd_config_bus_remove,
+	.uevent = idxd_bus_uevent,
 };
 EXPORT_SYMBOL_GPL(dsa_bus_type);
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1e89c80a07fc..e541d19f14d0 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -655,6 +655,9 @@ static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *d
 	return (strncmp(wq->driver_name, dev->driver->name, strlen(dev->driver->name)) == 0);
 }
 
+#define MODULE_ALIAS_IDXD_DEVICE(type) MODULE_ALIAS("idxd:t" __stringify(type) "*")
+#define IDXD_DEVICES_MODALIAS_FMT "idxd:t%d"
+
 int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 					struct module *module, const char *mod_name);
 #define idxd_driver_register(driver) \
-- 
2.34.1

