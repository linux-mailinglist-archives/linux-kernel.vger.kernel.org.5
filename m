Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701775EF17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjGXJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGXJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:27:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC02F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:27:07 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8ZXk4fCKzrRv0;
        Mon, 24 Jul 2023 17:26:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:27:05 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <ryan.roberts@arm.com>, <joey.gouly@arm.com>,
        <anshuman.khandual@arm.com>, <ardb@kernel.org>,
        <mark.rutland@arm.com>
CC:     <chris.zjh@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] arm64: fix build warning for ARM64_MEMSTART_SHIFT
Date:   Mon, 24 Jul 2023 17:27:51 +0000
Message-ID: <20230724172751.3048501-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
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

The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS == 3
and CONFIG_VA_BITS == 39. For this scenario, the macro ARM64_MEMSTART_SHIFT
would be defined to different value of PUD_SHIFT/CONT_PMD_SHIFT/CONT_PMD_SHIFT
according to different config, any of them would be undefined as long as
the value is equal to PGDIR_SHIFT, so add judgement before reference and
set the default value.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
v2:
	Add define judgement of PUD_SHIFT/CONT_PMD_SHIFT/CONT_PMD_SHIFT before
	use them, instead of define PUD_SHIFT only.
---
---
 arch/arm64/include/asm/kernel-pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 577773870b66..51bdce66885d 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -125,12 +125,14 @@
  * (64k granule), or a multiple that can be mapped using contiguous bits
  * in the page tables: 32 * PMD_SIZE (16k granule)
  */
-#if defined(CONFIG_ARM64_4K_PAGES)
+#if defined(CONFIG_ARM64_4K_PAGES) && defined(PUD_SHIFT)
 #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
-#elif defined(CONFIG_ARM64_16K_PAGES)
+#elif defined(CONFIG_ARM64_16K_PAGES) && defined(CONT_PMD_SHIFT)
 #define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
-#else
+#elif defined(CONFIG_ARM64_64K_PAGES) && defined(PMD_SHIFT)
 #define ARM64_MEMSTART_SHIFT		PMD_SHIFT
+#else
+#define ARM64_MEMSTART_SHIFT		PGDIR_SHIFT
 #endif
 
 /*
-- 
2.34.1

