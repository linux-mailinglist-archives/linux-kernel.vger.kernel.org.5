Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2878F685
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbjIABEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbjIABEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:04:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD5E0;
        Thu, 31 Aug 2023 18:04:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375009822"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="375009822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733361463"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="733361463"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:04:31 -0700
From:   joao@overdrivepizza.com
To:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao@overdrivepizza.com
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: [PATCH 0/2] Prevent potential write out of bounds
Date:   Thu, 31 Aug 2023 18:04:35 -0700
Message-ID: <20230901010437.126631-1-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.41.0
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

The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
unsigned int num_actions (line 10) and later traverses the actions in
the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.

Within the same file, the loop in the line 24 compares a signed int
(i) to an unsigned int (num_actions), and then uses i as an array
index. If an integer overflow happens, then the array within the loop
is wrongly indexed, causing a write out of bounds.

After checking with maintainers, it seems that the front-end caps the
maximum value of num_action, thus it is not possible to reach the given
write out of bounds, yet, still, to prevent disasters it is better to
fix the signedness here.

Similarly, also it is also good to ensure that an overflow won't happen
in net/netfilter/nf_tables_offload.c's function nft_flow_rule_create by
checking that num_actions is not negative.

Tks,

Joao Moreira (2):
  Make loop indexes unsigned
  Ensure num_actions is not a negative

 net/core/flow_offload.c           | 4 ++--
 net/netfilter/nf_tables_offload.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.41.0

