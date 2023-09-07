Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67253797A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjIGRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjIGRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:42:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD21710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:41:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56a8794b5adso921064a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694108487; x=1694713287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyb/Hvp8ra+4Pq/salkMBHtDnyRnI+Xyajrk0WeNia0=;
        b=HyTSa0gQlVoSIn+dk7R2SWVPcVXxoN5tsJyHdqCpGQkb2PmW+5cAC+K06zUDLoNv+F
         VRQpfU83tlOH5TaZrxUkr9EZPsYrbwoskyVM+zay6WPlafguz8LKyLmHgU2SznrXWFeL
         d7TL5UxU057ZS2YlVFORyBbtzuWDzKOma3irnxsZ9uhQ73o19AiRulgwPNud5mmqz+wZ
         ivQNBu5kUuF/WgvzGMEXOI23VTVCMlYh5w8N728XuJBKHyFMKJWfatB9Og23eJaBjvb9
         wA3N7MYdw4h7n3EFtSO3oqxrTYZvGegfuAuTl5Oh3N5ZXTDW+TgfhvOIFjS2CF8xhH2+
         oSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108487; x=1694713287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyb/Hvp8ra+4Pq/salkMBHtDnyRnI+Xyajrk0WeNia0=;
        b=Iy4GW5XG0x5d2nChI2oEqyV64aUE7o4zVTyO1Fkw4XgN6KH5Oiu5Xrgg5bXMBVpJYf
         D7UGmDghule8pTlHvKkqn1fxUrZoBSxg382RBup45/LyWxHEFuz/+OfT68j898x8waNg
         8QcNwCt128EUGtDJ2O6qgPANmX+rmD20hC6NEjiv6EniNf9SSsb//4l1hSbzv7tRQHvB
         RbVt3j9ejmeoAcl8y1Ey/G8YttM9bqyJ6WeQhZlZ4lMSFnozKP9YO5hQIPBxLaIt8Jig
         8O0Sz6q1/h2hC0ixv4kSkLjLCO4zFmQzkyZ7Clxz6da+HBexWXFPWv3DEJsML1jT/iw+
         4UNQ==
X-Gm-Message-State: AOJu0YxQsaKZM/9iw4JHPB0FEVtWz390a9U9meGftAGkxSg5b1A5CoDN
        Tih2t85Ay7DVjYZzRr1Ih1tagA==
X-Google-Smtp-Source: AGHT+IFvDm8mz7Low6dBUvkjvj/lz5WUHFf8+8LRuNq7GK2l8guCa7XwJvozegie9iJnbfGy1IaXUw==
X-Received: by 2002:a17:90a:289:b0:262:fc8a:ed1 with SMTP id w9-20020a17090a028900b00262fc8a0ed1mr290995pja.44.1694108487747;
        Thu, 07 Sep 2023 10:41:27 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:84f6:5055:9180:822])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a005d00b0026d4100e0e8sm1845358pjb.10.2023.09.07.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:41:27 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:41:24 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 3/5] riscv: Vector checksum header
Message-ID: <ZPoLRHq07Ttgf7rj@ghost>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
 <20230907-6ed9570259e770b6a472ee61@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-6ed9570259e770b6a472ee61@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:58:33AM +0100, Conor Dooley wrote:
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
> 
> Also, I don't see that you have addressed previous review comments from
> Samuel:
> https://lore.kernel.org/linux-riscv/0a8c98bf-46da-e77a-0431-a6c1e224af2e@sifive.com/
I added the check for vector as Samuel suggested, but then I
accidentally used riscv_v_enable() instead of kernel_vector_begin(), I
will make that change.

- Charlie
