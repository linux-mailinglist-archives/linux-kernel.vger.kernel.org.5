Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE4797A86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbjIGRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjIGRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:43:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5E1FFE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:43:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c09673b006so9257145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694108606; x=1694713406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7AODGgzjO594taBwmHKz6HitKdIGx7cKUiDd5WwWPc=;
        b=NBiRH0PtHB759doUtfXMruZXaMZbJX2QHphIr4KIhAc2SPNtrL4ueL8xTeqmdMhmD2
         g4rbTAqcW3lIUsp1AldWcRSCMNU8nXh2Rjv4D/PSio6n5eXFvD/at6xLJ1v/L1FTFm87
         n8SPE4BxaZN0ttmVPW+5ZVQvoRs0p3FVyGi0iyooda0B7OCUgC7b2jzrTNdhvHVVViGS
         HUHn25VgJgIeLpsFJmmEdVZOE+SBCN5kvVBeoBUsF++RXYRr6iaS1xmTnDPR73CDdzEj
         PKIsjN6Iz/73OGR9CO93EdR3wRyq+FyCA5S4Yf2gGrmTontJ+PFF5ITLMV5bw8vf7TYH
         9Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108606; x=1694713406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7AODGgzjO594taBwmHKz6HitKdIGx7cKUiDd5WwWPc=;
        b=dqy6kl0Xy6bXcy5gFcw9zOJYouhgXmHwOaAEy711WqExVklHPugoruk64hXvMjTH/b
         0d+iSy85N1kuzb7PviOOz3pUEsRj/Xx8tqgaODiAYSTzWHbg+/SconMUygKO9eVJzl1v
         15hpLztPua93/Cum+Mt0aU7gToSIFriuTGBlCTMk2eOXe75f+EeHeqcBl8wyvd0E5lXt
         YRI+F5hRvQSZiydXMQnY5s+S1rHO2Ze7kOYeLCjPnRyiVVP+mJRoBO0scv3uSE+z4y+N
         tgIUrsXOw6WQWvcMJBtHbOIi4yg+v3kmDPyt/IIfHuBZP03i4uBsf6rpjy8skM5kq/GW
         CHZA==
X-Gm-Message-State: AOJu0Yw0Ehg3xEpMM0UGUnxSwLp31kqdI3xdpYYK2h8MikRIzjhx1aMv
        EkrH0yqS3kYeZPHMFLzDFjy9nLfrAhG8eqo64+s=
X-Google-Smtp-Source: AGHT+IELdY5HocWspofgUiKEy8mrH49mxLIfYe85ETbBPjkDw6EA7nQSGCz0/uIln6eL4c/jCu1RhA==
X-Received: by 2002:a17:902:d4cf:b0:1bd:c338:ae14 with SMTP id o15-20020a170902d4cf00b001bdc338ae14mr409104plg.12.1694108605904;
        Thu, 07 Sep 2023 10:43:25 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:84f6:5055:9180:822])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709028c8800b001b80d399730sm34077plo.242.2023.09.07.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:43:25 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:43:22 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 3/5] riscv: Vector checksum header
Message-ID: <ZPoLuvJooH4W4IGA@ghost>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
 <20230907-c23868a1016a17299a470120@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-c23868a1016a17299a470120@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:47:55AM +0100, Conor Dooley wrote:
