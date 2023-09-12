Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0C79D6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjILQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjILQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:53:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972A170B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537635; x=1726073635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IedCP0iUzia28wCwNPou4hz5kxeqqUDBtslkvZspeQ=;
  b=Pl7KRv0k4Wq1yQm8vskoQY6KZ65jkmzUZq5hWX20OsrraXL/Ryu/5LP5
   JqQb2u30dgrqWL1Ee6UTtEDFhUPo3nguAyO4zV/efARUnoyAcNQwoS0JI
   qLrkIXfstU9hXYb/OIWMLI1p46mX2kPzwCHaKwZdNY44czmQ36ggy1FFq
   JTCSV+NefD95UB5hsq2YrHtB1DWRlXaR8286+WiU751mi15+Dym0AnNyt
   6BdQZA/ccbPMjZNi1EjRjw0Sw38pNYzejK9GtdpmTUZHuxhpGfdDDpOvE
   agz+HIQM2HftDlpr3J7F2flYJXImAZaCo+7wYqw3QjrwemxFHHuiS8Wbq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358713366"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358713366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074615472"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074615472"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2023 09:53:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 790211A7; Tue, 12 Sep 2023 19:53:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [resend, PATCH v1 2/3] resource: Unify next_resource() and next_resource_skip_children()
Date:   Tue, 12 Sep 2023 19:53:11 +0300
Message-Id: <20230912165312.402422-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912165312.402422-1-andriy.shevchenko@linux.intel.com>
References: <20230912165312.402422-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the next_resource() is used once and no user for the
next_resource_skip_children() outside of the for_each_resource().

Unify them by adding skip_children parameter to the next_resource().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 86716cd566e9..866ef3663a0b 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -56,26 +56,17 @@ struct resource_constraint {
 
 static DEFINE_RWLOCK(resource_lock);
 
-static struct resource *next_resource(struct resource *p)
+static struct resource *next_resource(struct resource *p, bool skip_children)
 {
-	if (p->child)
+	if (!skip_children && p->child)
 		return p->child;
 	while (!p->sibling && p->parent)
 		p = p->parent;
 	return p->sibling;
 }
 
-static struct resource *next_resource_skip_children(struct resource *p)
-{
-	while (!p->sibling && p->parent)
-		p = p->parent;
-	return p->sibling;
-}
-
 #define for_each_resource(_root, _p, _skip_children) \
-	for ((_p) = (_root)->child; (_p); \
-	     (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
-				       next_resource(_p))
+	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
 
 #ifdef CONFIG_PROC_FS
 
@@ -100,8 +91,10 @@ static void *r_start(struct seq_file *m, loff_t *pos)
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
+
 	(*pos)++;
-	return (void *)next_resource(p);
+
+	return (void *)next_resource(p, false);
 }
 
 static void r_stop(struct seq_file *m, void *v)
-- 
2.40.0.1.gaa8946217a0b

