Return-Path: <linux-kernel+bounces-158385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EA8B1F11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AC81F2273B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D686636;
	Thu, 25 Apr 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="boDefwJO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4C86151
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040569; cv=none; b=E1VTwT3JSw/w8CpEvqF2uEfRvex0IYQzeAdf3ZN8UpnWni0k1fzn3a5u9kNMqWqTNxf36WaP2XVxjyfuq4m2/ED3DULNwFJR7/1vr0B1TqgjP4I+qK0kKA6PDirzBq9b5RY/AnKlZlBhcige4k3MHLhLp9voT6Fmrv73Ssn8xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040569; c=relaxed/simple;
	bh=SCAVSdTcNSD5Yr1pNlMCWZKWtPeF6oeQXhk0cO+/3/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7Jpq+VsFKh+rOZUgj9/74xJ8d5ZkpDb2a1vJOvoW50hP2tc5XOUdKZyYJGGB2oS7/E1Nfg0qAnyevQXZBgyNOJ6/KWtTn0O9p9gxPj3hkmqamuSGWUVmqDHyiIVSJ1Y/LA08ZDx/PsjOQUJtm2bYa3R6Dzll2KS2tzI9LEDuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=boDefwJO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51a7d4466bso86558966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714040565; x=1714645365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tb0RWXYcOUdwAJ2aC7C5cjwImSQlTgJoiKwx4zZtUTU=;
        b=boDefwJOvTv8QB4t/E7QPSKLlWHC5eHMiDV101U9SOvXHs4z0AjBd/zY/N1rLB0DcH
         Oxo9jQmfr2fvQv4NZK0nTMD08Pd8OY9mPUAj6msILZEFduY/LI9PrJkPjyYo5L7HiVrp
         7u1Uct11PF2unz9eSXEpbC0EQzp0yWMBAxhZySbotxCFFNsc/c+C28vvLlFvMrI6UNOh
         WXyreJiIxszKKpf+5XDiWpu1/1l5pEWh7CBuIAlXC5281InGrAAzZlaJALJ1nsMWfG9u
         Wj0IWCJml2z3dJ+QHWl57I6jeXBFXa2y1wMgL8m7R9XWBbDmObb0xba6yKxYlMC6mBmn
         8wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040565; x=1714645365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb0RWXYcOUdwAJ2aC7C5cjwImSQlTgJoiKwx4zZtUTU=;
        b=WSWvQ9GiRnl29Ue53ZNsOTEVhaKJvbbhtlEYA0haM6JY7be3GRSZC8A22MRmvzMWZo
         ybmvHdnzqCeSOKoBV1jupfZEtrOIaSjGY+uIMOpoGAB0Zio166nMD1ezGvDI2QVLmrxa
         8jgqhg3c5dKkn4iwlTnJTvaHY5MxLe/z1tiePL3qNfjeel/bIUr/pIx23ZGWCyrgcD3t
         iKBkzRPsyvqSswJVZsWsPzJ7umM6h1B7txi//fN2Osb57kqup+X5jphcAK1JwYkVwZpa
         C3qUgZMXmZ5IrLRzGe8xd4ubinGWMcPK/8dJFuTlCDaW+0BVTCKPCo3Ir6+/13ubdsE1
         YcIg==
X-Forwarded-Encrypted: i=1; AJvYcCUaLUTtRP07cX69RfeQJcSeFue0jNWSIttr26twHWmj3W6iJqntzdUmVyEOmOO2mH+E+eeqCzcI/ioKkMPNQHTQOLGPmdHnomgmKzlK
X-Gm-Message-State: AOJu0Yxn49IHM6IQfH3bFgoEt2cCufz3HBf6vxPpZNl1XlZj0ulkL7g0
	TaE01t9VkVdpyGlTubfbx0bkHq4HWx5B6QmyYSLiSESlkwP2br5sLmJXfIAQ/KAjOBP9Alcmhr2
	1DIoUdX4Jpda7n4pv/YKSxVybZMTPodXw/lVogA==
X-Google-Smtp-Source: AGHT+IG8hw9GemhS0Y2zrqPlg61weeOaKBTk8AKOgSpxSoiunT0f7Msptuqm/wIphoBkX2od0EVzqsFkRHMXAD8JMOk=
X-Received: by 2002:a17:906:7ac6:b0:a55:bfe7:3e62 with SMTP id
 k6-20020a1709067ac600b00a55bfe73e62mr3060024ejo.11.1714040564519; Thu, 25 Apr
 2024 03:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423142307.495726312-1-mbland@motorola.com>
