Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC1812A90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjLNIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:40:55 -0500
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A76DE3;
        Thu, 14 Dec 2023 00:41:02 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35f833adaa6so346865ab.3;
        Thu, 14 Dec 2023 00:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543261; x=1703148061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQbR2JO/KFK5RF93JUmmx4V523VsDvrN1w2XiDVyh7c=;
        b=sC6+OGtMVPBf3BeuD1kktIfv9O3ogQa/33PK13qGxHjte53nFKFKF65vX7UdqExZHQ
         O/wlnENRDg4sofnJ1+B1ZTcFeIbwsnTcKmCbLzuQzcHerpc/J/Ws3uKg0MhPllgUBza7
         or9abWiXWgmSa3e7nEvAJgX94Agc5OsFRC2u2An0sEc1zf5RGI2sl3axiBM0UVEmVMTr
         iNIy6qJJaudPInvNtLyzGCH81tAkr4lueKPTFGidS0HfU9JDS9Lvg2uD+YXK6Bd1KvfY
         v7D1o7v2RBHmUc26OhUGZQToa0e1Uwiwqy5Ebp+FXa7gEtW+WMysOcWgFMUrjeERomTq
         AN0Q==
X-Gm-Message-State: AOJu0YziyXunf8HNNebY+uV4VVNMDIrDq+3v9mnv1eqVs/9iirU2CrQe
        kKBDpNo9FMLd0PibiBPu1/M=
X-Google-Smtp-Source: AGHT+IHTijws84bT+t+wUZlzE5DTLKpXqSjvyPgKeN8xOqYkuQ5p52nrDNR5ore1Nt4kSFPYClVCrA==
X-Received: by 2002:a05:6e02:1c4d:b0:35f:7629:87d3 with SMTP id d13-20020a056e021c4d00b0035f762987d3mr2870814ilg.43.1702543261164;
        Thu, 14 Dec 2023 00:41:01 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709026b0200b001cfad034756sm11747930plk.138.2023.12.14.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:41:00 -0800 (PST)
Date:   Thu, 14 Dec 2023 00:40:58 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] riscv: Enable percpu page first chunk allocator
Message-ID: <ZXq/msjihOEZAo3w@snowbird>
References: <20231212213457.132605-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212213457.132605-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 12, 2023 at 10:34:55PM +0100, Alexandre Ghiti wrote:
> While working with pcpu variables, I noticed that riscv did not support
> first chunk allocation in the vmalloc area which may be needed as a fallback
> in case of a sparse NUMA configuration.
> 
> patch 1 starts by introducing a new function flush_cache_vmap_early() which
> is needed since a new vmalloc mapping is established and directly accessed:
> on riscv, this would likely fail in case of a reordered access or if the
> uarch caches invalid entries in TLB.
> Note that most architectures do not include asm-generic/cacheflush.h so to
> avoid build failures, this patch implements the new function on each of
> those architectures. For all architectures except riscv, this new function
> is implemented as a no-op to keep the existing behaviour but it likely
> needs another implementation.
> 
> patch 2 simply enables the page percpu first chunk allocator in riscv.
> 
> Changes in v2:
> - Rebase on top of 6.7
> - Define flush_cache_vmap_early() for all architectures that do
>   not include <asm-generic/cacheflush.h> to avoid build failures
> 
> Alexandre Ghiti (2):
>   mm: Introduce flush_cache_vmap_early()
>   riscv: Enable pcpu page first chunk allocator
> 
>  arch/arc/include/asm/cacheflush.h      | 1 +
>  arch/arm/include/asm/cacheflush.h      | 2 ++
>  arch/csky/abiv1/inc/abi/cacheflush.h   | 1 +
>  arch/csky/abiv2/inc/abi/cacheflush.h   | 1 +
>  arch/m68k/include/asm/cacheflush_mm.h  | 1 +
>  arch/mips/include/asm/cacheflush.h     | 2 ++
>  arch/nios2/include/asm/cacheflush.h    | 1 +
>  arch/parisc/include/asm/cacheflush.h   | 1 +
>  arch/riscv/Kconfig                     | 2 ++
>  arch/riscv/include/asm/cacheflush.h    | 3 ++-
>  arch/riscv/include/asm/tlbflush.h      | 1 +
>  arch/riscv/mm/kasan_init.c             | 8 ++++++++
>  arch/riscv/mm/tlbflush.c               | 5 +++++
>  arch/sh/include/asm/cacheflush.h       | 1 +
>  arch/sparc/include/asm/cacheflush_32.h | 1 +
>  arch/sparc/include/asm/cacheflush_64.h | 1 +
>  arch/xtensa/include/asm/cacheflush.h   | 6 ++++--
>  include/asm-generic/cacheflush.h       | 6 ++++++
>  mm/percpu.c                            | 8 +-------
>  19 files changed, 42 insertions(+), 10 deletions(-)
> 
> -- 
> 2.39.2
> 

Thanks for the quick v2. Applied to percpu#for-6.8.

Thanks,
Dennis
