Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6A7901F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbjIASRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbjIASRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:17:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526CA1707
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693592227; x=1725128227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TbWSp+CQPKRZ1zYd1VCNuFvodX7IQ75yftc9mVnbeJQ=;
  b=IqfOq0l4P1H2UYV0/04Sei8u0HscU3VZo/9TSbYDu/vqCUKavfkCX1cr
   LHDzamG+e6HMonDKJ4317PJ+1dzqMTTSKTZTdQlpECjdf49ILhSDqeZgC
   hTkgo/LP2mrN9NidFsTpS4c6IRpBTbZj47fRxumWSO5zmPcmiRo0+mlsX
   QR+tpY9K9szbzr+pbecu+2/K+izH9PjJ/2uIxhgUnF4jNFs9Rk5Zg3yTN
   R2SW7KStWI9pN2t+RJhUY5aqaG16BLFgBe7hwuQZ34mpIUJUepxG43YKQ
   96BtssIWC9WwSBN5/KEDkSU7EI6lCT5Jrk8gHdnuJBkFQccqvwPZT5Myv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376208968"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="376208968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 11:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="775084459"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="775084459"
Received: from ylee37-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.18.85])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 11:17:06 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Date:   Fri,  1 Sep 2023 11:16:52 -0700
Message-Id: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stack's selftest utilizes the map_shadow_stack syscall. The
syscall is new with the feature, but the selftests cannot automatically
find the headers for the kernel source tree they are located in. This
resulted in the shadow stack test failing to build until the brand new
headers were installed.

To avoid this, a copy of the new uapi defines needed by the test were
included in the selftest (see link for discussion). When shadow stack was
merged the syscall number was changed, but the copy in the selftest was
not updated.

So update the copy of the syscall number define used when the required
headers are not installed, to have the final syscall number from the
merge.

Link: https://lore.kernel.org/lkml/Y%2FijdXoTAATt0+Ct@zn.tnic/
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 tools/testing/selftests/x86/test_shadow_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 2188968674cb..757e6527f67e 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -40,7 +40,7 @@
  * without building the headers.
  */
 #ifndef __NR_map_shadow_stack
-#define __NR_map_shadow_stack	452
+#define __NR_map_shadow_stack	453
 
 #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
 
-- 
2.34.1

