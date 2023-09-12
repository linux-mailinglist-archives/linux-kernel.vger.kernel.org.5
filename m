Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B390C79D45E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjILPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjILPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053A10DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531234; x=1726067234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IiHm5qqjR8NdKDjufrZuWY5WFVXJIdbQ2oc8nS645Xw=;
  b=DQoFv4sYqfZSTQ1FYxNoV5Qt9QUzcN3zAD9pJz1OkVoyCsJFgqy2c5Tw
   1Org4vprZc0+MoO6+J+jmCm9EXWksb3khuFpjoqWh/OuZ+s/2Kgst97kh
   v8lySsEsw9AqRnlGc1NdmqX3d2DJYXdMA0yIHWsgeh+fuRr/E9oXn0h8I
   3TVtuZyQjHvctOL721+ltbaXNyLUgRNGMaIlH+wn205lyDDWBCZIAYr7J
   Ff5r1c4nGOK4IU/WjcVIo6IMiddn/L7tXpMdOBO0tpB/UzzBbJMR+xxGY
   7VYL/DAQeG4f+hmeZdNY5bx5e9pKNBmwD24k5ZzWC76UZiGJdaqmlddlg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409356431"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409356431"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858836455"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858836455"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 08:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CF9D1A7; Tue, 12 Sep 2023 18:05:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 2/6] params: Introduce the param_unknown_fn type
Date:   Tue, 12 Sep 2023 18:05:47 +0300
Message-Id: <20230912150551.401537-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 962cd41a2cb5..3800d1e2a3ab 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -381,6 +381,8 @@ extern bool parameq(const char *name1, const char *name2);
  */
 extern bool parameqn(const char *name1, const char *name2, size_t n);
 
+typedef int (*parse_unknown_fn)(char *param, char *val, const char *doing, void *arg);
+
 /* Called on module insert or kernel boot */
 extern char *parse_args(const char *name,
 		      char *args,
@@ -388,9 +390,7 @@ extern char *parse_args(const char *name,
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
index 3efe6b98a600..fb594132ffc7 100644
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

