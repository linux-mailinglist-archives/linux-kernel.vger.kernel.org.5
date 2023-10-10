Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF17BFF31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjJJO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjJJO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:26:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DECE5AF;
        Tue, 10 Oct 2023 07:26:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614DBC15;
        Tue, 10 Oct 2023 07:27:21 -0700 (PDT)
Received: from e125770.cambridge.arm.com (e125770.arm.com [10.1.199.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85E93F762;
        Tue, 10 Oct 2023 07:26:39 -0700 (PDT)
From:   Luca Fancellu <luca.fancellu@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        Rahul Singh <rahul.singh@arm.com>
Subject: [PATCH 1/1] xen-netback: add software timestamp capabilities
Date:   Tue, 10 Oct 2023 15:26:30 +0100
Message-Id: <20231010142630.984585-2-luca.fancellu@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010142630.984585-1-luca.fancellu@arm.com>
References: <20231010142630.984585-1-luca.fancellu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add software timestamp capabilities to the xen-netback driver
by advertising it on the struct ethtool_ops and calling
skb_tx_timestamp before passing the buffer to the queue.

Signed-off-by: Luca Fancellu <luca.fancellu@arm.com>
---
 drivers/net/xen-netback/interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f3f2c07423a6..b71158967123 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -254,6 +254,9 @@ xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (vif->hash.alg == XEN_NETIF_CTRL_HASH_ALGORITHM_NONE)
 		skb_clear_hash(skb);
 
+	/* timestamp packet in software */
+	skb_tx_timestamp(skb);
+
 	if (!xenvif_rx_queue_tail(queue, skb))
 		goto drop;
 
@@ -460,7 +463,7 @@ static void xenvif_get_strings(struct net_device *dev, u32 stringset, u8 * data)
 
 static const struct ethtool_ops xenvif_ethtool_ops = {
 	.get_link	= ethtool_op_get_link,
-
+	.get_ts_info 	= ethtool_op_get_ts_info,
 	.get_sset_count = xenvif_get_sset_count,
 	.get_ethtool_stats = xenvif_get_ethtool_stats,
 	.get_strings = xenvif_get_strings,
-- 
2.34.1

