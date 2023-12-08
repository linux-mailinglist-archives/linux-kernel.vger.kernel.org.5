Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FB809D03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjLHHRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLHHRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:17:21 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102C1728;
        Thu,  7 Dec 2023 23:17:27 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d18c224c7so882527eaf.2;
        Thu, 07 Dec 2023 23:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702019846; x=1702624646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Vin8BT3wpq5T3wEcuxWKKOuHM8AGLU+CBTDMoLXsk=;
        b=ZyMR+sotpzOIOUv2ZmhLN+8Hrp4QmFc1qIqAI8amdgUMpuyoN29wOl/iYnKDyYrA+u
         vYgWjQNDKJCb0/JQE/0ttIVduToJ3wXW0MEwlOiP2U4H0TU7y8BYvGiaPL8va1UGGTh5
         fCo/dxpQVsMOAJw8WNI0B+AoPq/0A/731cHRjYTJ5aKMLuUrioXCSeFPrG2R4hxWLgy4
         sPU21OmoZB26WfopP1fuhq6/YI+mYaG+KvLjP5dze1I7Ul4VCuIO2PIRhgUB3WVPtY+d
         QudgOxOVaBvg431K7uSQp9uUecqdNYiEjRWk9qM0j8Ir8qcLGHLuJCJESwltLr6pVNIR
         oy3A==
X-Gm-Message-State: AOJu0YwoUPYxVQrrCx/AdCqiIPkmKzV80+c5pHFO3Gs62Ejsrwwa6Xqk
        Iqfg3xYSkjINjzwd9DWH218=
X-Google-Smtp-Source: AGHT+IH8OSidPNL0zpguBgIQHis69yqzvsgOqd92TReCneG0LANM00oMabB5MbmHHRItMnFMSTdHNg==
X-Received: by 2002:a05:6358:4327:b0:170:17eb:1ed with SMTP id r39-20020a056358432700b0017017eb01edmr4228974rwc.48.1702019846351;
        Thu, 07 Dec 2023 23:17:26 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id y130-20020a62ce88000000b006ce9d2471c0sm956133pfg.60.2023.12.07.23.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:17:25 -0800 (PST)
Date:   Thu, 7 Dec 2023 23:17:23 -0800
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
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Message-ID: <ZXLDA3zObbLybTJB@snowbird>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 10, 2023 at 03:07:19PM +0100, Alexandre Ghiti wrote:
> While working with pcpu variables, I noticed that riscv did not support
> first chunk allocation in the vmalloc area which may be needed as a fallback
> in case of a sparse NUMA configuration.
> 
> patch 1 starts by introducing a new function flush_cache_vmap_early() which
> is needed since a new vmalloc mapping is established and directly accessed:
> on riscv, this would likely fail in case of a reordered access or if the
> uarch caches invalid entries in TLB.
> 
> patch 2 simply enables the page percpu first chunk allocator in riscv.
> 
> Alexandre Ghiti (2):
>   mm: Introduce flush_cache_vmap_early() and its riscv implementation
>   riscv: Enable pcpu page first chunk allocator
> 
>  arch/riscv/Kconfig                  | 2 ++
>  arch/riscv/include/asm/cacheflush.h | 3 ++-
>  arch/riscv/include/asm/tlbflush.h   | 2 ++
>  arch/riscv/mm/kasan_init.c          | 8 ++++++++
>  arch/riscv/mm/tlbflush.c            | 5 +++++
>  include/asm-generic/cacheflush.h    | 6 ++++++
>  mm/percpu.c                         | 8 +-------
>  7 files changed, 26 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.2
> 

I've applied this to percpu#for-6.8.

Thanks,
Dennis
