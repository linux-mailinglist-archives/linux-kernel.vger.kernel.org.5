Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEE7EAAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjKNHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjKNHjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:39:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B7C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:39:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b709048f32so4539308b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699947574; x=1700552374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCcSIzFssxGcjzWi0Mw/cCEuglv4pf67mSBE0tXba7c=;
        b=Eq6os962c3WId1edWnOShn+L6f3AtHnRnzazlQuxQILlJ5zGyae4dJyQz2qM9MipvE
         vDQ0UVbiLoWLV1Rtj9Vd53KPTMw3qKKLhD42lhwgtatuBkFatwR0cie0zLbbtOM/Q83C
         8l4fxIcyn2DmqmKsNc9j1atdaAucHFLH/Utn6Xk11UCoWnGJMUahrQLy5rQdM5kdmG1W
         E+AMN6eMYU9oBwT58EKTUfaES+ZWfMW6FZ9p3n6DjvywY8braca2UR8aSfsZ7cPmbgrA
         G0z8UN3lEYmiOJJzOsD2N2BrIQkKdhPRWe1876lnJLY2vEvNvqQuChjbM4OLwpsKyjkz
         ez7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947574; x=1700552374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCcSIzFssxGcjzWi0Mw/cCEuglv4pf67mSBE0tXba7c=;
        b=vqsipV5tutrSBTZaBAUrKgprMIiXCrNKYyGxlVtDfyakTILpY8kHa3jPwrrUn6bHVO
         o2/36GKXCd6ANqCZus+v5lS/UGBmiCIkpPw17f9POtsVyjcfJsMXadY3etlh+ZbMu8TV
         sC5lQKL+AdCnkJps7lCGkrSmz6oipuYOqPoIG0xnOBxUabDofheHtkfdxg51rxv+5oPS
         ZGn8MmZHkwQE3plUllUi0omnZLom9rDkU90N0njdeA+BrLgodwRf8qcCG13ZlBpAKDCh
         VP1HeSw3Vspz7M2XcR52yCHnqXDnRBvtPA1+tCugQhoSLRImRj3oJEpoSEAk9/gWmFPO
         S7Hg==
X-Gm-Message-State: AOJu0Yx+7/i1PPbc8dvJdrvZ2yNp2x6T3Y/uRPuyUZHHPNtakBSY5eBe
        4Ak/WngjH6oOZU+5v4TVPQM=
X-Google-Smtp-Source: AGHT+IEzLsgnrjUQNjOWebFcxsZkM5dnQdsidEvD9dNoO/RT46aLo9CdmvaF3RieZDalYMDOyOLJPg==
X-Received: by 2002:a05:6a21:18b:b0:187:1606:2fc5 with SMTP id le11-20020a056a21018b00b0018716062fc5mr831051pzb.50.1699947573818;
        Mon, 13 Nov 2023 23:39:33 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id e8-20020aa78c48000000b0068be4ce33easm671944pfd.96.2023.11.13.23.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 23:39:33 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     bhe@redhat.com
Cc:     alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, ssengar@linux.microsoft.com,
        tglx@linutronix.de, x86@kernel.org, ytcoode@gmail.com,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] x86/setup: Use a more concise memblock API
Date:   Tue, 14 Nov 2023 15:37:00 +0800
Message-ID: <20231114073700.126543-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ZVLzZlHMXeHIO9eG@MiWiFi-R3L-srv>
References: <ZVLzZlHMXeHIO9eG@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing relocate_initrd()/numa_emulation()/numa_alloc_distance(),
the memblock.current_limit field has already been set to
`max_pfn_mapped << PAGE_SHIFT`, therefore we can replace
memblock_phys_alloc_range() with memblock_phys_alloc(), which has the same
functionality but is more concise.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1 -> v2:

Also replace memblock_phys_alloc_range() in numa_emulation() and
numa_alloc_distance() with memblock_phys_alloc()

 arch/x86/kernel/setup.c      | 3 +--
 arch/x86/mm/numa.c           | 3 +--
 arch/x86/mm/numa_emulation.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ec2c21a1844e..422497c17eec 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -259,8 +259,7 @@ static void __init relocate_initrd(void)
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);

 	/* We need to move the initrd down into directly mapped mem */
-	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
-						      PFN_PHYS(max_pfn_mapped));
+	u64 relocated_ramdisk = memblock_phys_alloc(area_size, PAGE_SIZE);
 	if (!relocated_ramdisk)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
 		      ramdisk_size);
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b29ceb19e46e..29cd8fc8ede1 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -378,8 +378,7 @@ static int __init numa_alloc_distance(void)
 	cnt++;
 	size = cnt * cnt * sizeof(numa_distance[0]);

-	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
-					 PFN_PHYS(max_pfn_mapped));
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	if (!phys) {
 		pr_warn("Warning: can't allocate distance table!\n");
 		/* don't retry until explicitly reset */
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 9a9305367fdd..8acb8d0f7d0f 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -447,8 +447,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	if (numa_dist_cnt) {
 		u64 phys;

-		phys = memblock_phys_alloc_range(phys_size, PAGE_SIZE, 0,
-						 PFN_PHYS(max_pfn_mapped));
+		phys = memblock_phys_alloc(phys_size, PAGE_SIZE);
 		if (!phys) {
 			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
 			goto no_emu;
--
2.42.1