> On Tue, Sep 05, 2023 at 09:46:52PM -0700, Charlie Jenkins wrote:
> > Vector code is written in assembly rather than using the GCC vector
> > instrinsics because they did not provide optimal code. Vector
> > instrinsic types are still used so the inline assembly can
> > appropriately select vector registers. However, this code cannot be
> > merged yet because it is currently not possible to use vector
> > instrinsics in the kernel because vector support needs to be directly
> > enabled by assembly.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 87 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > index 3f9d5a202e95..1d6c23cd1221 100644
> > --- a/arch/riscv/include/asm/checksum.h
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -10,6 +10,10 @@
> >  #include <linux/in6.h>
> >  #include <linux/uaccess.h>
> >  
> > +#ifdef CONFIG_RISCV_ISA_V
> > +#include <riscv_vector.h>
> > +#endif
> > +
> >  #ifdef CONFIG_32BIT
> >  typedef unsigned int csum_t;
> >  #else
> > @@ -43,6 +47,89 @@ static inline __sum16 csum_fold(__wsum sum)
> >   */
> >  static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> >  {
> > +#ifdef CONFIG_RISCV_ISA_V
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		/*
> > +		 * Vector is likely available when the kernel is compiled with
> > +		 * vector support, so nop when vector is available and jump when
> > +		 * vector is not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_vector]", "nop", 0,
> > +					      RISCV_ISA_EXT_v, 1)
> > +				  :
> > +				  :
> > +				  :
> > +				  : no_vector);
> > +	} else {
> > +		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v))
> > +			goto no_vector;
> > +	}
> 
> Silly question maybe, but is this complexity required?
> If you were to go and do
> 	if (!has_vector())
> 		goto no_vector
> is there any meaningful difference difference in performance?
Yes I should use that instead.
> 
> 
> > +
> > +	vuint64m1_t prev_buffer;
> > +	vuint32m1_t curr_buffer;
> > +	unsigned int vl;
> > +#ifdef CONFIG_32_BIT
> > +	csum_t high_result, low_result;
> > +
> > +	riscv_v_enable();
> > +	asm(".option push						\n\
> > +	.option arch, +v						\n\
> > +	vsetivli x0, 1, e64, ta, ma					\n\
> > +	vmv.v.i %[prev_buffer], 0					\n\
> > +	1:								\n\
> > +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
> > +	vle32.v %[curr_buffer], (%[iph])				\n\
> > +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
> > +	sub %[ihl], %[ihl], %[vl]					\n\
> > +	slli %[vl], %[vl], 2						\n\
> 
> Also, could you please try to align the operands for asm stuff?
> It makes quite a difference to readability.
> 
> Thanks,
> Conor.
> 
Will do.

- Charlie
> > +	add %[iph], %[vl], %[iph]					\n\
> > +	# If not all of iph could fit into vector reg, do another sum	\n\
> > +	bne %[ihl], zero, 1b						\n\
> > +	vsetivli x0, 1, e64, m1, ta, ma					\n\
> > +	vmv.x.s %[low_result], %[prev_buffer]				\n\
> > +	addi %[vl], x0, 32						\n\
> > +	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
> > +	vmv.x.s %[high_result], %[prev_buffer]				\n\
> > +	.option pop"
> > +	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
> > +		[curr_buffer] "=&vd" (curr_buffer),
> > +		[high_result] "=&r" (high_result),
> > +		[low_result] "=&r" (low_result)
> > +	: [iph] "r" (iph), [ihl] "r" (ihl));
> > +	riscv_v_disable();
> > +
> > +	high_result += low_result;
> > +	high_result += high_result < low_result;
> > +#else // !CONFIG_32_BIT
> > +	csum_t result;
> > +
> > +	riscv_v_enable();
> > +	asm(".option push						\n\
> > +	.option arch, +v						\n\
> > +	vsetivli x0, 1, e64, ta, ma					\n\
> > +	vmv.v.i %[prev_buffer], 0					\n\
> > +	1:								\n\
> > +	# Setup 32-bit sum of iph					\n\
> > +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
> > +	vle32.v %[curr_buffer], (%[iph])				\n\
> > +	# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
> > +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]     \n\
> > +	subw %[ihl], %[ihl], %[vl]					\n\
> > +	slli %[vl], %[vl], 2						\n\
> > +	addw %[iph], %[vl], %[iph]					\n\
> > +	# If not all of iph could fit into vector reg, do another sum	\n\
> > +	bne %[ihl], zero, 1b						\n\
> > +	vsetvli x0, x0, e64, m1, ta, ma					\n\
> > +	vmv.x.s %[result], %[prev_buffer]				\n\
> > +	.option pop"
> > +	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
> > +		[curr_buffer] "=&vd" (curr_buffer), [result] "=&r" (result)
> > +	: [iph] "r" (iph), [ihl] "r" (ihl));
> > +	riscv_v_disable();
> > +#endif // !CONFIG_32_BIT
> > +no_vector:
> > +#endif // !CONFIG_RISCV_ISA_V
> > +
> >  	csum_t csum = 0;
> >  	int pos = 0;
> >  
> > 
> > -- 
> > 2.42.0
> > 


