Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2B751CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjGMJIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjGMJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F0912E;
        Thu, 13 Jul 2023 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689239277; x=1720775277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPZzjqz7eqP99LYiwaj8IjdY7wvVMBfdnWJXbpDiBtk=;
  b=KYyiECIjtSO11ykoxV4pg2fPug+Pu0rnqK4hOzrPqclGYjzN3vQ27emh
   ioiSH0Jt+fizP7i+oRmPiAFI6sVy6B9IFgN018oaAAcZmt5o47Au8SOvr
   2pBf2ha3jTic9FZN8EbhyNcZrPVUxsTJ6PxdLC7zbE5+lpQ+lytW1EhKL
   oRZU2ZUQrB3c7i7J5orn7R5TR2bzvNDUMSD9Yd1W5h6unGEUc6YXUQYGs
   XoOY9JD98m+hhTF+2f47M+YrKI3TY+ot1gqQtOUw1lyZFxuz21Ypr6z5J
   vW5ArCZN8D/TpNpti4X5MLNz5q79ylCiVd4oZl3ddhlma7Z5Hcd2eq3az
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367760138"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367760138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 02:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866481086"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866481086"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2023 02:07:54 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, chuck.lever@oracle.com
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next 1/2 v2] tools: ynl-gen: fix enum index in _decode_enum(..)
Date:   Thu, 13 Jul 2023 11:05:49 +0200
Message-Id: <20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove wrong index adjustment, which is a leftover from adding
support for sparse enums.
enum.entries_by_val() function shall not subtract the start-value, as
it is indexed with real enum value.

Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic CLI")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1b3a36fbb1c3..3908438d3716 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -420,16 +420,14 @@ class YnlFamily(SpecFamily):
     def _decode_enum(self, rsp, attr_spec):
         raw = rsp[attr_spec['name']]
         enum = self.consts[attr_spec['enum']]
-        i = attr_spec.get('value-start', 0)
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             value = set()
             while raw:
                 if raw & 1:
-                    value.add(enum.entries_by_val[i].name)
+                    value.add(enum.entries_by_val[raw & 1].name)
                 raw >>= 1
-                i += 1
         else:
-            value = enum.entries_by_val[raw - i].name
+            value = enum.entries_by_val[raw].name
         rsp[attr_spec['name']] = value
 
     def _decode_binary(self, attr, attr_spec):
-- 
2.37.3

