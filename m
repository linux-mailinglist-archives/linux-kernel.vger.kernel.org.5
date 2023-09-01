Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E578FE7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjIANnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIANnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5A1712
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575758; x=1725111758;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=d0YrXbSatEME/b+INV4Zdy0fZgic8gHBbo7ZznXvK54=;
  b=gy5QWmO67drrT87RitXpiPgcJca4q12A57q8hPDgjHSsB9OahHf6ZZLL
   Df2ya13FTS+AeU4aoE4MgzPdx+cu7rHBqb1cWnlajrxoTBCsJr9PgkYfm
   x/z7C7hFQWCn8joe/ei5EFuX3stgblzx1Zaf7nlm7mo5Sm9k4rQ0PryRw
   cunyDisV5wvWYaySTApimB24/MnkF+rHUokjo0tjw0Ri7arNVI/CbLHmN
   nr4D0a/TDG3K9H8P9Y5lWMNWCkURZy4nrXW1NNcVFrMAZmIUwrBFCKmXq
   w+uw85ImkuXowJEVEq2Zlt2ri3IxTKEdt5cPvdfo04tNXWWZwtqtY81m7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361247237"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="361247237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805437332"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805437332"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 06:42:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A72F678D; Fri,  1 Sep 2023 16:42:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] resource: Constify resource crosscheck APIs
Date:   Fri,  1 Sep 2023 16:42:17 +0300
Message-Id: <20230901134217.1172891-3-andriy.shevchenko@linux.intel.com>
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

Constify APIs: _contains(), _overlaps(), _intersection(), _union().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 25d768d48970..14f5cfabbbc8 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -229,7 +229,7 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 	return res->flags & IORESOURCE_EXT_TYPE_BITS;
 }
 /* True iff r1 completely contains r2 */
-static inline bool resource_contains(struct resource *r1, struct resource *r2)
+static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
 {
 	if (resource_type(r1) != resource_type(r2))
 		return false;
@@ -239,13 +239,13 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 }
 
 /* True if any part of r1 overlaps r2 */
-static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
+static inline bool resource_overlaps(const struct resource *r1, const struct resource *r2)
 {
        return r1->start <= r2->end && r1->end >= r2->start;
 }
 
-static inline bool
-resource_intersection(struct resource *r1, struct resource *r2, struct resource *r)
+static inline bool resource_intersection(const struct resource *r1, const struct resource *r2,
+					 struct resource *r)
 {
 	if (!resource_overlaps(r1, r2))
 		return false;
@@ -254,8 +254,8 @@ resource_intersection(struct resource *r1, struct resource *r2, struct resource
 	return true;
 }
 
-static inline bool
-resource_union(struct resource *r1, struct resource *r2, struct resource *r)
+static inline bool resource_union(const struct resource *r1, const struct resource *r2,
+				  struct resource *r)
 {
 	if (!resource_overlaps(r1, r2))
 		return false;
-- 
2.40.0.1.gaa8946217a0b

