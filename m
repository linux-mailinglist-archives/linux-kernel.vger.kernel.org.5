Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C107B7EBDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjKOHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjKOHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:23:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2526D1;
        Tue, 14 Nov 2023 23:23:28 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SVZPz6L0VzWhG1;
        Wed, 15 Nov 2023 15:23:03 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Wed, 15 Nov
 2023 15:23:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 2/2] mm/kmemleak: move set_track_prepare() outside raw_spinlocks
Date:   Wed, 15 Nov 2023 16:21:38 +0800
Message-ID: <20231115082138.2649870-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115082138.2649870-1-liushixin2@huawei.com>
References: <20231115082138.2649870-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_track_prepare() will call __alloc_pages() which attempt to acquire
zone->lock(spinlocks), so move it outside object->lock(raw_spinlocks)
because it's not right to acquire spinlocks while holding raw_spinlocks
in RT mode.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 22bab3738a9e..5501363d6b31 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1152,6 +1152,7 @@ EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 void __ref kmemleak_update_trace(const void *ptr)
 {
 	struct kmemleak_object *object;
+	depot_stack_handle_t trace_handle;
 	unsigned long flags;
 
 	pr_debug("%s(0x%px)\n", __func__, ptr);
@@ -1168,8 +1169,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
+	trace_handle = set_track_prepare();
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->trace_handle = set_track_prepare();
+	object->trace_handle = trace_handle;
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
-- 
2.25.1

