Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94D7B0A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjI0Qrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjI0Qrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:47:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794EFB;
        Wed, 27 Sep 2023 09:47:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366934576"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="366934576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 09:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="922853701"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="922853701"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 09:47:33 -0700
From:   joao@overdrivepizza.com
To:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao@overdrivepizza.com
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: [PATCH v3 0/2] Prevent potential write out of bounds
Date:   Wed, 27 Sep 2023 09:47:13 -0700
Message-ID: <20230927164715.76744-1-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
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
making the variable unsigned and ensuring that it returns an error if
its value reaches 256. The set limit value comes from discussions in the
mailing list where 256 was identified as a more than enough for the
frontend actions.

This issue was observed by the commit author while reviewing a write-up
regarding a CVE within the same subsystem [1].

1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Tks,

v2:
- Identify overflow by making num_actions unsigned and checking if it
  reaches UINT_MAX instead of looking for its signedness.
v3:
- Avoid overflow by checking if num_actions reaches 256 (which is
  enough) instead of UINT_MAX.

Joao Moreira (2):
  Make loop indexes unsigned
  Make num_actions unsigned

 net/core/flow_offload.c           | 4 ++--
 net/netfilter/nf_tables_offload.c | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.42.0

