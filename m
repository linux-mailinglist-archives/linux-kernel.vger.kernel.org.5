Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5D76F04E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjHCRIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHCRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:08:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580E35A8;
        Thu,  3 Aug 2023 10:08:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso7982745e9.0;
        Thu, 03 Aug 2023 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691082518; x=1691687318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk7llkQgL4cMEKHdefrrxMgtn62a9OblrizmjtxCpss=;
        b=lUTsarpLg2XFm4fyiN/jzKZEg7WRlD8OtXgHZCoaNpblGEyi9jlXA6+HBwsa9nq+EI
         IONrQzuhPurL03OLdn0Cb49eB3t/kkOeOygtY3nEZzjR8yTfRDpFrM4Tb3Fiwhp2NXnD
         s6/0GswYV3qMIpc5BUk9cKv6rrZI8XUmZvhePNZh/+4EwAcD48mRz493oLTNT4HJoGUt
         4nHvQ9bS0UMoYQ8ilARn7RZmONnCfg5IN6/VMRSkNcAFgdz/Ff+vrLMByIHBVVx3u/28
         zLaG+9PNj5HDmJ8mjOKmO4+kJRWwcpG7m2EkcpLD9q8mbq1zaLtSGeUGP9FO+1SBJdy5
         +nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082518; x=1691687318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk7llkQgL4cMEKHdefrrxMgtn62a9OblrizmjtxCpss=;
        b=HVVW6WNZ1ihSEBuotkFy0JWepUpKSOlciTL1fRI28NhfFN3ApcVDXKAP8taq6X1ek/
         BLU4oqRW/E15Dgdy6z/7vnVOpHZeY7RhaK+m3L8Ypd0xZmn1REg+tk6iCyg+a9qSc6ox
         OF2tfDQRvCV32lrY9BcVZ3BA1pU9AlPzoo8KX61ovc7XXl5GeVAlQYff0xurK8hevppC
         JKR//G50dDpZz/ElOqfOY1fq7cP6AaKYFVMNDI5QHIOP5o8WRcuzJmKxuzlTa3AZiLEi
         ysn7SQzQ2KNljmFOIxZd9o/zsbK2JesDy188kNrLWUMNA2fNbIk+EX3nS2iOs2/0SDtg
         URfw==
X-Gm-Message-State: ABy/qLbEv7RMTfGcp+zbfjmv02Ooxop1Q89nOBcNxFByZnR3cERTFyGE
        Env0gRS4G6IY3ROwUr36MAo=
X-Google-Smtp-Source: APBJJlHUrTdG2N0krMLAGrMlWK0GQXgvtl9r3/mjOqwV41pBjC+SdzLz2A1REJr2BBPs3uxMSINOSA==
X-Received: by 2002:a1c:721a:0:b0:3fd:2e87:aa28 with SMTP id n26-20020a1c721a000000b003fd2e87aa28mr8133382wmc.15.1691082518262;
        Thu, 03 Aug 2023 10:08:38 -0700 (PDT)
Received: from suse.localnet (host-79-26-191-229.retail.telecomitalia.it. [79.26.191.229])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003fe20533a1esm341078wml.44.2023.08.03.10.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:08:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Thu, 03 Aug 2023 19:08:35 +0200
Message-ID: <4824798.GXAFRqVoOG@suse>
In-Reply-To: <20230728120054.12306-1-fmdefrancesco@gmail.com>
References: <20230728120054.12306-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 28 luglio 2023 13:53:01 CEST Fabio M. De Francesco wrote:
> Extend page_tables.rst by adding a section about the role of MMU and TLB
> in translating between virtual addresses and physical page frames.
> Furthermore explain the concept behind Page Faults and how the Linux
> kernel handles TLB misses. Finally briefly explain how and why to disable
> the page faults handler.

Hello everyone,

