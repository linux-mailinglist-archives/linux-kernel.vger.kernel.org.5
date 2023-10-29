Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3863C7DB15D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJ2Xda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjJ2XdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:33:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6A270D;
        Sun, 29 Oct 2023 15:55:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F9FC433C8;
        Sun, 29 Oct 2023 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620147;
        bh=KyghjT8fjcHLeQ851UGSAKU0YWIhtmCAbJN2wBmIgz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTebr8vJKhgpa5Z174zEAj3+X02BqURKnnmxfC44I8kfp7fruI9OWG+IhDEu0oB5S
         7sAu6lYxsSto/DuvmWRF+inhMV9GE19zWhYQRIwJTnHRMjlttKjDdOQmpqrQPqYB/Y
         IFdvaC5LT+Omf64oGn1t+O39N2iT9uzczTseXi6q2lZuFhP9fFpcQZAhf1sfSM/ZE4
         vEtModWg5Jd89tpBy3LCyID83leTNNW4YUpdBm3tlWdrO57q4wX0CxM24D56TX2Saz
         QrLk/VhZa9IZGpzqgzMyZDO5IWPXkCCnLiMv1IpJgMwUZkBrxeFhqMTAJj/nUwjHKQ
         jJmWf5adsI92A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 30/52] s390/kasan: handle DCSS mapping in memory holes
Date:   Sun, 29 Oct 2023 18:53:17 -0400
Message-ID: <20231029225441.789781-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 327899674eef18f96644be87aa5510b7523fe4f6 ]

When physical memory is defined under z/VM using DEF STOR CONFIG, there
may be memory holes that are not hotpluggable memory. In such cases,
DCSS mapping could be placed in one of these memory holes. Subsequently,
attempting memory access to such DCSS mapping would result in a kasan
failure because there is no shadow memory mapping for it.

To maintain consistency with cases where DCSS mapping is positioned after
the kernel identity mapping, which is then covered by kasan zero shadow
mapping, handle the scenario above by populating zero shadow mapping
for memory holes where DCSS mapping could potentially be placed.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/vmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index c67f59db7a512..f66d642251fe8 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -57,6 +57,7 @@ static void kasan_populate_shadow(void)
 	pmd_t pmd_z = __pmd(__pa(kasan_early_shadow_pte) | _SEGMENT_ENTRY);
 	pud_t pud_z = __pud(__pa(kasan_early_shadow_pmd) | _REGION3_ENTRY);
 	p4d_t p4d_z = __p4d(__pa(kasan_early_shadow_pud) | _REGION2_ENTRY);
+	unsigned long memgap_start = 0;
 	unsigned long untracked_end;
 	unsigned long start, end;
 	int i;
@@ -101,8 +102,12 @@ static void kasan_populate_shadow(void)
 	 * +- shadow end ----+---------+- shadow end ---+
 	 */
 
-	for_each_physmem_usable_range(i, &start, &end)
+	for_each_physmem_usable_range(i, &start, &end) {
 		kasan_populate(start, end, POPULATE_KASAN_MAP_SHADOW);
+		if (memgap_start && physmem_info.info_source == MEM_DETECT_DIAG260)
+			kasan_populate(memgap_start, start, POPULATE_KASAN_ZERO_SHADOW);
+		memgap_start = end;
+	}
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		untracked_end = VMALLOC_START;
 		/* shallowly populate kasan shadow for vmalloc and modules */
-- 
2.42.0

