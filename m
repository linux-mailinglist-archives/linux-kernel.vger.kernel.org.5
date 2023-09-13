Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F079E40F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbjIMJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:46:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD10198C;
        Wed, 13 Sep 2023 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694598364; x=1726134364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3buEeqBxdUMtlGYl0/iS7ECl7NUmPipZ2waf6U7e+oE=;
  b=ZMqOhcNP2VnuwFA7KYFA3goLKRdU2CKRJPD0lcUPfztkHRvk8TLicXG6
   NxRcY3nQOQifpmZXBNIHzwH61ktIkSYgYk0aF7ExGlfTxakH00NC1SuYw
   GOk0xZWg3tIe5YyPvYsqKop//1deoFDRggFBUCN4mYf4mWkArTXgMWdAt
   B54yfegAjyEjpf7Atja+r8wIRiooo49kgpMlagT6IXHaXcbKyrx94daqF
   BjO/JKW+NI/ygvZ1VUIiIoWFccfF96YdTTelj6TajSXylJvcwJFdYayZM
   UQ8MgqH/jraGOwbBeY+8ojHg02mwgc5aKHPxta8LSJWeDl5CHX7NtY2Qm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377524885"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377524885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074890994"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="1074890994"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2023 02:46:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38FCD8C9; Wed, 13 Sep 2023 12:46:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] lib/string_helpers: Don't copy a tail in kstrdup_and_replace() if 'new' is \0
Date:   Wed, 13 Sep 2023 12:45:57 +0300
Message-Id: <20230913094557.451463-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kstrdup_and_replace() takes two characters, old and new, to replace
former with latter after the copying of the original string. But in case
when new is a NUL, there is no point to copy the rest of the string,
the contract with the callers is that that the function returns a
NUL-terminated string and not a buffer of the size filled with a given
data. With this we can optimize the memory consumption by copying only
meaningful part of the original string and drop the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

The first user of this is pending:
https://lore.kernel.org/platform-driver-x86/20230913092701.440959-1-andriy.shevchenko@linux.intel.com/

 lib/string_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7713f73e66b0..e385bf3cc2de 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -723,11 +723,17 @@ EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
 
 /*
  * Returns duplicate string in which the @old characters are replaced by @new.
+ *
+ * If @new is NUL, copy the string up to the first occurrence of @old, which
+ * will be replaced by a NUL.
  */
 char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp)
 {
 	char *dst;
 
+	if (new == '\0')
+		return kmemdup_nul(src, strchrnul(src, old) - src, gfp);
+
 	dst = kstrdup(src, gfp);
 	if (!dst)
 		return NULL;
-- 
2.40.0.1.gaa8946217a0b

