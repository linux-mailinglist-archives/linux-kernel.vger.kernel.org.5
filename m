Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB0751CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjGMJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjGMJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:08:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B01980;
        Thu, 13 Jul 2023 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689239280; x=1720775280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0G5VImXv6hkeSTU8kcKA4+bnPv7R82T0wFQmCmbE0I=;
  b=S7kjHHsgneOKNqBFt871vTOCBTXdiZMGqYdjcj4igUR9PewXC1yfyklI
   /Jw/tVUvfhU2ilRKHamDaMxP0C9Kw1GAIdB3xyV+fmCCaupZ2wXnJOl5L
   pSuQpoqx7sotFvS+sZHceMOkrv6e3FG7apNbh5xOo9HKEOoflm+y1T8h9
   v+6K13b2Y5vGBuFvpWVqnQ2YkCFl4cyUq6bQvDbGyQEDKv6x2xI7youfy
   yeW1D/SqMTJwEDAfsuDa4+ICG+uonpEh98XqVLjIX6riuXgGUFE7Ui0YK
   cFCMFfaTIfPk92VyRg7AVlqYPsur5hqUoqZKwoO39F8KrDPdufDy4CglO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367760145"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367760145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 02:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866481095"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866481095"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2023 02:07:57 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, chuck.lever@oracle.com
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next 2/2 v2] tools: ynl-gen: fix parse multi-attr enum attribute
Date:   Thu, 13 Jul 2023 11:05:50 +0200
Message-Id: <20230713090550.132858-3-arkadiusz.kubalewski@intel.com>
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

When attribute is enum type and marked as multi-attr, the netlink
respond is not parsed, fails with stack trace:
Traceback (most recent call last):
  File "/net-next/tools/net/ynl/./test.py", line 520, in <module>
    main()
  File "/net-next/tools/net/ynl/./test.py", line 488, in main
    dplls=dplls_get(282574471561216)
  File "/net-next/tools/net/ynl/./test.py", line 48, in dplls_get
    reply=act(args)
  File "/net-next/tools/net/ynl/./test.py", line 41, in act
    reply = ynl.dump(args.dump, attrs)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 598, in dump
    return self._op(method, vals, dump=True)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 584, in _op
    rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 451, in _decode
    self._decode_enum(rsp, attr_spec)
  File "/net-next/tools/net/ynl/lib/ynl.py", line 408, in _decode_enum
    value = enum.entries_by_val[raw].name
TypeError: unhashable type: 'list'
error: 1

Redesign _decode_enum(..) to take a enum int value and translate
it to either a bitmask or enum name as expected.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3908438d3716..06d88f083f95 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -417,8 +417,7 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
-    def _decode_enum(self, rsp, attr_spec):
-        raw = rsp[attr_spec['name']]
+    def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             value = set()
@@ -428,7 +427,7 @@ class YnlFamily(SpecFamily):
                 raw >>= 1
         else:
             value = enum.entries_by_val[raw].name
-        rsp[attr_spec['name']] = value
+        return value
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
@@ -436,7 +435,7 @@ class YnlFamily(SpecFamily):
             decoded = attr.as_struct(members)
             for m in members:
                 if m.enum:
-                    self._decode_enum(decoded, m)
+                    decoded[m] = self._decode_enum(decoded[m], m)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -464,6 +463,9 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
+            if 'enum' in attr_spec:
+                decoded = self._decode_enum(int.from_bytes(attr.raw, "big"), attr_spec)
+
             if not attr_spec.is_multi:
                 rsp[attr_spec['name']] = decoded
             elif attr_spec.name in rsp:
@@ -471,8 +473,6 @@ class YnlFamily(SpecFamily):
             else:
                 rsp[attr_spec.name] = [decoded]
 
-            if 'enum' in attr_spec:
-                self._decode_enum(rsp, attr_spec)
         return rsp
 
     def _decode_extack_path(self, attrs, attr_set, offset, target):
-- 
2.37.3

