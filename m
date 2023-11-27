Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E97F990F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjK0GFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjK0GFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:05:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31D13D;
        Sun, 26 Nov 2023 22:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701065119; x=1732601119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jl2n3DOTd1DIka9IKBM+HJnvzYRs320kDKrmGMGFtSM=;
  b=DV7ku2DI0sYRh0xc32QFihO9/M4fFD51OQzJa7I7SLSO/mK33Jcisb7y
   KqMag0Xcnq6c3+GpYDmk7YzxkEdttrHmQk9C9ego3B+AxLX3ktS/Y7OmR
   6I1CHlzovNt/4QXDNXsv54EdhiYygwduNmeZ2zZ1fjFeM4CIYtgnJsJAb
   G1IiK19qinE+QUN8IU5qAWb2szfc2Wc6VOsfr3RPyeypkb0MXLZtpx1ae
   eHrfo1PvdiS89m+En22mS/8dGzJdjg79bVn+oZd/Psr1KD4YVQFz+Y8PE
   1NOMXE8Q+ZXLB1hIUf3B/hFMtTXJQEnvx2ZY1Rgi9EsedwLC5y/YL6hLj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="11341583"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="11341583"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717933496"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="717933496"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:05:17 -0800
From:   Sachin Bahadur <sachin.bahadur@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Date:   Sun, 26 Nov 2023 22:05:12 -0800
Message-Id: <20231127060512.1283336-1-sachin.bahadur@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF interface part of Bond should not allow driver reinit via devlink. Bond
config will be lost due to PF reinit. PF needs to be re-added to Bond
after PF reinit. ice_devlink_reload_down is called before PF driver reinit.
If PF is attached to bond, ice_devlink_reload_down returns error.

Fixes: trailer
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index f4e24d11ebd0..5fe88e949b09 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 					   "Remove all VFs before doing reinit\n");
 			return -EOPNOTSUPP;
 		}
+		if (pf->lag && pf->lag->bonded) {
+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");
+			return -EBUSY;
+		}
 		ice_unload(pf);
 		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
--
2.25.1

