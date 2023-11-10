Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53E37E8110
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbjKJSXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 13:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbjKJSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:21:13 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AF2B7CC;
        Fri, 10 Nov 2023 01:24:59 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5bf5d6eaf60so17754297b3.2;
        Fri, 10 Nov 2023 01:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608298; x=1700213098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmyygXGlWqHLIcYJDnrqzZMuJVEgqUclqA12kn4gnFE=;
        b=NiQu3GsbIMv6LSvCp8jhSgx+jRxZsbNu9V+EdBYoAEBxjHwGJzk7pJ71BfDX/UH7Wz
         ECHr3lABQC+1VZ10KOQzAZMPB8Bz5dNPcfMo1/0DVmltRYF8eUt6YUizB/FZaKCFENeQ
         TxF8D7whdKLkSABdJuZbfso8bUdVG9auUJwLIe7zW6zpA8tbd4ivo/e8U2/8/rHkcfnM
         hXx/BytyoA1ZZkKLCep3bXHW5EvrIN61PPgo69rKyn4wicbYC3w7l9C/JKfYt5V8zHUs
         B9U/G6g0+cc+lHlX9EvzVb7ekJ9NN4klXdY78jToGhtM6/yk5xM7NvIBU4bnXAM7s8cm
         EbQg==
X-Gm-Message-State: AOJu0YzIGX77uXdW2SL8+LwpzYWu+SupiR+qujqjNw3a5kjx48AIDHtl
        TLMJxfiPGuIKQTLf2z6Bxv+y6GskDiXDig==
X-Google-Smtp-Source: AGHT+IFoXrgCJRz7afFo0PwLPyK/4l+eLOmgJ+1kz5XbwTzyyUuxMlnex9ZLprOuCx2YEjtbrcBq7A==
X-Received: by 2002:a81:8305:0:b0:5a7:b973:db3c with SMTP id t5-20020a818305000000b005a7b973db3cmr8225093ywf.34.1699608298636;
        Fri, 10 Nov 2023 01:24:58 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h83-20020a816c56000000b005af9da2225bsm8481335ywc.20.2023.11.10.01.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 01:24:58 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so2038406276.1;
        Fri, 10 Nov 2023 01:24:57 -0800 (PST)
X-Received: by 2002:a25:bc90:0:b0:d9b:4a28:f66 with SMTP id
 e16-20020a25bc90000000b00d9b4a280f66mr7552303ybk.53.1699608297683; Fri, 10
 Nov 2023 01:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20231031064553.2319688-1-xiao.w.wang@intel.com> <20231031064553.2319688-3-xiao.w.wang@intel.com>
In-Reply-To: <20231031064553.2319688-3-xiao.w.wang@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Nov 2023 10:24:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
Message-ID: <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] riscv: Optimize bitops with Zbb extension
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        haicheng.li@intel.com, ajones@ventanamicro.com,
        yujie.liu@intel.com, charlie@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiao,

On Tue, Oct 31, 2023 at 7:37 AM Xiao Wang <xiao.w.wang@intel.com> wrote:
> This patch leverages the alternative mechanism to dynamically optimize
> bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> Zbb ext is not supported by the runtime CPU, legacy implementation is
> used. If Zbb is supported, then the optimized variants will be selected
> via alternative patching.
>
> The legacy bitops support is taken from the generic C implementation as
> fallback.
>
> If the parameter is a build-time constant, we leverage compiler builtin to
> calculate the result directly, this approach is inspired by x86 bitops
> implementation.
>
> EFI stub runs before the kernel, so alternative mechanism should not be
> used there, this patch introduces a macro NO_ALTERNATIVE for this purpose.
>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks for your patch, which is now commit 457926b253200bd9 ("riscv:
Optimize bitops with Zbb extension") in riscv/for-next.

> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,13 +15,261 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>
> +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
>  #include <asm-generic/bitops/__ffs.h>
> -#include <asm-generic/bitops/ffz.h>
> -#include <asm-generic/bitops/fls.h>
>  #include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/ffs.h>
> +#include <asm-generic/bitops/fls.h>
> +
> +#else
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +#if (BITS_PER_LONG == 64)
> +#define CTZW   "ctzw "
> +#define CLZW   "clzw "
> +#elif (BITS_PER_LONG == 32)
> +#define CTZW   "ctz "
> +#define CLZW   "clz "
> +#else
> +#error "Unexpected BITS_PER_LONG"
> +#endif
> +
> +static __always_inline unsigned long variable__ffs(unsigned long word)
> +{
> +       int num;
> +
> +       asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +                                     RISCV_ISA_EXT_ZBB, 1)
> +                         : : : : legacy);
> +
> +       asm volatile (".option push\n"
> +                     ".option arch,+zbb\n"
> +                     "ctz %0, %1\n"
> +                     ".option pop\n"
> +                     : "=r" (word) : "r" (word) :);
> +
> +       return word;
> +
> +legacy:
> +       num = 0;
> +#if BITS_PER_LONG == 64
> +       if ((word & 0xffffffff) == 0) {
> +               num += 32;
> +               word >>= 32;
> +       }
> +#endif
> +       if ((word & 0xffff) == 0) {
> +               num += 16;
> +               word >>= 16;
> +       }
> +       if ((word & 0xff) == 0) {
> +               num += 8;
> +               word >>= 8;
> +       }
> +       if ((word & 0xf) == 0) {
> +               num += 4;
> +               word >>= 4;
> +       }
> +       if ((word & 0x3) == 0) {
> +               num += 2;
> +               word >>= 2;
> +       }
> +       if ((word & 0x1) == 0)
> +               num += 1;
> +       return num;
> +}

Surely we can do better than duplicating include/asm-generic/bitops/__ffs.h?

E.g. rename the generic implementation to generic___ffs():

    -static __always_inline unsigned long __ffs(unsigned long word)
    +static __always_inline unsigned long generic__ffs(unsigned long word)
     {
             ...
     }

    +#ifndef __ffs
    +#define __ffs(x) generic__ffs(x)
    +#endif

and explicitly calling the generic one here?

Same comment for the other functions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
