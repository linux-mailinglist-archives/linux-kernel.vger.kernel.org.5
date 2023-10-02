Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953FB7B5376
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjJBMtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjJBMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:49:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86248B4;
        Mon,  2 Oct 2023 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696250949; x=1727786949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ry1zc4POzBYQAnRgk6toapa9wplSP5XsgZYRUDDv5YI=;
  b=H5Zpd20tMDIGTwYGWtAfiJ/JPCSRdH9W0Peo9uPyhHWKW8KeR3hUtJq1
   l+23LTkz3wZwFatkzx2RyYhJ0r8zHYROwWJSl1A/4Wz6pbq/OUQKWOEp2
   RMDZwar5Yfj1hVG7J2y39l4sMvQO2eBOoWNOk2Sys+H5HA2G6aH5kPhQi
   Va14dInPZ2gB8jTiionf9QQym50Pmzsy82zEFzUIBz5RuH8GEXRuW0G2Z
   qACWOvghlov90krKNqPdLff45qwRLYJS8e6p7+2USCSXlGOz2aVn7zfOx
   uv5X8N9I3pY8CANruuv7pSnC+nbsclV1jchA96ggUTzsOGApRRwvxAVB7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381517982"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381517982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894127812"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894127812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2023 05:47:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D8081593; Mon,  2 Oct 2023 15:49:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/5] params: Use size_add() for kmalloc()
Date:   Mon,  2 Oct 2023 15:48:54 +0300
Message-Id: <20231002124856.2455696-4-andriy.shevchenko@linux.intel.com>
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

Prevent allocations from integer overflow by using size_add().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index f8e3c4139854..c3a029fe183d 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
@@ -48,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
2.40.0.1.gaa8946217a0b

