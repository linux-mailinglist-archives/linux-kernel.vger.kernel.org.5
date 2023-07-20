Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3C75AF74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGTNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjGTNPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:15:42 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC710CB;
        Thu, 20 Jul 2023 06:15:39 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4R6Cp31Jwzz9xgYX;
        Thu, 20 Jul 2023 21:14:35 +0800 (CST)
Received: from fedora (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 21:15:26 +0800
Date:   Thu, 20 Jul 2023 21:15:24 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [PATCH] x86/head64: Harmonize the style of array-type parameter for
 fixup_pointer
Message-ID: <ZLkzbA3fErEsFtaF@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of '&' before the array parameter is redundant because '&array'
is equivalent to 'array'. Therefore, there is no need to include '&'
before the array parameter. In fact, using '&' can cause more confusion,
especially for individuals who are not familiar with the address-of
operation for arrays. They might mistakenly believe that one is different
from the other and spend additional time realizing that they are actually
the same.

Harmonizing the style by removing the unnecessary '&' would save time for
those individuals.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 arch/x86/kernel/head64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629b17f7..25a67a13a1fa 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -211,7 +211,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(&early_top_pgt, physaddr);
+	pgd = fixup_pointer(early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
 		*p = (unsigned long)level4_kernel_pgt;
@@ -220,11 +220,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	if (la57) {
-		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
+		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
+	pud = fixup_pointer(level3_kernel_pgt, physaddr);
 	pud[510] += load_delta;
 	pud[511] += load_delta;
 
-- 
2.40.0

