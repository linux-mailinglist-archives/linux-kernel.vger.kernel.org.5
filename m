Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99DD7BCD2C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjJHIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjJHIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:06:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FEF0;
        Sun,  8 Oct 2023 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696752397; x=1728288397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8S2MqqTgJdBHZ66P8fTZI04cW1lUao8eGVoF7GOEfAc=;
  b=Ug5sNrMQsoMSAp5DTIYlz2v7Ow9txHGQma4KJYJXv/DQjfHhiWoqvrP2
   DMbhPmLRY37DJZA5x2+zyw1JU+ZhRZoxwQpXAs2lQbBhIsulU2re4ufDY
   ngN62LQ2qhDFidUXLQ+VFQRuP9rwIC8I8bFPR+rRWo4yLGFTnGqrFVhj3
   Ea2TVj9Ar1KZGF+kJOMctrK0WIgeizzN6WZYFOJx7cF3c1jgT8van7Ls/
   1WyssNo8ix2lzaY19t93Dq7nSMLVrPitoXh71nh2dc/ItYSCZeXvyo8L3
   Pv1J9TMnC6Xb9lu1zPoQzW19JahUlRyfBLS+tiL7GLupYJFD4sEB5NgFN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="383864116"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="383864116"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="876475017"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="876475017"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:06:34 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Lili Li <lili.li@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] EDAC/pci: Fix a potential memory leak
Date:   Sun,  8 Oct 2023 16:02:31 +0800
Message-Id: <20231008080231.51917-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
References: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lili Li <lili.li@intel.com>

The EDAC PCI core misses kfreeing 'pvt_info' which may result in a memory
leak. Fix it by adding a flag to indicate whether 'pvt_info' is allocated
by the EDAC PCI core and kfreeing 'pvt_info' by the EDAC PCI core when the
flag is set to true.

Fixes: fb8cd45ca39b ("EDAC/pci: Get rid of the silly one-shot memory allocation in edac_pci_alloc_ctl_info()")
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 drivers/edac/edac_pci.c       | 1 +
 drivers/edac/edac_pci.h       | 5 +++++
 drivers/edac/edac_pci_sysfs.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/edac/edac_pci.c b/drivers/edac/edac_pci.c
index 64c142aecca7..7c9d1d9115c4 100644
--- a/drivers/edac/edac_pci.c
+++ b/drivers/edac/edac_pci.c
@@ -40,6 +40,7 @@ struct edac_pci_ctl_info *edac_pci_alloc_ctl_info(unsigned int sz_pvt,
 		pci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
 		if (!pci->pvt_info)
 			goto free;
+		pci->pvt_managed_by_edac_core = true;
 	}
 
 	pci->op_state = OP_ALLOC;
diff --git a/drivers/edac/edac_pci.h b/drivers/edac/edac_pci.h
index 5175f5724cfa..27fecf6bfafc 100644
--- a/drivers/edac/edac_pci.h
+++ b/drivers/edac/edac_pci.h
@@ -69,6 +69,11 @@ struct edac_pci_ctl_info {
 	const char *dev_name;	/* pci/platform/etc... name */
 
 	void *pvt_info;		/* pointer to 'private driver' info */
+	/*
+	 * Indicate whether the resource pointed by pvt_info is managed by
+	 * EDAC core
+	 */
+	bool pvt_managed_by_edac_core;
 
 	unsigned long start_time;	/* edac_pci load start time (jiffies) */
 
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 287cc51dbc86..520fb2fa9411 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -83,6 +83,8 @@ static void edac_pci_instance_release(struct kobject *kobj)
 	/* decrement reference count on top main kobj */
 	kobject_put(edac_pci_top_main_kobj);
 
+	if (pci->pvt_managed_by_edac_core)
+		kfree(pci->pvt_info);
 	kfree(pci);	/* Free the control struct */
 }
 
-- 
2.17.1

