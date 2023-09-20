Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84B7A8890
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjITPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjITPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:38:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F22CA;
        Wed, 20 Sep 2023 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695224308; x=1726760308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4gyXCBnrlqcGMYoIWPbjV5wf9sCClHXyno5V82uj9AQ=;
  b=d/e41QOeshUtDUTVnIpyPvO3ZvqEWlYy5OQEzLMyJrL6sqp9OVMwpUak
   9Qyw5A7BS6NDMBLwZAeZ88xd7NPdMisi9lT5snseA7+dFxVzFYA4SoePL
   mCFY23JL1BUqYbGF98w6FnNUD8iC6WF57uqifaC04jxtQbmiq5H+dGWJ+
   eb70LNIXSxXBsYsupqi4VmK4f9FECq3JrL9dMJtDFvq3Z60/cHXrMzddd
   krddtktGhADRySmOG3WiFUvqTcC228nD+a0rcId9UZpr1cidk74F9oNDV
   eMqLoHzFDQGKqlub0fIji+BpHQSoWi/rEle0hlWCqnTP29pUwAmD2je4q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370569828"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="370569828"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077485504"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077485504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 08:38:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABFA671B; Wed, 20 Sep 2023 18:38:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
        llvm@lists.linux.dev, alsa-devel@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v1 1/1] device property: Replace custom implementation of COUNT_ARGS()
Date:   Wed, 20 Sep 2023 18:38:19 +0300
Message-Id: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
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

Replace custom and non-portable implementation of COUNT_ARGS().

Fixes: e64b674bc9d7 ("software node: implement reference properties")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 1684fca930f7..55c2692ffa8c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/args.h>
 #include <linux/bits.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
@@ -314,7 +315,7 @@ struct software_node_ref_args {
 #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
 (const struct software_node_ref_args) {				\
 	.node = _ref_,						\
-	.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
+	.nargs = COUNT_ARGS(__VA_ARGS__),			\
 	.args = { __VA_ARGS__ },				\
 }
 
-- 
2.40.0.1.gaa8946217a0b

