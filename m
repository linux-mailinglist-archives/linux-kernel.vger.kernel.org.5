Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63047EF929
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjKQVHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:07:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B228D52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:07:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc316ccc38so22036225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700255231; x=1700860031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnuVSH1Hjhwo5eduxUsEbs6506SH8CFL3UEwOpV+ZLs=;
        b=kq5TvUb3Gx//JD8yyTivxM+JC1vQFFqo1PUFg6jNkA8BZavzPwLBQBllJammp+3Gux
         rT5A6Fj8ExB4gQ5iCoyYbTV1+vQG+wPCsayJRQX8G+KP7FVpDFSeA2/pt7BpTA3BMXls
         vigNjzMSOZi2AN0VM8R8kyXq2n3lIX+sHzdPCddR8ywQ5NF5FZiJKXI1T/K4kkaNSyeZ
         /8OhaUA+2KnaGYK6jUsIxpaR3JG1phOpx3Rkco4u6ArQkRnYxB8yyALMj9n3mbJEKDWX
         02oFpeEKE/ZdjopgrWUzd3WP1O1dmjpqnf/dKnjYPhxWMdkiDPtI2SoUzX8XFpM/Yh36
         QwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255231; x=1700860031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnuVSH1Hjhwo5eduxUsEbs6506SH8CFL3UEwOpV+ZLs=;
        b=V3C4tdD/Rv8jKzW84OVZF8/LzzTpTLBIh6dJOo6xsfic4QyZ2KaAXDaQEn5uLR4Fnl
         59c/9XKg7yvp/ubM6tjskPSkLvsendQ6vYIYE8L+aPj4hjmxf2foNyV35cQtGi9YtbSC
         nbfCGlyYxpw2f9kHvVZdkDgbt7lbXyfGT/6InEFZX33o80nEZKTxVLt8b6zXGhq67kXW
         JAcutezR6BAxjvZvBUkEgwQpQjTdimrZQv4uHKtJc4vW2gQ/bjo3Uw/Us1u6Z6mq4g4Q
         Xcpb0o609RJSHU93gmbaPlHSJqbFl3fPFA3owX3ELy7VDbmVcHEELbSsciNnioyOlXHP
         pKCg==
X-Gm-Message-State: AOJu0Yy3xzvB5sPoa/CP7D45u1rishKeB0/MYjezuWbEnOxhqvg699Tj
        dOobb3zLrNLMMpZIOyItMg16Qe1hT+GuuoyYPVF8Lg==
X-Google-Smtp-Source: AGHT+IGIe0efVUoLxW7XYbr8IrHRLNE7EZdKWFZY5p1GT0Vtttktdim+rSq9It/lH8StlziGqzcvOQ==
X-Received: by 2002:a17:903:181:b0:1cc:5db8:7ebb with SMTP id z1-20020a170903018100b001cc5db87ebbmr1036913plg.9.1700255230418;
        Fri, 17 Nov 2023 13:07:10 -0800 (PST)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ee8100b001cc2ebd2c2csm1781336pld.256.2023.11.17.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:07:09 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:07:06 -0500
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Evan Green <evan@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v10 4/5] riscv: Add checksum library
Message-ID: <ZVfV+vPhiu5blbZu@ghost>
References: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
 <20231101-optimize_checksum-v10-4-a498577bb969@rivosinc.com>
 <DM8PR11MB5751D86C9588FB838F49218FB8A9A@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751D86C9588FB838F49218FB8A9A@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:39:54AM +0000, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > Sent: Thursday, November 2, 2023 6:48 AM
