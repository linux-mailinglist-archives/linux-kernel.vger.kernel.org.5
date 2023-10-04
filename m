Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AE7B8A65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbjJDSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbjJDSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:35:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF0A7;
        Wed,  4 Oct 2023 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444500; x=1727980500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bpSnUeyMCwr5z8q24pn1zkzo5CtrPo+vd10q6+Wf0l0=;
  b=Uo9vqPMr/6k6DuxuUB+ra/S5yf6o8RCQosIHI7cQKqv19sEEnFWwUE6S
   T6vq7Ka5Kq3dfueJD3tFpPLRydKWFDpk99YuUgj6RSxNDFH2upM4JkS1g
   InCjUpR7hVDbD9bFX9rvEafBwG8CZleg3BkBVd74oGq4sxWmzo8szJWeK
   umtSU11W+XSvK6vbPqo829RW+q0bl50Dk5ngWznNsrj8uFN3j4PEb+Noi
   2Ff7+9ajvtyqrEnk9AOyylSsfka2YCsoiv8LqCABR7N2a3SLYDNVOheUF
   7Yt3oDiF7322Zoc59FEnYvzYxTFOvNtF28xDHUos+8SNdLsYTS1REeA7l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383168102"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383168102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780909015"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="780909015"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.153])
  by orsmga008.jf.intel.com with SMTP; 04 Oct 2023 11:34:55 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 04 Oct 2023 21:34:55 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wang Wendy <wendy.wang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] powercap: intel_rapl: Don't warn about BIOS locked limits during resume
Date:   Wed,  4 Oct 2023 21:34:55 +0300
Message-ID: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Restore enough of the original behaviour to stop spamming
dmesg with warnings about BIOS locked limits when trying
to restore them during resume.

This still doesn't 100% match the original behaviour
as we no longer attempt to blindly restore the BIOS locked
limits. No idea if that makes any difference in practice.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Wang Wendy <wendy.wang@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 40a2cc649c79..9a6a40c83f82 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -882,22 +882,34 @@ static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
 	return rapl_read_data_raw(rd, prim, xlate, data);
 }
 
-static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
-			       enum pl_prims pl_prim,
-			       unsigned long long value)
+static int rapl_write_pl_data_nowarn(struct rapl_domain *rd, int pl,
+				     enum pl_prims pl_prim,
+				     unsigned long long value)
 {
 	enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
 
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
 
-	if (rd->rpl[pl].locked) {
-		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
+	if (rd->rpl[pl].locked)
 		return -EACCES;
-	}
 
 	return rapl_write_data_raw(rd, prim, value);
 }
+
+static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
+			      enum pl_prims pl_prim,
+			      unsigned long long value)
+{
+	int ret;
+
+	ret = rapl_write_pl_data_nowarn(rd, pl, pl_prim, value);
+	if (ret == -EACCES)
+		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
+
+	return ret;
+}
+
 /*
  * Raw RAPL data stored in MSRs are in certain scales. We need to
  * convert them into standard units based on the units reported in
@@ -1634,8 +1646,8 @@ static void power_limit_state_restore(void)
 		rd = power_zone_to_rapl_domain(rp->power_zone);
 		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
 			if (rd->rpl[i].last_power_limit)
-				rapl_write_pl_data(rd, i, PL_LIMIT,
-					       rd->rpl[i].last_power_limit);
+				rapl_write_pl_data_nowarn(rd, i, PL_LIMIT,
+							  rd->rpl[i].last_power_limit);
 	}
 	cpus_read_unlock();
 }
-- 
2.41.0