In-Reply-To: <20240423142307.495726312-1-mbland@motorola.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 25 Apr 2024 12:22:33 +0200
Message-ID: <CAHVXubjRUYibhLqeY1zCdU1n4dAwuOxcVU5Y0suAM7Pb7iw=Fw@mail.gmail.com>
Subject: Re: [PATCH v2] ptdump: add non-leaf descriptor support
To: 20240423110435.c84aa2a0e4cb5a17fb1ab18d@linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Maxwell Bland <mbland@motorola.com> Jonathan Corbet" <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Will Deacon <will@kernel.org>, 
	Maxwell Bland <mbland@motorola.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxwell,

On Tue, Apr 23, 2024 at 9:26=E2=80=AFPM Maxwell Bland <mbland@motorola.com>=
 wrote:
>
> Add an optional note_non_leaf parameter to ptdump, causing note_page to
> be called on non-leaf descriptors. Implement this functionality on arm64
> by printing table descriptors along with table-specific permission sets.
>
> For arm64, break (1) the uniform number of columns for each descriptor,
> and (2) the coalescing of large PTE regions, which are now split up by
> PMD. This is a "good" thing since it makes the behavior and protection
> bits set on page tables, such as PXNTable, more explicit.
>
> Examples (spaces and last attribute condensed)
> Before:
> 0xffff008440210000-0xffff008440400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff008440400000-0xffff008441c00000 24M PMD ro NX SHD AF NG BLK UXN M..=
.
> 0xffff008441c00000-0xffff008441dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff008441dc0000-0xffff00844317b000 20204K PTE RW NX SHD AF NG UXN M...
>
> After:
> 0xffff0fb640200000-0xffff0fb640400000 2M PMD TBL RW x NXTbl UXNTbl M...
> 0xffff0fb640200000-0xffff0fb640210000 64K PTE RW NX SHD AF NG UXN M...
> 0xffff0fb640210000-0xffff0fb640400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb640400000-0xffff0fb641c00000 24M PMD BLK ro SHD AF NG NX UXN ...
> 0xffff0fb641c00000-0xffff0fb641e00000 2M PMD TBL RW x NXTbl UXNTbl M...
> 0xffff0fb641c00000-0xffff0fb641dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb641dc0000-0xffff0fb641e00000 256K PTE RW NX SHD AF NG UXN ME...

I think it would be easier to read if the lower levels were tabulated,
so that we can quickly see the page table structure.

I'll implement this on riscv once merged, I'm a big user of this dump :)

Thanks,

Alex

>
> Full dumps available at
> github.com/maxwell-bland/linux-patch-data/tree/main/ptdump-non-leaf
>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>
> Dear Andrew,
>
> > I was going to queue this while awaiting acks from arm people, but
> > there's a large reject in Documentation/arch/arm64/ptdump.rst.
>
> Ack, thank you and apologies, if I understand correctly, you are seeing
> this issue on linux-next/akpm, I was not familiar with the submission
> process. I was not able to reproduce on mm-unstable, linux-next/master,
> mm/master, ... This reply (v2 commit) is cherry-picked to
> linux-next/akpm.
>
> A diff with linux-next/master for my original submission only returns:
>
>   611c611
>   < base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
>   > base-commit: 7d4768ae56014b3db93423e84f8794f173ec5c91
>
> Regards,
> Maxwell Bland
>
>  Documentation/arch/arm64/ptdump.rst | 125 ++++++++++++++++
>  arch/arm64/mm/ptdump.c              | 224 +++++++++++++++++++++++++---
>  include/linux/ptdump.h              |   1 +
>  mm/ptdump.c                         |  13 ++
>  4 files changed, 343 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/arch/arm64/ptdump.rst
>
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm=
64/ptdump.rst
> new file mode 100644
> index 000000000000..0f38b92fd839
> --- /dev/null
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -0,0 +1,125 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel page table dump
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ptdump is a debugfs interface that provides a detailed dump of the kerne=
l page
> +tables. It offers a comprehensive overview of the kernel virtual memory =
layout
> +as well as the attributes associated with the various regions in a
> +human-readable format. It is useful to dump the kernel page tables to ve=
rify
> +permissions and memory types. Examining the page table entries and permi=
ssions
> +helps identify potential security vulnerabilities such as mappings with =
overly
> +permissive access rights or improper memory protections.
> +
> +Memory hotplug allows dynamic expansion or contraction of available memo=
ry
> +without requiring a system reboot. To maintain the consistency and integ=
rity of
> +the memory management data structures, arm64 makes use of the
> +mem_hotplug_lock semaphore in write mode. Additionally, in read mode,
> +mem_hotplug_lock supports an efficient implementation of
> +get_online_mems() and put_online_mems(). These protect the offlining of
> +memory being accessed by the ptdump code.
> +
> +In order to dump the kernel page tables, enable the following configurat=
ions
> +and mount debugfs::
> +
> + CONFIG_GENERIC_PTDUMP=3Dy
> + CONFIG_PTDUMP_CORE=3Dy
> + CONFIG_PTDUMP_DEBUGFS=3Dy
> +
> + mount -t debugfs nodev /sys/kernel/debug
> + cat /sys/kernel/debug/kernel_page_tables
> +
> +On analysing the output of cat /sys/kernel/debug/kernel_page_tables one =
can
> +derive information about the virtual address range of a contiguous group=
 of
