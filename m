Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A67AE673
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjIZHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:11:31 -0400
Received: from out-201.mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759CEDE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:11:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695712282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=syqQR+9bPrQHdilL6zKTkrPq1VgSbRvVhw85Q7F9WZ4=;
        b=B7R2Klencrq0fTtMQPjIqR9iGvs7PJvaVFQliMgF9PNe5Ko1WkYEf6kFLTERkfM5/cf8eh
        Wu7gwqHpeVik7TI2jErLTf5Uj4xokGz0Gtf2RTq+RaTN/778O4FWJji7emfynVtBDp+U3D
        lGakHMqUulc7Nj2VfjrRSWWhAZd2It4=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        jacob.e.keller@intel.com, gregkh@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH RESEND] i40e: fix the wrong PTP frequency calculation
Date:   Tue, 26 Sep 2023 15:10:59 +0800
Message-Id: <20230926071059.1239033-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new adjustment should be based on the base frequency, not the
I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().

This issue was introduced in commit 3626a690b717 ("i40e: use
mul_u64_u64_div_u64 for PTP frequency calculation"), frequency is left
just as base I40E_PTP_40GB_INCVAL before the commit. After the commit,
frequency is the I40E_PTP_40GB_INCVAL times the ptp_adj_mult value.
But then the diff is applied on the wrong value, and no multiplication
is done afterwards.

It was accidentally fixed in commit 1060707e3809 ("ptp: introduce helpers
to adjust by scaled parts per million"). It uses adjust_by_scaled_ppm
correctly performs the calculation and uses the base adjustment, so
there's no error here. But it is a new feature and doesn't need to
backported to the stable releases.

This issue affects both v6.0 and v6.1, and the v6.1 version is an LTS
release. Therefore, the patch only needs to be applied to v6.1 stable.

Fixes: 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for PTP frequency calculation")
Cc: <stable@vger.kernel.org> # 6.1
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ffea0c9c82f1..97a9efe7b713 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -361,9 +361,9 @@ static int i40e_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 				   1000000ULL << 16);
 
 	if (neg_adj)
-		adj = I40E_PTP_40GB_INCVAL - diff;
+		adj = freq - diff;
 	else
-		adj = I40E_PTP_40GB_INCVAL + diff;
+		adj = freq + diff;
 
 	wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
 	wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);
-- 
2.25.1

