Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5EB7F167C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjKTO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjKTO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:56:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10FA191
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:55:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332cb136335so417345f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700492143; x=1701096943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGFXkVothP8GzTo2jzsCD/SdXLlf2F5wZiQpSoYT7RM=;
        b=ohK1BrCADl5VA5SbpWdhMtthYwdrT3Q8zuf+q8iP2yQFpbbbPTkJ8yHI4dO8YvtLBE
         AY69hX3NrLsYiM9wspwi0TU36lhen0FJwI9iGKMjpt3Yf/mNg9jIrgQDX4xtymowmkqj
         L3WqW2s8e/VDs8vQf3rGrjJLEO1HqjxwPtRuQ0m3lYEneoUDHIn0W4l7ylTWmlQaiD4L
         gke8b1SdahVapkBpGP+o/+C8TUeDbvDQ3pp4oid2Qt4oDKWFC4VXtved7LcF8+epePeg
         0tDikFdjAbjhvu8vcTgydsN0t1PoOJdcMKJgADUAuqIDSwf02rO7Bl3rFqtTOl2yOynw
         95+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700492143; x=1701096943;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGFXkVothP8GzTo2jzsCD/SdXLlf2F5wZiQpSoYT7RM=;
        b=wNan7VI39xnk/L6BP7t7C2LH/a/io9FtFpfE6Y/93E0x4sBm7R2WsF0bHXC+wEeBIV
         AUef5Z0rWX6z96l47aQhz3gnrZYuasDXHZYTIDqwlgwxEvcKli48PVQg5t8jAUSeYMUp
         cnguh1jHtMsGgA7/RHqvBS2vkrekQzdXwTrm8s89hkXBKtpQ/m0KXRG586hbuhQzDKXm
         51lFajIeKZ5SqNS4uae4QCnPu0n9iFVEsBP8qFpQ+Ns6DY0QAQpB9IrPiAAjaOIn7pnm
         e2HSMZEdtTIsWlRAkp0TqeLnIYk++uPYb/31e4duRBgx7DKzPY9oYjLXc++cZrItG67D
         /g3g==
X-Gm-Message-State: AOJu0Yy0Rx/ETVRiNUUl0LDo3ij+S+/01fIgYPpXaeRxrJLj8tFPYzpr
        Qbje/DEkFpCSkXeLY1WRSwgQ8w==
X-Google-Smtp-Source: AGHT+IFdemXx/VBd55p8WW6PTbADwdmABtmyFhPv5LoMpcPkl7d+s0athPBnib8Bo4DNxgkN7RrcTQ==
X-Received: by 2002:a05:6000:1845:b0:32f:9ad3:860f with SMTP id c5-20020a056000184500b0032f9ad3860fmr5696667wri.52.1700492143135;
        Mon, 20 Nov 2023 06:55:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c15-20020adfe70f000000b0032da8fb0d05sm11408245wrm.110.2023.11.20.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:55:42 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 20 Nov 2023 09:55:40 -0500
To:     oe-kbuild@lists.linux.dev, Kairui Song <ryncsn@gmail.com>,
        linux-mm@kvack.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand
 alone helper
