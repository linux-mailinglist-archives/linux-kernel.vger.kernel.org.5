Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911DD78EB22
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbjHaKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHaKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:53:55 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679ECF4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:53:51 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37VAqug1084419;
        Thu, 31 Aug 2023 18:52:56 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rbyc93TmSz2QxHbp;
        Thu, 31 Aug 2023 18:50:17 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 31 Aug 2023 18:52:55 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Date:   Thu, 31 Aug 2023 18:52:52 +0800
Message-ID: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 37VAqug1084419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There is no explicit gfp flags to let the allocation skip zero
operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. I would like to make
__GFP_SKIP_ZERO be visible even if kasan is not configured.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/gfp_types.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
 mode change 100644 => 100755 include/linux/gfp_types.h

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
old mode 100644
new mode 100755
index d88c46ca82e1..4e9d50bba269
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -46,12 +46,11 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
+#define ___GFP_SKIP_ZERO	0x1000000u
 #ifdef CONFIG_KASAN_HW_TAGS
-#define ___GFP_SKIP_ZERO		0x1000000u
 #define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
 #define ___GFP_SKIP_KASAN_POISON	0x4000000u
 #else
-#define ___GFP_SKIP_ZERO		0
 #define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
-- 
2.25.1

