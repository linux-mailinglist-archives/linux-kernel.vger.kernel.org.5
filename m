Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8817F0A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjKTAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:50:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB643115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700441428; x=1731977428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQSlQVcIwOTVNAsthDE2Qp1AHV7FsCkFHdvb4nHAnAE=;
  b=iC8oF1QUbHg3SgDWw6m90EuHdpxJzbVI0SyE9amxiUBVdUKKrx5SEyl6
   TU7HXgn5PKu6vD+n5lZGUIvJ65XMppDFgmbnm2Mvxjg7I7ZWRrkDztUOr
   a+v9q+ulVPuY/BSw/Qo54ysrohZ3XbXL5UB8tYOl2h1aKa/jv2hvZRRqU
   GEcD9F0sS92rLwjU956l3pzQjeApJ0sgKe8G+JsXE8/vitzfNOdD88Udr
   QAzgVR6mbFcVnNO0PPwsrNCwmWUsJyPRp3Vhb8nPPy1s0YPrJaZkEICrA
   ivLvzLGZAgCny+Svx8x5Vn6Q6ZjuUjsX2FxMBiL+Ni+1ZjR6jegEgz7YJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390390800"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="390390800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 16:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="889770711"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="889770711"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2023 16:50:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4sUY-0005lp-1E;
        Mon, 20 Nov 2023 00:50:22 +0000
Date:   Mon, 20 Nov 2023 08:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 11/24] mm/swap: also handle swapcache lookup in
 swapin_readahead
Message-ID: <202311200813.x056cCRJ-lkp@intel.com>
References: <20231119194740.94101-12-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-12-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.7-rc2 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-fix-a-potential-undefined-behavior-issue/20231120-035926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231119194740.94101-12-ryncsn%40gmail.com
patch subject: [PATCH 11/24] mm/swap: also handle swapcache lookup in swapin_readahead
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231120/202311200813.x056cCRJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200813.x056cCRJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200813.x056cCRJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from mm/filemap.c:62:
>> mm/swap.h:101:52: warning: 'enum swap_cache_result' declared inside parameter list will not be visible outside of this definition or declaration
     101 |                         struct vm_fault *vmf, enum swap_cache_result *result)
         |                                                    ^~~~~~~~~~~~~~~~~
--
   In file included from mm/memory.c:93:
>> mm/swap.h:101:52: warning: 'enum swap_cache_result' declared inside parameter list will not be visible outside of this definition or declaration
     101 |                         struct vm_fault *vmf, enum swap_cache_result *result)
         |                                                    ^~~~~~~~~~~~~~~~~
   mm/memory.c: In function 'do_swap_page':
>> mm/memory.c:3790:32: error: storage size of 'cache_result' isn't known
    3790 |         enum swap_cache_result cache_result;
         |                                ^~~~~~~~~~~~