> > To: Charlie Jenkins <charlie@rivosinc.com>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Conor Dooley <conor@kernel.org>; Samuel Holland
> > <samuel.holland@sifive.com>; David Laight <David.Laight@aculab.com>;
> > Wang, Xiao W <xiao.w.wang@intel.com>; Evan Green <evan@rivosinc.com>;
> > linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > arch@vger.kernel.org
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>; Albert Ou
> > <aou@eecs.berkeley.edu>; Arnd Bergmann <arnd@arndb.de>; Conor Dooley
> > <conor.dooley@microchip.com>
> > Subject: [PATCH v10 4/5] riscv: Add checksum library
> > 
> > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > will load from the buffer in groups of 32 bits, and when compiled for
> > 64-bit will load in groups of 64 bits.
> 
> The csum_ipv6_magic() API is also provided in this patch for 64-bit , but not
> mentioned in the commit log.
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/checksum.h |  11 ++
> >  arch/riscv/lib/Makefile           |   1 +
> >  arch/riscv/lib/csum.c             | 326
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 338 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h
> > b/arch/riscv/include/asm/checksum.h
> > index 3d77cac338fe..f8f8e437a88a 100644
> > --- a/arch/riscv/include/asm/checksum.h
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -12,6 +12,17 @@
> > 
> >  #define ip_fast_csum ip_fast_csum
> > 
> > +extern unsigned int do_csum(const unsigned char *buff, int len);
> > +#define do_csum do_csum
> > +
> > +/* Default version is sufficient for 32 bit */
> > +#ifndef CONFIG_32BIT
> > +#define _HAVE_ARCH_IPV6_CSUM
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum sum);
> > +#endif
> > +
> >  /* Define riscv versions of functions before importing asm-
> > generic/checksum.h */
> >  #include <asm-generic/checksum.h>
> > 
> > diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> > index 26cb2502ecf8..2aa1a4ad361f 100644
> > --- a/arch/riscv/lib/Makefile
> > +++ b/arch/riscv/lib/Makefile
> > @@ -6,6 +6,7 @@ lib-y			+= memmove.o
> >  lib-y			+= strcmp.o
> >  lib-y			+= strlen.o
> >  lib-y			+= strncmp.o
> > +lib-y			+= csum.o
> >  lib-$(CONFIG_MMU)	+= uaccess.o
> >  lib-$(CONFIG_64BIT)	+= tishift.o
> >  lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
> > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > new file mode 100644
> > index 000000000000..3221d4520bbb
> > --- /dev/null
> > +++ b/arch/riscv/lib/csum.c
> > @@ -0,0 +1,326 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Checksum library
> > + *
> > + * Influenced by arch/arm64/lib/csum.c
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/compiler.h>
> > +#include <asm/cpufeature.h>
> 
> It seems generally we separate the header including codes for <linux/*.h> and <asm/*.h>,
> We can follow the style.
> 
> > +#include <linux/jump_label.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kernel.h>
> > +
> > +#include <net/checksum.h>
> > +
> > +/* Default version is sufficient for 32 bit */
> > +#ifndef CONFIG_32BIT
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum csum)
> > +{
> > +	unsigned int ulen, uproto;
> > +	unsigned long sum = csum;
> > +
> > +	sum += saddr->s6_addr32[0];
> > +	sum += saddr->s6_addr32[1];
> > +	sum += saddr->s6_addr32[2];
> > +	sum += saddr->s6_addr32[3];
> > +
> > +	sum += daddr->s6_addr32[0];
> > +	sum += daddr->s6_addr32[1];
> > +	sum += daddr->s6_addr32[2];
> > +	sum += daddr->s6_addr32[3];
> > +
> > +	ulen = htonl((unsigned int)len);
> > +	sum += ulen;
> > +
> > +	uproto = htonl(proto);
> > +	sum += uproto;
> > +
> > +	/*
> > +	 * Zbb support saves 4 instructions, so not worth checking without
> > +	 * alternatives if supported
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		unsigned long fold_temp;
> > +
> > +		/*
> > +		 * Zbb is likely available when the kernel is compiled with Zbb
> > +		 * support, so nop when Zbb is available and jump when Zbb
> > is
> > +		 * not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +				  :
> > +				  :
> > +				  :
> > +				  : no_zbb);
> > +		asm(".option push					\n\
> > +		.option arch,+zbb					\n\
> > +			rori	%[fold_temp], %[sum], 32		\n\
> > +			add	%[sum], %[fold_temp], %[sum]
> > 	\n\
> > +			srli	%[sum], %[sum], 32			\n\
> > +			not	%[fold_temp], %[sum]			\n\
> > +			roriw	%[sum], %[sum], 16			\n\
> > +			subw	%[sum], %[fold_temp], %[sum]
> > 	\n\
> > +		.option pop"
> > +		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
> > +		return (__force __sum16)(sum >> 16);
> > +	}
> > +no_zbb:
> > +	sum += ror64(sum, 32);
> > +	sum >>= 32;
> > +	return csum_fold((__force __wsum)sum);
> > +}
> > +EXPORT_SYMBOL(csum_ipv6_magic);
> > +#endif /* !CONFIG_32BIT */
> > +
> > +#ifdef CONFIG_32BIT
> > +#define OFFSET_MASK 3
> > +#elif CONFIG_64BIT
> > +#define OFFSET_MASK 7
> > +#endif
> > +
> > +static inline __no_sanitize_address unsigned long
> > +do_csum_common(const unsigned long *ptr, const unsigned char *buff, int
> > len,
> > +	       unsigned long data)
> > +{
> > +	unsigned int shift;
> > +	const unsigned long *end;
> > +	unsigned long csum = 0, carry = 0;
> > +
> > +	end = (const unsigned long *)(buff + len);
> > +
> > +	/*
> > +	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
> > +	 * faster than doing 32-bit reads on architectures that support larger
> > +	 * reads.
> > +	 */
> > +	while (ptr < end) {
> > +		csum += data;
> > +		carry += csum < data;
> > +		len -= sizeof(long);
> 
> "len" is not used in below code, so the above line is unnecessary.
> Can we consolidate the two parameters of "buff" and "len" into one parameter "end"? 
> 

That is interesting that this line of code snuck through. I will fix
that and the other issues you have pointed out.

- Charlie

> > +		data = *(ptr++);
> > +	}
> > +
> > +	/*
> > +	 * Perform alignment (and over-read) bytes on the tail if any bytes
> > +	 * leftover.
> > +	 */
> > +	shift = ((long)ptr - (long)end) * 8;
> > +#ifdef __LITTLE_ENDIAN
> > +	data = (data << shift) >> shift;
> > +#else
> > +	data = (data >> shift) << shift;
> > +#endif
> > +	csum += data;
> > +	carry += csum < data;
> > +	csum += carry;
> > +	csum += csum < carry;
> > +
> > +	return csum;
> > +}
> > +
> > +/*
> > + * Algorithm accounts for buff being misaligned.
> > + * If buff is not aligned, will over-read bytes but not use the bytes that it
> > + * shouldn't. The same thing will occur on the tail-end of the read.
> > + */
> > +static inline __no_sanitize_address unsigned int
> > +do_csum_with_alignment(const unsigned char *buff, int len)
> > +{
> > +	unsigned int offset, shift;
> > +	unsigned long csum, data;
> > +	const unsigned long *ptr;
> > +
> > +	/*
> > +	 * Align address to closest word (double word on rv64) that comes
> > before
> > +	 * buff. This should always be in the same page and cache line.
> > +	 * Directly call KASAN with the alignment we will be using.
> > +	 */
> > +	offset = (unsigned long)buff & OFFSET_MASK;
> > +	kasan_check_read(buff, len);
> > +	ptr = (const unsigned long *)(buff - offset);
> > +
> > +	/*
> > +	 * Clear the most significant bytes that were over-read if buff was not
> > +	 * aligned.
> > +	 */
> > +	shift = offset * 8;
> > +	data = *(ptr++);
> > +#ifdef __LITTLE_ENDIAN
> > +	data = (data >> shift) << shift;
> > +#else
> > +	data = (data << shift) >> shift;
> > +#endif
> > +
> > +	csum = do_csum_common(ptr, buff, len, data);
> > +
> > +	/*
> > +	 * Zbb support saves 6 instructions, so not worth checking without
> > +	 * alternatives if supported
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		unsigned long fold_temp;
> > +
> > +		/*
> > +		 * Zbb is likely available when the kernel is compiled with Zbb
> > +		 * support, so nop when Zbb is available and jump when Zbb
> > is
> > +		 * not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +				  :
> > +				  :
> > +				  :
> > +				  : no_zbb);
> > +
> > +#ifdef CONFIG_32BIT
> > +		asm_volatile_goto(".option push			\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 16	\n\
> > +			andi	%[offset], %[offset], 1		\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +			beq	%[offset], zero, %l[end]	\n\
> > +			rev8	%[csum], %[csum]		\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			: [offset] "r" (offset)
> > +			:
> > +			: end);
> > +
> > +		return (unsigned short)csum;
> > +#else /* !CONFIG_32BIT */
> > +		asm_volatile_goto(".option push			\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 32	\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +			srli	%[csum], %[csum], 32		\n\
> > +			roriw	%[fold_temp], %[csum], 16	\n\
> > +			addw	%[csum], %[fold_temp], %[csum]	\n\
> > +			andi	%[offset], %[offset], 1		\n\
> > +			beq	%[offset], zero, %l[end]	\n\
> > +			rev8	%[csum], %[csum]		\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			: [offset] "r" (offset)
> > +			:
> > +			: end);
> > +
> > +		return (csum << 16) >> 48;
> > +#endif /* !CONFIG_32BIT */
> > +end:
> > +		return csum >> 16;
> > +	}
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> > +	csum += ror64(csum, 32);
> > +	csum >>= 32;
> > +#endif
> > +	csum = (u32)csum + ror32((u32)csum, 16);
> > +	if (offset & 1)
> > +		return (u16)swab32(csum);
> > +	return csum >> 16;
> > +}
> > +
> > +/*
> > + * Does not perform alignment, should only be used if machine has fast
> > + * misaligned accesses, or when buff is known to be aligned.
> > + */
> > +static inline unsigned int do_csum_no_alignment(const unsigned char *buff,
> > int len)
> > +{
> > +	unsigned long csum, data;
> > +	const unsigned long *ptr;
> > +
> 
> kasan_check_read() missing here.
> 
> > +	ptr = (const unsigned long *)(buff);
> > +
> > +	data = *(ptr++);
> > +
> > +	csum = do_csum_common(ptr, buff, len, data);
> > +
> > +	/*
> > +	 * Zbb support saves 6 instructions, so not worth checking without
> > +	 * alternatives if supported
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		unsigned long fold_temp;
> > +
> > +		/*
> > +		 * Zbb is likely available when the kernel is compiled with Zbb
> > +		 * support, so nop when Zbb is available and jump when Zbb
> > is
> > +		 * not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +				  :
> > +				  :
> > +				  :
> > +				  : no_zbb);
> > +
> > +#ifdef CONFIG_32BIT
> > +		asm (".option push				\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 16	\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			:
> > +			: );
> > +
> > +#else /* !CONFIG_32BIT */
> > +		asm (".option push				\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 32	\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +			srli	%[csum], %[csum], 32		\n\
> > +			roriw	%[fold_temp], %[csum], 16	\n\
> > +			addw	%[csum], %[fold_temp], %[csum]	\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			:
> > +			: );
> > +#endif /* !CONFIG_32BIT */
> > +		return csum >> 16;
> > +	}
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> > +	csum += ror64(csum, 32);
> > +	csum >>= 32;
> > +#endif
> > +	csum = (u32)csum + ror32((u32)csum, 16);
> > +	return csum >> 16;
> > +}
> 
> The algorithm part looks good to me.
> 
> BRs,
> Xiao
> 
> > +
> > +/*
> > + * Perform a checksum on an arbitrary memory address.
> > + * Will do a light-weight address alignment if buff is misaligned, unless
> > + * cpu supports fast misaligned accesses.
> > + */
> > +unsigned int do_csum(const unsigned char *buff, int len)
> > +{
> > +	if (unlikely(len <= 0))
> > +		return 0;
> > +
> > +	/*
> > +	 * Significant performance gains can be seen by not doing alignment
> > +	 * on machines with fast misaligned accesses.
> > +	 *
> > +	 * There is some duplicate code between the "with_alignment" and
> > +	 * "no_alignment" implmentations, but the overlap is too awkward to
> > be
> > +	 * able to fit in one function without introducing multiple static
> > +	 * branches. The largest chunk of overlap was delegated into the
> > +	 * do_csum_common function.
> > +	 */
> > +	if (static_branch_likely(&fast_misaligned_access_speed_key))
> > +		return do_csum_no_alignment(buff, len);
> > +
> > +	if (((unsigned long)buff & OFFSET_MASK) == 0)
> > +		return do_csum_no_alignment(buff, len);
> > +
> > +	return do_csum_with_alignment(buff, len);
> > +}
> > 
> > --
> > 2.34.1
> 
