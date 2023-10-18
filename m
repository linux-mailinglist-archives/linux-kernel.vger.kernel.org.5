Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A77CD717
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122819D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697619289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pp5sXxU1MFlNUtAtVI0C/KnM/d5Lryu4hPhDsWo2s0M=;
        b=QPZfSwgy9Zr7hkRfuNV8k1U9p/7JPf8bpSW3BNXYz7aSkLH0hM+x5k4sIWqKr08VTrahPT
        iLP9674R8d/9hrH/oPIMxvzTGc0PadZbKfTdnVhJ3J+5Wun+zK2vQcD9ohCxRpp4pmnvNW
        +e+ngP8JE/IswVoZghNd7P8ykjl04Ec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-qrWKnXEXPOmIyykWECAa-Q-1; Wed, 18 Oct 2023 04:54:38 -0400
X-MC-Unique: qrWKnXEXPOmIyykWECAa-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6CA3826D3D;
        Wed, 18 Oct 2023 08:54:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 073D7909;
        Wed, 18 Oct 2023 08:54:36 +0000 (UTC)
Date:   Wed, 18 Oct 2023 16:54:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/23 at 05:26pm, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
> commit: 4c91c07c93bbbdd7f2d9de2beb7ee5c2a48ad8e7 mm: vmalloc: convert vread() to vread_iter()
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
> 
> smatch warnings:
> mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)

I see the code deficit, while the reproduce link seems to be unavilable.
Could you double check the link and provide a good one so that I can
verify the code fix?

Thanks
Baoquan

> 
> vim +/vm +3689 mm/vmalloc.c
> 
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3619  long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3620  {
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3621  	struct vmap_area *va;
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3622  	struct vm_struct *vm;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3623  	char *vaddr;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3624  	size_t n, size, flags, remains;
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3625  
> 4aff1dc4fb3a5a Andrey Konovalov        2022-03-24  3626  	addr = kasan_reset_tag(addr);
> 4aff1dc4fb3a5a Andrey Konovalov        2022-03-24  3627  
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3628  	/* Don't allow overflow */
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3629  	if ((unsigned long) addr + count < count)
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3630  		count = -(unsigned long) addr;
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3631  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3632  	remains = count;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3633  
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3634  	spin_lock(&vmap_area_lock);
> f181234a5a21fd Chen Wandun             2021-09-02  3635  	va = find_vmap_area_exceed_addr((unsigned long)addr);
> f608788cd2d6ca Serapheim Dimitropoulos 2021-04-29  3636  	if (!va)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3637  		goto finished_zero;
> f181234a5a21fd Chen Wandun             2021-09-02  3638  
> f181234a5a21fd Chen Wandun             2021-09-02  3639  	/* no intersects with alive vmap_area */
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3640  	if ((unsigned long)addr + remains <= va->va_start)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3641  		goto finished_zero;
> f181234a5a21fd Chen Wandun             2021-09-02  3642  
> f608788cd2d6ca Serapheim Dimitropoulos 2021-04-29  3643  	list_for_each_entry_from(va, &vmap_area_list, list) {
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3644  		size_t copied;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3645  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3646  		if (remains == 0)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3647  			goto finished;
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3648  
> 06c8994626d1b7 Baoquan He              2023-02-06  3649  		vm = va->vm;
> 06c8994626d1b7 Baoquan He              2023-02-06  3650  		flags = va->flags & VMAP_FLAGS_MASK;
> 06c8994626d1b7 Baoquan He              2023-02-06  3651  		/*
> 06c8994626d1b7 Baoquan He              2023-02-06  3652  		 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
> 06c8994626d1b7 Baoquan He              2023-02-06  3653  		 * be set together with VMAP_RAM.
> 06c8994626d1b7 Baoquan He              2023-02-06  3654  		 */
> 06c8994626d1b7 Baoquan He              2023-02-06  3655  		WARN_ON(flags == VMAP_BLOCK);
> 06c8994626d1b7 Baoquan He              2023-02-06  3656  
> 06c8994626d1b7 Baoquan He              2023-02-06  3657  		if (!vm && !flags)
> 
> NULL check
> 
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3658  			continue;
> e81ce85f960c2e Joonsoo Kim             2013-04-29  3659  
> 30a7a9b17c4b03 Baoquan He              2023-02-06  3660  		if (vm && (vm->flags & VM_UNINITIALIZED))
> 30a7a9b17c4b03 Baoquan He              2023-02-06  3661  			continue;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3662  
> 30a7a9b17c4b03 Baoquan He              2023-02-06  3663  		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
> 30a7a9b17c4b03 Baoquan He              2023-02-06  3664  		smp_rmb();
> 30a7a9b17c4b03 Baoquan He              2023-02-06  3665  
> 06c8994626d1b7 Baoquan He              2023-02-06  3666  		vaddr = (char *) va->va_start;
> 06c8994626d1b7 Baoquan He              2023-02-06 @3667  		size = vm ? get_vm_area_size(vm) : va_size(va);
> 06c8994626d1b7 Baoquan He              2023-02-06  3668  
> 06c8994626d1b7 Baoquan He              2023-02-06  3669  		if (addr >= vaddr + size)
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3670  			continue;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3671  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3672  		if (addr < vaddr) {
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3673  			size_t to_zero = min_t(size_t, vaddr - addr, remains);
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3674  			size_t zeroed = zero_iter(iter, to_zero);
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3675  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3676  			addr += zeroed;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3677  			remains -= zeroed;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3678  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3679  			if (remains == 0 || zeroed != to_zero)
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3680  				goto finished;
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3681  		}
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3682  
> 06c8994626d1b7 Baoquan He              2023-02-06  3683  		n = vaddr + size - addr;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3684  		if (n > remains)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3685  			n = remains;
> 06c8994626d1b7 Baoquan He              2023-02-06  3686  
> 06c8994626d1b7 Baoquan He              2023-02-06  3687  		if (flags & VMAP_RAM)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3688  			copied = vmap_ram_vread_iter(iter, addr, n, flags);
> 06c8994626d1b7 Baoquan He              2023-02-06 @3689  		else if (!(vm->flags & VM_IOREMAP))
>                                                                                    ^^^^^^^^^
> Unchecked dereference
> 
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3690  			copied = aligned_vread_iter(iter, addr, n);
> d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3691  		else /* IOREMAP area is treated as memory hole */
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3692  			copied = zero_iter(iter, n);
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3693  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3694  		addr += copied;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3695  		remains -= copied;
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3696  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3697  		if (copied != n)
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3698  			goto finished;
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3699  	}
> d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3700  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3701  finished_zero:
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3702  	spin_unlock(&vmap_area_lock);
> d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3703  	/* zero-fill memory holes */
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3704  	return count - remains + zero_iter(iter, remains);
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3705  finished:
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3706  	/* Nothing remains, or We couldn't copy/zero everything. */
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3707  	spin_unlock(&vmap_area_lock);
> d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3708  
> 4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3709  	return count - remains;
> ^1da177e4c3f41 Linus Torvalds          2005-04-16  3710  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

