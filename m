Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27167DDDCB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjKAIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjKAIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:39:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C81109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:39:25 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SL0j14TFkzrTJX;
        Wed,  1 Nov 2023 16:36:21 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 1 Nov 2023 16:39:23 +0800
From:   WoZ1zh1 <wozizhi@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH -next,V2] cachefiles: support to disable assert macro
Date:   Thu, 2 Nov 2023 00:34:31 +0800
Message-ID: <20231101163431.2108688-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/cachefiles/internal.h, ASSERT macro is enabled by default and can
not be disabled, then assert failure will crash the kernel as the BUG()
is included in the ASSERT macro. Therefore, add CACHEFILES_ASSERT to
control it.

Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
---
 fs/cachefiles/Kconfig    | 11 +++++++++++
 fs/cachefiles/internal.h |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 8df715640a48..83d8ec3ba2d8 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -38,3 +38,14 @@ config CACHEFILES_ONDEMAND
 	  and is delegated to userspace.
 
 	  If unsure, say N.
+
+config CACHEFILES_ASSERT
+	bool "CACHEFILES asserts"
+	default n
+	depends on CACHEFILES
+	help
+	  Support the ASSERT mode for failure behavior.
+	  Say N here to disable the ASSERT by default.
+	  Say Y to add assertion checks in some places. But the assertion
+	  failure will result in fatal errors that BUG() the kernel.
+
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..263b1f13e943 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -425,7 +425,7 @@ do {							\
 #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
 #endif
 
-#if 1 /* defined(__KDEBUGALL) */
+#ifdef CONFIG_CACHEFILES_ASSERT
 
 #define ASSERT(X)							\
 do {									\
-- 
2.39.2