>> mm/memory.c:3857:37: error: 'SWAP_CACHE_HIT' undeclared (first use in this function); did you mean 'DQST_CACHE_HITS'?
    3857 |                 if (cache_result != SWAP_CACHE_HIT) {
         |                                     ^~~~~~~~~~~~~~
         |                                     DQST_CACHE_HITS
   mm/memory.c:3857:37: note: each undeclared identifier is reported only once for each function it appears in
>> mm/memory.c:3863:37: error: 'SWAP_CACHE_BYPASS' undeclared (first use in this function); did you mean 'SMP_CACHE_BYTES'?
    3863 |                 if (cache_result != SWAP_CACHE_BYPASS)
         |                                     ^~~~~~~~~~~~~~~~~
         |                                     SMP_CACHE_BYTES
>> mm/memory.c:3790:32: warning: unused variable 'cache_result' [-Wunused-variable]
    3790 |         enum swap_cache_result cache_result;
         |                                ^~~~~~~~~~~~


vim +3790 mm/memory.c

  3777	
  3778	/*
  3779	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3780	 * but allow concurrent faults), and pte mapped but not yet locked.
  3781	 * We return with pte unmapped and unlocked.
  3782	 *
  3783	 * We return with the mmap_lock locked or unlocked in the same cases
  3784	 * as does filemap_fault().
  3785	 */
  3786	vm_fault_t do_swap_page(struct vm_fault *vmf)
  3787	{
  3788		struct vm_area_struct *vma = vmf->vma;
  3789		struct folio *swapcache = NULL, *folio = NULL;
> 3790		enum swap_cache_result cache_result;
  3791		struct page *page;
  3792		struct swap_info_struct *si = NULL;
  3793		rmap_t rmap_flags = RMAP_NONE;
  3794		bool exclusive = false;
  3795		swp_entry_t entry;
  3796		pte_t pte;
  3797		vm_fault_t ret = 0;
  3798	
  3799		if (!pte_unmap_same(vmf))
  3800			goto out;
  3801	
  3802		entry = pte_to_swp_entry(vmf->orig_pte);
  3803		if (unlikely(non_swap_entry(entry))) {
  3804			if (is_migration_entry(entry)) {
  3805				migration_entry_wait(vma->vm_mm, vmf->pmd,
  3806						     vmf->address);
  3807			} else if (is_device_exclusive_entry(entry)) {
  3808				vmf->page = pfn_swap_entry_to_page(entry);
  3809				ret = remove_device_exclusive_entry(vmf);
  3810			} else if (is_device_private_entry(entry)) {
  3811				if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
  3812					/*
  3813					 * migrate_to_ram is not yet ready to operate
  3814					 * under VMA lock.
  3815					 */
  3816					vma_end_read(vma);
  3817					ret = VM_FAULT_RETRY;
  3818					goto out;
  3819				}
  3820	
  3821				vmf->page = pfn_swap_entry_to_page(entry);
  3822				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  3823						vmf->address, &vmf->ptl);
  3824				if (unlikely(!vmf->pte ||
  3825					     !pte_same(ptep_get(vmf->pte),
  3826								vmf->orig_pte)))
  3827					goto unlock;
  3828	
  3829				/*
  3830				 * Get a page reference while we know the page can't be
  3831				 * freed.
  3832				 */
  3833				get_page(vmf->page);
  3834				pte_unmap_unlock(vmf->pte, vmf->ptl);
  3835				ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
  3836				put_page(vmf->page);
  3837			} else if (is_hwpoison_entry(entry)) {
  3838				ret = VM_FAULT_HWPOISON;
  3839			} else if (is_pte_marker_entry(entry)) {
  3840				ret = handle_pte_marker(vmf);
  3841			} else {
  3842				print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
  3843				ret = VM_FAULT_SIGBUS;
  3844			}
  3845			goto out;
  3846		}
  3847	
  3848		/* Prevent swapoff from happening to us. */
  3849		si = get_swap_device(entry);
  3850		if (unlikely(!si))
  3851			goto out;
  3852	
  3853		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
  3854					vmf, &cache_result);
  3855		if (page) {
  3856			folio = page_folio(page);
> 3857			if (cache_result != SWAP_CACHE_HIT) {
  3858				/* Had to read the page from swap area: Major fault */
  3859				ret = VM_FAULT_MAJOR;
  3860				count_vm_event(PGMAJFAULT);
  3861				count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
  3862			}
> 3863			if (cache_result != SWAP_CACHE_BYPASS)
  3864				swapcache = folio;
  3865			if (PageHWPoison(page)) {
  3866				/*
  3867				 * hwpoisoned dirty swapcache pages are kept for killing
  3868				 * owner processes (which may be unknown at hwpoison time)
  3869				 */
  3870				ret = VM_FAULT_HWPOISON;
  3871				goto out_release;
  3872			}
  3873		} else {
  3874			/*
  3875			 * Back out if somebody else faulted in this pte
  3876			 * while we released the pte lock.
  3877			 */
  3878			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  3879					vmf->address, &vmf->ptl);
  3880			if (likely(vmf->pte &&
  3881				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  3882				ret = VM_FAULT_OOM;
  3883			goto unlock;
  3884		}
  3885	
  3886		ret |= folio_lock_or_retry(folio, vmf);
  3887		if (ret & VM_FAULT_RETRY)
  3888			goto out_release;
  3889	
  3890		if (swapcache) {
  3891			/*
  3892			 * Make sure folio_free_swap() or swapoff did not release the
  3893			 * swapcache from under us.  The page pin, and pte_same test
  3894			 * below, are not enough to exclude that.  Even if it is still
  3895			 * swapcache, we need to check that the page's swap has not
  3896			 * changed.
  3897			 */
  3898			if (unlikely(!folio_test_swapcache(folio) ||
  3899				     page_swap_entry(page).val != entry.val))
  3900				goto out_page;
  3901	
  3902			/*
  3903			 * KSM sometimes has to copy on read faults, for example, if
  3904			 * page->index of !PageKSM() pages would be nonlinear inside the
  3905			 * anon VMA -- PageKSM() is lost on actual swapout.
  3906			 */
  3907			page = ksm_might_need_to_copy(page, vma, vmf->address);
  3908			if (unlikely(!page)) {
  3909				ret = VM_FAULT_OOM;
  3910				goto out_page;
  3911			} else if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
  3912				ret = VM_FAULT_HWPOISON;
  3913				goto out_page;
  3914			}
  3915			folio = page_folio(page);
  3916	
  3917			/*
  3918			 * If we want to map a page that's in the swapcache writable, we
  3919			 * have to detect via the refcount if we're really the exclusive
  3920			 * owner. Try removing the extra reference from the local LRU
  3921			 * caches if required.
  3922			 */
  3923			if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
  3924			    !folio_test_ksm(folio) && !folio_test_lru(folio))
  3925				lru_add_drain();
  3926		}
  3927	
  3928		folio_throttle_swaprate(folio, GFP_KERNEL);
  3929	
  3930		/*
  3931		 * Back out if somebody else already faulted in this pte.
  3932		 */
  3933		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
  3934				&vmf->ptl);
  3935		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  3936			goto out_nomap;
  3937	
  3938		if (unlikely(!folio_test_uptodate(folio))) {
  3939			ret = VM_FAULT_SIGBUS;
  3940			goto out_nomap;
  3941		}
  3942	
  3943		/*
  3944		 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
  3945		 * must never point at an anonymous page in the swapcache that is
  3946		 * PG_anon_exclusive. Sanity check that this holds and especially, that
  3947		 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
  3948		 * check after taking the PT lock and making sure that nobody
  3949		 * concurrently faulted in this page and set PG_anon_exclusive.
  3950		 */
  3951		BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
  3952		BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
  3953	
  3954		/*
  3955		 * Check under PT lock (to protect against concurrent fork() sharing
  3956		 * the swap entry concurrently) for certainly exclusive pages.
  3957		 */
  3958		if (!folio_test_ksm(folio)) {
  3959			exclusive = pte_swp_exclusive(vmf->orig_pte);
  3960			if (folio != swapcache) {
  3961				/*
  3962				 * We have a fresh page that is not exposed to the
  3963				 * swapcache -> certainly exclusive.
  3964				 */
  3965				exclusive = true;
  3966			} else if (exclusive && folio_test_writeback(folio) &&
  3967				  data_race(si->flags & SWP_STABLE_WRITES)) {
  3968				/*
  3969				 * This is tricky: not all swap backends support
  3970				 * concurrent page modifications while under writeback.
  3971				 *
  3972				 * So if we stumble over such a page in the swapcache
  3973				 * we must not set the page exclusive, otherwise we can
  3974				 * map it writable without further checks and modify it
  3975				 * while still under writeback.
  3976				 *
  3977				 * For these problematic swap backends, simply drop the
  3978				 * exclusive marker: this is perfectly fine as we start
  3979				 * writeback only if we fully unmapped the page and
  3980				 * there are no unexpected references on the page after
  3981				 * unmapping succeeded. After fully unmapped, no
  3982				 * further GUP references (FOLL_GET and FOLL_PIN) can
  3983				 * appear, so dropping the exclusive marker and mapping
  3984				 * it only R/O is fine.
  3985				 */
  3986				exclusive = false;
  3987			}
  3988		}
  3989	
  3990		/*
  3991		 * Some architectures may have to restore extra metadata to the page
  3992		 * when reading from swap. This metadata may be indexed by swap entry
  3993		 * so this must be called before swap_free().
  3994		 */
  3995		arch_swap_restore(entry, folio);
  3996	
  3997		/*
  3998		 * Remove the swap entry and conditionally try to free up the swapcache.
  3999		 * We're already holding a reference on the page but haven't mapped it
  4000		 * yet.
  4001		 */
  4002		swap_free(entry);
  4003		if (should_try_to_free_swap(folio, vma, vmf->flags))
  4004			folio_free_swap(folio);
  4005	
  4006		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
  4007		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
  4008		pte = mk_pte(page, vma->vm_page_prot);
  4009	
  4010		/*
  4011		 * Same logic as in do_wp_page(); however, optimize for pages that are
  4012		 * certainly not shared either because we just allocated them without
  4013		 * exposing them to the swapcache or because the swap entry indicates
  4014		 * exclusivity.
  4015		 */
  4016		if (!folio_test_ksm(folio) &&
  4017		    (exclusive || folio_ref_count(folio) == 1)) {
  4018			if (vmf->flags & FAULT_FLAG_WRITE) {
  4019				pte = maybe_mkwrite(pte_mkdirty(pte), vma);
  4020				vmf->flags &= ~FAULT_FLAG_WRITE;
  4021			}
  4022			rmap_flags |= RMAP_EXCLUSIVE;
  4023		}
  4024		flush_icache_page(vma, page);
  4025		if (pte_swp_soft_dirty(vmf->orig_pte))
  4026			pte = pte_mksoft_dirty(pte);
  4027		if (pte_swp_uffd_wp(vmf->orig_pte))
  4028			pte = pte_mkuffd_wp(pte);
  4029		vmf->orig_pte = pte;
  4030	
  4031		/* ksm created a completely new copy */
  4032		if (unlikely(folio != swapcache && swapcache)) {
  4033			page_add_new_anon_rmap(page, vma, vmf->address);
  4034			folio_add_lru_vma(folio, vma);
  4035		} else {
  4036			page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
  4037		}
  4038	
  4039		VM_BUG_ON(!folio_test_anon(folio) ||
  4040				(pte_write(pte) && !PageAnonExclusive(page)));
  4041		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
  4042		arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
  4043	
  4044		folio_unlock(folio);
  4045		if (folio != swapcache && swapcache) {
  4046			/*
  4047			 * Hold the lock to avoid the swap entry to be reused
  4048			 * until we take the PT lock for the pte_same() check
  4049			 * (to avoid false positives from pte_same). For
  4050			 * further safety release the lock after the swap_free
  4051			 * so that the swap count won't change under a
  4052			 * parallel locked swapcache.
  4053			 */
  4054			folio_unlock(swapcache);
  4055			folio_put(swapcache);
  4056		}
  4057	
  4058		if (vmf->flags & FAULT_FLAG_WRITE) {
  4059			ret |= do_wp_page(vmf);
  4060			if (ret & VM_FAULT_ERROR)
  4061				ret &= VM_FAULT_ERROR;
  4062			goto out;
  4063		}
  4064	
  4065		/* No need to invalidate - it was non-present before */
  4066		update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
  4067	unlock:
  4068		if (vmf->pte)
  4069			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4070	out:
  4071		if (si)
  4072			put_swap_device(si);
  4073		return ret;
  4074	out_nomap:
  4075		if (vmf->pte)
  4076			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4077	out_page:
  4078		folio_unlock(folio);
  4079	out_release:
  4080		folio_put(folio);
  4081		if (folio != swapcache && swapcache) {
  4082			folio_unlock(swapcache);
  4083			folio_put(swapcache);
  4084		}
  4085		if (si)
  4086			put_swap_device(si);
  4087		return ret;
  4088	}
  4089	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
