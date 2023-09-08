Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA4798BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245533AbjIHSBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbjIHSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF726BB;
        Fri,  8 Sep 2023 11:00:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F5EC433CB;
        Fri,  8 Sep 2023 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196034;
        bh=w6qHlNyMN4kEXbZIw0AZpfeiBoj3N8yPUsiJu+tEJe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7/Br+mI7rt8Uf8q27pxvoDZ4Gl1uSM1jTRWR/4u2RRI49bL2aNZJZ6/7XQxC3cwF
         VAdskm46/fmrbqDKjIWcTFT9YuvsYxC2vk9A/q5VuNURiUN1nPa3m/c+bL1N4/ItEC
         xN2dXiY5CX1CBvEI+Ec1zdVyBXhVXn4YMB+3V/wO10j7RgpmCcpQ8VPrP5Lau5iYUg
         CvR05tbAbCCXe9Fct1KF+zYQ91TR0P58TUPVeOAIfyQNjjlxvxQugTftuRr9x/UmVp
         aNrk6bHbf6kqB8Ea0D4LU6vzNgBN61tcyWS8q/NP2qvJDnHaRBy1Dn6AnSn3oI0ivo
         bctNaqJI1Ljzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 09/16] s390/boot: cleanup number of page table levels setup
Date:   Fri,  8 Sep 2023 13:59:46 -0400
Message-Id: <20230908175953.3457942-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908175953.3457942-1-sashal@kernel.org>
References: <20230908175953.3457942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 8ddccc8a7d06f7ea4d8579970c95609d1b1de77b ]

The separate vmalloc area size check against _REGION2_SIZE
is needed in case user provided insanely large value using
vmalloc= kernel command line parameter. That could lead to
overflow and selecting 3 page table levels instead of 4.

Use size_add() for the overflow check and get rid of the
extra vmalloc area check.

With the current values of CONFIG_MAX_PHYSMEM_BITS and
PAGES_PER_SECTION the sum of maximal possible size of
identity mapping and vmemmap area (derived from these
macros) plus modules area size MODULES_LEN can not
overflow. Thus, that sum is used as first addend while
vmalloc area size is second addend for size_add().

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/startup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 64bd7ac3e35d1..f8d0550e5d2af 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -176,6 +176,7 @@ static unsigned long setup_kernel_memory_layout(void)
 	unsigned long asce_limit;
 	unsigned long rte_size;
 	unsigned long pages;
+	unsigned long vsize;
 	unsigned long vmax;
 
 	pages = ident_map_size / PAGE_SIZE;
@@ -183,11 +184,9 @@ static unsigned long setup_kernel_memory_layout(void)
 	vmemmap_size = SECTION_ALIGN_UP(pages) * sizeof(struct page);
 
 	/* choose kernel address space layout: 4 or 3 levels. */
-	vmemmap_start = round_up(ident_map_size, _REGION3_SIZE);
-	if (IS_ENABLED(CONFIG_KASAN) ||
-	    vmalloc_size > _REGION2_SIZE ||
-	    vmemmap_start + vmemmap_size + vmalloc_size + MODULES_LEN >
-		    _REGION2_SIZE) {
+	vsize = round_up(ident_map_size, _REGION3_SIZE) + vmemmap_size + MODULES_LEN;
+	vsize = size_add(vsize, vmalloc_size);
+	if (IS_ENABLED(CONFIG_KASAN) || (vsize > _REGION2_SIZE)) {
 		asce_limit = _REGION1_SIZE;
 		rte_size = _REGION2_SIZE;
 	} else {
-- 
2.40.1

