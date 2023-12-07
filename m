Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71168808BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443529AbjLGPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443507AbjLGPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:34:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BCD10E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:34:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso770580a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701963297; x=1702568097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxNM9WK2tvtShQbb1K2hHNFEu7MJ8bT3CozvqGIxTXw=;
        b=Vb2yv7OsSFAJiUX8lv5KyAdhba04e7m6nZYG+42w8hABlphhKBTuxvJscSBw67MH1h
         PUBdHzzCKK6xmnJGBTY840u2mkFJaLuj0iPft8qDWj42NKrcXV3VcI9jA67k3yn5K5p5
         DEpCbusM1ZEaD1by4iC3kBSxoPv4se9ZPkWKA2w2/d91gT/bJGRdXtzBIul8wRac7b/8
         OHC83FKInWLo47OmcCSp8UCDyF8mOUQDaJ6ydVn72auj/vgNB4hQDP435w+eTx5bHeFw
         nk17fX0i9Mb08pmJbx+89TZ75bVn9RWRZyP4bi+cTl/eDaMGMptttY2t+0ySSgqQ4xzZ
         1flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701963297; x=1702568097;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxNM9WK2tvtShQbb1K2hHNFEu7MJ8bT3CozvqGIxTXw=;
        b=F7Q5uP/uuAxBRzlCTE7OdoVcp3ecz5j1UJqCrdPogSxgCBPD+rn1ezNMZSsBme3Z/K
         d9il3oE7bKkS78yyxI6xvhYHKfGRZ0HENzqEXgahQmBP6GtLnsAMQxF9+OG9MH4OeXeB
         KEY974wLlcytUuBbykG7pkECbJP+JZLTt3hthoMlp8Qk8I6cu4NIIWN6dQNH0hTUd2mR
         5Gz8mwic9X0kLN1DaFelLhpVkZbGxIEftf5paITblWpCPisehfdusvK+SmrgjIc15V7w
         AmvM4E1KM/ANBbB1Nkr0uQ2VRDG3iReMk+lISCTNBwFF/dPhxY3PzKzQyMx3A2jMixSf
         eNXA==
X-Gm-Message-State: AOJu0Yx9PdJLzqrWEylKXnWO9MvI4EXwndKaJ+VsHf2+Puilq8i401iD
        MFc2x/RLN7tZCMyPwvwR9XEW9w==
X-Google-Smtp-Source: AGHT+IF65TZgzhTweL9gbJz3prMlwSaSPqbYrTnygSycKn7vPV8yFjNeM3gu/nqMBGL+EF94LLE7vQ==
X-Received: by 2002:a17:90b:30d7:b0:286:f3d8:de2a with SMTP id hi23-20020a17090b30d700b00286f3d8de2amr5477031pjb.45.1701963296891;
        Thu, 07 Dec 2023 07:34:56 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id ok6-20020a17090b1d4600b00286573fc6e5sm24874pjb.4.2023.12.07.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:34:55 -0800 (PST)
Date:   Thu, 07 Dec 2023 07:34:55 -0800 (PST)
X-Google-Original-Date: Thu, 07 Dec 2023 07:34:53 PST (-0800)
Subject:     Re: [PATCH 0/5] riscv: Use READ_ONCE()/WRITE_ONCE() for pte accesses
In-Reply-To: <20231002151031.110551-1-alexghiti@rivosinc.com>
CC:     ryan.roberts@arm.com, glider@google.com, elver@google.com,
        dvyukov@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
        Ard Biesheuvel <ardb@kernel.org>, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-079ed07b-4a53-4d32-9821-768bbb34fe58@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 08:10:26 PDT (-0700), alexghiti@rivosinc.com wrote:
> This series is a follow-up for riscv of a recent series from Ryan [1] which
> converts all direct dereferences of pte_t into a ptet_get() access.
>
> The goal here for riscv is to use READ_ONCE()/WRITE_ONCE() for all page
> table entries accesses to avoid any compiler transformation when the
> hardware can concurrently modify the page tables entries (A/D bits for
> example).
>
> I went a bit further and added pud/p4d/pgd_get() helpers as such concurrent
> modifications can happen too at those levels.
>
> [1] https://lore.kernel.org/all/20230612151545.3317766-1-ryan.roberts@arm.com/
>
> Alexandre Ghiti (5):
>   riscv: Use WRITE_ONCE() when setting page table entries
>   mm: Introduce pudp/p4dp/pgdp_get() functions
>   riscv: mm: Only compile pgtable.c if MMU
>   riscv: Suffix all page table entry pointers with 'p'
>   riscv: Use accessors to page table entries instead of direct
>     dereference
>
>  arch/riscv/include/asm/kfence.h     |   6 +-
>  arch/riscv/include/asm/kvm_host.h   |   2 +-
>  arch/riscv/include/asm/pgalloc.h    |  86 ++++++++++----------
>  arch/riscv/include/asm/pgtable-64.h |  26 +++---
>  arch/riscv/include/asm/pgtable.h    |  33 ++------
>  arch/riscv/kernel/efi.c             |   2 +-
>  arch/riscv/kvm/mmu.c                |  44 +++++-----
>  arch/riscv/mm/Makefile              |   3 +-
>  arch/riscv/mm/fault.c               |  38 ++++-----
>  arch/riscv/mm/hugetlbpage.c         |  80 +++++++++----------
>  arch/riscv/mm/init.c                |  30 +++----
>  arch/riscv/mm/kasan_init.c          | 119 ++++++++++++++--------------
>  arch/riscv/mm/pageattr.c            |  74 +++++++++--------
>  arch/riscv/mm/pgtable.c             |  71 +++++++++++------
>  include/linux/pgtable.h             |  21 +++++
>  15 files changed, 334 insertions(+), 301 deletions(-)

This has some build failures, I was just talking to Alex and he's going 
to fix them.
