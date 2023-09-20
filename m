Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF257A8B34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjITSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjITSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4700C6;
        Wed, 20 Sep 2023 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695233352; x=1726769352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QkeZCJ+wbV6YBiqruqO3WbNO7KU2wC4MLYBVcJfsgoo=;
  b=O30kftMdhUXNjDUiWf0UdGZjAHpXUxpKa4RmMAuWotabc0d9Ac4i9+ib
   JiVb82GbFEgjjYV+l5HtaUfkk/IaxdCN/2Kxon5CcmR3ByXu2AGxQqqZZ
   UuXxJWqicLRZqLZj+VPymu+sxxZjQ3EgHUSaIoc8a//Cn2yrOvPzrkBUY
   COKU0wQ91NG5zc8JsjiiO5KsuD+gGO2hobJYCm3KPp8zcaa8OakE7N56Q
   +C8Mx04EsUNKA3+gsqwO9LM9uKf52HXrCzbe5FLBPutWyXCqAzZZp3UDl
   /kJQ4UKZrux/TuhuitPzEjV8BCnGK3tfby+YV77xaNZyvwQYpaKr2HcqE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359685158"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359685158"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870469682"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870469682"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 11:09:09 -0700
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
Subject: [PATCH net-next 1/3] ice: fix undefined references to ice_is_*() when !CONFIG_PTP_1588_CLOCK
Date:   Wed, 20 Sep 2023 20:07:43 +0200
Message-ID: <20230920180745.1607563-2-aleksander.lobakin@intel.com>
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

Starting the cited commit, ice_lib.c unconditionally refers to three
functions compiled only when CONFIG_PTP_1588_CLOCK is set (as they're
located in ice_ptp_hw.c):

ERROR: modpost: "ice_is_clock_mux_present_e810t"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_phy_rclk_present"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_cgu_present"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!

These three are HW feature tests and it is safe to stub them as
`return false` when PTP support is disabled.

Fixes: 8a3a565ff210 ("ice: add admin commands to access cgu configuration")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309181001.G72eBLpj-lkp@intel.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6f277e7b06b9..405a72864dc7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -271,10 +271,33 @@ int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_is_pca9575_present(struct ice_hw *hw);
+
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+
 bool ice_is_phy_rclk_present(struct ice_hw *hw);
 bool ice_is_clock_mux_present_e810t(struct ice_hw *hw);
-int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx);
 bool ice_is_cgu_present(struct ice_hw *hw);
+
+#else /* !CONFIG_PTP_1588_CLOCK */
+
+static inline bool ice_is_phy_rclk_present(const struct ice_hw *hw)
+{
+	return false;
+}
+
+static inline bool ice_is_clock_mux_present_e810t(const struct ice_hw *hw)
+{
+	return false;
+}
+
+static inline bool ice_is_cgu_present(const struct ice_hw *hw)
+{
+	return false;
+}
+
+#endif /* !CONFIG_PTP_1588_CLOCK */
+
+int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
-- 
2.41.0

