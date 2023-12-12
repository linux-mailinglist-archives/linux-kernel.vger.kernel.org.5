Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F253180E80F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbjLLJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjLLJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:46:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2AD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702374394; x=1733910394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jQ1g0JWTs+h+uCJaGecUkR5E/TcmaxUbWdQhueCisdo=;
  b=Wwe4ffY5zASFMaoW7tjmDjnJWPoOx3lBoe3qccgPxhBb1VJ/5YXsVDtA
   1UBYqbv+S5ILIJOZqgbluC0xOUzhnwH4/C/c6zprxzNIbkpQK2GVGTjpV
   QSoaYkcgihp9fFMmmr6B0m/p84DG4AzraGPh78RUOIj2QXqOrMDefv48e
   1psXXM0VuHf6jXndE1klKz8JdFxOLb4fbX7RLO0UgnzUVM6w12uiWAv8C
   t1oYDsP4IoexYngDO7vwWrLw/ZLg/tZsElkqeNuaTZar860EAzSUmRDz/
   XIRzy4Zbr1Aq3UP7uiJCsabbVIwHu3lrqk5+drcrUDJszE3raO5aH1xOA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374286558"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="374286558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="749653695"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="749653695"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 01:46:29 -0800
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Stultz <jstultz@google.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Halaney <ahalaney@redhat.com>, Lobakin@vger.kernel.org,
        Aleksander <aleksander.lobakin@intel.com>, Gan@vger.kernel.org,
        Yi Fang <yi.fang.gan@intel.com>, linux-kernel@vger.kernel.org
Cc:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Lai@vger.kernel.org, Peter Jun Ann <peter.jun.ann.lai@intel.com>
Subject: [PATCH net-next 1/1] driver.h: add helper macro for module_exit() boilerplate
Date:   Tue, 12 Dec 2023 17:43:52 +0800
Message-Id: <20231212094352.2263283-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the modules need a module_init() but don't need to do
anything special in module_exit() might need to have an empty
module_exit(). This patch add a new macro module_exit_stub() to
replace the empty module_exit(). The macro is useful to remove
the module_exit() boilerplate.

Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 include/linux/device/driver.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..18e75c7b5c2f 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -288,4 +288,18 @@ static int __init __driver##_init(void) \
 } \
 device_initcall(__driver##_init);
 
+/**
+ * module_exit_stub() - Helper macro for drivers that have init but don't
+ * do anything in exit. This eliminates some boilerplate.
+ * Each module may only use this macro one, and calling it replaces
+ * module_exit().
+ *
+ * @__driver: driver name
+ */
+#define module_exit_stub(__driver) \
+static void __exit __driver##_exit(void) \
+{ \
+} \
+module_exit(__driver##_exit)
+
 #endif	/* _DEVICE_DRIVER_H_ */
-- 
2.34.1

