Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40280EECB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376811AbjLLO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjLLO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:29:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D98E;
        Tue, 12 Dec 2023 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702391392; x=1733927392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tC4nqzPPkN2y5U1+kXQLWaCibaTxMNcqk0oLrJfP9KY=;
  b=SDNZRE1C0WvK46b1KUE5s0Pfy7LIkGGIWaFRiu8LUECAFzGtqNAKJMGk
   ASeCbFD8tKUJKqdw8/4kXTaJ/CaXp1SsZtJg2koM0d/IGl4dGImUmP7Po
   f+I/pFQ1oHGvTUkmmAsEVHXdZE4Y7gqFgcHtt1DqSuUZzH896ef6AlitA
   CAhudX3Eqy0qYm5DwTgPDThII7u8j99gE/Lx2KfINFWK+VMyV1zc0SyFz
   JUawTzroU+8DXYwwq+MjUUvI4s57sHpsVKTk8uClDCnnOsaqej6aTEJYf
   uXcqV5/jdvb/PJsq3QimdhXvd/l/x8HoJEUeRh1ea/Gwj/2PzSE+9b4bY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1887348"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1887348"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104923746"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104923746"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 06:29:48 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>,
        Jiri Pirko <jiri@resnulli.us>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] ethtool: add SET for TCP_DATA_SPLIT ringparam
Date:   Tue, 12 Dec 2023 15:27:51 +0100
Message-ID: <20231212142752.935000-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
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

Follow up commit 9690ae604290 ("ethtool: add header/data split
indication") and add the set part of Ethtool's header split, i.e.
ability to enable/disable header split via the Ethtool Netlink
interface. This might be helpful to optimize the setup for particular
workloads, for example, to avoid XDP frags, and so on.
A driver should advertise ``ETHTOOL_RING_USE_TCP_DATA_SPLIT`` in its
ops->supported_ring_params to allow doing that. "Unknown" passed from
the userspace when the header split is supported means the driver is
free to choose the preferred state.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/rings.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index deb683d3360f..67b30940234b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -95,6 +95,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_TX_PUSH: capture for setting tx_push
  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
+ * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -102,6 +103,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_TX_PUSH		= BIT(2),
 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
+	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index fb09f774ea01..b7865a14fdf8 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -124,6 +124,8 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_JUMBO]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TX]			= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT]	=
+		NLA_POLICY_MAX(NLA_U8, ETHTOOL_TCP_DATA_SPLIT_ENABLED),
 	[ETHTOOL_A_RINGS_CQE_SIZE]		= NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
@@ -145,6 +147,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
+				    "setting TCP data split is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -202,6 +212,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	ethnl_update_u32(&ringparam.tx_pending, tb[ETHTOOL_A_RINGS_TX], &mod);
 	ethnl_update_u32(&kernel_ringparam.rx_buf_len,
 			 tb[ETHTOOL_A_RINGS_RX_BUF_LEN], &mod);
+	ethnl_update_u8(&kernel_ringparam.tcp_data_split,
+			tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT], &mod);
 	ethnl_update_u32(&kernel_ringparam.cqe_size,
 			 tb[ETHTOOL_A_RINGS_CQE_SIZE], &mod);
 	ethnl_update_u8(&kernel_ringparam.tx_push,
-- 
2.43.0

