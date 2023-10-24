Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E37D5B54
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJXTR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJXTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:17:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49710C3;
        Tue, 24 Oct 2023 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698175043; x=1729711043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGKgHwucaZd6y0NQGPmgV3sCFZELqEJC0AJNAp25S3g=;
  b=OWJCPw/HfGmnd98i63Lyj+3lQTn8uoeir1Za6t93XhOsWteUxIs4ked+
   eQg6NsJHJgB+NOWfkpKQEsYpF644twv3HCoV9pfRMi5NcdqRQh/dL7MTT
   xInxCkVCaYs4AooSTnCCs18WtLqZLWV8ec5jHl4RVyOgOn1NAIF/hzhAb
   cSTTOMj5b61D1CnKVLN+lH5EfRRgreRMBO5Ho4wBH/7D1BdosiqSBXqQd
   Yz7dT1KnnK0QeUn8IPhTShGwbBXqjiW02ubtF+pKUDXRSk5v7rPRigbj2
   82OPm67cnw873KMdEF+lVim4Yi0eo9sjzqjymWMKyi+LnBypVWf/8aB2Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418269767"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418269767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 12:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902303518"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902303518"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga001.fm.intel.com with SMTP; 24 Oct 2023 12:14:59 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Oct 2023 22:17:19 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wang Wendy <wendy.wang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH v2] powercap: intel_rapl: Downgrade BIOS locked limits pr_warn() to pr_debug()
Date:   Tue, 24 Oct 2023 22:17:19 +0300
Message-ID: <20231024191719.4041-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Before the refactoring the pr_warn() only triggered when
someone explicitly tried to write to a BIOS locked limit.
After the refactoring the warning is also triggering during
system resume. The user can't do anything about this so
printing scary warnings doesn't make sense

Keep the printk but make it pr_debug() instead of pr_warn()
to make it clear it's not a serious issue.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Wang Wendy <wendy.wang@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 40a2cc649c79..2feed036c1cd 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -892,7 +892,7 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
 		return -EINVAL;
 
 	if (rd->rpl[pl].locked) {
-		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
+		pr_debug("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
 		return -EACCES;
 	}
 
-- 
2.41.0

