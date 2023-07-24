Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BADB75E9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGXCa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGXCaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:30:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF313BF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:30:12 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8PGv5HsHzVjXK;
        Mon, 24 Jul 2023 10:28:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:30:10 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <joey.gouly@arm.com>,
        <anshuman.khandual@arm.com>, <mark.rutland@arm.com>,
        <ardb@kernel.org>
CC:     <chris.zjh@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] arm64: fix -Wundef warning for PUD_SHIFT
Date:   Mon, 24 Jul 2023 10:30:55 +0000
Message-ID: <20230724103055.2379274-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, the following warning occurs.

arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
  129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
      |                                         ^~~~~~~~~
arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
  142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
      |     ^~~~~~~~~~~~~~~~~~~~

The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS ==
3, and at this time PUD_SHIFT is equal to PGDIR_SHIFT, so define it.

Fixes: 06e9bf2fd9b3 ("arm64: choose memstart_addr based on minimum sparsemem section alignment")
Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
v2:
	Define PUD_SHIFT before use it instead of judgement
---
---
 arch/arm64/include/asm/kernel-pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 577773870b66..996a144e2929 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -59,6 +59,10 @@
 #define EARLY_KASLR	(0)
 #endif
 
+#ifndef PUD_SHIFT
+#define PUD_SHIFT PGDIR_SHIFT
+#endif
+
 #define SPAN_NR_ENTRIES(vstart, vend, shift) \
 	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
 
-- 
2.34.1

