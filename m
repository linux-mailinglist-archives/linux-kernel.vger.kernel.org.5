Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30ED770352
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHDOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjHDOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:39:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AC46B1;
        Fri,  4 Aug 2023 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159955; x=1722695955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkrFpsjN1kkwBUnx7S3/fsHajYxtZIFrVprJT5SR/KE=;
  b=WLS5gvwbycHK2N2dq8jfKBdG6GzBUYrxQRqsvwdSOsaxGVYIUWifCJzr
   SKv6MGPp9DFpyxeI6ZDmeOJJeNe9C18IGCVoUi72563sIZoxzHGCmKzR5
   ZGFT1BZ99bYhrjCEdJwTqkzcZ+oI9rmEqR2BmZ8K4Otwx9VAwJBARhHVe
   Ya8VTRv2JOfTMqXskBEVZqoGJ4+c/qnthf0792rOHuI2OfpU27pxlAeQq
   8pFpPwve/vzoYVijEBjNmgpH1ZsAenkWa7RrNR31q+YKwQfq5P8oViwU+
   wqEYxg89S8+W9AkLeBKwo4xXNHl1HugcoXTHNEnQvJhBrgNIsXxneuxmq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373816828"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373816828"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723678949"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="723678949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 07:39:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E494BF; Fri,  4 Aug 2023 17:39:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 1/4] lib/string_helpers: Add kstrdup_and_replace() helper
Date:   Fri,  4 Aug 2023 17:39:07 +0300
Message-Id: <20230804143910.15504-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
References: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate a NULL-terminated string and replace all occurrences of
the old character with a new one. In other words, provide functionality
of kstrdup() + strreplace().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 789ab30045da..9d1f5bb74dd5 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -109,6 +109,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index d3b1dd718daf..9982344cca34 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -719,6 +719,21 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
 
+/*
+ * Returns duplicate string in which the @old characters are replaced by @new.
+ */
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp)
+{
+	char *dst;
+
+	dst = kstrdup(src, gfp);
+	if (!dst)
+		return NULL;
+
+	return strreplace(dst, old, new);
+}
+EXPORT_SYMBOL_GPL(kstrdup_and_replace);
+
 /**
  * kasprintf_strarray - allocate and fill array of sequential strings
  * @gfp: flags for the slab allocator
-- 
2.40.0.1.gaa8946217a0b