> +page table entries, followed by size of the memory region covered by thi=
s
> +group, the hierarchical structure of the page tables and finally the att=
ributes
> +associated with each page in the group. Groups are broken up either acco=
rding
> +to a change in attributes or by parent descriptor, such as a PMD. Note t=
hat the
> +set of attributes, and therefore formatting, is not equivalent between e=
ntry
> +types. For example, PMD entries have a separate set of attributes from l=
eaf
> +level PTE entries, because they support both the UXNTable and PXNTable
> +permission bits.
> +
> +The page attributes provide information about access permissions, execut=
ion
> +capability, type of mapping such as leaf level PTE or block level PGD, P=
MD and
> +PUD, and access status of a page within the kernel memory. Non-PTE block=
 or
> +page level entries are denoted with either "BLK" or "TBL", respectively.
> +Assessing these attributes can assist in understanding the memory layout=
,
> +access patterns and security characteristics of the kernel pages.
> +
> +Kernel virtual memory layout example::
> +
> + start address        end address         size type  leaf    attributes
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ Linear Mapping start ]---                                       =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW         =
      x      NXTbl UXNTbl    MEM/NORMAL    |
> + | 0xffff0d02c3200000-0xffff0d02c3218000   96K PTE           ro NX SHD A=
F NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3218000-0xffff0d02c3250000  224K PTE           RW NX SHD A=
F NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3250000-0xffff0d02c33b3000 1420K PTE           ro NX SHD A=
F NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c33b3000-0xffff0d02c3400000  308K PTE           RW NX SHD A=
F NG     UXN    MEM/NORMAL-TAGGED          |
> + | 0xffff0d02c3400000-0xffff0d02c3600000    2M PMD   TBL     RW         =
      x      NXTbl UXNTbl    MEM/NORMAL    |
> + | 0xffff0d02c3400000-0xffff0d02c3600000    2M PTE           RW NX SHD A=
F NG     UXN    MEM/NORMAL-TAGGED          |
> + | ...                                                                  =
                                           |
> + | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW         =
      x      NXTbl UXNTbl    MEM/NORMAL    |
> + | ...                                                                  =
                                           |
> + | ---[ Linear Mapping end ]---                                         =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ Modules start ]---                                              =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xffff800000000000-0xffff800000000080 128B PGD   TBL     RW          =
     x     UXNTbl    MEM/NORMAL            |
> + | 0xffff800000000000-0xffff800080000000   2G PUD F BLK     RW          =
     x               MEM/NORMAL            |
> + | ...                                                                  =
                                           |
> + | ---[ Modules end ]---                                                =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ vmalloc() area ]---                                             =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xffff800080000000-0xffff8000c0000000   1G PUD   TBL     RW          =
     x     UXNTbl    MEM/NORMAL            |
> + | ...                                                                  =
                                           |
> + | 0xffff800080200000-0xffff800080400000   2M PMD   TBL     RW          =
     x      NXTbl UXNTbl    MEM/NORMAL     |
