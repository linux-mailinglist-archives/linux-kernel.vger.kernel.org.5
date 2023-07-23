Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA62175E1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGWNOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGWNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:14:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB203E57;
        Sun, 23 Jul 2023 06:14:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso32697535e9.2;
        Sun, 23 Jul 2023 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690118066; x=1690722866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W1u2MVpGKLpBiXVuRgUMbIPOpowv0h6POZ4Q69kPEw=;
        b=f7yYsghWvl866bYjcCiFV0z7F4z95ARagx3h3TSvgIxiKS4YEl0LSrRGAtpHiAkpk9
         btGjehTl5ra7cllW8CwPnkas0KSINR7pY83WV4SnjPIdoHeDmXhhsl6SuiigTbkrx95U
         o8Kktc79ujFxmmUouqHMc/2hsMw12E+At1OaaGvXxqs5BoqOfmg6StwwQwqItc2U8dY8
         WYLQCsxTHqbwp+qggzrkgcoPBQhhEql6IS6B+ShGMOuZ5HkxlmEy2L2q8yLbcGMktk3T
         +8byXKtHZx9/IPYa+XqMIzpuQMVFE+JQRqh3z8FZtp3jlSDk18+VoDGyxX/s1RaWdp2p
         JXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690118066; x=1690722866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W1u2MVpGKLpBiXVuRgUMbIPOpowv0h6POZ4Q69kPEw=;
        b=PyTmX2PRAeJoIQb4vDi7Q4fsUrmR02Mp7hR7Yi174j9NaMam7moKPajaXJ+mZoiFeI
         6w35kh/+luOKblq+1l26jau6+7oRz5RDwKHirOVv/U5xPQ0uIwK53k3+MDdImiJsg3rq
         3XsHNl4Hxvt4gR/+64HxHQMG08KgpbSDUfAoCkyIeXADmzpnL8b8omak3Ju6XSOHGURa
         U5XoRbs8hf4uWvC9/90g3gpG8dPWuyshL5XvEKMXo0kSWjMRwaeYsg+OF8p7wcns0+gB
         LCYQs5y6ONT2Egoy+KGChauV4foswg20CbmRfCj6D1fygHkmAuJkjTc3zT0yavGJaKAe
         gBOA==
X-Gm-Message-State: ABy/qLYVh08nvaGyk3Ij/0uC1scVeXpBTGNXKwzLgM0Y0xwouhsP/25R
        +01hLjATVH6THXus+Tlhhk265p/0ltI=
X-Google-Smtp-Source: APBJJlFEVmjwJvqvDE8T2vbcheMra+2GkEuWoZHrWtnjG6aA0Fgss2BDAGlYBjc9BJkKVsMiO7TAlw==
X-Received: by 2002:adf:d84d:0:b0:317:4828:89b7 with SMTP id k13-20020adfd84d000000b00317482889b7mr2945320wrl.67.1690118065735;
        Sun, 23 Jul 2023 06:14:25 -0700 (PDT)
