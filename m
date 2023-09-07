Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAB797A92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbjIGRpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbjIGRpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:45:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE81FEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:44:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68e403bb448so587477b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694108675; x=1694713475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCtqJ2v90gtNEyhzR2bE+oo8HzdMCZa9CshpcYdMP5Q=;
        b=BUq6ztAa8NQ+SndwmqcXAU48MQEvB26zONT/GQ4z2iS/yODLs4y/ftgQel4/R2eiYM
         TbUE747pcKCTKSIsu2nQLSNnb9tJSQW/a4OaKU1EB5A4Z7ZbN/3FHaJsNdEHzVbTGKTE
         lyiyb4z1SwCsm+BBP0hghKuJsBZ+7TnWSfWu1EBCY16II/fM1TlZy+BotLfFFu+B139Q
         /OxzqzIW1+ZiR7Qe3KXin+bOkbyvq0VwcKOxrZNusHOvp2Nw9nF6PreaDZ0CPjpco7Jp
         L2XUdQHKoXNtdC55z3PtKkfsnKxZof2CBqYea2nvBT9qxm/xWWrSJ4BnkbU8WDHMRPil
         XpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108675; x=1694713475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCtqJ2v90gtNEyhzR2bE+oo8HzdMCZa9CshpcYdMP5Q=;
        b=qN5q+vooBkD+U6zpj0nNagSzfL98RmwJeYxMp/Cqv0xhUk2X5HsCUWx+5jUE5gwE0I
         SbSmHZ6aRpg78S1s25XdqbXZCbP73JemKpWUWZxzCyRS3LMMj7qh5jwDSN1mkboG9iom
         1rfIb0XxLGPUDi3I6NgsdBm4eJqOMF0aSJrjoIcEdwdQ7LESH7lCYl5pAw9nfNv+CJd/
         G0Z1xE7TOZifecwr+kz/wg7pmR+VY4KRFhAnRKGE2VAkN2xYfv6RK3UIAmuCWenImQaL
         BYj59uqrey/WIMHu4E/ntAxozl63b7/kNmmTvXpKIVV1FLlDpdM7bGcHnhj6ELUgmXee
         n1fg==
X-Gm-Message-State: AOJu0YxsIG1Fq8fwSFrL4i5dDXEvDyc2g9SlQ7AKE1e+U5uN4dTPB2D0
        0hzClfkT6KvWumRPpl+UlxfT5Q==
X-Google-Smtp-Source: AGHT+IGKlJ3xnjimABZZjw0izpcyGAzZhRB7XVrLYIALIqu7KjiK8LMDFOXECqHizN0cOMXuOlhPvA==
X-Received: by 2002:a05:6a00:14c2:b0:68b:e8b8:b9ee with SMTP id w2-20020a056a0014c200b0068be8b8b9eemr141311pfu.11.1694108675570;
        Thu, 07 Sep 2023 10:44:35 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:84f6:5055:9180:822])
        by smtp.gmail.com with ESMTPSA id c14-20020aa781ce000000b00687dde8ae5dsm5944pfn.154.2023.09.07.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:44:35 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:44:32 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/5] riscv: Checksum header
Message-ID: <ZPoMAGYlIxPZsE7+@ghost>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-1-ccd658db743b@rivosinc.com>
 <20230907-f8c8993dbeb24d5ea5310ec7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-f8c8993dbeb24d5ea5310ec7@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:40:54AM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> Just a passing thought that I can't really test since I am meant to be
> on holidays...
> 
> On Tue, Sep 05, 2023 at 09:46:50PM -0700, Charlie Jenkins wrote:
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 96 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..573714b9ea15
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,96 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * IP checksum routines
> > + *
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#ifndef __ASM_RISCV_CHECKSUM_H
> > +#define __ASM_RISCV_CHECKSUM_H
> > +
> > +#include <linux/in6.h>
> > +#include <linux/uaccess.h>
> > +
> > +#ifdef CONFIG_32BIT
> > +typedef unsigned int csum_t;
> > +#else
> > +typedef unsigned long csum_t;
> > +#endif
> > +
> > +/*
> > + *	Fold a partial checksum without adding pseudo headers
> > + */
> > +static inline __sum16 csum_fold(__wsum sum)
> > +{
> > +	sum += (sum >> 16) | (sum << 16);
> > +	return (__force __sum16)(~(sum >> 16));
> > +}
> > +
> > +#define csum_fold csum_fold
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> > + * @iph is assumed to be word aligned.
> > + */
> > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > +{
> > +	csum_t csum = 0;
> > +	int pos = 0;
> > +
> > +	do {
> > +		csum += ((const unsigned int *)iph)[pos];
> > +#ifdef CONFIG_32BIT
> > +		csum += csum < ((const unsigned int *)iph)[pos];
> > +#endif // !CONFIG_32BIT
> 
> Some of this ifdeffery really should become IS_ENABLED(), there's
> nothing in some of them that can't just get removed by the compiler.
> 
> > +	} while (++pos < ihl);
> > +
> > +#ifdef CONFIG_RISCV_ISA_ZBB
> 
> This here I can't test since I'm supposed to be AFK, but can this also
> be an IS_ENABLED()? I know it is guarding code that the toolchain may
> not support, but does it get removed before that matters?
> 
> I mainly ask because there's a host of ifdeffery here & the code would
> be a lot easier to understand if we could cut it down to a minimum.
> 
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		csum_t fold_temp;
> > +
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +		    :
> > +		    :
> > +		    :
> > +		    : no_zbb);
> > +#ifdef CONFIG_32BIT
> > +		asm(".option push				\n\
> > +		.option arch,+zbb				\n\
> > +			rori %[fold_temp],%[csum],16		\n\
> > +			add %[csum],%[fold_temp],%[csum]	\n\
> > +		.option pop"
> > +		: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +#else // !CONFIG_32BIT
> > +		asm(".option push				\n\
> > +		.option arch,+zbb				\n\
> > +		    rori %[fold_temp], %[csum], 32		\n\
> > +		    add %[csum], %[fold_temp], %[csum]		\n\
> > +		    srli %[csum], %[csum], 32			\n\
> > +		    roriw %[fold_temp], %[csum], 16		\n\
> > +		    addw %[csum], %[fold_temp], %[csum]		\n\
> > +		.option pop"
> > +		: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +#endif // !CONFIG_32BIT
> 
> These 3 I think are pretty easy to follow immediately, but...
> 
> > +		return ~(csum >> 16);
> > +	}
> > +	/*
> > +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > +	 * worth checking if supported without Alternatives.
> > +	 */
> > +no_zbb:
> > +#endif // CONFIG_RISCV_ISA_ZBB
> > +#ifdef CONFIG_32BIT
> > +#else // !CONFIG_32BIT
> > +	csum += (csum >> 32) | (csum << 32);
> > +	csum >>= 16;
> > +#endif // !CONFIG_32BIT
> 
> ...these ones here could be converted too, afaict.
> 
> Thanks,
> Conor.
> 
That should make it look much cleaner, I will switch over to IS_ENABLED.

- Charlie
> > +	return csum_fold((__force __wsum)csum);
> > +}
> > +
> > +#define ip_fast_csum ip_fast_csum
> > +
> > +#include <asm-generic/checksum.h>
> > +
> > +#endif // __ASM_RISCV_CHECKSUM_H
> > 
> > -- 
> > 2.42.0
> > 


