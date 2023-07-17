Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078C755F54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGQJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGQJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:33:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081210E5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689586432; x=1721122432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s6ZoXKzWeESKEZrwLJVnimopWYHbgY2dHEYUngYjQ1o=;
  b=ObVqPVNSNcuyM6qfN2gg1C6ccgc6XF0TguL8UhexP6j6wDLVPiIRADCp
   /U+llFYrsot4SiIv0DXpdmJg0GfbuY560TkM3ERz3bwEkRtjSg3UKjAR4
   rHDmH4vbT8rDkvDzznuAjM9SgqIs+R93oUHUYrqJMakMC4Fdtt36+vxy4
   t1kOM+4l5ll1NI9wMGGnpWPVthAmAdETVLta8uJDOazPhC+0+DM9IA/L7
   p3IG4vWFqwdwUo8xsFz6plpAJQK4bfya4FRHJdN/ftCQy1swaj+iGTZMG
   cVqyTA6w2xJrINmRG9F+RR9MmWtLiteSp14GNlCZI9SRBw0t/1XBfsEZv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="364762671"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364762671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="847218975"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847218975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2023 02:33:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0232256; Mon, 17 Jul 2023 12:33:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Date:   Mon, 17 Jul 2023 12:33:32 +0300
Message-Id: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Privided seq_show_option_n() macro breaks build with -Werror
and W=1, e.g.:

In function ‘strncpy’,
    inlined from ‘ocfs2_show_options’ at fs/ocfs2/super.c:1520:3:
include/linux/fortify-string.h:68:33: error: ‘__builtin_strncpy’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
   68 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
include/linux/fortify-string.h:151:16: note: in expansion of macro ‘__underlying_strncpy’
  151 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

While -Werror wasn't enabled by default at the time of the original code
landed into mainline, strscpy() was already there and preferred over strncpy().
Due to above mentioned issues, use the latter in seq_show_option_n().

Fixes: a068acf2ee77 ("fs: create and use seq_show_option for escaping")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/seq_file.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index bd023dd38ae6..e87d635ca24f 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -260,8 +260,7 @@ static inline void seq_show_option(struct seq_file *m, const char *name,
  */
 #define seq_show_option_n(m, name, value, length) {	\
 	char val_buf[length + 1];			\
-	strncpy(val_buf, value, length);		\
-	val_buf[length] = '\0';				\
+	strscpy(val_buf, value, sizeof(val_buf));	\
 	seq_show_option(m, name, val_buf);		\
 }
 
-- 
2.40.0.1.gaa8946217a0b

