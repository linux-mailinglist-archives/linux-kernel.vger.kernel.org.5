Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329857A8B37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjITSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjITSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5EF9;
        Wed, 20 Sep 2023 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695233356; x=1726769356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iBHldoR40VpXeC3G/McChx+fgRcdfcyH8Q5bUfcu6gs=;
  b=cqoFZJY6521G/v8U12fJFye2KZl7CVMRvdxtw3+ddOvOj7ma2RK2Udrb
   X7gccfTb1IO6XbT1t2WjvflpyKRPbaIDcm2EKKgrnym/OsPjJp9NK8dAa
   Mc5sRk+kaWlN4s5hnyJb3MHf8e7Kg6s1oIG+WRhsrKjnuUj+gsa0DKsKt
   WFBoFiR6ZFKdCtjLtSooBobRkBEvQBcJTLL/ff8iPsAtuNotZ61tc4gTT
   aIfDt4nfphatE7W5mqqPIiMutDh1fG1b9Jyup/X6nwzELFiswR2wsAaY8
   /aRLF1VHeODIX0YEWvaIvXMF8n2+tGvtJLaRk3LR50Hgf4H7tOFGv72I3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359685184"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359685184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870469685"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870469685"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 11:09:12 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Michal Michalik <michal.michalik@intel.com>,
        Milena Olech <milena.olech@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH net-next 2/3] ice: fix undefined references from DPLL code when !CONFIG_PTP_1588_CLOCK
Date:   Wed, 20 Sep 2023 20:07:44 +0200
Message-ID: <20230920180745.1607563-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPLL code in ice unconditionally calls several PTP functions which are
only built when CONFIG_PTP_1588_CLOCK is set. This throws a good bunch
of link errors:

ERROR: modpost: "ice_cgu_get_pin_name"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_state"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
OR: modpost: "ice_is_cgu_present"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_rclk_pin_info"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_type"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_freq_supp"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!

ice_dpll_{,de}init() can be only called at runtime when the
corresponding feature flags are set, which is not the case when PTP
support is not compiled. However, the linker has no clue about this.
Compile DPLL code only when CONFIG_PTP_1588_CLOCK is enabled and guard
the mentioned init/deinit function calls, so that ice_dpll.o is only
referred when it gets compiled.

Note that ideally ice_is_feature_supported() needs to check for
compile-time flags first to be able to handle this without any
additional call guards, and we may want to do that in the future.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309191214.TaYEct4H-lkp@intel.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile   | 5 ++---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 00806ddf5bf0..16f96d5210d8 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -34,8 +34,7 @@ ice-y := ice_main.o	\
 	 ice_lag.o	\
 	 ice_ethtool.o  \
 	 ice_repr.o	\
-	 ice_tc_lib.o	\
-	 ice_dpll.o
+	 ice_tc_lib.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
 	ice_virtchnl.o		\
@@ -44,7 +43,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
-ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o
+ice-$(CONFIG_PTP_1588_CLOCK) += ice_dpll.o ice_ptp.o ice_ptp_hw.o
 ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
 ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e22f41fea8db..9b48918dcdb7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4665,8 +4665,9 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
 
-	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
-	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
+	if (IS_ENABLED(CONFIG_PTP_1588_CLOCK) &&
+	    (ice_is_feature_supported(pf, ICE_F_CGU) ||
+	     ice_is_feature_supported(pf, ICE_F_PHY_RCLK)))
 		ice_dpll_init(pf);
 
 	/* Note: Flow director init failure is non-fatal to load */
@@ -4695,7 +4696,8 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_gnss_exit(pf);
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_release(pf);
-	if (test_bit(ICE_FLAG_DPLL, pf->flags))
+	if (IS_ENABLED(CONFIG_PTP_1588_CLOCK) &&
+	    test_bit(ICE_FLAG_DPLL, pf->flags))
 		ice_dpll_deinit(pf);
 }
 
-- 
2.41.0

