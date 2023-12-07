Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9762808ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443653AbjLGRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443576AbjLGRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:22:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C691991;
        Thu,  7 Dec 2023 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701969759; x=1733505759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TjROgvzz+AzG/C6BlsByYcCs8uICvUxyJbG/WNviUeU=;
  b=nISc8Q+cu+CKybA8Zxdahs56kTjlfJFGDluPFjFN/DtHz/TStccHriPP
   ouYGDLa0ud+cs96xbxfbW8P/Ah6iLHbGTmsCZhwnTMKsmxp9V/wDrE8Wc
   pPe9dNpzQFf1rOLSwgSjJZSy2o1s+GvOhsuKqW9PIGy26oTXxILlZEBoc
   GSmzW6LqXSSRz+NFpmYCl1XuvA4LJkss0sGW5r9IBuEc4Qnr/Lg4M5P0C
   PPmYq471Do0AIzoU+jom5jX+lcLA5v9FIfC8+pf40bUc8879phMKT247K
   8awaOPhyApSUaayMRIljT1nFlVsFf09pJM3Z08GXfZ/3QBDKWsh2UIDhV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374434980"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374434980"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721548643"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721548643"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 09:22:33 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 09/12] iavf: pack iavf_ring more efficiently
Date:   Thu,  7 Dec 2023 18:20:07 +0100
Message-ID: <20231207172010.1441468-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before replacing the Rx buffer management with libie, clean up
&iavf_ring a bit.
There are several fields not used anywhere in the code -- simply remove
them. Move ::tail up to remove a hole. Replace ::arm_wb boolean with
1-bit flag in ::flags to free 1 more byte. Finally, move ::prev_pkt_ctr
out of &iavf_tx_queue_stats -- it doesn't belong there (used for Tx
stall detection). Place it next to the stats on the ring itself to fill
the 4-byte slot.
The result: no holes and all the hot fields fit into the first 64-byte
cacheline.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 12 +++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 22 +++------------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 665ee1feb877..62f976d322ab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -184,7 +184,7 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 			 * pending work.
 			 */
 			packets = tx_ring->stats.packets & INT_MAX;
-			if (tx_ring->tx_stats.prev_pkt_ctr == packets) {
+			if (tx_ring->prev_pkt_ctr == packets) {
 				iavf_force_wb(vsi, tx_ring->q_vector);
 				continue;
 			}
@@ -193,7 +193,7 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 			 * to iavf_get_tx_pending()
 			 */
 			smp_rmb();
-			tx_ring->tx_stats.prev_pkt_ctr =
+			tx_ring->prev_pkt_ctr =
 			  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
 		}
 	}
@@ -319,7 +319,7 @@ static bool iavf_clean_tx_irq(struct iavf_vsi *vsi,
 		    ((j / WB_STRIDE) == 0) && (j > 0) &&
 		    !test_bit(__IAVF_VSI_DOWN, vsi->state) &&
 		    (IAVF_DESC_UNUSED(tx_ring) != tx_ring->count))
-			tx_ring->arm_wb = true;
+			tx_ring->flags |= IAVF_TXR_FLAGS_ARM_WB;
 	}
 
 	/* notify netdev of completed buffers */
@@ -674,7 +674,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
-	tx_ring->tx_stats.prev_pkt_ctr = -1;
+	tx_ring->prev_pkt_ctr = -1;
 	return 0;
 
 err:
@@ -1494,8 +1494,8 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 			continue;
 		}
-		arm_wb |= ring->arm_wb;
-		ring->arm_wb = false;
+		arm_wb |= !!(ring->flags & IAVF_TXR_FLAGS_ARM_WB);
+		ring->flags &= ~IAVF_TXR_FLAGS_ARM_WB;
 	}
 
 	/* Handle case where we are called by netpoll with a budget of 0 */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 720bca0e6716..9b8154c5f4fb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -228,7 +228,6 @@ struct iavf_tx_queue_stats {
 	u64 tx_done_old;
 	u64 tx_linearize;
 	u64 tx_force_wb;
-	int prev_pkt_ctr;
 	u64 tx_lost_interrupt;
 };
 
@@ -238,12 +237,6 @@ struct iavf_rx_queue_stats {
 	u64 alloc_buff_failed;
 };
 
-enum iavf_ring_state_t {
-	__IAVF_TX_FDIR_INIT_DONE,
-	__IAVF_TX_XPS_INIT_DONE,
-	__IAVF_RING_STATE_NBITS /* must be last */
-};
-
 /* some useful defines for virtchannel interface, which
  * is the only remaining user of header split
  */
@@ -265,10 +258,8 @@ struct iavf_ring {
 		struct iavf_tx_buffer *tx_bi;
 		struct iavf_rx_buffer *rx_bi;
 	};
-	DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
-	u16 queue_index;		/* Queue number of ring */
-	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
+	u16 queue_index;		/* Queue number of ring */
 
 	/* high bit set means dynamic, use accessors routines to read/write.
 	 * hardware only supports 2us resolution for the ITR registers.
@@ -278,22 +269,14 @@ struct iavf_ring {
 	u16 itr_setting;
 
 	u16 count;			/* Number of descriptors */
-	u16 reg_idx;			/* HW register index of the ring */
 
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
-
-	bool ring_active;		/* is ring online or not */
-	bool arm_wb;		/* do something to arm write back */
-	u8 packet_stride;
-
 	u16 flags;
 #define IAVF_TXR_FLAGS_WB_ON_ITR		BIT(0)
-/* BIT(1) is free, was IAVF_RXR_FLAGS_BUILD_SKB_ENABLED */
+#define IAVF_TXR_FLAGS_ARM_WB			BIT(1)
 /* BIT(2) is free */
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
@@ -307,6 +290,7 @@ struct iavf_ring {
 		struct iavf_rx_queue_stats rx_stats;
 	};
 
+	int prev_pkt_ctr;		/* For Tx stall detection */
 	unsigned int size;		/* length of descriptor ring in bytes */
 	dma_addr_t dma;			/* physical address of ring */
 
-- 
2.43.0

