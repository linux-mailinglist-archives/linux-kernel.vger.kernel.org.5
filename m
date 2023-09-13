Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8879EAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjIMOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbjIMOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:25:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFAB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694615099; x=1726151099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XKOsmvZaoSUNMXOhheZXkeEtZd0F/hnfQCZH/hf2+EQ=;
  b=ZVy0keU/LpWSInV6ELDhSTBbXyAYXqMXZWIGaAAPk4zHQ+3/dfoFihwc
   q/XtQt4D4rExzKt1/BxiEPRtdIdW7RTqhX/0H9K/7UfyQdZiRGAPYErx0
   n5iPvhEzbbgkqbBZoQCJ1epx7Gb7eWuASduh1zagVOCKnYUgABGpP+uhZ
   YZy78LBNAMXfsXP0s5vZaMnYy5ra1HpiuX1ReoeBFubNwc+YxBNYyoLGo
   IX3CrvVAOtuz+Gmjx5mk1nty6zviwfIkgW8iEQP/9N19PO6ycEKnLR330
   qHQRX0Ydxi64n8TuaQrZOpnelf/1EGzEdtiSMvdFEgrFVSKm79VKUbrzm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442705093"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="442705093"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 07:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747322619"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747322619"
Received: from mdhaisne-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.45.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 07:24:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D49C310940B; Wed, 13 Sep 2023 17:24:10 +0300 (+03)
Date:   Wed, 13 Sep 2023 17:24:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
        x86@kernel.org
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230913142410.dfqsg3l5v44mr5j3@box>
References: <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:57:07PM +0300, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> > > early console in extract_kernel
> > > input_data: 0x000000807eb433a8
> > > input_len: 0x0000000000d26271
> > > output: 0x000000807b000000
> > > output_len: 0x0000000004800c10
> > > kernel_total_size: 0x0000000003e28000
> > > needed_size: 0x0000000004a00000
> > > trampoline_32bit: 0x000000000009d000
> > >
> > > Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
> > > pages->pgt_buf_offset: 0x0000000000006000
> > > pages->pgt_buf_size: 0x0000000000006000
> > >
> > >
> > > Error: kernel_ident_mapping_init() failed
> > >
> > > It crashes on #PF due to stbl->nr_tables dereference in
> > > efi_get_conf_table() called from init_unaccepted_memory().
> > >
> > > I don't see anything special about stbl location: 0x775d6018.
> > >
> > > One other bit of information: disabling 5-level paging also helps the
> > > issue.
> > >
> > > I will debug further.
> 
> The problem is not limited to unaccepted memory, it also triggers if we
> reach efi_get_rsdp_addr() in the same setup.
> 
> I think we have several problems here.
> 
> - 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
>   boot_data and setup_data if we assume that they are in different 1G
>   regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
>   for PUD, 4 for PMD tables.
> 
>   Looks like we never map EFI/ACPI memory explicitly.
> 
>   It might work if kernel/cmdline/... are in single 1G and we have
>   spare pages to handle page faults.
> 
> - No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;
> 
> - I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
>   And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
>   we run out of memory.
> 
> I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
> case.
> 
> I don't know what the right fix here. We can increase the constants to be
> enough to cover existing cases, but it is very fragile. I am not sure I
> saw all users. Some of them could silently handled with pagefault handler
> in some setups. And it is hard to catch new users during code review.
> 
> Also I'm not sure why do we need pagefault handler there. Looks like it
> just masking problems. I think everything has to be mapped explicitly.
> 
> Any comments?

I struggle to come up with anything better than increasing the constant to
a value that "ought to be enough for anybody" ©, let's say 128K.

And we can eliminate logic on no-KASLR vs. KASLR vs. KASLR+VERBOSE_BOOTUP.

Objections?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
