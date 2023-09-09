Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F17997AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbjIILcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjIILcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:32:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD4E46
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694259135; x=1725795135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nUYLq5T9/GHcLWl6uTwmBe2oMwAzdBhwkG/9NeVxpJk=;
  b=kJTZcKmdzDqiq+VnZZBvN+zKu51AH0HJFPtV9qf7XMie9hgc/eKdjyAf
   If3KJeEjNrVzn4QqcRazj6z03t0Ul8XvEeyPADSTO6foftFWbql55Gn7n
   b6qotkPIBT8ACQdPkNA88c5IUkxXAqdSPcDW06gwMa4oCrtBYRZ5wrb9g
   wqmj6AuO+Jp0fPFckrpYKfyfWNKLJbc9Txc8JRZvDFgbMd2SaYQQyXKAP
   H2va3Ihwur1m7TVWM30ayk7MjQe3DYy4uWCiMUTgiint434knMRzjdP3F
   0rJRa6V7AClCs/w1Z/PBBYkUB1hmV79lUEuAFnZ2bsIb7WgicNw+7kpI4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376722593"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="376722593"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745879626"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="745879626"
Received: from rdota-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.166])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:32:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A293C104CCE; Sat,  9 Sep 2023 14:32:09 +0300 (+03)
Date:   Sat, 9 Sep 2023 14:32:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230909113209.actnan6hczrclz2d@box.shutemov.name>
References: <20230829114816.GA508985@ziqianlu-dell>
 <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:17:53PM +0200, Ard Biesheuvel wrote:
> On Fri, Sep 8, 2023 at 5:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 08, 2023 at 03:32:33PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Sep 08, 2023 at 02:02:30PM +0800, Aaron Lu wrote:
> > > > On Thu, Sep 07, 2023 at 04:14:09PM +0300, Kirill A. Shutemov wrote:
> > > > > On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > > > > > > Could you show dmesg of the first kernel before kexec?
> > > > > >
> > > > > > Attached.
> > > > > >
> > > > > > BTW, kexec is invoked like this:
> > > > > > kver=6.4.0-rc5-00009-g75d090fd167a
> > > > > > kdir=$HOME/kernels/$kver
> > > > > > sudo kexec -l $kdir/vmlinuz-$kver --initrd=$kdir/initramfs-$kver.img --append="root=UUID=4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro net.ifnames=0 acpi_rsdp=0x728e8014 no_hash_pointers sched_verbose selinux=0"
> > > > >
> > > > > I don't understand why it happens.
> > > > >
> > > > > Could you check if this patch changes anything:
> > > > >
> > > > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > > > > index 94b7abcf624b..172c476ff6f3 100644
> > > > > --- a/arch/x86/boot/compressed/misc.c
> > > > > +++ b/arch/x86/boot/compressed/misc.c
> > > > > @@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> > > > >
> > > > >   debug_putstr("\nDecompressing Linux... ");
> > > > >
> > > > > +#if 0
> > > > >   if (init_unaccepted_memory()) {
> > > > >           debug_putstr("Accepting memory... ");
> > > > >           accept_memory(__pa(output), __pa(output) + needed_size);
> > > > >   }
> > > > > +#endif
> > > > >
> > > > >   __decompress(input_data, input_len, NULL, NULL, output, output_len,
> > > > >                   NULL, error);
> > > > > --
> > > >
> > > > It solved the problem.
> > >
> > > Looks like increasing BOOT_INIT_PGT_SIZE fixes the issue. I don't yet
> > > understand why and how unaccepted memory is involved. I will look more
> > > into it.
> > >
> > > Enabling CONFIG_RANDOMIZE_BASE also makes the issue go away.
> >
> > Is this perhaps just luck? I.e. does is break ever on, say, 1000 boot
> > attempts? (i.e. maybe some position is bad and KASLR happens to usually
> > avoid it?)

Yes, it can be luck.

> > > Kees, maybe you have a clue?
> >
> > The only thing I can think of is that something isn't being counted
> > correctly due to the size of code, and it just happens that this commit
> > makes the code large enough to exceed some set of mappings?
> >
> > >
> > > diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> > > index 9191280d9ea3..26ccce41d781 100644
> > > --- a/arch/x86/include/asm/boot.h
> > > +++ b/arch/x86/include/asm/boot.h
> > > @@ -40,7 +40,7 @@
> > >  #ifdef CONFIG_X86_64
> > >  # define BOOT_STACK_SIZE     0x4000
> > >
> > > -# define BOOT_INIT_PGT_SIZE  (6*4096)
> > > +# define BOOT_INIT_PGT_SIZE  (7*4096)
> >
> > That's why this might be working, for example? How large is the boot
> > image before/after the commit, etc?
> >
> 
> Not sure why these changes would make a difference here, but choking
> on accept_memory() on a non-TDX suggests that init_unaccepted_memory()
> is poking into unmapped memory before it even decides that the
> unaccepted memory does not exist.
> 
> init_unaccepted_memory() has
> 
>         ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
>         if (ret) {
>                 warn("EFI config table not found.");
>                 return false;
>         }
> 
> which looks for <guid, phys_addr> tuples in an array pointed to by the
> EFI system table, and if either of those is not mapped, things can be
> expected to explode.
> 
> The only odd thing there is that this code is invoked after setting up
> the 'demand paging' logic in the decompressor.
> 
> If you haven't yet, could you please retry the kexec boot with
> earlyprintk=tty<insert your UART params here>?

early console in extract_kernel
input_data: 0x000000807eb433a8
input_len: 0x0000000000d26271
output: 0x000000807b000000
output_len: 0x0000000004800c10
kernel_total_size: 0x0000000003e28000
needed_size: 0x0000000004a00000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
pages->pgt_buf_offset: 0x0000000000006000
pages->pgt_buf_size: 0x0000000000006000


Error: kernel_ident_mapping_init() failed

It crashes on #PF due to stbl->nr_tables dereference in
efi_get_conf_table() called from init_unaccepted_memory().

I don't see anything special about stbl location: 0x775d6018.

One other bit of information: disabling 5-level paging also helps the
issue.

I will debug further.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
