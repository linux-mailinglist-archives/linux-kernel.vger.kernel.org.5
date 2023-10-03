Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31A7B69AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJCNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756693;
        Tue,  3 Oct 2023 06:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696338109; x=1727874109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5BuiHCbUGxDTXwBye3t5k+Ijkv31TrOL/+KCudCyRS8=;
  b=FqUn7KpepFTyNqXzdElUcBDwZoLpH+mPPbz7O2O2c3Xs3AbrOtJXpUha
   7cj9RRxKoC4PDlBHccCS+IQtA6bsHc8+L2HeW7F1fAyyFrXEHuOdv4Ygr
   PqnEOLDHiPP8a5BzZb3YLXQU1Jne5bYd6sij91YS9L2+0ebVJxiTqueR1
   HQlg0VpR+keKEP+0WGETeWTqv205JNCaWMMg+2frIT+GopxjySzCFT8YC
   FOAMe62ZFIvA5ok97jLK27zWufP2akDY3/52trYKcIibhIm4bsJ7lDDo7
   13yhlRzVgEGiHwEtqCm/hTNBXP4B19WR2KB4d3uVLCC+C81RhjaQbG27S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381745967"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381745967"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786085405"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786085405"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 06:01:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9AEE118A0; Tue,  3 Oct 2023 16:01:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to string.h
Date:   Tue,  3 Oct 2023 16:01:42 +0300
Message-Id: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lib/cmdline.c is basically a set of some small string parsers
which are wide used in the kernel. Their prototypes belong to the
string.h rather then kernel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 6 ------
 include/linux/string.h | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c07f9c779d45..3e6c5ac08f8b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -195,12 +195,6 @@ static inline void might_fault(void) { }
 
 void do_exit(long error_code) __noreturn;
 
-extern int get_option(char **str, int *pint);
-extern char *get_options(const char *str, int nints, int *ints);
-extern unsigned long long memparse(const char *ptr, char **retptr);
-extern bool parse_option_str(const char *str, const char *option);
-extern char *next_arg(char *args, char **param, char **val);
-
 extern int core_kernel_text(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
diff --git a/include/linux/string.h b/include/linux/string.h
index 3c920b6d609b..0995f2a737ef 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -181,9 +181,17 @@ extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
+/* lib/argv_split.c */
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
+/* lib/cmdline.c */
+extern int get_option(char **str, int *pint);
+extern char *get_options(const char *str, int nints, int *ints);
+extern unsigned long long memparse(const char *ptr, char **retptr);
+extern bool parse_option_str(const char *str, const char *option);
+extern char *next_arg(char *args, char **param, char **val);
+
 extern bool sysfs_streq(const char *s1, const char *s2);
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
-- 
2.40.0.1.gaa8946217a0b

