Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3272D79D45F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjILPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjILPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC4A10DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531234; x=1726067234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3PADM1uFv8tnSLMvvhvYaZtPehE/6YKdLW1n09TF9U=;
  b=Vv4fQh649KrhtEOhWDDiluxQ0RQ9PNd5alaPppENkXKbD5RwjbUW6LX5
   tId8+i2o4KaYVtfD3oYpWalvJzIUiTzlU5iX18fOeCj39c2RtXxyii1yc
   TB+idrCJ5iDf24Tp1ha7Gjchx+xzVP+r1q7i7TMIYPJNuF7MwlQIXnjov
   BwrTXE4IS37O4sia6xq7tVL9Mkm4KW445hem7DAQxwNTxXLJ/G9TacbHQ
   u4BzCK7JpVhxDFANvni7wK4ekhO6v7KNqWVF094Z4cMjTuum3/xpvKQ+f
   c7atHFUsAcgvONPiaRu4XkfKqv4DVZa++F7SEYXMdDd4rrDUF7p9gr989
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409356435"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409356435"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858836453"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858836453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 08:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 787C8BC0; Tue, 12 Sep 2023 18:05:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 3/6] params: Do not go over the limit when getting the string length
Date:   Tue, 12 Sep 2023 18:05:48 +0300
Message-Id: <20230912150551.401537-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use strnlen() even on early stages and it prevents from
going over the string boundaries in case it's already too long.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index fb594132ffc7..930a5dc2f004 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -259,7 +259,10 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-	if (strlen(val) > 1024) {
+	size_t len, maxlen = 1024;
+
+	len = strnlen(val, maxlen + 1);
+	if (len == maxlen + 1) {
 		pr_err("%s: string parameter too long\n", kp->name);
 		return -ENOSPC;
 	}
@@ -269,7 +272,7 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 	/* This is a hack.  We can't kmalloc in early boot, and we
 	 * don't need to; this mangled commandline is preserved. */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(strlen(val)+1);
+		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
 			return -ENOMEM;
 		strcpy(*(char **)kp->arg, val);
@@ -507,7 +510,7 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
 
-	if (strlen(val)+1 > kps->maxlen) {
+	if (strnlen(val, kps->maxlen) == kps->maxlen) {
 		pr_err("%s: string doesn't fit in %u chars.\n",
 		       kp->name, kps->maxlen-1);
 		return -ENOSPC;
-- 
2.40.0.1.gaa8946217a0b

