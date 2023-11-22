Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55047F4F71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbjKVSYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjKVSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15081E7;
        Wed, 22 Nov 2023 10:24:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a62d4788so11286e87.0;
        Wed, 22 Nov 2023 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677469; x=1701282269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyLQCKiJ2VFITvxQw03Yt4z2bmF2c1oQIabjn568Vj0=;
        b=VFJLe2aYfzRUmE2Yo3oC4pDVpfPTXgIY8DuwVkLTT/CtMJfKIw+cmvcXxGG2O5V0Im
         Y3TuxTL0Tem7EnkyAb+JLaV9+agNGcdYNeZmwI60gSCGfnUXDJm1w48bl97TCH3fUvdx
         n9OCX5wnDavCVb6+SuhuH1QrgCnwFncGP/lQrYSKO8CQbE/2vOpip4bFDOXLTglF5BoZ
         gXuBaSaoRhRBswzfLZtmUS85zcik0KhxjY2RKuUDVQuK9/4yBryf+wRs7CxPD+F6+qBK
         9kfrSortyBs3GVPEvEiyI3+MxJDp0tktiqa9SDSFkRz1DYdfj1sGNd8uWzryT1CS1JNi
         pSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677469; x=1701282269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyLQCKiJ2VFITvxQw03Yt4z2bmF2c1oQIabjn568Vj0=;
        b=GlDt2opA6LK5qPZkeYKD7mptHuucHFq53fmePeyyjEguoOUzn+zt610h/F3jBip5S6
         OegCjjbNlONPJSdbsWPgiPt8PUOjKBJp4re1CeHMtC4ponyuPZcb0L3C4a/ZveRAQkgF
         t6DcNpVecAG8JUAhrNbNoMDeOrc7n5gGO2UECROB9qCSbXTvrkWin8sUHIlTKggZj8C0
         BSt2fnQZ8eHw/8esJIHMMJdW2XiuyvMrNXBftdnoWSPf/uPs4F2BnJ9mXJhNSL9pkXI/
         Jmsb4l47ZFj+CYS/kTXmEIJC3w3CdX7GTAm+MquPVwQ67rSWqZCYZjQUN/4yPH6EU0us
         FGrg==
X-Gm-Message-State: AOJu0YwCvy9jmZ97leRqDq+bS9Yx4uyCtYkXhJFuCCON8/FsLPmvyeNS
        2LRsdbPppG/l6oDJ2V9i/zQ=
X-Google-Smtp-Source: AGHT+IHtCn8A+p6OVWkqu13c1CgByHGQ/x6y5cHnYmQZd4VzgkmBIX01gu2cG3MkZsPP1Mx6p/2Fdg==
X-Received: by 2002:a05:6512:15a3:b0:508:26b2:7803 with SMTP id bp35-20020a05651215a300b0050826b27803mr3009239lfb.69.1700677469095;
        Wed, 22 Nov 2023 10:24:29 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b0050aa9df16fbsm1363250lfd.179.2023.11.22.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:28 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 3/7] mips: Fix max_mapnr being uninitialized on early stages
Date:   Wed, 22 Nov 2023 21:24:01 +0300
Message-ID: <20231122182419.30633-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_mapnr variable is utilized in the pfn_valid() method in order to
determine the upper PFN space boundary. Having it uninitialized
effectively makes any PFN passed to that method invalid. That in its turn
causes the kernel mm-subsystem occasion malfunctions even after the
max_mapnr variable is actually properly updated. For instance,
pfn_valid() is called in the init_unavailable_range() method in the
framework of the calls-chain on MIPS:
setup_arch()
+-> paging_init()
    +-> free_area_init()
        +-> memmap_init()
            +-> memmap_init_zone_range()
                +-> init_unavailable_range()

Since pfn_valid() always returns "false" value before max_mapnr is
initialized in the mem_init() method, any flatmem page-holes will be left
in the poisoned/uninitialized state including the IO-memory pages. Thus
any further attempts to map/remap the IO-memory by using MMU may fail.
In particular it happened in my case on attempt to map the SRAM region.
The kernel bootup procedure just crashed on the unhandled unaligned access
bug raised in the __update_cache() method:

