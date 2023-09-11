Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B082579B96A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbjIKWQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbjIKO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:58:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6B1B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694444304; x=1725980304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FT4+8y4yqex+aCmnurGGSCi/Y+7+16wH2XrhNGt8psM=;
  b=WD6OXOA9+t0PtgYQC4fJ1pK4mXD69i0sQRDJnOSsET1LgPMd4TC2qxgv
   /vKDIe2yc4xhujeN9RqR/rAtvJ6J+1CNwWTwGn1mirZ6IQ+vssWyB9HKd
   JgKHnwEwMnBJyCvy8twnJ+DvWbgkmHtglk5hlcegoQLX6ykR424uNbnxl
   Lw36/iOmsWuPm7SZCSLYpq2OE3FrmlJx4BRQu6GnDkBUhO/tz1aisd/W0
   Y1DmVtPwwIjpX9iT0K+XcWxGaMxC4+QqD6ywwYzjVDObwIXOVQa6lAaEY
   kXGterM9qUNFjPvvN3ZxdaeUz/fETIkJKMmnNjFkPP48RoewGopKgz04F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368342060"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368342060"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917047573"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917047573"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:57:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 729B810940E; Mon, 11 Sep 2023 17:57:07 +0300 (+03)
Date:   Mon, 11 Sep 2023 17:57:07 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
References: <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> > early console in extract_kernel
> > input_data: 0x000000807eb433a8
> > input_len: 0x0000000000d26271
> > output: 0x000000807b000000
> > output_len: 0x0000000004800c10
> > kernel_total_size: 0x0000000003e28000
> > needed_size: 0x0000000004a00000
> > trampoline_32bit: 0x000000000009d000
> >
> > Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
> > pages->pgt_buf_offset: 0x0000000000006000
> > pages->pgt_buf_size: 0x0000000000006000
> >
> >
> > Error: kernel_ident_mapping_init() failed
> >
> > It crashes on #PF due to stbl->nr_tables dereference in
> > efi_get_conf_table() called from init_unaccepted_memory().
> >
> > I don't see anything special about stbl location: 0x775d6018.
> >
> > One other bit of information: disabling 5-level paging also helps the
> > issue.
> >
> > I will debug further.

The problem is not limited to unaccepted memory, it also triggers if we
reach efi_get_rsdp_addr() in the same setup.

I think we have several problems here.

- 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
  boot_data and setup_data if we assume that they are in different 1G
  regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
  for PUD, 4 for PMD tables.

  Looks like we never map EFI/ACPI memory explicitly.

  It might work if kernel/cmdline/... are in single 1G and we have
  spare pages to handle page faults.

- No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;

- I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
  And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
  we run out of memory.

I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
case.

I don't know what the right fix here. We can increase the constants to be
enough to cover existing cases, but it is very fragile. I am not sure I
saw all users. Some of them could silently handled with pagefault handler
in some setups. And it is hard to catch new users during code review.

Also I'm not sure why do we need pagefault handler there. Looks like it
just masking problems. I think everything has to be mapped explicitly.

Any comments?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