Received: from suse.localnet (host-87-20-104-222.retail.telecomitalia.it. [87.20.104.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d45d1000000b003142ea7a661sm9740742wrs.21.2023.07.23.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:14:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH] Documentation/page_tables: MMU, TLB, and Page Faults
Date:   Sun, 23 Jul 2023 15:14:18 +0200
Message-ID: <4838064.GXAFRqVoOG@suse>
In-Reply-To: <20230722004451.7730-1-fmdefrancesco@gmail.com>
References: <20230722004451.7730-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 22 luglio 2023 02:43:13 CEST Fabio M. De Francesco wrote:
> Extend page_tables.rst by adding a small introductive section about
> the role of MMU and TLB in translating between virtual addresses and
> physical page frames. Furthermore explain the concepts behind the
> Page Faults exceptions and how Linux handles them.

This is superseded by "[RFC PATCH v2] Documentation/page_tables: Add info 
about MMU/TLB and Page Faults" at https://lore.kernel.org/lkml/
20230723120721.7139-1-fmdefrancesco@gmail.com/. Please refer to the above-
mentioned second version and discard this.

Thanks,

Fabio

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This is an RFC PATCH because of two reasons:
> 
> 1) I've heard that there is consensus about the need to revise and
> extend the MM documentation, but I'm not sure about whether or not
> developers need these kind of introductory information.
> 
> 2) While preparing this little patch I decided to take a quicj look at
> the code and found out it currently is not how I thought I remembered
> it. I'm especially speaking about the x86 case. I'm not sure that I've
> been able to properly understand what I described as a difference in
> workflow compared to most of the other architecture.
> 
> Therefore, for the two reasons explained above, I'd like to hear from
> people actively involved in MM. If this is not what you want, feel free
> to throw it away. Otherwise I'd be happy to write more on this and other
> MM topics. I'm looking forward for comments on this small work.
> 
>  Documentation/mm/page_tables.rst | 61 ++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/mm/page_tables.rst
> b/Documentation/mm/page_tables.rst index 7840c1891751..fa617894fda8 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -152,3 +152,64 @@ Page table handling code that wishes to be
> architecture-neutral, such as the virtual memory manager, will need to be
> written so that it traverses all of the currently five levels. This style
> should also be preferred for
>  architecture-specific code, so as to be robust to future changes.
> +
> +
> +MMU, TLB, and Page Faults
> +=========================
> +
> +The Memory Management Unit (MMU) is a hardware component that handles 
virtual
> to +physical address translations. It uses a relatively small cache in
> hardware +called the Translation Lookaside Buffer (TLB) to speed up these
> translations. +When a process wants to access a memory location, the CPU
> provides a virtual +address to the MMU, which then uses the TLB to quickly
> find the corresponding +physical address.
> +
> +However, sometimes the MMU can't find a valid translation in the TLB. This
> +could be because the process is trying to access a range of memory that 
it's
> not +allowed to, or because the memory hasn't been loaded into RAM yet. When
> this +happens, the MMU triggers a page fault, which is a type of interrupt
> that +signals the CPU to pause the current process and run a special 
function
> to +handle the fault.
> +
> +One cause of page faults is due to bugs (or maliciously crafted addresses)
> and +happens when a process tries to access a range of memory that it 
doesn't
> have +permission to. This could be because the memory is reserved for the
> kernel or +for another process, or because the process is trying to write to
> a read-only +section of memory. When this happens, the kernel sends a
> Segmentation Fault +(SIGSEGV) signal to the process, which usually causes 
the
> process to terminate. +
> +An expected and more common cause of page faults is "lazy allocation". This
> is +a technique used by the Kernel to improve memory efficiency and reduce
> +footprint. Instead of allocating physical memory to a process as soon as
> it's +requested, the kernel waits until the process actually tries to use 
the
> memory. +This can save a significant amount of memory in cases where a
> process requests +a large block but only uses a small portion of it.
> +
> +A related technique is "Copy-on-Write" (COW), where the Kernel allows
> multiple +processes to share the same physical memory as long as they're 
only
> reading +from it. If a process tries to write to the shared memory, the
> kernel triggers +a page fault and allocates a separate copy of the memory 
for
> the process. This +allows the kernel to save memory and avoid unnecessary
> data copying and, by +doing so, it reduces latency.
> +
> +Now, let's see how the Linux kernel handles these page faults:
> +
> +1. For most architectures, `do_page_fault()` is the primary interrupt 
handler
> +   for page faults. It delegates the actual handling of the page fault to + 
>  `handle_mm_fault()`. This function checks the cause of the page fault and + 
>  takes the appropriate action, such as loading the required page into +  
> memory, granting the process the necessary permissions, or sending a +  
> SIGSEGV signal to the process.
> +
> +2. In the specific case of the x86 architecture, the interrupt handler is
> +   defined by the `DEFINE_IDTENTRY_RAW_ERRORCODE()` macro, which calls
> +   `handle_page_fault()`. This function then calls either
> +   `do_user_addr_fault()` or `do_kern_addr_fault()`, depending on whether
> +   the fault occurred in user space or kernel space. Both of these 
functions
> +   eventually lead to `handle_mm_fault()`, similar to the workflow in other
> +   architectures.
> +
> +The actual implementation of the workflow is very complex. Its design 
allows
> +Linux to handle page faults in a way that is tailored to the specific
> +characteristics of each architecture, while still sharing a common overall
> +structure.
> --
> 2.41.0




