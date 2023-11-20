Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE07F12D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjKTMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjKTMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:09:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBEB8;
        Mon, 20 Nov 2023 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482144; x=1732018144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vkKEZYR1JQ2LvJYNE9fzcULsL9BK72aBp+vTKNFQKvk=;
  b=B1iz5UkjXDwEa8/UYKwt1OymeZS/ABVIOAby1SDCXxcEynrwyownkitZ
   vgdJEkXBhylfj5NLMfnQ7NS+B+TzZ0xk6/9hnjVLAZe5elZ9xAYqLpC6T
   ug2zzoLBulTiDemdnA4PTOUCwf9vh/UM44DrcfA5xP04Dej/Ls1A/PHET
   QG+sbymJFBe+zic379ofxHJQpslT+YKVz2ehKl65dhCUUn6P/wDk8jkwa
   Gxy0LtRDH7zpvlOK5mPEBwXVHMpF/zea42eO2PwG5Y86Q/Cyyjxf5B/En
   UypVouAXGIxO+FmboiG2CaytrT0ijHsXAFRzhFrJTgbHX7zAdFGEdKYU0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455651"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455651"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878583"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878583"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:08:50 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/6] compiler.h: Introduce helpers for identifying array and pointer types
Date:   Mon, 20 Nov 2023 17:38:32 +0530
Message-Id: <20231120120837.3002-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce is_array_type() and is_pointer_type() helpers, which compare the
data type of provided argument against the enumeration values defined in
typeclass.h using __builtin_classify_type() function and identify array
and pointer types respectively.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/compiler.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c7057b..b4f656002c0f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,11 @@ static inline void *offset_to_ptr(const int *off)
 #define is_signed_type(type) (((type)(-1)) < (__force type)1)
 #define is_unsigned_type(type) (!is_signed_type(type))
 
+/* Classify data type based on enum values in typeclass.h */
+#define is_array_type(x)		(__builtin_classify_type(x) == 14)
+#define is_pointer_type(x)		(__builtin_classify_type(x) == 5)
+#define is_array_or_pointer_type(x)	(is_array_type(x) || is_pointer_type(x))
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.17.1

