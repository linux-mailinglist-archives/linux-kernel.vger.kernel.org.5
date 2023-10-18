Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776927CEBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjJRXRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJRXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77D113;
        Wed, 18 Oct 2023 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670989; x=1729206989;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GIPMSMLcNSd70raoeZwCxjNvumcHnXvuwgkKfWU6OdQ=;
  b=XO5yM3YtmIUNCneEOiNYb6ZijDJOhQJp68s2OJwXBKvd0l9+O18bPLUS
   xWvwOVMDrRvY11TO0DwNe+d0XaRAQ964W/q1/heZzBYoNXFzm/NFpkBBP
   83RXhPlrTpXQ4ePmmeP5XkJo0m+IAmIXXFZcDRGaoIHKP+xYnlDDO4vce
   yOZrx17B25sShSdY589HOvET5zf2pIM7y7jWH6WtcFPvfPAZ5ah6O0qM4
   td/HN1uG26xciwZ5ct/axiXkiamOnOB7XJnFKcgoq4K8GOOJviafpZfsF
   B6OLpCxxDFx3ZG+U+QwMczsMYLbBp8bDQPRqCgDEgQeBlZ4TCjwGAdk8/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605961"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782183"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782183"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id C5BFA580DD0;
        Wed, 18 Oct 2023 16:16:25 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@linux.intel.com, arnd@arndb.de, peterz@infradead.org,
        aleksander.lobakin@intel.com, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH V4 10/17] linux/io.h: iounmap/ioport_unmap cleanup.h support
Date:   Wed, 18 Oct 2023 16:16:17 -0700
Message-Id: <20231018231624.1044633-11-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auto-release cleanups for ioumap and ioport_unmap.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V4 - New patch

 include/linux/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index 7304f2a69960..1488832c4ad2 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_IO_H
 #define _LINUX_IO_H
 
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/bug.h>
@@ -20,6 +21,9 @@ __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
+DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
+DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
+
 #ifdef CONFIG_MMU
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       phys_addr_t phys_addr, pgprot_t prot);
-- 
2.34.1

