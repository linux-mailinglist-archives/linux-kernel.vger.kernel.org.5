Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EAA7A9BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjIUTEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjIUTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:03:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FF89D92;
        Thu, 21 Sep 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318732; x=1726854732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CB1e+1tDos0izps6y7bKpYTFHFvWb1uVC0e3ziRvTvY=;
  b=mecA3MhG8FsF1L21mW5EE32egHlmVWqjFJFhGlb4kpq8+3WFNyFwOYe5
   AVLA1N14JzI47A9GpIoKEuqzdP2MRL+oaQy0rY6PAGD8hhxC3ytF/OOjP
   DQHi/j14luo8t1InVRRC5EgEtqJ7AXax/FSub8DKQ4GEAueW597y+XKAs
   HeZpdzFJ8u0HjksA48SfAs89sRKddv5hGEd6THec/Hp3WU4pTFJjWGwWs
   DT4PtivxIs1gfBGJADMpG6ybuxqsiiD3U+q8bAaJVXNUM4kASWgO2LUuI
   ZmbZWeIP8HufYhLqlguGLN1hYD1Ze/d+owXRUHWMNo4Zis3b/dSz1Dk47
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="379396206"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="379396206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="812639263"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="812639263"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 06:00:40 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next] idpf: fix undefined reference to tcp_gro_complete() when !CONFIG_INET
Date:   Thu, 21 Sep 2023 14:59:36 +0200
Message-ID: <20230921125936.1621191-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
the drivers using it may still be compiled (spotted by Randy):

aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
in function `idpf_rx_rsc.isra.0':
drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
undefined reference to `tcp_gro_complete'

The drivers need to guard the calls to it manually.
Return early from the RSC completion function if !CONFIG_INET, it won't
work properly either way. This effectively makes it be compiled-out
almost entirely on such builds.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Directly to net-next, build bots are not happy :s

From v1[0]:
 * post the patch as standalone;
 * pick the received tags (Randy, Jake, Przemek).

[0] https://lore.kernel.org/netdev/20230920180745.1607563-1-aleksander.lobakin@intel.com
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6fa79898c42c..aa45afeb6496 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (unlikely(!(ipv4 ^ ipv6)))
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_INET))
+		return 0;
+
 	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
 	if (unlikely(rsc_segments == 1))
 		return 0;
-- 
2.41.0

