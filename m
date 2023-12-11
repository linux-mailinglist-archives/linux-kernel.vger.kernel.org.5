Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2180C9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjLKMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjLKMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:33:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BCA8E;
        Mon, 11 Dec 2023 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702298011; x=1733834011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LkVViNkwO7QQP+f8k/J3d57xIdGBSObZp2X787WTBXs=;
  b=Bz0iL+yRQ4my/Xg8WPzBa8nIHN6ETCgKeA0PaAU7rwLBqh0xqG0MZApF
   a3nNbkEmp9x6mTX2FastmZ0x57K2RZxAVsHZEVR29JH9f108f2j0+1X3J
   w7cfNeMNejTZEIZd1+m9DUmiR0FhHK9A+HwqLDYhgsdlLt3BYNHyi+8kI
   zXeJt1/zRf3vXGXG4zLf6XQ+ITI7NyLY55e8UGxs/7O6yqep+K/V16GGZ
   opLvv6BRhQI+kUsCx1FKpyO9lGPpxKqzdTpwxNkdwUTj73VygGPola4X7
   Ste8tYUiuTrU7axYDyQcUJDddK0Mym6TnbS5MriIasL8hsHWUgVwVzSbB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="391808850"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="391808850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="21069107"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2023 04:33:28 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] idpf: fix corrupted frames and skb leaks in singleq mode
Date:   Mon, 11 Dec 2023 13:31:44 +0100
Message-ID: <20231211123144.3759488-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
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

idpf_ring::skb serves only for keeping an incomplete frame between
several NAPI Rx polling cycles, as one cycle may end up before
processing the end of packet descriptor. The pointer is taken from
the ring onto the stack before entering the loop and gets written
there after the loop exits. When inside the loop, only the onstack
pointer is used.
For some reason, the logics is broken in the singleq mode, where the
pointer is taken from the ring each iteration. This means that if a
frame got fragmented into several descriptors, each fragment will have
its own skb, but only the last one will be passed up the stack
(containing garbage), leaving the rest leaked.
Then, on ifdown, rxq::skb is being freed only in the splitq mode, while
it can point to a valid skb in singleq as well. This can lead to a yet
another skb leak.
Just don't touch the ring skb field inside the polling loop, letting
the onstack skb pointer work as expected: build a new skb if it's the
first frame descriptor and attach a frag otherwise. On ifdown, free
rxq::skb unconditionally if the pointer is non-NULL.

Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Tony, please add it to dev-queue instead of the first revision.

From v1[0]:
* fix the related skb leak on ifdown;
* fix subject prefix;
* pick Reviewed-bys.

[0] https://lore.kernel.org/all/20231201143821.1091005-1-aleksander.lobakin@intel.com
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 1 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 81288a17da2a..20c4b3a64710 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1044,7 +1044,6 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		}
 
 		idpf_rx_sync_for_cpu(rx_buf, fields.size);
-		skb = rx_q->skb;
 		if (skb)
 			idpf_rx_add_frag(rx_buf, skb, fields.size);
 		else
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1f728a9004d9..9e942e5baf39 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -396,7 +396,7 @@ static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
 	if (!rxq)
 		return;
 
-	if (!bufq && idpf_is_queue_model_split(q_model) && rxq->skb) {
+	if (rxq->skb) {
 		dev_kfree_skb_any(rxq->skb);
 		rxq->skb = NULL;
 	}
-- 
2.43.0

