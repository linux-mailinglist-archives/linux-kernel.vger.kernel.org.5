Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD397D4D06
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjJXJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJXJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:55:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A0C1;
        Tue, 24 Oct 2023 02:55:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13200C433C7;
        Tue, 24 Oct 2023 09:55:20 +0000 (UTC)
Date:   Tue, 24 Oct 2023 10:55:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: linux-next: build warning after merge of the arm64 tree
Message-ID: <ZTeUhsf1xWmkJcRh@arm.com>
References: <20231024172409.7b519868@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024172409.7b519868@canb.auug.org.au>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Ard

On Tue, Oct 24, 2023 at 05:24:09PM +1100, Stephen Rothwell wrote:
> After merging the arm64 tree, today's linux-next build (arm64 defconfig)
> produced this warning:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: __pi_$x+0x38 (section: .text) -> __pi_map_range (section: .init.text)
> 
> I don't know what caused this.

For some reason, building linux-next doesn't inline all the functions in
the map_range.c file and we end up with some of them in different
sections. I didn't get this when building the arm64 for-next/core
separately.

My fix (I'll push it to the arm64 branch):

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index be7caf07bfa7..e07f3ece5430 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -20,17 +20,17 @@ extern const u8 __eh_frame_start[], __eh_frame_end[];

 extern void idmap_cpu_replace_ttbr1(void *pgdir);

-static void map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
-			void *start, void *end, pgprot_t prot,
-			bool may_use_cont, int root_level)
+static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
+			       void *start, void *end, pgprot_t prot,
+			       bool may_use_cont, int root_level)
 {
 	map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
 		  ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
 		  prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);
 }

-static void unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
-			  void *end, int root_level)
+static void __init unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
+				 void *end, int root_level)
 {
 	map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
 		    false, root_level);
@@ -205,7 +205,7 @@ static void __init remap_idmap_for_lpa2(void)
 	memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
 }

-static void map_fdt(u64 fdt)
+static void __init map_fdt(u64 fdt)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
 	u64 efdt = fdt + MAX_FDT_SIZE;

-- 
Catalin
