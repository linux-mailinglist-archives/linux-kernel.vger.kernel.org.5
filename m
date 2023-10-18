Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E617CDB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjJRMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJRMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:03:23 -0400
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B13F95
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:03:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.V21j794_1697630594;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V21j794_1697630594)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 20:03:15 +0800
Date:   Wed, 18 Oct 2023 20:03:14 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Rutherford <srutherford@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] x86/sme: Mark the code as __head in
 mem_encrypt_identity.c
Message-ID: <20231018120314.GA11219@k08j02272.eu95sqa>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
 <ZS6DngTm9ILei4dM@gmail.com>
 <20231018071347.GA87734@k08j02272.eu95sqa>
 <ZS+xX7IJfdGJj7Ix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+xX7IJfdGJj7Ix@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:20:15PM +0800, Ingo Molnar wrote:
> 
> * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> 
> > On Tue, Oct 17, 2023 at 08:52:46PM +0800, Ingo Molnar wrote:
> > > 
> > > * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > 
> > > > The functions sme_enable() and sme_encrypt_kernel() are only called by
> > > > the head code which runs in identity virtual address. Therefore, it's
> > > > better to mark them as __head as well.
> > > > 
> > > > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > > > ---
> > > >  arch/x86/include/asm/mem_encrypt.h |  8 ++++----
> > > >  arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++++-------------
> > > >  2 files changed, 18 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> > > > index 359ada486fa9..48469e22a75e 100644
> > > > --- a/arch/x86/include/asm/mem_encrypt.h
> > > > +++ b/arch/x86/include/asm/mem_encrypt.h
> > > > @@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
> > > >  
> > > >  void __init sme_early_init(void);
> > > >  
> > > > -void __init sme_encrypt_kernel(struct boot_params *bp);
> > > > -void __init sme_enable(struct boot_params *bp);
> > > > +void sme_encrypt_kernel(struct boot_params *bp);
> > > > +void sme_enable(struct boot_params *bp);
> > > >  
> > > >  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
> > > >  int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> > > > @@ -75,8 +75,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
> > > >  
> > > >  static inline void __init sme_early_init(void) { }
> > > >  
> > > > -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> > > > -static inline void __init sme_enable(struct boot_params *bp) { }
> > > > +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
> > > > +static inline void sme_enable(struct boot_params *bp) { }
> > > 
> > > So I think we should preserve the previous convention of marking functions 
> > > __init in the header-declaration and at the definition site as well, and do 
> > > the same with __head as well?
> > > 
> > Hi Ingo,
> > 
> > I tried to include <asm/init.h> into <asm/mem_encrypt.h> and mark the
> > function declaration as __head, but it resulted in a build failure. This
> > is because <asm/init.h> is not self-contained; the type "pgd_t" is
> > defined in <asm/pgtable_types.h>, which includes <asm/mem_encrypt.h>,
> > leading to mutual inclusion of header files. To avoid the issue of
> > complicated header file inclusion, I removed the annotation from the
> > function declaration.
> 
> The right solution at that point is to make <asm/init.h> self-contained...
>

The "pgd_t" is a typedef declaration in <asm/pgtable_types.h>, so it
cannot be forward declared. Therefore, I had to include
<asm/pgtable_types.h> into <asm/init.h> to make it self-contained.
However, <asm/pgtable_types.h> includes <asm/mem_encrypt.h>. If I
include <asm/init.h> into <asm/mem_encrypt.h> to mark functions as
__head in the header-declaration, it would result in mutual inclusion of
header files. It appears that <asm/mem_encrypt.h> is a base header that
is included in multiple headers, so adding one more header to it would
complicate things. In reality, if it is acceptable, I could move the
__head definition into <asm/mem_encrypt.h>.
 
> > Actually, initially, I noticed that the __init definition is in
> > <linux/init.h>, so I first placed the __head definition in
> > <linux/init.h> as well. However, this conflicted with the local variable
> > in the "list_next_or_null_rcu" macro in <linux/rculist.h>. Then I
> > realized that __head was only used in x86, so I made the decision to put
> > it in the architecture-specific header. Considering simplicity, I chose
> > to put the definition in <asm/init.h>. I also attempted to put the
> > definition in other headers such as <asm/boot.h> and
> > <asm/bootparam_utils.h>, and included them in <asm/mem_encrypt.h>, but
> > the build still failed.
> 
> When exporting a localized definition you should consider namespace 
> collisions - the name '__head' is way too generic, no wonder it caused 
> problems elsewhere.
> 
> I'd suggest naming it __init_head or so, but still keep it in a x86-only 
> header.
> 
> I presume keeping it all in the  separate section and widening its usage has a 
> specific purpose? Please outline that in the changelog as well.
> 

Based on my understanding, the __head section contains the early boot
code that runs at a low identity address instead of the compile-time
address. Therefore, it must use RIP-relative addressing to access
memory. This makes the __head section special. However, when it comes to
C source code, the compiler may generate absolute addressing, which can
result in boot failure. That's why the fixup_pointer() function is
introduced in head64.c. So maybe we could consider validating the memory
access instructions in this section using objtool to ensure that the
generated instructions are PC-relative. Then we should mark all the
early boot code as __head.

Thanks!

> Ie. instead of mechanical patches that try to follow existing patterns 
> cargo-cult style, this area of x86 code requires well-argued, well thought 
> out patches that show background knowledge of the area.
> 
> Thanks,
> 
> 	Ingo
