Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9918A7F5575
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjKWAj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:39:56 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF418D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:39:52 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4aff11732bdso122503e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700699991; x=1701304791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwQlGsWYOqxIdXRKSpiAx1SqqlnvS6MmmN0ONz1p3kw=;
        b=RRZIL99uxKIkg9PhXUUIXtZh1h9w3o+SPf1P8cLdFneOeI409O+kM1ooPwBeRf5dcZ
         clgoO1aN84vqzZ5MQZK0bSyEdwnVRCKtw7lMUiAmbrueqWjdJFYvZsG9glWkfUl5Ww14
         DUw6nQsJj66/nNYUUrOvxszd+8FNJmQfkhD4cS60x6sRypWGsSlpi9sEKn23Nuc7EgAF
         GPa7zX84rv80I9eMXeOgAdnkDo6YwUuIqgvG6E4eLXsjHsONLWGdJLdwsh3CVWRdlMNh
         SOIs91v/9x+fgRP6LUFSZzw4qPWCOc03CMjk9ENZtlDktXS8gouY/Ad8Z1WqD0tF9bPg
         3DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700699991; x=1701304791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwQlGsWYOqxIdXRKSpiAx1SqqlnvS6MmmN0ONz1p3kw=;
        b=cDgSPrfL3iCm6BsZnN/hw+bCMgLmchhOWJzBiIRaJNMmyo7Yah9CDYTMdl+NN0qVfh
         78LEEAZ6bOhrcuNQ2wct64DHO4bHLIixuktuEX/eUmLl81+2Wg13EhLVM8foFHqGGSG9
         9CbvTpIVg+kkuENQWHpK3eCP1nR7oYUFYyKJbAFRkqzxWPVxZhlCMB++VqxJwsZm2KAk
         ZTwK9d2wpluJ6P9cJef0R1lA2/pYE0Lnh2G71/uW050VpFYraTqZULb7AElfaSZoz6Gk
         0XdXHppyz4+GlCGS//jlOAbl5DO1/qbJLZe8xJRDuRqSRh8ROVAMAa4leZnsMlzfHei6
         2BSA==
X-Gm-Message-State: AOJu0YyOvvrGfhKpRhfmf9QPPW2crGL4NDVKdXx3sXDFXGVThGRL6nSN
        Z5NuDFth6U1i5kj4m9aB0ZvAgENwbVqxPT5E6Uw=
X-Google-Smtp-Source: AGHT+IEq7du79WE0HCEszn4TAAwpuHFwCiiAJe28LVauqC0P++29Al260qNAZ/zpmAXClF4k0a7dvbQ3EGfiisUn7kk=
X-Received: by 2002:a1f:6244:0:b0:4ac:962c:c2ea with SMTP id
 w65-20020a1f6244000000b004ac962cc2eamr4289472vkb.10.1700699991089; Wed, 22
 Nov 2023 16:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
In-Reply-To: <20231122231202.121277-1-andrey.konovalov@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 23 Nov 2023 09:39:39 +0900
Message-ID: <CAB=+i9QFeQqSAhwY_BF-DZvZ9TL_rWz7nMOBhDWhXecamsn=dw@mail.gmail.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> When both KASAN and slub_debug are enabled, when a free object is being
> prepared in setup_object, slub_debug poisons the object data before KASAN
> initializes its per-object metadata.
>
> Right now, in setup_object, KASAN only initializes the alloc metadata,
> which is always stored outside of the object. slub_debug is aware of
> this and it skips poisoning and checking that memory area.
>
> However, with the following patch in this series, KASAN also starts
> initializing its free medata in setup_object. As this metadata might be
> stored within the object, this initialization might overwrite the
> slub_debug poisoning. This leads to slub_debug reports.
>
> Thus, skip checking slub_debug poisoning of the object data area that
> overlaps with the in-object KASAN free metadata.
>
> Also make slub_debug poisoning of tail kmalloc redzones more precise when
> KASAN is enabled: slub_debug can still poison and check the tail kmalloc
> allocation area that comes after the KASAN free metadata.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Thank you for looking at this quickly!
Unfortunately the problem isn't fixed yet with the patch.

