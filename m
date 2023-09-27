Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D07AF83D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjI0Cjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0Chv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:37:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDE1C26C;
        Tue, 26 Sep 2023 19:02:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385565355"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385565355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725628857"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725628857"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:41 -0700
From:   joao@overdrivepizza.com
To:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao@overdrivepizza.com
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: [PATCH v2 2/2] Make num_actions unsigned
Date:   Tue, 26 Sep 2023 19:02:21 -0700
Message-ID: <20230927020221.85292-3-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927020221.85292-1-joao@overdrivepizza.com>
References: <20230927020221.85292-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao.moreira@intel.com>

Currently, in nft_flow_rule_create function, num_actions is a signed
integer. Yet, it is processed within a loop which increments its
value. To prevent an overflow from occurring, make it unsigned and
also check if it reaches UINT_MAX when being incremented.

After checking with maintainers, it was mentioned that front-end will
cap the num_actions value and that it is not possible to reach such
condition for an overflow. Yet, for correctness, it is still better to
fix this.

This issue was observed by the commit author while reviewing a write-up
regarding a CVE within the same subsystem [1].

1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Signed-off-by: Joao Moreira <joao.moreira@intel.com>
---
 net/netfilter/nf_tables_offload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 12ab78fa5d84..d25088791a74 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 {
 	struct nft_offload_ctx *ctx;
 	struct nft_flow_rule *flow;
-	int num_actions = 0, err;
+	unsigned int num_actions = 0;
+	int err;
 	struct nft_expr *expr;
 
 	expr = nft_expr_first(rule);
@@ -99,6 +100,9 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 		    expr->ops->offload_action(expr))
 			num_actions++;
 
+		if (num_actions == UINT_MAX)
+			return ERR_PTR(-ENOMEM);
+
 		expr = nft_expr_next(expr);
 	}
 
-- 
2.42.0

