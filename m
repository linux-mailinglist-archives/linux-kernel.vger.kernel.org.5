Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0C80E117
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjLLBvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLLBvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:51:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C6D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:51:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b459364167so195044239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702345869; x=1702950669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX2WLxx5Rcq4VaM/IYqMbN57BjVsaN794DZZVcGhbe0=;
        b=Q2udXtbuAh9U7GTYaAewsWbSvtCAWlCvmGDwCAXrG9NRnadhRnCbkzAPN5qtCTUvFI
         NpTW7fEJ2wui8WduLl5SDl5Xzqmn7/k23xkZic0VedyfHKRc5ZzmZSyw2py8nc/u1W9L
         yZzlOdvw52LHutLp1F7tn/FSEeuFjruCIdUaGLwy2voyk3NeKrdpgMIN0is3aGu7GNzO
         6jHXG1eaI+7b9mmIvZayhO9PURZD7MUkJ99d1lGLguv8rC8KdJuL1HJNz2vlIqdtW5uC
         NZmjUvAYj0g4sl2/uaeF2N3YOBuB/46z8UEn4G78mmdgo/Of3aGWxH5upAjvfbd5VObK
         /6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702345869; x=1702950669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX2WLxx5Rcq4VaM/IYqMbN57BjVsaN794DZZVcGhbe0=;
        b=HPpwGNpyCKrvKXB3jHiC8l8xhIilbT+8h55nZlN43BiyqwYebx/jE4yIWivDPBQJAL
         gkmJpoieCdnWvOujDQ/u+RAyIaFg/me5Fbxj1d0GBWxTmwbDEQypBDuuvM29tn+KlCjA
         1q3hgfQB2mSw4RdMHOrggLhYA/WBYT21x6s7ww6K8eXCbNpAU9Wpwprp7Ul1W+eBQVJe
         qzVh/aQ9uf+N8W4TB85vlfJGk32yOvuS7tM1cUzKehIJGic2hLvqEEYfU1uhbHLXeICY
         2c7tO1+z7nnf9Uuxim3OT4w953ilQgdhjDIyNkt9p/6uSgYMQl1DhUdQUjpikOsdLgm4
         EB7A==
X-Gm-Message-State: AOJu0Yx73JPu4P0HfkZdvASUasAu30ApLOI6vXkbski8k+NasgvjifW3
        6kdtG2Zq33Hg1oJj4bnHFVR+OOzAsSgkZM7zufs=
X-Google-Smtp-Source: AGHT+IGnyMrJXzmjvP+GzSeN8xEYOBCyBBOu71OLX4nlpJx0A1/qebH4GVwEO5MPcOyQmk0ZvFgk2Q==
X-Received: by 2002:a05:6e02:1aa5:b0:35d:a3ce:4e50 with SMTP id l5-20020a056e021aa500b0035da3ce4e50mr4700952ilv.37.1702345869214;
        Mon, 11 Dec 2023 17:51:09 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b001d0d312bc2asm7296320plb.193.2023.12.11.17.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 17:51:08 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:51:06 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linux-riscv@lists.infradead.org, bigunclemax@gmail.com,
        Amma Lee <lixiaoyun@binary-semi.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] riscv: optimize ELF relocation function in riscv
Message-ID: <ZXe8imHSg20nKagf@ghost>
References: <20230913130501.287250-1-fido_max@inbox.ru>
 <ZXJrGLwxtjf6cK42@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJrGLwxtjf6cK42@ghost>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:02:16PM -0800, Charlie Jenkins wrote:
> On Wed, Sep 13, 2023 at 04:05:00PM +0300, Maxim Kochetkov wrote:
> > The patch can optimize the running times of insmod command by modify ELF
> > relocation function.
> > In the 5.10 and latest kernel, when install the riscv ELF drivers which
> > contains multiple symbol table items to be relocated, kernel takes a lot
> > of time to execute the relocation. For example, we install a 3+MB driver
> > need 180+s.
> > We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
> > type items relocation function in the arch\riscv\kernel\module.c and
> > find that there are two-loops in the function. If we modify the begin
> > number in the second for-loops iteration, we could save significant time
> > for installation. We install the same 3+MB driver could just need 2s.
> > 
> > Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
> > Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> > ---
> > Changes in v4:
> > - use 'while' loop instead of 'for' loop to avoid code duplicate
> > ---
> >  arch/riscv/kernel/module.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 7c651d55fcbd..8c9b644ebfdb 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -346,6 +346,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  	Elf_Sym *sym;
> >  	u32 *location;
> >  	unsigned int i, type;
> > +	unsigned int j_idx = 0;
> >  	Elf_Addr v;
> >  	int res;
> >  
> > @@ -384,9 +385,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  		v = sym->st_value + rel[i].r_addend;
> >  
> >  		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
> > -			unsigned int j;
> > +			unsigned int j = j_idx;
> > +			bool found = false;
> >  
> > -			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
> > +			do {
> >  				unsigned long hi20_loc =
> >  					sechdrs[sechdrs[relsec].sh_info].sh_addr
> >  					+ rel[j].r_offset;
> > @@ -415,16 +417,26 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  					hi20 = (offset + 0x800) & 0xfffff000;
> >  					lo12 = offset - hi20;
> >  					v = lo12;
> > +					found = true;
> >  
> >  					break;
> >  				}
> > -			}
> > -			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
> > +
> > +				j++;
> > +				if (j > sechdrs[relsec].sh_size / sizeof(*rel))
> > +					j = 0;
> Very interesting algorithm here. Assuming the hi relocation is after the
> previous one seems to be a good heuristic. However I think we can do
> better. In GNU ld, a hashmap of all of the hi relocations is stored and
> a list of all of the lo relocations. After all of the other relocations
> have been parsed, it iterates through all of the lo relocations and
> looks up the associated hi relocation in the hashmap.
> 
> There is more memory overhead here but I suspect it will be faster. I
> had started to mock up a hashmap implementation to see if it was faster
> but decided I should mention it here first in case somebody had some
> additional insight. 

Turns out this is a fantastic heuristic. Using a hashmap is
significantly faster than the default implementation but this algorithm
above is significantly faster than the hashmap. Using the amdgpu driver
(which is actually a collection of drivers) and is a size of about 469M
I found that the hashmap implementation is about 30% faster than the
current implementation, but this patch is 50% faster than the current
implementation. It is probably possible to write an ELF header with the
relocations sufficiently scrambled to make the hashmap faster, but I
suspect that for all "normal" programs this algorithm is faster.

I also tried a couple other smaller modules and it was faster or around
the same as the hashmap in all of them.

A lot of code has changed in this file since this patch was submitted,
can you rebase onto 6.7-rc1? Otherwise this patch is great.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> - Charlie
> 
> > +
> > +			} while (j_idx != j);
> > +
> > +			if (!found) {
> >  				pr_err(
> >  				  "%s: Can not find HI20 relocation information\n",
> >  				  me->name);
> >  				return -EINVAL;
> >  			}
> > +
> > +			/* Record the previous j-loop end index */
> > +			j_idx = j;
> >  		}
> >  
> >  		res = handler(me, location, v);
> > -- 
> > 2.40.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
