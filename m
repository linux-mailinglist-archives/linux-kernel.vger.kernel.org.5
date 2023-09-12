Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4938E79D467
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjILPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjILPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80419CEB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531265; x=1726067265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZARSdoFCqlQ8R698PWQsBWxz7kOn+9GL/Gy+QZMtVQ=;
  b=QTUysuG4oGVdHe7Sxr2STVwLOAenqsdONirLY/pR793dMV3OJlfWAbou
   p9/63hxXp2vsERnpVb6KvyG780FIVuVqTnbsSp/N130hHaeVjY2Yc8zS4
   tLI8ULo8jlWYFTQSYot4fUuNbNYHInlRt5P1/NAP+8uQe/lpCo+aJTf0I
   Vd8NRJ/KUdD7HOHp+HTLmZbKUgOA/VIHWApuBZvb0WDs7kt8q7qCNV98f
   YBfphW91H1jUuf1/H4i4Ze/KeSBO9ZNlrJWN54udfQqV4WiyvOf4H19oS
   xxyfFuOWSEU5egt1gXzvGj69chyGJGBFPy7l/uYbHTJOl9rYyKbmerlct
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368662560"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="368662560"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773065029"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="773065029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2023 08:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E53FBC2; Tue, 12 Sep 2023 18:05:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 4/6] params: Use size_add() for kmalloc()
Date:   Tue, 12 Sep 2023 18:05:49 +0300
Message-Id: <20230912150551.401537-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent allocations from integer overflow by using size_add().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 930a5dc2f004..fd11c731475f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
@@ -48,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
2.40.0.1.gaa8946217a0b

