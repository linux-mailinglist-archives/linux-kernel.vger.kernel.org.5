Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77979D6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjILQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbjILQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:53:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C8110
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537634; x=1726073634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0YrXbSatEME/b+INV4Zdy0fZgic8gHBbo7ZznXvK54=;
  b=ZnG4B+IQTArSZ/YQa73f1YNDL0bpR3KWz7LbhczJsMAszKDIvq8ScWdL
   Z3w46zgmEGyJewcrcDcucANjBuFeM45lnBrtV5iTSrlrsNIfMoq5kAQn7
   vJryhC5ze1Y6EMlbVwtrFyS6jgLnjhtjbSvHQUvuoYKU2UOe/lOF5/82J
   9AEvq/b62cKwEqAoKEFtgxqr6lPOn8fosnNj8/Wv4H5bE/bwyc48sj6MS
   ZVJwkbOcrm59KKMpvl6ag7lKy+Ov0NjTcM52Fcm4NuuOsZC4apcAEmsbr
   MajL+WuxAw5D3EDgWnFiKYKb1lNRKJnw2hdUReDt9jbhDcVTMePV6Tgun
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358713371"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358713371"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074615473"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074615473"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2023 09:53:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82BEF3C6; Tue, 12 Sep 2023 19:53:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [resend, PATCH v1 3/3] resource: Constify resource crosscheck APIs
Date:   Tue, 12 Sep 2023 19:53:12 +0300
Message-Id: <20230912165312.402422-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912165312.402422-1-andriy.shevchenko@linux.intel.com>
References: <20230912165312.402422-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

