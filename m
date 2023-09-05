Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D039793101
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbjIEViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjIEViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:38:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54907133;
        Tue,  5 Sep 2023 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693949882; x=1725485882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9apBiphN57rQ3aiF+Q7XIdDoQMMdkK/gnjUcFUrpp1Y=;
  b=eEThhPxsH7/2we0hJiQL8UXRpyA4U/RHkrpnSuyVVfT1oLgKhzUfowW4
   7dQKZzNuCd08qh4UYN2gwvwcG5c6uHBEIylMRtWJuAC/XICHK97o77pXv
   9o8IVQgkNFUEpSL8ilMRS0tcyiu2CswIuPYMxqoMJfChzYKoQYFAWDY4u
   tOhnmlpCe77HGBGx69FngXabvfB0MkAs09zGZqUK0RDvxqUF2YvBZrCy2
   bVcM0iOe67wBqO1Mm5cl2w0E1naPNq60iX62FQDoHAz3C/ktT4H+KqZFC
   2fT9j2Al/OKX6gkiEXAKNm2Vu3j4ZasawC8lCcTGTsWkcBKIEGxHIYHOs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443298014"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443298014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864902564"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="864902564"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:38:01 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     sasha.neftin@intel.com,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Ferenc Fejes <ferenc.fejes@ericsson.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Andre Guedes <andre.guedes@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v1] igc: Fix infinite initialization loop with early XDP redirect
Date:   Tue,  5 Sep 2023 14:37:52 -0700
Message-ID: <20230905213753.697461-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a XDP redirect happens before the link is ready, that
transmission will not finish and will timeout, causing an adapter
reset. If the redirects do not stop, the adapter will not stop
resetting.

Wait for the driver to signal that there's a carrier before allowing
transmissions to proceed.

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 293b45717683..98de34d0ce07 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6491,7 +6491,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	struct igc_ring *ring;
 	int i, drops;
 
-	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
-- 
2.41.0