I applied this on top of linux-next and built a kernel with the same config=
,
it is still stuck at boot.

[dmesg]

[    0.000000] Linux version
6.7.0-rc2-next-20231122-00001-gfc1613c2f6f3
(hyeyoo@localhost.localdomain) (gcc (GCC) 11.33
[    0.000000] Command line: console=3DttyS0 root=3D/dev/sda1 nokaslr
[    0.000000] RIP: 0010:setup_arch (arch/x86/kernel/setup.c:443
arch/x86/kernel/setup.c:665 arch/x86/kernel/setup.c:81
[ 0.000000] Code: b6 0a 08 00 48 89 c5 48 85 c0 0f 84 58 13 00 00 48
c1 e8 03 48 83 05 4e a9 66 00 01 80 3c 18 00 0f3

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   b6 0a                   mov    $0xa,%dh
   2:   08 00                   or     %al,(%rax)
   4:   48 89 c5                mov    %rax,%rbp
   7:   48 85 c0                test   %rax,%rax
   a:   0f 84 58 13 00 00       je     0x1368
  10:   48 c1 e8 03             shr    $0x3,%rax
  14:   48 83 05 4e a9 66 00    addq   $0x1,0x66a94e(%rip)        # 0x66a96=
a
  1b:   01
  1c:   80 3c 18 00             cmpb   $0x0,(%rax,%rbx,1)
  20:   f3                      repz
[    0.000000] RSP: 0000:ffffffff86207e00 EFLAGS: 00010046 ORIG_RAX:
0000000000000009
[    0.000000] RAX: 1fffffffffe40069 RBX: dffffc0000000000 RCX: 1ffffffff12=
30a30
[    0.000000] RDX: 0000000000000000 RSI: 0107d62120059000 RDI: ffffffff891=
85180
[    0.000000] RBP: ffffffffff200348 R08: 8000000000000163 R09: 1ffffffff12=
30a28
[    0.000000] R10: ffffffff89194150 R11: 0000000000000000 R12: 00000000000=
00010
[    0.000000] R13: ffffffffff200354 R14: 0107d62120058348 R15: 0107d621200=
58348
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff88f75000(0000)
knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffff200348 CR3: 0000000009128000 CR4: 00000000000=
000b0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000] ? show_regs (arch/x86/kernel/dumpstack.c:478)
[    0.000000] ? early_fixup_exception (arch/x86/mm/extable.c:364)
[    0.000000] ? do_early_exception (arch/x86/kernel/head64.c:423)
[    0.000000] ? early_idt_handler_common (arch/x86/kernel/head_64.S:555)
[    0.000000] ? setup_arch (arch/x86/kernel/setup.c:443
arch/x86/kernel/setup.c:665 arch/x86/kernel/setup.c:814)
[    0.000000] ? __pfx_setup_arch (arch/x86/kernel/setup.c:728)
[    0.000000] ? vprintk_default (kernel/printk/printk.c:2318)
[    0.000000] ? vprintk (kernel/printk/printk_safe.c:45)
[    0.000000] ? _printk (kernel/printk/printk.c:2328)
[    0.000000] ? __pfx__printk (kernel/printk/printk.c:2323)
[    0.000000] ? init_cgroup_root (kernel/cgroup/cgroup.c:2054)
[    0.000000] ? cgroup_init_early (kernel/cgroup/cgroup.c:6077
(discriminator 13))
[    0.000000] ? start_kernel (init/main.c:897 (discriminator 3))
[    0.000000] ? x86_64_start_reservations (arch/x86/kernel/head64.c:543)
[    0.000000] ? x86_64_start_kernel (arch/x86/kernel/head64.c:536)
[    0.000000] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:=
432)
[    0.000000]  </TASK>
