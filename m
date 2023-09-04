Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FB7791E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjIDUWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:22:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC05184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:22:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso763539a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693858954; x=1694463754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sE+FlBZ0KYIiVYmRnx2Za3tZtM1vnyzitJj3+gSyToE=;
        b=W2wzArlgb94U8b0OhoVbEfAHnmw+pRO1klu7dZD/CX1tSKvPp4mxJ1L2CqJnwqzF/z
         8AafEubGdYbnJWxy0jZT0Bw6ZE0tQLclRqopURAzNtwRpMs5hdCnRi4uyxSIOZc5nEIA
         nGC32bQbjkNbZDW5xC5aI5QzTF77K8FUiVsypqZdshDGrxxFDD2+Otlar7Erlr6lY8dD
         OQhPMnpoyVB1jN4+Gv8+c+iJ7MHCGUn3VljjJ3P94yNS8fZjldEqrcuxsPBnAh2OsEEN
         wZYoWLnydPKNswypTZAPQPFf3ZOFDhqmwjqmPGVGLK7F75fJFZ/UaDgW9e6FkzbcJGhk
         R0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693858954; x=1694463754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE+FlBZ0KYIiVYmRnx2Za3tZtM1vnyzitJj3+gSyToE=;
        b=YYz39C87hHf7KsYpPCEwrfa5AActfJ5vsTcnbFUmxeDnc/EacZ773rpBEG+Y2BmSA0
         nS0EA/cLxoKL9wTlt4v9GbSS39Q4IDhbQsbRv1UyTCxFQSSVg5lNnXhks7nWUNbsYByf
         /SWDNreG+iDrQ0dS3eJcGzitfHk/3dqB0fB5M2nHEOCOpOhy1eMdWWKIVxnLfKgJXqco
         b06y6i/uxQn0VNTbgVvibhCksM+AM0oDVVnV8DdFEbhjhzOZSswiBMXnLy18OFNUJdo3
         4XD51BpyUIYNQGRDUypGQzWC0QFQ6zD6bMk5qB5NGJ7HnObVmMK1OliAVsLQhq/bdVZx
         EiRw==
X-Gm-Message-State: AOJu0YwYsvnoTeI074/D2rNtUNk/bsahl5xv0cxJkqsy4a32PBP9p1zz
        LDdC+MPCGNQxP9zCk14iqq4c9w==
X-Google-Smtp-Source: AGHT+IHKDIdLfsv7nmFqSNCjsF2ZBWBdJsYxqF8mF/BfAWpu96P9iOb0N9jOCanVylwHFYXu1I1mqQ==
X-Received: by 2002:a05:6a21:6d9f:b0:13a:43e8:3fa6 with SMTP id wl31-20020a056a216d9f00b0013a43e83fa6mr10844133pzb.23.1693858954385;
        Mon, 04 Sep 2023 13:22:34 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:5de2:2323:20de:e26d])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001b8b2fb52d4sm7894454plf.203.2023.09.04.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 13:22:33 -0700 (PDT)
Date:   Mon, 4 Sep 2023 13:22:32 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: update T-Head memory type definitions
Message-ID: <ZPY8iB6BV9wXTqPV@x1>
References: <20230827090644.1318-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827090644.1318-1-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:06:44PM +0800, Jisheng Zhang wrote:
> Update T-Head memory type definitions according to C910 doc [1]
> For NC and IO, SH property isn't configurable, hardcoded as SH,
> so set SH for NOCACHE and IO.
> 
> And also set bit[61](Bufferable) for NOCACHE according to the
> table 6.1 in the doc [1].
> 
> Link: https://github.com/T-head-Semi/openc910 [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7a5097202e15..9a2c780a11e9 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -126,14 +126,18 @@ enum napot_cont_order {
>  
>  /*
>   * [63:59] T-Head Memory Type definitions:
> - *
> - * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + * bit[63] SO - Strong Order
> + * bit[62] C - Cacheable
> + * bit[61] B - Bufferable
> + * bit[60] SH - Shareable
> + * bit[59] Sec - Trustable
> + * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
>   * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
> - * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
> -#define _PAGE_NOCACHE_THEAD	0UL
> -#define _PAGE_IO_THEAD		(1UL << 63)
> +#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
> +#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
>  #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>  
>  static inline u64 riscv_page_mtmask(void)
> -- 
> 2.40.1
> 

Tested-by: Drew Fustini <dfustini@baylibre.com>

I applied this on top of:

 [1] riscv: errata: improve T-Head CMO
 [2] riscv: dts: thead: set dma-noncoherent to soc bus
 [3] RISC-V: Add basic eMMC support for BeagleV Ahead 

The BeagleV Ahead eMMC continues to function okay in ADMA mode after
this patch was applied.

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/20230827090813.1353-1-jszhang@kernel.org/
[2] https://lore.kernel.org/linux-riscv/ZOIBQI3L4kP7c%2FT1@xhacker/
[3] https://lore.kernel.org/linux-riscv/20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com/
