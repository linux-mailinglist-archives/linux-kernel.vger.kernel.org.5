Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB397CE69F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJRSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJRSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:31:27 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCB11D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:31:05 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7b92cd0ccso89443347b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697653864; x=1698258664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHUD6sASExs/GXz3U87JmB/giRzmLpe5GxsMQInFySk=;
        b=lpDO54jhyXPyxDN9JeTok6drXwsgfjYVmABBc32vq7sKCxMo/v6Co7kqEY1YCLM0Lg
         WM7J08ptPcKDw8hf6inuPRcn3NT7rZ2zsxHrgy4eV5QtVQkNfDlKQShHv130B1GgNw/q
         4W7sYq8WlRQjvqwwiHgXspoE7rKPHxRggMyJ5OtNNqcRfzyqjBqBSqM4LChxuz6Qczy5
         IArgRWMyPpB2DFZXZEoz2F0XSF8Gmy7VOFn6fDFMSXmwu/T+EDstf6XdF6nPbyb78rHZ
         pzwzBssF5GVTJglBRjuEXrxzH4QEghkO8yIzh95peKxDbi93B9JUIPow0RAj1cEnMeFN
         Ry/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653864; x=1698258664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHUD6sASExs/GXz3U87JmB/giRzmLpe5GxsMQInFySk=;
        b=vvPwy1fOEJyCUOglGNk0Sg9K7mgP3UQy0O3l6eG43BB82ZXQwaafDd81r5o8nZ6yLH
         xwTXINpiKMXyGWSp04U53cdHchkWOV35VeYitPEZj4WaVAmIU/4ZkBAO/LIfE0JEbpRq
         QsDeCwi5xzNnfXld+nyUJZF8rqPPnRTOrMCes5q6hGqFF+IEZyLeinXmZbU510S9I5bi
         /yuo/F7swPbOxtXT5dpHcxZJULO418Ad9NkXepBPzGT9kiNkTvoKkYHQi9BPU7n7ET5o
         mj4gC13FU/d9e7NHdolNkNSeEccFQWCafWl+bZOAF+pKPHI3SwlJFctlzC+DVQscSbBO
         8VXg==
X-Gm-Message-State: AOJu0YwfZATtpUpUhyeB845xAkCeqXIYIcU+D0pfHiHJ+mpKMA0fh4XW
        UhqNkK3NdEmBRE9z2CCr9bwYBA==
X-Google-Smtp-Source: AGHT+IFQaGgVrwHXJazEcctfK/sJKSWbuonzH4gNdGVcLIC5LWa08vWj6PJu5tXvvU8uHJMregz7BA==
X-Received: by 2002:a05:690c:1b:b0:59f:72a6:da0e with SMTP id bc27-20020a05690c001b00b0059f72a6da0emr80934ywb.41.1697653864677;
        Wed, 18 Oct 2023 11:31:04 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id g8-20020a05620a218800b007759e9b0eb8sm147121qka.99.2023.10.18.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:31:04 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:31:00 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 1/2] riscv: Add remaining module relocations
Message-ID: <ZTAkZAm21O3gtA7i@ghost>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
 <CAJM55Z9xgyJoCX83hgwerF6SRo6yit8=0rmLzhF8Ju4TmZq3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z9xgyJoCX83hgwerF6SRo6yit8=0rmLzhF8Ju4TmZq3BA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:17:44AM -0700, Emil Renner Berthing wrote:
