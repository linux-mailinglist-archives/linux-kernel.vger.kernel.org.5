Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A77CD562
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJRHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbjJRHNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:13:55 -0400
Received: from out0-213.mail.aliyun.com (out0-213.mail.aliyun.com [140.205.0.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE757FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:13:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.V1pyUc-_1697613227;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V1pyUc-_1697613227)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 15:13:48 +0800
Date:   Wed, 18 Oct 2023 15:13:47 +0800
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
Message-ID: <20231018071347.GA87734@k08j02272.eu95sqa>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
 <ZS6DngTm9ILei4dM@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6DngTm9ILei4dM@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:52:46PM +0800, Ingo Molnar wrote:
> 
> * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> 
> > The functions sme_enable() and sme_encrypt_kernel() are only called by
> > the head code which runs in identity virtual address. Therefore, it's
> > better to mark them as __head as well.
> > 
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > ---
> >  arch/x86/include/asm/mem_encrypt.h |  8 ++++----
> >  arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++++-------------
> >  2 files changed, 18 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> > index 359ada486fa9..48469e22a75e 100644
> > --- a/arch/x86/include/asm/mem_encrypt.h
> > +++ b/arch/x86/include/asm/mem_encrypt.h
> > @@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
> >  
> >  void __init sme_early_init(void);
> >  
> > -void __init sme_encrypt_kernel(struct boot_params *bp);
> > -void __init sme_enable(struct boot_params *bp);
> > +void sme_encrypt_kernel(struct boot_params *bp);
> > +void sme_enable(struct boot_params *bp);
> >  
> >  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
> >  int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> > @@ -75,8 +75,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
> >  
> >  static inline void __init sme_early_init(void) { }
> >  
> > -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> > -static inline void __init sme_enable(struct boot_params *bp) { }
> > +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
> > +static inline void sme_enable(struct boot_params *bp) { }
> 
> So I think we should preserve the previous convention of marking functions 
> __init in the header-declaration and at the definition site as well, and do 
> the same with __head as well?
> 
Hi Ingo,

I tried to include <asm/init.h> into <asm/mem_encrypt.h> and mark the
function declaration as __head, but it resulted in a build failure. This
is because <asm/init.h> is not self-contained; the type "pgd_t" is
defined in <asm/pgtable_types.h>, which includes <asm/mem_encrypt.h>,
leading to mutual inclusion of header files. To avoid the issue of
complicated header file inclusion, I removed the annotation from the
function declaration.

Actually, initially, I noticed that the __init definition is in
<linux/init.h>, so I first placed the __head definition in
<linux/init.h> as well. However, this conflicted with the local variable
in the "list_next_or_null_rcu" macro in <linux/rculist.h>. Then I
realized that __head was only used in x86, so I made the decision to put
it in the architecture-specific header. Considering simplicity, I chose
to put the definition in <asm/init.h>. I also attempted to put the
definition in other headers such as <asm/boot.h> and
<asm/bootparam_utils.h>, and included them in <asm/mem_encrypt.h>, but
the build still failed.

Thanks!

> Thanks,
> 
> 	Ingo
