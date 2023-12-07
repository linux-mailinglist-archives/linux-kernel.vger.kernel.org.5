Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8180805E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjLGFqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:46:48 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C5121;
        Wed,  6 Dec 2023 21:46:53 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cf7a8ab047so3777115ad.1;
        Wed, 06 Dec 2023 21:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928012; x=1702532812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egxxoHFyDqeCA/LxlDg8JyWMVYkStRh8cbZHikRDbS0=;
        b=JeRe68CMyQ2Y8eU4AcHetoaEmDGZiqZUj8X1z1QW0ZAmA2hvt0hszrmH9ceEEOrkCO
         3L4sEuJi7/hybH+tayAtm2+46DP4DsjnrOlvTcCgy85h5Acrc/LkbMqRJsmNsGajuuDW
         aCJRdP7JKoVtlsJK23tftejfYdJnXso/JH0GsmXxftmJXooqUTOwEomojiaWEza4iFXy
         7LDqcQ95mpP3L899yMm+B38ytew2URwlCeVPmFpLNgJg+qDzOG3qkIiEJkcJZGaoSIfJ
         AdKVoLMshv/ewuSbYOdoO5VYhKnO+d6uHXbU1huN3h/CnbrwUAuWVnSj6JbRa2tsHbxO
         uDNA==
X-Gm-Message-State: AOJu0YxRP7XcvhouDLWfGrp+Vwj3t5tROh2EV1EzJddywWQtxhxQLBmR
        yMan8oD1xLG5qFmojZrtUxA=
X-Google-Smtp-Source: AGHT+IF6vXYcdw6GXClAOhugyGgBVtuMtwXIfwxdWqT56yjqXEpfSXOgZ2/KtLitjpsLVgMAz5ioAA==
X-Received: by 2002:a17:902:c101:b0:1d0:8afd:b28c with SMTP id 1-20020a170902c10100b001d08afdb28cmr1453916pli.92.1701928012478;
        Wed, 06 Dec 2023 21:46:52 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001d08e080042sm431944plb.43.2023.12.06.21.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:46:51 -0800 (PST)
Date:   Wed, 6 Dec 2023 21:46:48 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Message-ID: <ZXFcSEzalzl790bO@snowbird>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
 <f259088f-a590-454e-b322-397e63071155@ghiti.fr>
 <ZXDEyzVcBOPUCCpg@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXDEyzVcBOPUCCpg@slm.duckdns.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 06, 2023 at 09:00:27AM -1000, Tejun Heo wrote:
> On Wed, Dec 06, 2023 at 11:08:20AM +0100, Alexandre Ghiti wrote:
> > Hi Tejun,
> > 
> > On 10/11/2023 15:07, Alexandre Ghiti wrote:
> > > While working with pcpu variables, I noticed that riscv did not support
> > > first chunk allocation in the vmalloc area which may be needed as a fallback
> > > in case of a sparse NUMA configuration.
> > > 
> > > patch 1 starts by introducing a new function flush_cache_vmap_early() which
> > > is needed since a new vmalloc mapping is established and directly accessed:
> > > on riscv, this would likely fail in case of a reordered access or if the
> > > uarch caches invalid entries in TLB.
> > > 
> > > patch 2 simply enables the page percpu first chunk allocator in riscv.
> > > 
> > > Alexandre Ghiti (2):
> > >    mm: Introduce flush_cache_vmap_early() and its riscv implementation
> > >    riscv: Enable pcpu page first chunk allocator
> > > 
> > >   arch/riscv/Kconfig                  | 2 ++
> > >   arch/riscv/include/asm/cacheflush.h | 3 ++-
> > >   arch/riscv/include/asm/tlbflush.h   | 2 ++
> > >   arch/riscv/mm/kasan_init.c          | 8 ++++++++
> > >   arch/riscv/mm/tlbflush.c            | 5 +++++
> > >   include/asm-generic/cacheflush.h    | 6 ++++++
> > >   mm/percpu.c                         | 8 +-------
> > >   7 files changed, 26 insertions(+), 8 deletions(-)
> > > 
> > 
> > Any feedback regarding this?
> 
> On cursory look, it looked fine to me but Dennis is maintaining the percpu
> tree now. Dennis?
> 

Ah I wasn't sure at the time if we needed this to go through percpu vs
risc v. I need to poke tglx and potentially pull some more stuff so I
can take it.

I regrettably got both the covid and flu vaccines today and feel like a
truck hit me. I'll review this tomorrow and make sure it's taken care
of for the next merge window.

Thanks,
Dennis

> Thanks.
> 
> -- 
> tejun