> Charlie Jenkins wrote:
> > Add all final module relocations and add error logs explaining the ones
> > that are not supported.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/uapi/asm/elf.h |   5 +-
> >  arch/riscv/kernel/module.c        | 207 +++++++++++++++++++++++++++++++++-----
> >  2 files changed, 186 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
> > index d696d6610231..11a71b8533d5 100644
> > --- a/arch/riscv/include/uapi/asm/elf.h
> > +++ b/arch/riscv/include/uapi/asm/elf.h
> > @@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_TLS_DTPREL64	9
> >  #define R_RISCV_TLS_TPREL32	10
> >  #define R_RISCV_TLS_TPREL64	11
> > +#define R_RISCV_IRELATIVE	58
> >
> >  /* Relocation types not used by the dynamic linker */
> >  #define R_RISCV_BRANCH		16
> > @@ -81,7 +82,6 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_ALIGN		43
> >  #define R_RISCV_RVC_BRANCH	44
> >  #define R_RISCV_RVC_JUMP	45
> > -#define R_RISCV_LUI		46
> >  #define R_RISCV_GPREL_I		47
> >  #define R_RISCV_GPREL_S		48
> >  #define R_RISCV_TPREL_I		49
> > @@ -93,6 +93,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_SET16		55
> >  #define R_RISCV_SET32		56
> >  #define R_RISCV_32_PCREL	57
> > +#define R_RISCV_PLT32		59
> > +#define R_RISCV_SET_ULEB128	60
> > +#define R_RISCV_SUB_ULEB128	61
> >
> >
> >  #endif /* _UAPI_ASM_RISCV_ELF_H */
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 7c651d55fcbd..e860726352ac 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/kernel.h>
> >  #include <linux/moduleloader.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sizes.h>
> > @@ -268,6 +269,12 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
> >  	return -EINVAL;
> >  }
> >
> > +static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location += (u8)v;
> > +	return 0;
> > +}
> > +
> >  static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
> >  				    Elf_Addr v)
> >  {
> > @@ -289,6 +296,12 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
> >  	return 0;
> >  }
> >
> > +static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location -= (u8)v;
> > +	return 0;
> > +}
> > +
> >  static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
> >  				    Elf_Addr v)
> >  {
> > @@ -310,31 +323,149 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
> >  	return 0;
> >  }
> >
> > -static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
> > -				Elf_Addr v) = {
> > -	[R_RISCV_32]			= apply_r_riscv_32_rela,
> > -	[R_RISCV_64]			= apply_r_riscv_64_rela,
> > -	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
> > -	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
> > -	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rvc_branch_rela,
> > -	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
> > -	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
> > -	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
> > -	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
> > -	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
> > -	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
> > -	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
> > -	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
> > -	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
> > -	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
> > -	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
> > -	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
> > -	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
> > -	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
> > -	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
> > -	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
> > -	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
> > -	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
> > +static int dynamic_linking_not_supported(struct module *me, u32 *location,
> > +					 Elf_Addr v)
> > +{
> > +	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
> > +	       me->name, location);
> > +	return -EINVAL;
> > +}
> > +
> > +static int tls_not_supported(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
> > +	       me->name, location);
> > +	return -EINVAL;
> > +}
> > +
> > +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (*location - ((u8)v & 0x3F)) & 0x3F;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (u8)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u16 *)location = (u16)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
> > +				       Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	/*
> > +	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
> > +	 * R_RISCV_SUB_ULEB128 so do computation there
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	if (v >= 128) {
> > +		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC = %p\n",
> > +		       me->name, (unsigned long)v, location);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*location = v;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Relocations defined in the riscv-elf-psabi-doc.
> > + * This handles static linking only.
> > + */
> > +static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
> > +				    Elf_Addr v) = {
> > +	[R_RISCV_32] =			apply_r_riscv_32_rela,
> > +	[R_RISCV_64] =			apply_r_riscv_64_rela,
> > +	[R_RISCV_RELATIVE] =		dynamic_linking_not_supported,
> > +	[R_RISCV_COPY] =		dynamic_linking_not_supported,
> > +	[R_RISCV_JUMP_SLOT] =		dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPMOD32] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPMOD64] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPREL32] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPREL64] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_TPREL32] =		dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_TPREL64] =		dynamic_linking_not_supported,
> > +	/* 12-15 undefined */
> > +	[R_RISCV_BRANCH] =		apply_r_riscv_branch_rela,
> > +	[R_RISCV_JAL] =			apply_r_riscv_jal_rela,
> > +	[R_RISCV_CALL] =		apply_r_riscv_call_rela,
> > +	[R_RISCV_CALL_PLT] =		apply_r_riscv_call_plt_rela,
> > +	[R_RISCV_GOT_HI20] =		apply_r_riscv_got_hi20_rela,
> > +	[R_RISCV_TLS_GOT_HI20] =	tls_not_supported,
> > +	[R_RISCV_TLS_GD_HI20] =		tls_not_supported,
> > +	[R_RISCV_PCREL_HI20] =		apply_r_riscv_pcrel_hi20_rela,
> > +	[R_RISCV_PCREL_LO12_I] =	apply_r_riscv_pcrel_lo12_i_rela,
> > +	[R_RISCV_PCREL_LO12_S] =	apply_r_riscv_pcrel_lo12_s_rela,
> > +	[R_RISCV_HI20] =		apply_r_riscv_hi20_rela,
> > +	[R_RISCV_LO12_I] =		apply_r_riscv_lo12_i_rela,
> > +	[R_RISCV_LO12_S] =		apply_r_riscv_lo12_s_rela,
> > +	[R_RISCV_TPREL_HI20] =		tls_not_supported,
> > +	[R_RISCV_TPREL_LO12_I] =	tls_not_supported,
> > +	[R_RISCV_TPREL_LO12_S] =	tls_not_supported,
> > +	[R_RISCV_TPREL_ADD] =		tls_not_supported,
> > +	[R_RISCV_ADD8] =		apply_r_riscv_add8_rela,
> > +	[R_RISCV_ADD16] =		apply_r_riscv_add16_rela,
> > +	[R_RISCV_ADD32] =		apply_r_riscv_add32_rela,
> > +	[R_RISCV_ADD64] =		apply_r_riscv_add64_rela,
> > +	[R_RISCV_SUB8] =		apply_r_riscv_sub8_rela,
> > +	[R_RISCV_SUB16] =		apply_r_riscv_sub16_rela,
> > +	[R_RISCV_SUB32] =		apply_r_riscv_sub32_rela,
> > +	[R_RISCV_SUB64] =		apply_r_riscv_sub64_rela,
> > +	/* 41-42 reserved for future standard use */
> > +	[R_RISCV_ALIGN] =		apply_r_riscv_align_rela,
> > +	[R_RISCV_RVC_BRANCH] =		apply_r_riscv_rvc_branch_rela,
> > +	[R_RISCV_RVC_JUMP] =		apply_r_riscv_rvc_jump_rela,
> > +	/* 46-50 reserved for future standard use */
> > +	[R_RISCV_RELAX] =		apply_r_riscv_relax_rela,
> > +	[R_RISCV_SUB6] =		apply_r_riscv_sub6_rela,
> > +	[R_RISCV_SET6] =		apply_r_riscv_set6_rela,
> > +	[R_RISCV_SET8] =		apply_r_riscv_set8_rela,
> > +	[R_RISCV_SET16] =		apply_r_riscv_set16_rela,
> > +	[R_RISCV_SET32] =		apply_r_riscv_set32_rela,
> > +	[R_RISCV_32_PCREL] =		apply_r_riscv_32_pcrel_rela,
> > +	[R_RISCV_IRELATIVE] =		dynamic_linking_not_supported,
> > +	[R_RISCV_PLT32] =		apply_r_riscv_plt32_rela,
> > +	[R_RISCV_SET_ULEB128] =		apply_r_riscv_set_uleb128,
> > +	[R_RISCV_SUB_ULEB128] =		apply_r_riscv_sub_uleb128,
> > +	/* 62-191 reserved for future standard use */
> > +	/* 192-255 nonstandard ABI extensions  */
> >  };
> 
> Hi Charlie,
> 
> This is not a critique of this patch, but all these callbacks take a
> u32 *location and
> because of the compressed instructions this pointer may not be
> aligned, so a lot of
> the callbacks end up doing unaligned access which may fault to an
> M-mode handler on
> some platforms.
> 
> I once sent a patch to fix this:
> https://lore.kernel.org/linux-riscv/20220224152456.493365-2-kernel@esmil.dk/
> 
> Maybe that's something you want to look into while touching this code anyway.
> 
> /Emil

