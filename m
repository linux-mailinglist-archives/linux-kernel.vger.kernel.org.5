Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1676F96F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHDFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjHDFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:10:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DCA4229
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691125768; x=1722661768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0BVzKJgnxxS0Kjt1kPZeP946iAiq2X6MYsv63AwKm1o=;
  b=NFfvv2gqQ9ld9n5Fcnd03b9RW/yNHO2R7eL1/1BEZhLdfIjwdX7irm+A
   LNsMjeFemcE98TIDsxSMSL7REEEYef+pSeDVDd6GpksZZmDzGV6UahKwP
   Acv8kedcZ5KwLN5Mio9obLUd6mUt6NCoNtXJQHl9EBf4Xtee2vJjHS6f+
   dhgZZdHkSlL40HnDzLUYQqkD9ceKG1zXYvRvyzMu7Vzoox9/vwJcH75ar
   3MTrpd5nCtuNztZlVBy0VevPZkIqMDf7lKGsaWDntI9DOPP/SVmo6UrGD
   hDIJd5+QAajn/VK5X71qjIRz8O9392NmmHknlj2vvjeki6qaz4+FZldNg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368971037"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="368971037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976399793"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="976399793"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 22:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 697E9170; Fri,  4 Aug 2023 08:09:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] math.h: Document abs_diff()
Date:   Fri,  4 Aug 2023 08:09:34 +0300
Message-Id: <20230804050934.83223-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially abs_diff() has lack of documentation. Add it.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/math.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 336e3e3678e7..dfba59b59998 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -155,6 +155,18 @@ __STRUCT_FRACT(u32)
 	__builtin_types_compatible_p(typeof(x), unsigned type),		\
 	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
 
+/**
+ * abs_diff - return absolute value of the difference between the arguments
+ * @a: the first argument
+ * @b: the second argument
+ *
+ * @a and @b has to be of the same type. With this restriction we compare
+ * signed to signed and unsigned to unsigned. The result is the subtraction
+ * the smaller of the two from the bigger, hence result is always a positive
+ * value.
+ *
+ * Return: an absolute value of the difference between the @a and @b.
+ */
 #define abs_diff(a, b) ({			\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
-- 
2.40.0.1.gaa8946217a0b