> + | 0xffff800080200000-0xffff80008022f000 188K PTE           RW NX SHD AF=
 NG     UXN    MEM/NORMAL                  |
> + | 0xffff80008022f000-0xffff800080230000   4K PTE F BLK     RW x        =
               MEM/NORMAL                  |
> + | 0xffff800080230000-0xffff800080233000  12K PTE           RW NX SHD AF=
 NG     UXN    MEM/NORMAL                  |
> + | 0xffff800080233000-0xffff800080234000   4K PTE F BLK     RW x        =
               MEM/NORMAL                  |
> + | 0xffff800080234000-0xffff800080237000  12K PTE           RW NX SHD AF=
 NG     UXN    MEM/NORMAL                  |
> + | ...                                                                  =
                                           |
> + | 0xffff800080400000-0xffff800084000000  60M PMD F BLK     RW          =
     x      x     x         MEM/NORMAL     |
> + | ...                                                                  =
                                           |
> + | ---[ vmalloc() end ]---                                              =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ vmemmap start ]---                                              =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xfffffe33cb000000-0xfffffe33cc000000  16M PMD   BLK     RW SHD AF NG=
     NX UXN x     x         MEM/NORMAL     |
> + | 0xfffffe33cc000000-0xfffffe3400000000 832M PMD F BLK     RW          =
     x      x     x         MEM/NORMAL     |
> + | ...                                                                  =
                                           |
> + | ---[ vmemmap end ]---                                                =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ PCI I/O start ]---                                              =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xffffffffc0800000-0xffffffffc0810000 64K PTE           RW NX SHD AF =
NG     UXN    DEVICE/nGnRE                 |
> + | ...                                                                  =
                                           |
> + | ---[ PCI I/O end ]---                                                =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> + | ---[ Fixmap start ]---                                               =
                                           |
> + | ...                                                                  =
                                           |
> + | 0xffffffffff5f6000-0xffffffffff5f9000 12K PTE           ro x  SHD AF =
       UXN    MEM/NORMAL                   |
> + | 0xffffffffff5f9000-0xffffffffff5fa000  4K PTE           ro NX SHD AF =
NG     UXN    MEM/NORMAL                   |
> + | ...                                                                  =
                                           |
> + | ---[ Fixmap end ]---                                                 =
                                           |
> + +----------------------------------------------------------------------=
-------------------------------------------+
> +
> +cat /sys/kernel/debug/kernel_page_tables output::
> +
> + 0xffff000000000000-0xffff0d0000000000   13T PGD F BLK     RW           =
    x               MEM/NORMAL
> + 0xffff0d0000000000-0xffff0d0000000080  128B PGD   TBL     RW           =
    NXTbl UXNTbl    MEM/NORMAL
> + 0xffff0d0000000000-0xffff0d02c0000000   11G PUD F BLK     RW           =
    x               MEM/NORMAL
> + 0xffff0d02c0000000-0xffff0d0300000000    1G PUD   TBL     RW           =
    NXTbl UXNTbl    MEM/NORMAL
> + 0xffff0d02c0000000-0xffff0d02c0200000    2M PMD   TBL     RW           =
    x      NXTbl UXNTbl    MEM/NORMAL
> + 0xffff0d02c0000000-0xffff0d02c0200000    2M PTE           RW NX SHD AF =
NG     UXN    MEM/NORMAL-TAGGED
> + 0xffff0d02c0200000-0xffff0d02c0400000    2M PMD   TBL     RW           =
    x      NXTbl UXNTbl    MEM/NORMAL
> + 0xffff0d02c0200000-0xffff0d02c0210000   64K PTE           RW NX SHD AF =
NG     UXN    MEM/NORMAL-TAGGED
> + 0xffff0d02c0210000-0xffff0d02c0400000 1984K PTE           ro NX SHD AF =
NG     UXN    MEM/NORMAL
> + 0xffff0d02c0400000-0xffff0d02c1c00000   24M PMD   BLK     ro SHD AF NG =
    NX UXN x     x         MEM/NORMAL
> + 0xffff0d02c1c00000-0xffff0d02c1e00000    2M PMD   TBL     RW           =
    x      NXTbl UXNTbl    MEM/NORMAL