Oh nice, I will pick up that patch and change the "native-endian"
wording to be "little-endian" in the commit.

- Charlie

> >
> >  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> > @@ -348,6 +479,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  	unsigned int i, type;
> >  	Elf_Addr v;
> >  	int res;
> > +	bool uleb128_set_exists = false;
> > +	u32 *uleb128_set_loc;
> > +	unsigned long uleb128_set_sym_val;
> > +
> >
> >  	pr_debug("Applying relocate section %u to %u\n", relsec,
> >  	       sechdrs[relsec].sh_info);
> > @@ -425,6 +560,28 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  				  me->name);
> >  				return -EINVAL;
> >  			}
> > +		} else if (type == R_RISCV_SET_ULEB128) {
> > +			if (uleb128_set_exists) {
> > +				pr_err("%s: riscv psABI requires the next ULEB128 relocation to come after a R_RISCV_SET_ULEB128 is an R_RISCV_SUB_ULEB128, not another R_RISCV_SET_ULEB128.\n",
> > +				       me->name);
> > +				return -EINVAL;
> > +			}
> > +			uleb128_set_exists = true;
> > +			uleb128_set_loc = location;
> > +			uleb128_set_sym_val =
> > +				((Elf_Sym *)sechdrs[symindex].sh_addr +
> > +					ELF_RISCV_R_SYM(rel[i].r_info))
> > +					->st_value +
> > +				rel[i].r_addend;
> > +		} else if (type == R_RISCV_SUB_ULEB128) {
> > +			if (uleb128_set_exists && uleb128_set_loc == location) {
> > +				/* Calculate set and subtraction */
> > +				v = uleb128_set_sym_val - v;
> > +			} else {
> > +				pr_err("%s: R_RISCV_SUB_ULEB128 must always be paired with the first R_RISCV_SET_ULEB128 that comes before it. PC = %p\n",
> > +				       me->name, location);
> > +				return -EINVAL;
> > +			}
> >  		}
> >
> >  		res = handler(me, location, v);
> >
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
