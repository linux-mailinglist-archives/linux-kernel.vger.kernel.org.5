Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD97520A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjGML72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjGML7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:59:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E74270F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:59:21 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1tRj1Kt0zrRlT;
        Thu, 13 Jul 2023 19:58:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 19:59:17 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] arm64: vdso: Clear common make C=2 warnings
Date:   Thu, 13 Jul 2023 19:58:31 +0800
Message-ID: <20230713115831.777-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make C=2 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- xxx.o

When I use the command above to do a 'make C=2' check on any object file,
the following warnings are always output:

  CHECK   arch/arm64/kernel/vdso/vgettimeofday.c
arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning:
 symbol '__kernel_clock_gettime' was not declared. Should it be static?
arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning:
 symbol '__kernel_gettimeofday' was not declared. Should it be static?
arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning:
 symbol '__kernel_clock_getres' was not declared. Should it be static?

Therefore, the declaration of the three functions is added to eliminate
these common warnings to provide a clean output.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/vdso/vgettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
index 4236cf34d7d9c34..9941c5b04f15878 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -6,6 +6,10 @@
  *
  */
 
+int __kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+int __kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+int __kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res);
+
 int __kernel_clock_gettime(clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-- 
2.25.1

