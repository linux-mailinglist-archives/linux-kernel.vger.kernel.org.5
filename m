Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1316800D6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379199AbjLAOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379202AbjLAOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:39:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66E171B;
        Fri,  1 Dec 2023 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701441571; x=1732977571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8zt17gleUs6XdyCrQUt22NFtXS6H7COoWrjOZ8T+sc=;
  b=S5NX34br8AOZqWrnoTha5RmB6Ti7SNlMM5quV1FwhII2MJZVw2ybeBKz
   hYSEIZI7CsIdCtXVoaWdldwy2jBxk//l3T/+naoUv5hrIDoahc5WJKUw8
   xShpCeeQMpu1dZ+bOkxKUs/Yvo8NEPQWNOkR5cU+bmk4PcaYY9Q4Cp6ZH
   0y8eo5kB3SE7xW8Pq8V8ErQZZlkJjm5F2/R16jEQ3xHi82wkN3VDwZAma
   ex88pLiSIf2pbTRqPXFF2tQQmTEX5IeCFUmn1iL1vb2d/99g3zHEp9Px0
   FuC9oMgvGI+GdEV9U56URj1i2goXgFkEI0SWeKwSDgAWib1diYCDf9SYF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="359144"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="359144"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 06:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913597561"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913597561"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2023 06:39:28 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH iwl] idpf: fix corrupted frames and skb leaks in singleq mode
Date:   Fri,  1 Dec 2023 15:38:21 +0100
Message-ID: <20231201143821.1091005-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Just don't touch the ring skb field inside the polling loop, letting
the onstack skb pointer work as expected: build a new skb if it's the
first frame descriptor and attach a frag otherwise.

Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.43.0