> + 0xffff0d02c1c00000-0xffff0d02c1dc0000 1792K PTE           ro NX SHD AF =
NG     UXN    MEM/NORMAL
> + 0xffff0d02c1dc0000-0xffff0d02c1e00000  256K PTE           RW NX SHD AF =
NG     UXN    MEM/NORMAL-TAGGED
> +
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 9bc4066c5bf3..6a8b2bcc9ac7 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -24,6 +24,7 @@
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/ptdump.h>
> +#include <asm/pgalloc.h>
>
>
>  enum address_markers_idx {
> @@ -97,6 +98,11 @@ static const struct prot_bits pte_bits[] =3D {
>                 .val    =3D PTE_VALID,
>                 .set    =3D " ",
>                 .clear  =3D "F",
> +       }, {
> +               .mask   =3D PTE_TABLE_BIT,
> +               .val    =3D PTE_TABLE_BIT,
> +               .set    =3D "   ",
> +               .clear  =3D "BLK",
>         }, {
>                 .mask   =3D PTE_USER,
>                 .val    =3D PTE_USER,
> @@ -132,11 +138,6 @@ static const struct prot_bits pte_bits[] =3D {
>                 .val    =3D PTE_CONT,
>                 .set    =3D "CON",
>                 .clear  =3D "   ",
> -       }, {
> -               .mask   =3D PTE_TABLE_BIT,
> -               .val    =3D PTE_TABLE_BIT,
> -               .set    =3D "   ",
> -               .clear  =3D "BLK",
>         }, {
>                 .mask   =3D PTE_UXN,
>                 .val    =3D PTE_UXN,
> @@ -170,34 +171,206 @@ static const struct prot_bits pte_bits[] =3D {
>         }
>  };
>
> +static const struct prot_bits pmd_bits[] =3D {
> +       {
> +               .mask   =3D PMD_SECT_VALID,
> +               .val    =3D PMD_SECT_VALID,
> +               .set    =3D " ",
> +               .clear  =3D "F",
> +       }, {
> +               .mask   =3D PMD_TABLE_BIT,
> +               .val    =3D PMD_TABLE_BIT,
> +               .set    =3D "TBL",
> +               .clear  =3D "BLK",
> +       }, {
> +               .mask   =3D PMD_SECT_USER,
> +               .val    =3D PMD_SECT_USER,
> +               .set    =3D "USR",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PMD_SECT_RDONLY,
> +               .val    =3D PMD_SECT_RDONLY,
> +               .set    =3D "ro",
> +               .clear  =3D "RW",
> +       }, {
> +               .mask   =3D PMD_SECT_S,
> +               .val    =3D PMD_SECT_S,
> +               .set    =3D "SHD",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PMD_SECT_AF,
> +               .val    =3D PMD_SECT_AF,
> +               .set    =3D "AF",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PMD_SECT_NG,
> +               .val    =3D PMD_SECT_NG,
> +               .set    =3D "NG",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PMD_SECT_CONT,
> +               .val    =3D PMD_SECT_CONT,
> +               .set    =3D "CON",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PMD_SECT_PXN,
> +               .val    =3D PMD_SECT_PXN,
> +               .set    =3D "NX",
> +               .clear  =3D "x ",
> +       }, {
> +               .mask   =3D PMD_SECT_UXN,
> +               .val    =3D PMD_SECT_UXN,
> +               .set    =3D "UXN",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PMD_TABLE_PXN,
> +               .val    =3D PMD_TABLE_PXN,
> +               .set    =3D "NXTbl",
> +               .clear  =3D "x    ",
> +       }, {
> +               .mask   =3D PMD_TABLE_UXN,
> +               .val    =3D PMD_TABLE_UXN,
> +               .set    =3D "UXNTbl",
> +               .clear  =3D "x     ",
> +       }, {
> +               .mask   =3D PTE_GP,
> +               .val    =3D PTE_GP,
> +               .set    =3D "GP",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_DEVICE_nGnRnE),
> +               .set    =3D "DEVICE/nGnRnE",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_DEVICE_nGnRE),
> +               .set    =3D "DEVICE/nGnRE",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL_NC),
> +               .set    =3D "MEM/NORMAL-NC",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL),
> +               .set    =3D "MEM/NORMAL",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL_TAGGED),
> +               .set    =3D "MEM/NORMAL-TAGGED",
> +       }
> +};
> +
> +static const struct prot_bits pud_bits[] =3D {
> +       {
> +               .mask   =3D PUD_TYPE_SECT,
> +               .val    =3D PUD_TYPE_SECT,
> +               .set    =3D " ",
> +               .clear  =3D "F",
> +       }, {
> +               .mask   =3D PUD_TABLE_BIT,
> +               .val    =3D PUD_TABLE_BIT,
> +               .set    =3D "TBL",
> +               .clear  =3D "BLK",
> +       }, {
> +               .mask   =3D PTE_USER,
> +               .val    =3D PTE_USER,
> +               .set    =3D "USR",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PUD_SECT_RDONLY,
> +               .val    =3D PUD_SECT_RDONLY,
> +               .set    =3D "ro",
> +               .clear  =3D "RW",
> +       }, {
> +               .mask   =3D PTE_SHARED,
> +               .val    =3D PTE_SHARED,
> +               .set    =3D "SHD",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PTE_AF,
> +               .val    =3D PTE_AF,
> +               .set    =3D "AF",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PTE_NG,
> +               .val    =3D PTE_NG,
> +               .set    =3D "NG",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PTE_CONT,
> +               .val    =3D PTE_CONT,
> +               .set    =3D "CON",
> +               .clear  =3D "   ",
> +       }, {
> +               .mask   =3D PUD_TABLE_PXN,
> +               .val    =3D PUD_TABLE_PXN,
> +               .set    =3D "NXTbl",
> +               .clear  =3D "x    ",
> +       }, {
> +               .mask   =3D PUD_TABLE_UXN,
> +               .val    =3D PUD_TABLE_UXN,
> +               .set    =3D "UXNTbl",
> +               .clear  =3D "      ",
> +       }, {
> +               .mask   =3D PTE_GP,
> +               .val    =3D PTE_GP,
> +               .set    =3D "GP",
> +               .clear  =3D "  ",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_DEVICE_nGnRnE),
> +               .set    =3D "DEVICE/nGnRnE",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_DEVICE_nGnRE),
> +               .set    =3D "DEVICE/nGnRE",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL_NC),
> +               .set    =3D "MEM/NORMAL-NC",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL),
> +               .set    =3D "MEM/NORMAL",
> +       }, {
> +               .mask   =3D PMD_ATTRINDX_MASK,
> +               .val    =3D PMD_ATTRINDX(MT_NORMAL_TAGGED),
> +               .set    =3D "MEM/NORMAL-TAGGED",
> +       }
> +};
> +
>  struct pg_level {
>         const struct prot_bits *bits;
>         const char *name;
>         size_t num;
>         u64 mask;
> +       unsigned long size;
>  };
>
>  static struct pg_level pg_level[] =3D {
>         { /* pgd */
>                 .name   =3D "PGD",
> -               .bits   =3D pte_bits,
> -               .num    =3D ARRAY_SIZE(pte_bits),
> +               .bits   =3D pud_bits,
> +               .num    =3D ARRAY_SIZE(pud_bits),
> +               .size   =3D PGD_SIZE
>         }, { /* p4d */
>                 .name   =3D "P4D",
> -               .bits   =3D pte_bits,
> -               .num    =3D ARRAY_SIZE(pte_bits),
> +               .bits   =3D pud_bits,
> +               .num    =3D ARRAY_SIZE(pud_bits),
> +               .size   =3D P4D_SIZE
>         }, { /* pud */
>                 .name   =3D (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
> -               .bits   =3D pte_bits,
> -               .num    =3D ARRAY_SIZE(pte_bits),
> +               .bits   =3D pud_bits,
> +               .num    =3D ARRAY_SIZE(pud_bits),
>         }, { /* pmd */
>                 .name   =3D (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
> -               .bits   =3D pte_bits,
> -               .num    =3D ARRAY_SIZE(pte_bits),
> +               .bits   =3D pmd_bits,
> +               .num    =3D ARRAY_SIZE(pmd_bits),
>         }, { /* pte */
>                 .name   =3D "PTE",
>                 .bits   =3D pte_bits,
>                 .num    =3D ARRAY_SIZE(pte_bits),
> +               .size   =3D PAGE_SIZE
>         },
>  };
>
> @@ -252,7 +425,7 @@ static void note_page(struct ptdump_state *pt_st, uns=
igned long addr, int level,
>                       u64 val)
>  {
>         struct pg_state *st =3D container_of(pt_st, struct pg_state, ptdu=
mp);
> -       static const char units[] =3D "KMGTPE";
> +       static const char units[] =3D "BKMGTPE";
>         u64 prot =3D 0;
>
>         if (level >=3D 0)
> @@ -263,8 +436,8 @@ static void note_page(struct ptdump_state *pt_st, uns=
igned long addr, int level,
>                 st->current_prot =3D prot;
>                 st->start_address =3D addr;
>                 pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker-=
>name);
> -       } else if (prot !=3D st->current_prot || level !=3D st->level ||
> -                  addr >=3D st->marker[1].start_address) {
> +       } else if ((prot !=3D st->current_prot || level !=3D st->level ||
> +                  addr >=3D st->marker[1].start_address)) {
>                 const char *unit =3D units;
>                 unsigned long delta;
>
> @@ -273,10 +446,20 @@ static void note_page(struct ptdump_state *pt_st, u=
nsigned long addr, int level,
>                         note_prot_wx(st, addr);
>                 }
>
> -               pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> -                                  st->start_address, addr);
> +               /*
> +                * Entries are coalesced into a single line, so non-leaf
> +                * entries have no size relative to start_address
> +                */
> +               if (st->start_address !=3D addr) {
> +                       pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   =
",
> +                                          st->start_address, addr);
> +                       delta =3D (addr - st->start_address);
> +               } else {
> +                       pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   =
", addr,
> +                                          addr + pg_level[st->level].siz=
e);
> +                       delta =3D (pg_level[st->level].size);
> +               }
>
> -               delta =3D (addr - st->start_address) >> 10;
>                 while (!(delta & 1023) && unit[1]) {
>                         delta >>=3D 10;
>                         unit++;
> @@ -322,7 +505,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_in=
fo *info)
>                         .range =3D (struct ptdump_range[]){
>                                 {info->base_addr, end},
>                                 {0, 0}
> -                       }
> +                       },
> +                       .note_non_leaf =3D true
>                 }
>         };
>
> diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
> index 2a3a95586425..d32fa8515182 100644
> --- a/include/linux/ptdump.h
> +++ b/include/linux/ptdump.h
> @@ -16,6 +16,7 @@ struct ptdump_state {
>                           int level, u64 val);
>         void (*effective_prot)(struct ptdump_state *st, int level, u64 va=
l);
>         const struct ptdump_range *range;
> +       bool note_non_leaf;
>  };
>
>  void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_=
t *pgd);
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index eea3d28d173c..aacbd499ffcd 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -40,6 +40,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long a=
ddr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 0, pgd_val(val));
>
> +       if (st->note_non_leaf && !pgd_leaf(val))
> +               st->note_page(st, addr, 0, pgd_val(val));
> +
>         if (pgd_leaf(val)) {
>                 st->note_page(st, addr, 0, pgd_val(val));
>                 walk->action =3D ACTION_CONTINUE;
> @@ -63,6 +66,9 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long a=
ddr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 1, p4d_val(val));
>
> +       if (st->note_non_leaf && !p4d_leaf(val))
> +               st->note_page(st, addr, 1, p4d_val(val));
> +
>         if (p4d_leaf(val)) {
>                 st->note_page(st, addr, 1, p4d_val(val));
>                 walk->action =3D ACTION_CONTINUE;
> @@ -86,6 +92,9 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long a=
ddr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 2, pud_val(val));
>
> +       if (st->note_non_leaf && !pud_leaf(val))
> +               st->note_page(st, addr, 2, pud_val(val));
> +
>         if (pud_leaf(val)) {
>                 st->note_page(st, addr, 2, pud_val(val));
>                 walk->action =3D ACTION_CONTINUE;
> @@ -107,6 +116,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned lon=
g addr,
>
>         if (st->effective_prot)
>                 st->effective_prot(st, 3, pmd_val(val));
> +
> +       if (st->note_non_leaf && !pmd_leaf(val))
> +               st->note_page(st, addr, 3, pmd_val(val));
> +
>         if (pmd_leaf(val)) {
>                 st->note_page(st, addr, 3, pmd_val(val));
>                 walk->action =3D ACTION_CONTINUE;
>
> base-commit: 5f9df76887bf8170e8844f1907c13fbbb30e9c36
> --
> 2.34.1
>

