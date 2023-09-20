Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833267A74E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjITHxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjITHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:53:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E809D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695196414; x=1726732414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cyF9k8+wKohW4Ip51mWA8jLGwLnjOpNLUoQ7IQBCewg=;
  b=WeSB6Qq4KgBz0TYf0O0IBx7sHB9rqLyYnkFvUM5ecMzkC5xdTsrk0aWZ
   kJK5Ed/0Le65mS7HN/pOE7aOs7OpDNN/dv0rYsk0UZ0+ucgnBHAKuWPCV
   xZjWye8iD8zbf8bMjLgU9Lwz9qlXT8ybslmezfgIFFeHrgLCEc0kqQA0l
   MM0XWmtg+/oe8VmEOnZywdeCGxhde4hMl8zQZ1agbw0dqb5TSlZgLeyrk
   9e2tVmZzvQk5o/7vryPE1n7WMjeoaTGpPRjraAh3yKd0Z4nzdTN3FGgGv
   FZj+exyHWEd+rr5xju/gX+icGZKQ2tKI6oRnVHJMYtYssWQKj37bgCv7X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411095222"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411095222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870272968"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="870272968"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 00:53:31 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mm/slub: add sanity check for slub_min/max_order cmdline setup
Date:   Wed, 20 Sep 2023 15:44:13 +0800
Message-Id: <20230920074413.1361547-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are 2 parameters could be setup from kernel cmdline:
slub_min_order and slub_max_order. It's possible that the user
configured slub_min_order is bigger than the default slub_max_order
[1], which can still take effect, as calculate_oder() will use MAX_ORDER
as a fallback to check against, but has some downsides:

* the kernel message about SLUB will be strange in showing min/max
  orders:

    SLUB: HWalign=64, Order=9-3, MinObjects=0, CPUs=16, Nodes=1

* in calculate_order() called by each slab, the 2 loops of
  calc_slab_order() will all be meaningless due to slub_min_order
  is bigger than slub_max_order

* prevent future code cleanup like in [2].

Fix it by adding some sanity check to enforce the min/max semantics.

[1]. https://lore.kernel.org/lkml/21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com/
[2]. https://lore.kernel.org/lkml/20230908145302.30320-7-vbabka@suse.cz/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..b36e5eb0ccb7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4711,6 +4711,9 @@ static int __init setup_slub_min_order(char *str)
 {
 	get_option(&str, (int *)&slub_min_order);
 
+	if (slub_min_order > slub_max_order)
+		slub_max_order = slub_min_order;
+
 	return 1;
 }
 
@@ -4721,6 +4724,9 @@ static int __init setup_slub_max_order(char *str)
 	get_option(&str, (int *)&slub_max_order);
 	slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);
 
+	if (slub_min_order > slub_max_order)
+		slub_min_order = slub_max_order;
+
 	return 1;
 }
 
-- 
2.27.0