I'd be grateful to anyone who wanted to comment on / or formally review thi=
s=20
patch. At the moment I've only had comments by Jonathan Cameron on RFC v2=20
(https://lore.kernel.org/all/20230723120721.7139-1-fmdefrancesco@gmail.com/
#t).

Does anybody else want to contribute?

Thanks in advance,

=46abio

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> This has been an RFC PATCH in its 2nd version for a week or so. I received
> comments and suggestions on it from Jonathan Cameron (thanks!), and so it=
=20
has
> now been modified to a real patch. I hope that other people want to add=20
their
> comments on this document in order to further improve and extend it.
>=20
> The link to the thread with the RFC PATCH v2 and the messages between=20
Jonathan
> and me start at
> https://lore.kernel.org/all/20230723120721.7139-1-fmdefrancesco@gmail.com=
/#r
>=20
>  Documentation/mm/page_tables.rst | 105 +++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>=20
> diff --git a/Documentation/mm/page_tables.rst
> b/Documentation/mm/page_tables.rst index 7840c1891751..6ecfd6d2f1f3 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -152,3 +152,108 @@ Page table handling code that wishes to be
> architecture-neutral, such as the virtual memory manager, will need to be
> written so that it traverses all of the currently five levels. This style
> should also be preferred for
>  architecture-specific code, so as to be robust to future changes.
> +
> +
> +MMU, TLB, and Page Faults
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The `Memory Management Unit (MMU)` is a hardware component that handles
> virtual +to physical address translations. It may use relatively small=20
caches
> in hardware +called `Translation Lookaside Buffers (TLBs)` and `Page Walk
> Caches` to speed up +these translations.
> +
> +When a process wants to access a memory location, the CPU provides a=20
virtual
> +address to the MMU, which then uses the MMU to check access permissions =
and
> +dirty bits, and if possible it resolves the physical address and consent=
s=20
the
> +requested type of access to the corresponding physical address.
> +
> +If the TLBs have not yet any recorded translations, the MMU may use the=
=20
Page
> +Walk Caches and complete or restart the page tables walks until a physic=
al
> +address can finally be resolved. Permissions and dirty bits are checked.
> +
> +In the context of a virtual memory system, like the one used by the Linux
> +kernel, each page of memory has associated permission and dirty bits.
> +
> +The dirty bit for a page is set (i.e., turned on) when the page is writt=
en
> +to. This indicates that the page has been modified since it was loaded i=
nto
> +memory. It probably needs to be written on disk or other cores may need =
to
> +be informed about previous changes before allowing further operations.
> +
> +If nothing prevents it, eventually the physical memory can be accessed a=
nd
> +the requested operation on the physical frame is performed.
> +
> +There are several reasons why the MMU can't find certain translations. It
> +could happen because the process is trying to access a range of memory t=
hat
> is +not allowed to, or because the data is not present into RAM.
> +
> +When these conditions happen, the MMU triggers page faults, which are ty=
pes
> +of exceptions that signal the CPU to pause the current process and run a
> special +function to handle the mentioned page faults.
> +
> +One cause of page faults is due to bugs (or maliciously crafted addresse=
s)
> and +happens when a process tries to access a range of memory that it=20
doesn't
> have +permission to. This could be because the memory is reserved for the
> kernel or +for another process, or because the process is trying to write=
 to
> a read-only +section of memory. When this happens, the kernel sends a
> Segmentation Fault +(SIGSEGV) signal to the process, which usually causes=
=20
the
> process to terminate. +
> +An expected and more common cause of page faults is an optimization call=
ed
> "lazy +allocation". This is a technique used by the Kernel to improve mem=
ory
> efficiency +and reduce footprint. Instead of allocating physical memory t=
o a
> process as soon +as it's requested, the Kernel waits until the process
> actually tries to use the +memory. This can save a significant amount of
> memory in cases where a process +requests a large block but only uses a=20
small
> portion of it.
> +
> +A related technique is called "Copy-on-Write" (CoW), where the Kernel=20
allows
> +multiple processes to share the same physical memory as long as they're=
=20
only
> +reading from it. If a process tries to write to the shared memory, the=20
kernel
> +triggers a page fault and allocates a separate copy of the memory for the
> +process. This allows the Kernel to save memory and avoid unnecessary data
> +copying and, by doing so, it reduces latency and space occupation.
> +
> +Now, let's see how the Linux kernel handles these page faults:
> +
> +1. For most architectures, `do_page_fault()` is the primary interrupt=20
handler
> +   for page faults. It delegates the actual handling of the page fault t=
o +=20
>  `handle_mm_fault()`. This function checks the cause of the page fault an=
d +=20
>  takes the appropriate action, such as loading the required page into + =
=20
> memory, granting the process the necessary permissions, or sending a + =20
> SIGSEGV signal to the process.
> +
> +2. In the specific case of the x86 architecture, the interrupt handler is
> +   defined by the `DEFINE_IDTENTRY_RAW_ERRORCODE()` macro, which calls
> +   `handle_page_fault()`. This function then calls either
> +   `do_user_addr_fault()` or `do_kern_addr_fault()`, depending on whether
> +   the fault occurred in user space or kernel space. Both of these=20
functions
> +   eventually lead to `handle_mm_fault()`, similar to the workflow in ot=
her
> +   architectures.
> +
> +`handle_mm_fault()` (likely) ends up calling `__handle_mm_fault()` to ca=
rry
> +out the actual work of allocation of the page tables. It works by using
> +several functions to find the entry's offsets of the 4 - 5 layers of tab=
les
> +and allocate the tables it needs to. The functions that look for the off=
set
> +have names like `*_offset()`, where the "*" is for pgd, p4d, pud, pmd, p=
te;
> +instead the functions to allocate the corresponding tables, layer by lay=
er,
> +are named `*_alloc`, with the above mentioned convention to name them af=
ter
> +the corresponding types of tables in the hierarchy.
> +
> +At the very end of the walk with allocations, if it didn't return errors,
> +`__handle_mm_fault()` finally calls `handle_pte_fault()`, which via
> +`do_fault()` performs one of `do_read_fault()`, `do_cow_fault()`,
> +`do_shared_fault()`. "read", "cow", "shared" give hints about the reasons
> +and the kind of fault it's handling.
> +
> +The actual implementation of the workflow is very complex. Its design=20
allows
> +Linux to handle page faults in a way that is tailored to the specific
> +characteristics of each architecture, while still sharing a common overa=
ll
> +structure.
> +
> +To conclude this brief overview from very high altitude of how Linux=20
handles
> +page faults, let's add that page faults handler can be disabled and enab=
led
> +respectively with `pagefault_disable()` and `pagefault_enable()`.
> +
> +Several code path make use of the latter two functions because they need=
 to
> +disable traps into the page faults handler, mostly to prevent deadlocks.=
[1]
> +
> +[1] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
> +https://lore.kernel.org/all/20221025220136.2366143-1-ira.weiny@intel.com/
> --
> 2.41.0




