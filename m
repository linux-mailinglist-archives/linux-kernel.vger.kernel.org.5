Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6257B0A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjI0Qrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjI0Qri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA85DE;
        Wed, 27 Sep 2023 09:47:36 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366934590"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="366934590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 09:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="922853707"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="922853707"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 09:47:35 -0700
From:   joao@overdrivepizza.com
To:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao@overdrivepizza.com
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: [PATCH v3 1/2] Make loop indexes unsigned
Date:   Wed, 27 Sep 2023 09:47:14 -0700
Message-ID: <20230927164715.76744-2-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927164715.76744-1-joao@overdrivepizza.com>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
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

Both flow_rule_alloc and offload_action_alloc functions received an
unsigned num_actions parameters which are then operated within a loop.
The index of this loop is declared as a signed int. If it was possible
to pass a large enough num_actions to these functions, it would lead to
an out of bounds write.

After checking with maintainers, it was mentioned that front-end will
cap the num_actions value and that it is not possible to reach this
function with such a large number. Yet, for correctness, it is still
better to fix this.

This issue was observed by the commit author while reviewing a write-up
regarding a CVE within the same subsystem [1].

1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Signed-off-by: Joao Moreira <joao.moreira@intel.com>
---
 net/core/flow_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index bc5169482710..bc3f53a09d8f 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -10,7 +10,7 @@
 struct flow_rule *flow_rule_alloc(unsigned int num_actions)
 {
 	struct flow_rule *rule;
-	int i;
+	unsigned int i;
 
 	rule = kzalloc(struct_size(rule, action.entries, num_actions),
 		       GFP_KERNEL);
@@ -31,7 +31,7 @@ EXPORT_SYMBOL(flow_rule_alloc);
 struct flow_offload_action *offload_action_alloc(unsigned int num_actions)
 {
 	struct flow_offload_action *fl_action;
-	int i;
+	unsigned int i;
 
 	fl_action = kzalloc(struct_size(fl_action, action.entries, num_actions),
 			    GFP_KERNEL);
-- 
2.42.0