Message-ID: <918235dd-44d0-470e-aad2-5001ac947cb8@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-4-ryncsn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-fix-a-potential-undefined-behavior-issue/20231120-035926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231119194740.94101-4-ryncsn%40gmail.com
patch subject: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand alone helper
config: um-randconfig-r081-20231120 (https://download.01.org/0day-ci/archive/20231120/202311201135.iG2KLShW-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311201135.iG2KLShW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311201135.iG2KLShW-lkp@intel.com/

smatch warnings:
mm/swap_state.c:881 swapin_no_readahead() warn: use 'gfp_mask' here instead of GFP_KERNEL?

vim +/gfp_mask +881 mm/swap_state.c

19f582d2684e47 Kairui Song 2023-11-20  856  /**
19f582d2684e47 Kairui Song 2023-11-20  857   * swapin_no_readahead - swap in pages skipping swap cache and readahead
19f582d2684e47 Kairui Song 2023-11-20  858   * @entry: swap entry of this memory
19f582d2684e47 Kairui Song 2023-11-20  859   * @gfp_mask: memory allocation flags
19f582d2684e47 Kairui Song 2023-11-20  860   * @vmf: fault information
19f582d2684e47 Kairui Song 2023-11-20  861   *
19f582d2684e47 Kairui Song 2023-11-20  862   * Returns the struct page for entry and addr after the swap entry is read
19f582d2684e47 Kairui Song 2023-11-20  863   * in.
19f582d2684e47 Kairui Song 2023-11-20  864   */
19f582d2684e47 Kairui Song 2023-11-20  865  struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
19f582d2684e47 Kairui Song 2023-11-20  866  				 struct vm_fault *vmf)
19f582d2684e47 Kairui Song 2023-11-20  867  {
19f582d2684e47 Kairui Song 2023-11-20  868  	struct vm_area_struct *vma = vmf->vma;
19f582d2684e47 Kairui Song 2023-11-20  869  	struct page *page = NULL;
19f582d2684e47 Kairui Song 2023-11-20  870  	struct folio *folio;
19f582d2684e47 Kairui Song 2023-11-20  871  	void *shadow = NULL;
19f582d2684e47 Kairui Song 2023-11-20  872  
19f582d2684e47 Kairui Song 2023-11-20  873  	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
19f582d2684e47 Kairui Song 2023-11-20  874  				vma, vmf->address, false);
19f582d2684e47 Kairui Song 2023-11-20  875  	if (folio) {
19f582d2684e47 Kairui Song 2023-11-20  876  		__folio_set_locked(folio);
19f582d2684e47 Kairui Song 2023-11-20  877  		__folio_set_swapbacked(folio);
19f582d2684e47 Kairui Song 2023-11-20  878  
19f582d2684e47 Kairui Song 2023-11-20  879  		if (mem_cgroup_swapin_charge_folio(folio,
19f582d2684e47 Kairui Song 2023-11-20  880  					vma->vm_mm, GFP_KERNEL,

s/GFP_KERNEL/gfp_mask/?

19f582d2684e47 Kairui Song 2023-11-20 @881  					entry)) {
19f582d2684e47 Kairui Song 2023-11-20  882  			folio_unlock(folio);
19f582d2684e47 Kairui Song 2023-11-20  883  			folio_put(folio);
19f582d2684e47 Kairui Song 2023-11-20  884  			return NULL;
19f582d2684e47 Kairui Song 2023-11-20  885  		}
19f582d2684e47 Kairui Song 2023-11-20  886  		mem_cgroup_swapin_uncharge_swap(entry);
19f582d2684e47 Kairui Song 2023-11-20  887  
19f582d2684e47 Kairui Song 2023-11-20  888  		shadow = get_shadow_from_swap_cache(entry);
19f582d2684e47 Kairui Song 2023-11-20  889  		if (shadow)
19f582d2684e47 Kairui Song 2023-11-20  890  			workingset_refault(folio, shadow);
19f582d2684e47 Kairui Song 2023-11-20  891  
19f582d2684e47 Kairui Song 2023-11-20  892  		folio_add_lru(folio);
19f582d2684e47 Kairui Song 2023-11-20  893  
19f582d2684e47 Kairui Song 2023-11-20  894  		/* To provide entry to swap_readpage() */
19f582d2684e47 Kairui Song 2023-11-20  895  		folio->swap = entry;
19f582d2684e47 Kairui Song 2023-11-20  896  		page = &folio->page;
19f582d2684e47 Kairui Song 2023-11-20  897  		swap_readpage(page, true, NULL);
19f582d2684e47 Kairui Song 2023-11-20  898  		folio->private = NULL;
19f582d2684e47 Kairui Song 2023-11-20  899  	}
19f582d2684e47 Kairui Song 2023-11-20  900  
19f582d2684e47 Kairui Song 2023-11-20  901  	return page;
19f582d2684e47 Kairui Song 2023-11-20  902  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

