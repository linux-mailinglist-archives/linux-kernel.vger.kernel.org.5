Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0D78FE8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbjIANob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjIANoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:44:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD019AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575846; x=1725111846;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6xslPpiG+wv0B3QAT5lk3I7KMb0wSLeJEybXYu/sjFY=;
  b=lyK/yeroUtC2/cLoedlB/m5ng2ws6PXCM6toyeiPrmFp7ii+BOKJULrL
   EkSD1EBDAU1XZ7+1fy0Jk/eWwBWc8mSYNWGazIQc8eF8jPsGjuo73gH+Q
   CK1DnxiEfp2IqtsjevSlGjO5YQy4hMVhzsvhw05EFsxl1kA0MsJiWU6eM
   G0UgGFjGYWbpdrfs42i8uPXv2cpq44BeHgvYbyGxLZLlydHUTZ24z0Dwl
   MtjGq3a6toZJ/FGAyRGoURVmOfimGuw5H3e8KAXL+iqjO6OJjHnv7ayHg
   Nh5qukqURI5NsToqTjyhmAZ/bRraUdDEq0R1bIXBj0ry5VcrX+7zV+MIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407213207"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="407213207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863539925"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="863539925"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2023 06:42:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 89EA4761; Fri,  1 Sep 2023 16:42:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] resource: Reuse for_each_resource() macro
Date:   Fri,  1 Sep 2023 16:42:15 +0300
Message-Id: <20230901134217.1172891-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few places where for_each_resource() is open coded.
Replace that by the macro. This makes code easier to read and
understand.

With this, compile r_next() only for CONFIG_PROC_FS=y.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..86716cd566e9 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -77,13 +77,6 @@ static struct resource *next_resource_skip_children(struct resource *p)
 	     (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
 				       next_resource(_p))
 
-static void *r_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct resource *p = v;
-	(*pos)++;
-	return (void *)next_resource(p);
-}
-
 #ifdef CONFIG_PROC_FS
 
 enum { MAX_IORES_LEVEL = 5 };
@@ -91,14 +84,26 @@ enum { MAX_IORES_LEVEL = 5 };
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
 {
-	struct resource *p = pde_data(file_inode(m->file));
-	loff_t l = 0;
+	struct resource *root = pde_data(file_inode(m->file));
+	struct resource *p;
+	loff_t l = *pos;
+
 	read_lock(&resource_lock);
-	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
-		;
+	for_each_resource(root, p, false) {
+		if (l-- == 0)
+			break;
+	}
+
 	return p;
 }
 
+static void *r_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct resource *p = v;
+	(*pos)++;
+	return (void *)next_resource(p);
+}
+
 static void r_stop(struct seq_file *m, void *v)
 	__releases(resource_lock)
 {
@@ -336,7 +341,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for (p = iomem_resource.child; p; p = next_resource(p)) {
+	for_each_resource(&iomem_resource, p, false) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -1641,13 +1646,12 @@ __setup("reserve=", reserve_setup);
  */
 int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 {
-	struct resource *p = &iomem_resource;
 	resource_size_t end = addr + size - 1;
+	struct resource *p;
 	int err = 0;
-	loff_t l;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for_each_resource(&iomem_resource, p, false) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
-- 
2.40.0.1.gaa8946217a0b

