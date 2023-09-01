Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01D78FE89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbjIANnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349866AbjIANn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F611709
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575791; x=1725111791;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2IedCP0iUzia28wCwNPou4hz5kxeqqUDBtslkvZspeQ=;
  b=lJxWN3yVa32nVL4C6oR1MstdudCoB5FcHM8CPgiKEBh8X6aovYyrrZ+v
   CEXDIQi/7fWYXPk3BtIPxh48GO9AIZ1tpJ1W2KV9Jc6QLG6tvxnmpUEE8
   vonNX8hxj6iFQHa3KtzsIr/JwSDZe8iyAawyJQTwRHquPIY7Lo47HwqOZ
   nKaEPo/o1xIHKRUSzM+oh8g38OrrpjBdRCe7R2tGTFxufqmQpdlDwTauS
   XkUvTBWw8przIU+fdhyTw1mxVOfmViyXD4kSj8TAQo8pEFLZwhwbkbHE7
   sJoseJIA2So0LCbg+/JSMEjXdz9Bsjyl7Y5EvhENWOPuAcG34cM5pOc6w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361247238"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="361247238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805437331"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805437331"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 06:42:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9983571E; Fri,  1 Sep 2023 16:42:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] resource: Unify next_resource() and next_resource_skip_children()
Date:   Fri,  1 Sep 2023 16:42:16 +0300
Message-Id: <20230901134217.1172891-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134217.1172891-1-andriy.shevchenko@linux.intel.com>
References: <20230901134217.1172891-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

