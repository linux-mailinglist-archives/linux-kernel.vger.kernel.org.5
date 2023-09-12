Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0179D6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjILQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjILQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:53:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73287170F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537635; x=1726073635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6xslPpiG+wv0B3QAT5lk3I7KMb0wSLeJEybXYu/sjFY=;
  b=MaKTcfxTNsH/aMZsaJJzZfI0ma2qK6Zy25T+1YDBEl1cfCYWkN1h3XhP
   XIa8Z5LoZsOBSey8yXYWRTa5KEuAWUXH7zxHZ/Al0oqM3Sv213ZR5cEnL
   Xs0Aialr1NvEQTo8FKEfPzegi+rp0atn0g6vbvFiMUW/pjFQIwlXar2ZY
   D7i/t99l07xBNqP7D2hlsJmX3DHSw+zUV4L04v7AdLQZ2nD7UdIovnuU5
   xwzrnxu06P/bwjq47eI1VE9lw9qZ7lUljfrDovzcIVI7WmQP0XBS3zlAZ
   l2Cx8LptfsVi1q60wOwn08q+tsRLpSjYFYHy22g9yaz5xvhBggJ55P1Io
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358713374"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358713374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074615474"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074615474"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2023 09:53:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6C433248; Tue, 12 Sep 2023 19:53:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [resend, PATCH v1 1/3] resource: Reuse for_each_resource() macro
Date:   Tue, 12 Sep 2023 19:53:10 +0300
Message-Id: <20230912165312.402422-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

