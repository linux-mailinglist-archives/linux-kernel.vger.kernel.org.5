Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAF7DE504
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbjKARIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKARIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:08:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813911D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:08:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so82716b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698858480; x=1699463280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0jwxtV8BjEMUKr1MCcns6yw/2htCkE6khzyLyRHgjw=;
        b=mTVq5OAu6OonZPzRPs+CSEcgQCT+ccAR3TUREAcbl8+3KOfs6pf5Yu+pw4VhvN+85b
         TTchIc5VgCsFUrjnGvziP6MdaTR2aSC2rcHToAL/Mw8Ygp/0yWxioBoNMiMJK9W8LHvT
         8KHynayFm9Pu/XEVD1huPJX+X/DlSxsTAMVsaPlcTMWYyD7y20SxKe/Psa8VQGagf5LL
         fYKDqDnQ3J6KLqQhciptf4oeMCV5HQzBckA22VJAsU6hnU/ZxdkmB3PF07eb2/BAmdcD
         lOXpre+WnYyBHzcm+J6xO9XC3p/pVMCAd9ou8lTJqxnZPNWJ/qvA9WSfhUP0eGfpiFmQ
         Et3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858480; x=1699463280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0jwxtV8BjEMUKr1MCcns6yw/2htCkE6khzyLyRHgjw=;
        b=PkDk0Z5fizVpcPEqRN684EZM6Sqdjz+/FtuFxpBySS3HS6LcfPOhw7QB2VPYVMYTPP
         iwm1Ok0buzh7Kg/8urA1UbbS9RpCQLJ06/ibG6qd4K+O1guwsKSoHjcWcmYgyqx3BCKc
         xaqtF2X5PEBpu/n7tlbpGlP0U2t8faAvenvayJFEM35ZaxcTdSNMulYQI39yTvqXCqFt
         tUbfjSIn/I4IMbcsCTYYCG/tLPKKNnCG1HlDVa+lKMimiD0bCCe9Y0TmZlTxtB9zaZrb
         Px6e0LLLagPdAQjDu1L7W7ZM6PZviktUmmn9zbKouWi5e8IKK0i+vV7mIS7IRh3C0rq3
         5PwA==
X-Gm-Message-State: AOJu0YyJijJ9qhwycqu4zKbadCjWoj3F9bxxLOP59Fnd2d8xHgBuD7n7
        Vl9KctZq6Ui44w7AvL8BIPkKoA==
X-Google-Smtp-Source: AGHT+IHK0new2RJGuOMeOg1bLtg3GxGg8z52nEHawRrwA8m5jo+bIus/3hti+RsRerMj5i2NpV0hmQ==
X-Received: by 2002:a05:6a20:1383:b0:17a:fa76:805f with SMTP id hn3-20020a056a20138300b0017afa76805fmr13731659pzc.23.1698858479847;
        Wed, 01 Nov 2023 10:07:59 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t9-20020aa79389000000b00694ebe2b0d4sm1494135pfe.191.2023.11.01.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:07:59 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:07:56 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 3/5] riscv: Checksum header
Message-ID: <ZUKF7PDn4wZZ/2jc@ghost>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231031-optimize_checksum-v9-3-ea018e69b229@rivosinc.com>
 <ZUJtTEeFD24ZYXHQ@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUJtTEeFD24ZYXHQ@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:22:52PM +0800, Jisheng Zhang wrote:
> On Tue, Oct 31, 2023 at 05:18:53PM -0700, Charlie Jenkins wrote:
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 81 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..3d77cac338fe
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Checksum routines
> > + *
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#ifndef __ASM_RISCV_CHECKSUM_H
> > +#define __ASM_RISCV_CHECKSUM_H
> > +
> > +#include <linux/in6.h>
> > +#include <linux/uaccess.h>
> > +
> > +#define ip_fast_csum ip_fast_csum
> > +
> > +/* Define riscv versions of functions before importing asm-generic/checksum.h */
> > +#include <asm-generic/checksum.h>
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> > + * @iph is assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
> > + *	riscv, defining IP headers to be aligned.
> > + */
> > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > +{
> > +	unsigned long csum = 0;
> > +	int pos = 0;
> > +
> > +	do {
> > +		csum += ((const unsigned int *)iph)[pos];
> > +		if (IS_ENABLED(CONFIG_32BIT))
> > +			csum += csum < ((const unsigned int *)iph)[pos];
> > +	} while (++pos < ihl);
> > +
> > +	/*
> > +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > +	 * worth checking if supported without Alternatives.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		unsigned long fold_temp;
> > +
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> 
> This looks like a open coding of riscv_has_extension_*, so if
> we use the it, the code could be rewritten as:
> 
> 	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
> 		if (32bit) {
> 			asm(...)
> 
> 		} else {
> 			asm(...)
> 		}
> 		return csum >> 16;
> 	}
> #ifndef CONFIG_32BIT
> 	csum += ror64(csum, 32);
> 	csum >>= 32;
> #endif
> 	return csum_fold((__force __wsum)csum);
> 
> The code readability is improved and make it a bit easier to refactor
> the asm(...) code in the future.
> 
> And IMHO, the generated code should be the same.
> 
> Thanks

It is unfortunately not the same. riscv_has_extension_likely checks at
runtime for ZBB if alternatives is not supported. That is why the
comment is there. I can reference riscv_has_extension_likely to avoid
confusion.

- Charlie

> 
> >
> 
> > +		    :
> > +		    :
> > +		    :
> > +		    : no_zbb);
> > +
> > +		if (IS_ENABLED(CONFIG_32BIT)) {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				not	%[fold_temp], %[csum]		\n\
> > +				rori	%[csum], %[csum], 16		\n\
> > +				sub	%[csum], %[fold_temp], %[csum]	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		} else {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				rori	%[fold_temp], %[csum], 32	\n\
> > +				add	%[csum], %[fold_temp], %[csum]	\n\
> > +				srli	%[csum], %[csum], 32		\n\
> > +				not	%[fold_temp], %[csum]		\n\
> > +				roriw	%[csum], %[csum], 16		\n\
> > +				subw	%[csum], %[fold_temp], %[csum]	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		}
> > +		return csum >> 16;
> > +	}
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> > +	csum += ror64(csum, 32);
> > +	csum >>= 32;
> > +#endif
> > +	return csum_fold((__force __wsum)csum);
> > +}
> > +
> > +#endif /* __ASM_RISCV_CHECKSUM_H */
> > 
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
