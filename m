Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FCA7B5375
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjJBMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjJBMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:49:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F03BD;
        Mon,  2 Oct 2023 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696250950; x=1727786950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfHAEitE/kOTudrhcZUhf3FG7lcoNA4VM+Ov2c+VfUc=;
  b=T4WsMvFKSTdb2mfnr4r9TjAVDzwx1vnFtSzIOiydMQBv4aO5mS/KYPSl
   GmVd4sZwGrehmv2nFOyhB1AZ7+L8Krdm8X3OT0KagtKNBrwg78OWY47hF
   QlWOyJmRJ+NXeCYEo1siI2aczIuZe0O+cmQDi5IjB/VtnSkzqI2ZQVUZ2
   rMcY0OCrvq8c0zwmQGtyeyqo/rrmo7NokHBzof4oBk/JjasxU009iixMu
   0dTr6yHBV/9HcSouO9IBFbenY1K40+D90eURgT6ZORFTSPWm0wnbWPFHl
   YiJhPVXfWtnLVwc3Coi6miw0H7cIn7TpmQNUEEwnqA2+2GYNHhjPh0wXc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381517972"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381517972"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894127809"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894127809"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2023 05:47:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF8F365; Mon,  2 Oct 2023 15:49:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/5] params: Introduce the param_unknown_fn type
Date:   Mon,  2 Oct 2023 15:48:52 +0300
Message-Id: <20231002124856.2455696-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
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

Introduce a new type for the callback to parse an unknown argument.
This unifies function prototypes which takes that as a parameter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/moduleparam.h | 6 +++---
 kernel/params.c             | 8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 4fa9726bc328..bfb85fd13e1f 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -385,6 +385,8 @@ extern bool parameq(const char *name1, const char *name2);
  */
 extern bool parameqn(const char *name1, const char *name2, size_t n);
 
+typedef int (*parse_unknown_fn)(char *param, char *val, const char *doing, void *arg);
+
 /* Called on module insert or kernel boot */
 extern char *parse_args(const char *name,
 		      char *args,
@@ -392,9 +394,7 @@ extern char *parse_args(const char *name,
 		      unsigned num,
 		      s16 level_min,
 		      s16 level_max,
-		      void *arg,
-		      int (*unknown)(char *param, char *val,
-				     const char *doing, void *arg));
+		      void *arg, parse_unknown_fn unknown);
 
 /* Called by module remove. */
 #ifdef CONFIG_SYSFS
diff --git a/kernel/params.c b/kernel/params.c
index 2d4a0564697e..626fa8265932 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -120,9 +120,7 @@ static int parse_one(char *param,
 		     unsigned num_params,
 		     s16 min_level,
 		     s16 max_level,
-		     void *arg,
-		     int (*handle_unknown)(char *param, char *val,
-				     const char *doing, void *arg))
+		     void *arg, parse_unknown_fn handle_unknown)
 {
 	unsigned int i;
 	int err;
@@ -165,9 +163,7 @@ char *parse_args(const char *doing,
 		 unsigned num,
 		 s16 min_level,
 		 s16 max_level,
-		 void *arg,
-		 int (*unknown)(char *param, char *val,
-				const char *doing, void *arg))
+		 void *arg, parse_unknown_fn unknown)
 {
 	char *param, *val, *err = NULL;
 
-- 
2.40.0.1.gaa8946217a0b

