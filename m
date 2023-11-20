Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38047F1566
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjKTONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjKTONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:13:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA3BA;
        Mon, 20 Nov 2023 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700489588; x=1732025588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcBH8dkNNXnKF0j8ud1kjx2WkqUBoV7nIP12in5A7ms=;
  b=TxSBSO+96S4nOTT7Yf2deTYfI8sCLlpIaN6Tlifb2d52DOIOrsHFDZ5o
   nKk+MscvvOE36MwYo3BbRNbWXsRe0Rld4Yn/nAPiJ8BzjZHHvSI3kHnUB
   1kYvK7XlD2ewyuAZD8bU/wx90VuFpCRZFhqK3Emfg3LNEpMNWiCu9wmbG
   paMzndE/UobhONmQC79En+zvIK4pQZpYKc8/Vs8AZmhWB2JC+VOSVPFf/
   mgb02HO81MIblsbjyv5dQiCsuoTGJ6pgzg94soNdjdL1xWZdIYwVV2cF+
   +vA9Lo3/bnALAzcHfS41qvoB2zi51jM7b64xW4VtcnLK4PqNAhxL8O97Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458121751"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458121751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801184238"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801184238"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 219BB24F; Mon, 20 Nov 2023 16:12:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v2 2/4] EDAC, pnd2: Apply bit macros and helpers where it makes sense
Date:   Mon, 20 Nov 2023 16:10:46 +0200
Message-ID: <20231120141231.1638240-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply bit macros (BIT()/BIT_ULL()/GENMASK()/etc) and helpers
(for_each_set_bit()/etc) where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed uninitialized variable (lkp, Qiuxu), dropped mask check change (Qiuxu) 

 drivers/edac/pnd2_edac.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 45e3c2913d51..ee7c9b024354 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -183,7 +183,7 @@ static int _apl_rd_reg(int port, int off, int op, u32 *data)
 	}
 
 	P2SB_READ(dword, P2SB_DATA_OFF, data);
-	ret = (status >> 1) & 0x3;
+	ret = (status >> 1) & GENMASK(1, 0);
 out:
 	/* Hide the P2SB device, if it was hidden before */
 	if (hidden)
@@ -307,7 +307,7 @@ static bool two_channels; /* Both PMI channels in one slice enabled */
 
 static u8 sym_chan_mask;
 static u8 asym_chan_mask;
-static u8 chan_mask;
+static unsigned long chan_mask;
 
 static int slice_selector = -1;
 static int chan_selector = -1;
@@ -598,7 +598,7 @@ static void remove_addr_bit(u64 *addr, int bitidx)
 	if (bitidx == -1)
 		return;
 
-	mask = (1ull << bitidx) - 1;
+	mask = BIT_ULL(bitidx) - 1;
 	*addr = ((*addr >> 1) & ~mask) | (*addr & mask);
 }
 
@@ -642,7 +642,7 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 	int sym_chan_shift = sym_channels >> 1;
 
 	/* Give up if address is out of range, or in MMIO gap */
-	if (addr >= (1ul << PND_MAX_PHYS_BIT) ||
+	if (addr >= BIT(PND_MAX_PHYS_BIT) ||
 	   (addr >= top_lm && addr < SZ_4G) || addr >= top_hm) {
 		snprintf(msg, PND2_MSG_SIZE, "Error address 0x%llx is not DRAM", addr);
 		return -EINVAL;
@@ -727,10 +727,10 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 }
 
 /* Translate PMI address to memory (rank, row, bank, column) */
-#define C(n) (0x10 | (n))	/* column */
-#define B(n) (0x20 | (n))	/* bank */
-#define R(n) (0x40 | (n))	/* row */
-#define RS   (0x80)			/* rank */
+#define C(n) (BIT(4) | (n))	/* column */
+#define B(n) (BIT(5) | (n))	/* bank */
+#define R(n) (BIT(6) | (n))	/* row */
+#define RS   (BIT(7))		/* rank */
 
 /* addrdec values */
 #define AMAP_1KB	0
@@ -1064,9 +1064,9 @@ static int apl_check_ecc_active(void)
 	int	i, ret = 0;
 
 	/* Check dramtype and ECC mode for each present DIMM */
-	for (i = 0; i < APL_NUM_CHANNELS; i++)
-		if (chan_mask & BIT(i))
-			ret += check_channel(i);
+	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS)
+		ret += check_channel(i);
+
 	return ret ? -EINVAL : 0;
 }
 
@@ -1205,10 +1205,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *mci)
 	u64	capacity;
 	int	i, g;
 
-	for (i = 0; i < APL_NUM_CHANNELS; i++) {
-		if (!(chan_mask & BIT(i)))
-			continue;
-
+	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS) {
 		dimm = edac_get_dimm(mci, i, 0, 0);
 		if (!dimm) {
 			edac_dbg(0, "No allocated DIMM for channel %d\n", i);
@@ -1228,8 +1225,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *mci)
 		}
 
 		pvt->dimm_geom[i] = g;
-		capacity = (d->rken0 + d->rken1) * 8 * (1ul << dimms[g].rowbits) *
-				   (1ul << dimms[g].colbits);
+		capacity = (d->rken0 + d->rken1) * 8 * BIT(dimms[g].rowbits + dimms[g].colbits);
 		edac_dbg(0, "Channel %d: %lld MByte DIMM\n", i, capacity >> (20 - 3));
 		dimm->nr_pages = MiB_TO_PAGES(capacity >> (20 - 3));
 		dimm->grain = 32;
@@ -1295,7 +1291,7 @@ static void dnv_get_dimm_config(struct mem_ctl_info *mci)
 				continue;
 			}
 
-			capacity = ranks_of_dimm[j] * banks * (1ul << rowbits) * (1ul << colbits);
+			capacity = ranks_of_dimm[j] * banks * BIT(rowbits + colbits);
 			edac_dbg(0, "Channel %d DIMM %d: %lld MByte DIMM\n", i, j, capacity >> (20 - 3));
 			dimm->nr_pages = MiB_TO_PAGES(capacity >> (20 - 3));
 			dimm->grain = 32;
-- 
2.43.0.rc1.1.gbec44491f096