> Unhandled kernel unaligned access[#1]:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00307-g0dff108838c9-dirty #2056
> ...
> Call Trace:
> [<8011ef9c>] __update_cache+0x88/0x1bc
> [<80385944>] ioremap_page_range+0x110/0x2a4
> [<80126948>] ioremap_prot+0x17c/0x1f4
> [<80711b80>] __devm_ioremap+0x8c/0x120
> [<80711e0c>] __devm_ioremap_resource+0xf4/0x218
> [<808bf244>] sram_probe+0x4f4/0x930
> [<80889d20>] platform_probe+0x68/0xec
> ...

Let's fix the problem by initializing the max_mapnr variable as soon as
the required data is available. In particular it can be done right in the
paging_init() method before free_area_init() is called since all the PFN
zone boundaries have already been calculated by that time.

Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note I don't really know since what point that problem actually exists.
Based on the commits log it might had been persistent even before the
boot_mem_map allocator was dropped. On the other hand I hadn't seen it
actually come out before moving my working tree from kernel 6.5-rc4 to
6.7-rc1. So after updating the kernel I got the unhandled unaligned access
BUG() due to the access to compound head pointer the __update_cache()
method (see the commit log). After enabling the DEBUG_VM config I managed
to find out that the IO-memory pages were just left uninitialized and
poisoned:

> page:81367080 is uninitialized and poisoned (pfn 8192)
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> Kernel bug detected[#1]:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00298-g88721b1a9ad5-dirty
> $ 0   : 00000000 812d0000 00000034 dced7cdf
> $ 4   : dced7cdf 00594000 10000000 ffff00fe
> $ 8   : 8196bfe0 00000000 00000001 818458c0
> $12   : 00000000 00000000 00000000 00000216
> $16   : 00002800 81227b80 00000000 00000000
> $20   : 00000000 00000000 00000000 00000000
> $24   : 0000022b 818458c0
> $28   : 81968000 8196be68 00000000 803a0920
> Hi    : 00000000
> Lo    : 00000000
> epc   : 8039d2a4 BUG+0x0/0x4
> ra    : 803a0920 post_alloc_hook+0x0/0x128
> Status: 10000003 KERNEL EXL IE
> Cause : 00800424 (ExcCode 09)
> PrId  : 0001a830 (MIPS P5600)
> Modules linked in:
> Process swapper/0 (pid: 1, threadinfo=81968000, task=819a0000, tls=00000000)
> Stack : 00000000 8101ccb0 00000000 8196bd00 00000000 80359768 818a8300 00000001
>         81139088 8114438c 8042e4f8 81297a2c 81297a2c 81255e90 819a1b50 dced7cdf
>         81297a2c 81297a2c 00000000 81227b80 00000000 81241168 811394b0 00000000
>         81140000 80e2cee0 00000000 00000000 00000000 00000000 00000000 819b0000
>         81140000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>         ...
> Call Trace:
> [<8039d2a4>] BUG+0x0/0x4
> [<803a0920>] post_alloc_hook+0x0/0x128
>
> Code: 01001025  03e00008  24020001 <000c000d> 2403003c  27bdffd0  afb2001c  3c12812f  8e4269e4

Which in its turn made me digging deeper into the way the MMIO-space pages
are initialized. That's how I got into the pfn_valid() and
init_unavailable_range() working improperly on my setup.

Anyway none of the problems above I spotted on kernel 6.5-rc4. So what
actually triggered having them finally popped up isn't that easy to be
foundn seeing the involved code hasn't changed much.
---
 arch/mips/mm/init.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5dcb525a8995..6e368a4658b5 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -422,7 +422,12 @@ void __init paging_init(void)
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
+
+	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+#else
+	max_mapnr = max_low_pfn;
 #endif
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -458,13 +463,6 @@ void __init mem_init(void)
 	 */
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
-#ifdef CONFIG_HIGHMEM
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
-#else
-	max_mapnr = max_low_pfn;
-#endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 	maar_init();
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
-- 
2.42.1

