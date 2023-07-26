Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAE0763C42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGZQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGZQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1041BDA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD8661B91
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F430C433C8;
        Wed, 26 Jul 2023 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690388385;
        bh=q0XNGgzUjSJEz9MnAbeQ62rwy2DQXpbgmuxGrKUCKJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3n+mrkudX9kGHBZNHm+2fmuD/KmIxToahj+uwjhkD1khveZil+gpp5keMnzShQsI
         50VFInEN8b5uIzJyLWlDQSATYGJ+t/3+2Tgx54clw5NMX/I51gXUslNSk6Hoa6LjrE
         9kLsuxnF1tiGfkVep48AQOmJ5k8aoV53Z3P61s5QSgEo50Ny0oGb9k92DeiHpRhYzp
         iK9ffk0U6vT79ONkBrEF6cktrXNeOTlhkIEkb+QcqAzzr65D/TLwuK1qBhaEEm/iiz
         uk4Xl2OIf85wnJnuFz8gNF7EuZ8LZodVZ0xAjNrnegz36Qam8C5YC4RchvNTa6zpcd
         cGo7blDEiQHZQ==
Date:   Wed, 26 Jul 2023 09:19:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] mm: Batch-zap large anonymous folio PTE mappings
Message-ID: <20230726161942.GA1123863@dev-arch.thelio-3990X>
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-4-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720112955.643283-4-ryan.roberts@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On Thu, Jul 20, 2023 at 12:29:55PM +0100, Ryan Roberts wrote:
> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to the
> deferred split queue in the common case, which reduces split queue lock
> contention.
> 
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meaning
> there is no value to adding it to the split queue.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..189b1cfd823d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1391,6 +1391,94 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>  }
>  
> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
> +				struct page *anchor, unsigned long anchor_vaddr)
> +{
> +	unsigned long offset;
> +	unsigned long vaddr;
> +
> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
> +	vaddr = anchor_vaddr + offset;
> +
> +	if (anchor > page) {
> +		if (vaddr > anchor_vaddr)
> +			return 0;
> +	} else {
> +		if (vaddr < anchor_vaddr)
> +			return ULONG_MAX;
> +	}
> +
> +	return vaddr;
> +}
> +
> +static int folio_nr_pages_cont_mapped(struct folio *folio,
> +				      struct page *page, pte_t *pte,
> +				      unsigned long addr, unsigned long end)
> +{
> +	pte_t ptent;
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +	struct page *folio_end;
> +
> +	if (!folio_test_large(folio))
> +		return 1;
> +
> +	folio_end = &folio->page + folio_nr_pages(folio);
> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	pfn = page_to_pfn(page);
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +
> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
> +			break;
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return i;
> +}
> +
> +static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
> +					    struct vm_area_struct *vma,
> +					    struct folio *folio,
> +					    struct page *page, pte_t *pte,
> +					    unsigned long addr, int nr_pages,
> +					    struct zap_details *details)
> +{
> +	struct mm_struct *mm = tlb->mm;
> +	pte_t ptent;
> +	bool full;
> +	int i;
> +
> +	for (i = 0; i < nr_pages;) {
> +		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> +		full = __tlb_remove_page(tlb, page, 0);
> +
> +		if (unlikely(page_mapcount(page) < 1))
> +			print_bad_pte(vma, addr, ptent, page);
> +
> +		i++;
> +		page++;
> +		pte++;
> +		addr += PAGE_SIZE;
> +
> +		if (unlikely(full))
> +			break;
> +	}
> +
> +	folio_remove_rmap_range(folio, page - i, i, vma);
> +
> +	return i;
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
> @@ -1428,6 +1516,38 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			page = vm_normal_page(vma, addr, ptent);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
> +
> +			/*
> +			 * Batch zap large anonymous folio mappings. This allows
> +			 * batching the rmap removal, which means we avoid
> +			 * spuriously adding a partially unmapped folio to the
> +			 * deferrred split queue in the common case, which
> +			 * reduces split queue lock contention.
> +			 */
> +			if (page && PageAnon(page)) {
> +				struct folio *folio = page_folio(page);
> +				int nr_pages_req, nr_pages;
> +
> +				nr_pages_req = folio_nr_pages_cont_mapped(
> +						folio, page, pte, addr, end);
> +
> +				nr_pages = try_zap_anon_pte_range(tlb, vma,
> +						folio, page, pte, addr,
> +						nr_pages_req, details);
> +
> +				rss[mm_counter(page)] -= nr_pages;
> +				nr_pages--;
> +				pte += nr_pages;
> +				addr += nr_pages << PAGE_SHIFT;
> +
> +				if (unlikely(nr_pages < nr_pages_req)) {
> +					force_flush = 1;
> +					addr += PAGE_SIZE;
> +					break;
> +				}
> +				continue;
> +			}
> +
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> -- 
> 2.25.1
> 

After this change in -next as commit 904d9713b3b0 ("mm: batch-zap large
anonymous folio PTE mappings"), I see the following splats several times
when booting Debian's s390x configuration (which I have mirrored at [1])
in QEMU (bisect log below):

$ qemu-system-s390x \
    -display none \
    -nodefaults \
    -M s390-ccw-virtio \
    -kernel arch/s390/boot/bzImage \
    -initrd rootfs.cpio \
    -m 512m \
    -serial mon:stdio
KASLR disabled: CPU has no PRNG
KASLR disabled: CPU has no PRNG
[    2.502282] Linux version 6.5.0-rc3+ (nathan@dev-arch.thelio-3990X) (s390-linux-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP Wed Jul 26 09:14:20 MST 2023
...
[    3.406011] Freeing initrd memory: 7004K
[    3.492739] BUG: Bad page state in process modprobe  pfn:01b18
[    3.492909] page:00000000233d9f2f refcount:0 mapcount:1 mapping:0000000000000000 index:0xdb pfn:0x1b18
[    3.492998] flags: 0xa0004(uptodate|mappedtodisk|swapbacked|zone=0)
[    3.493195] page_type: 0x0()
[    3.493457] raw: 00000000000a0004 0000000000000100 0000000000000122 0000000000000000
[    3.493492] raw: 00000000000000db 0000000000000000 0000000000000000 0000000000000000
[    3.493525] page dumped because: nonzero mapcount
[    3.493549] Modules linked in:
[    3.493719] CPU: 0 PID: 38 Comm: modprobe Not tainted 6.5.0-rc3+ #1
[    3.493814] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    3.493892] Call Trace:
[    3.494117]  [<0000000000add35a>] dump_stack_lvl+0x62/0x88
[    3.494333]  [<00000000003d565a>] bad_page+0x8a/0x130
[    3.494355]  [<00000000003d6728>] free_unref_page_prepare+0x268/0x3d8
[    3.494375]  [<00000000003d9408>] free_unref_page+0x48/0x140
[    3.494394]  [<00000000003ad99c>] unmap_page_range+0x924/0x1388
[    3.494412]  [<00000000003ae54c>] unmap_vmas+0x14c/0x200
[    3.494429]  [<00000000003be2f2>] exit_mmap+0xba/0x3a0
[    3.494447]  [<0000000000147000>] __mmput+0x50/0x180
[    3.494466]  [<0000000000152a00>] do_exit+0x320/0xb40
[    3.494484]  [<0000000000153450>] do_group_exit+0x40/0xb8
[    3.494502]  [<00000000001534f6>] __s390x_sys_exit_group+0x2e/0x30
[    3.494520]  [<0000000000b05080>] __do_syscall+0x1e8/0x210
[    3.494539]  [<0000000000b15970>] system_call+0x70/0x98
[    3.494663] Disabling lock debugging due to kernel taint
[    3.494809] BUG: Bad page map in process modprobe  pte:01b1831f pmd:1fff9000
[    3.494833] page:00000000233d9f2f refcount:0 mapcount:0 mapping:0000000000000000 index:0xdb pfn:0x1b18
[    3.494852] flags: 0xa0004(uptodate|mappedtodisk|swapbacked|zone=0)
[    3.494866] page_type: 0xffffffff()
[    3.494882] raw: 00000000000a0004 0000000000000100 0000000000000122 0000000000000000
[    3.494898] raw: 00000000000000db 0000000000000000 ffffffff00000000 0000000000000000
[    3.494908] page dumped because: bad pte
[    3.494923] addr:000002aa1d75c000 vm_flags:08100071 anon_vma:000000001fffc340 mapping:000000000286d6b8 index:db
[    3.494983] file:busybox fault:shmem_fault mmap:shmem_mmap read_folio:0x0
[    3.495247] CPU: 0 PID: 38 Comm: modprobe Tainted: G    B              6.5.0-rc3+ #1
[    3.495267] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    3.495277] Call Trace:
[    3.495285]  [<0000000000add35a>] dump_stack_lvl+0x62/0x88
[    3.495307]  [<00000000003ab30e>] print_bad_pte+0x176/0x2c8
[    3.495324]  [<00000000003ae098>] unmap_page_range+0x1020/0x1388
[    3.495341]  [<00000000003ae54c>] unmap_vmas+0x14c/0x200
[    3.495357]  [<00000000003be2f2>] exit_mmap+0xba/0x3a0
[    3.495375]  [<0000000000147000>] __mmput+0x50/0x180
[    3.495394]  [<0000000000152a00>] do_exit+0x320/0xb40
[    3.495411]  [<0000000000153450>] do_group_exit+0x40/0xb8
[    3.495429]  [<00000000001534f6>] __s390x_sys_exit_group+0x2e/0x30
[    3.495447]  [<0000000000b05080>] __do_syscall+0x1e8/0x210
[    3.495465]  [<0000000000b15970>] system_call+0x70/0x98
...

The rootfs is available at [2] if it is relevant. I am happy to provide
any additional information or test patches as necessary.

Cheers,
Nathan

[1]: https://github.com/nathanchance/llvm-kernel-testing/blob/79aa4ab2edc595979366c427cb49f477c7f31c68/configs/debian/s390x.config
[2]: https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/s390-rootfs.cpio.zst

# bad: [0ba5d07205771c50789fd9063950aa75e7f1183f] Add linux-next specific files for 20230726
# good: [18b44bc5a67275641fb26f2c54ba7eef80ac5950] ovl: Always reevaluate the file signature for IMA
git bisect start '0ba5d07205771c50789fd9063950aa75e7f1183f' '18b44bc5a67275641fb26f2c54ba7eef80ac5950'
# bad: [8fe1b33ece8f8fe1377082e839817886cb8c0f81] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 8fe1b33ece8f8fe1377082e839817886cb8c0f81
# bad: [932bd67958459da3dc755b5bea7758e9d951dee5] Merge branch 'ti-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
git bisect bad 932bd67958459da3dc755b5bea7758e9d951dee5
# bad: [a4abec0a3653fb9dfb3ea6cea2ad1d36f507ca97] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
git bisect bad a4abec0a3653fb9dfb3ea6cea2ad1d36f507ca97
# bad: [5a52022bde252d090e051077af297dcfeff9fd0d] powerpc/book3s64/radix: add debug message to give more details of vmemmap allocation
git bisect bad 5a52022bde252d090e051077af297dcfeff9fd0d
# good: [671115657ee2403d18cb849061d7245687d9fdc5] mm/pgtable: notes on pte_offset_map[_lock]()
git bisect good 671115657ee2403d18cb849061d7245687d9fdc5
# good: [26c3a4fe0eb027ff00ad42168c8732db0c0b40d7] arm64/smmu: use TLBI ASID when invalidating entire range
git bisect good 26c3a4fe0eb027ff00ad42168c8732db0c0b40d7
# bad: [8585d0b53780f11cad8dad37997369949e3d5043] mm: memcg: use rstat for non-hierarchical stats
git bisect bad 8585d0b53780f11cad8dad37997369949e3d5043
# bad: [9abfe35eb187c3f79af5bb07c2f9815a480c4965] mm/compaction: correct comment of candidate pfn in fast_isolate_freepages
git bisect bad 9abfe35eb187c3f79af5bb07c2f9815a480c4965
# bad: [208f64c37a4e22b25b8037776c5713545eaf54fa] selftests: line buffer test program's stdout
git bisect bad 208f64c37a4e22b25b8037776c5713545eaf54fa
# good: [08356142587c28b86817646ff318317b5237fdeb] mmu_notifiers: rename invalidate_range notifier
git bisect good 08356142587c28b86817646ff318317b5237fdeb
# good: [652555287069f2c0bbbfaf262eb41638f5c87550] mm: allow deferred splitting of arbitrary large anon folios
git bisect good 652555287069f2c0bbbfaf262eb41638f5c87550
# bad: [904d9713b3b0e64329b2f6d159966b5c737444ff] mm: batch-zap large anonymous folio PTE mappings
git bisect bad 904d9713b3b0e64329b2f6d159966b5c737444ff
# good: [9a7c14665a566fbc1adc2c35982898abc1546525] mm: implement folio_remove_rmap_range()
git bisect good 9a7c14665a566fbc1adc2c35982898abc1546525
# first bad commit: [904d9713b3b0e64329b2f6d159966b5c737444ff] mm: batch-zap large anonymous folio PTE mappings
