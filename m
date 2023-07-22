Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BA75D802
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGVAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGVAFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:05:49 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E212F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:05:48 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583b3aa4f41so2045147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689984348; x=1690589148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gilgmM3T5/NO10gFbFfqKTcuQVcjb78tMR3nmoqFU0M=;
        b=7a0ETakWVKpUKxncf4WB0YUPORg4ERAZLthtoN1muAeu8Eo24Tcw51rxTbRFIhlL4N
         PCl55xfnooRDA0g3L5YizNjjHl+SgpJpO+TsL/prUWsM0Al0SvubCJAW8a+wy+CTQDOc
         NISkNBGulVqHikK1TmnccpTwV5EekVQtDOIvlqYvuzhTMImZ8eSI71PmMNL2iEoyRso7
         415bBqMa/e1h3InB3zEK5GPYaYSbuBT//ap+cidPJS6ku6CL32nwbBWhO9zyNHGWrKFB
         betNjH+5kKALWNs0tP1nsn+94VEtho5S7C6YhoqL4SmxSr9jCvNy8os4zckTAm742G2O
         lq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984348; x=1690589148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gilgmM3T5/NO10gFbFfqKTcuQVcjb78tMR3nmoqFU0M=;
        b=hXkKUzs4U0kAZ+JwoqRxOCHeBWO71NkdqudDr9kpjLmtaLCLYavSYTbxxV7KGkzaoF
         NAuN9b4zjEqKJjcAsLdhBfNgytz5zK7hp0ubPSATEszVuMHTMigYw17uUg0umKaIfA5/
         MDYT5sA/hA/vUGdPmNVRD3+u3c+fPLOl5v3tSjiOplRrBvaJROeVZRGciY0h/8d89w9+
         Dc6lqvG0Zp7QuZQ8ATHl0aaben2wz/cbqo7IXU58hXpdrJgx1Usxz4bLDONrsF06QNj1
         63UJArNZYpc79vGgxD8Sn48Lx8AkQ0+PQy4WxE+xbngUrUXY7747tpXsMb0U11Lpaz5q
         6Qeg==
X-Gm-Message-State: ABy/qLZO+Ob2+cahtH9yN/PrtR6Ma40YRmsnqpAnnl7BuN0BVqsirPo5
        KiEmsNOYkHFoSFQESNmBBBwn6MhSMqOKxfm0Qsd2ew==
X-Google-Smtp-Source: APBJJlHSkvKhK/NasDaYJ11LN/tb8BV7TC00wY/CCFhdkwG0zIAKsUxOEFovv4IpP1NB81j0ZIsmu89aEHmwY09HI38=
X-Received: by 2002:a25:77d2:0:b0:cf6:5149:211a with SMTP id
 s201-20020a2577d2000000b00cf65149211amr3406479ybc.55.1689984347588; Fri, 21
 Jul 2023 17:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230721034643.616851-1-jannh@google.com>
In-Reply-To: <20230721034643.616851-1-jannh@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Jul 2023 17:05:33 -0700
Message-ID: <CAJuCfpFaju-oAWyPKwApgUFdscrzX5LDTov1uxpw=MbsrL+cZQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Lock VMA in dup_anon_vma() before setting ->anon_vma
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:46=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> When VMAs are merged, dup_anon_vma() is called with `dst` pointing to the
> VMA that is being expanded to cover the area previously occupied by anoth=
er
> VMA. This currently happens while `dst` is not write-locked.
>
> This means that, in the `src->anon_vma && !dst->anon_vma` case, as soon a=
s
> the assignment `dst->anon_vma =3D src->anon_vma` has happened, concurrent
> page faults can happen on `dst` under the per-VMA lock.
> This is already icky in itself, since such page faults can now install
> pages into `dst` that are attached to an `anon_vma` that is not yet tied
> back to the `anon_vma` with an `anon_vma_chain`.
> But if `anon_vma_clone()` fails due to an out-of-memory error, things get
> much worse: `anon_vma_clone()` then reverts `dst->anon_vma` back to NULL,
> and `dst` remains completely unconnected to the `anon_vma`, even though w=
e
> can have pages in the area covered by `dst` that point to the `anon_vma`.
>
> This means the `anon_vma` of such pages can be freed while the pages are
> still mapped into userspace, which leads to UAF when a helper like
> folio_lock_anon_vma_read() tries to look up the anon_vma of such a page.
>
> This theoretically is a security bug, but I believe it is really hard to
> actually trigger as an unprivileged user because it requires that you can
> make an order-0 GFP_KERNEL allocation fail, and the page allocator tries
> pretty hard to prevent that.
>
> I think doing the vma_start_write() call inside dup_anon_vma() is the mos=
t
> straightforward fix for now.

Indeed, this is a valid fix because we end up modifying the 'dst'
without locking it. Locking in vma_merge()/vma_expand() happens inside
vma_prepare() but that's too late because dup_anon_vma() would already
happen.

>
> For a kernel-assisted reproducer, see the notes section of the patch mail=
.
>
> Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to contro=
l it")
> Cc: stable@vger.kernel.org
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> To reproduce, patch mm/rmap.c by adding "#include <linux/delay.h>" and
> changing anon_vma_chain_alloc() like this:
>
>  static inline struct anon_vma_chain *anon_vma_chain_alloc(gfp_t gfp)
>  {
> +       if (strcmp(current->comm, "FAILME") =3D=3D 0) {
> +               // inject delay and error
> +               mdelay(2000);
> +               return NULL;
> +       }
>         return kmem_cache_alloc(anon_vma_chain_cachep, gfp);
>  }
>
> Then build with KASAN and run this reproducer:
>
>
> #define _GNU_SOURCE
> #include <pthread.h>
> #include <err.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <sys/mman.h>
> #include <sys/prctl.h>
>
> #define SYSCHK(x) ({          \
>   typeof(x) __res =3D (x);      \
>   if (__res =3D=3D (typeof(x))-1L) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
>
> static char *area;
> static volatile int fault_thread_done;
> static volatile int spin_launch;
>
> static void *fault_thread(void *dummy) {
>   while (!spin_launch) /*spin*/;
>   sleep(1);
>   area[0] =3D 1;
>   fault_thread_done =3D 1;
>   return NULL;
> }
>
> int main(void) {
>   fault_thread_done =3D 0;
>   pthread_t thread;
>   if (pthread_create(&thread, NULL, fault_thread, NULL))
>     errx(1, "pthread_create");
>
>   // allocator spam
>   int fd =3D SYSCHK(open("/etc/hostname", O_RDONLY));
>   char *vmas[10000];
>   for (int i=3D0; i<5000; i++) {
>     vmas[i] =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE, fd, 0));
>     *vmas[i] =3D 1;
>   }
>
>   // create a 3-page area, no anon_vma at this point, with guard vma behi=
nd it to prevent merging with neighboring anon_vmas
>   area =3D SYSCHK(mmap((void*)0x10000, 0x4000, PROT_READ|PROT_WRITE, MAP_=
PRIVATE|MAP_ANONYMOUS, -1, 0));
>   SYSCHK(mmap(area+0x3000, 0x1000, PROT_READ, MAP_SHARED|MAP_FIXED, fd, 0=
));
>   // turn it into 3 VMAs
>   SYSCHK(mprotect(area+0x1000, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC));
>
>   // create an anon_vma for the tail VMA
>   area[0x2000] =3D 1;
>
>   // more allocator spam
>   for (int i=3D5000; i<10000; i++) {
>     vmas[i] =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE, fd, 0));
>     *vmas[i] =3D 1;
>   }
>
>   printf("with anon_vma on tail VMA:\n\n");
>   system("cat /proc/$PPID/smaps | head -n55");
>   printf("\n\n");
>
>   spin_launch=3D1;
>   // mprotect() will try to merge the VMAs but bail out due to the inject=
ed
>   // allocator failure
>   SYSCHK(prctl(PR_SET_NAME, "FAILME"));
>   SYSCHK(mprotect(area+0x1000, 0x1000, PROT_READ|PROT_WRITE));
>   SYSCHK(prctl(PR_SET_NAME, "normal"));
>
>   printf("after merge from mprotect:\n\n");
>   if (!fault_thread_done)
>     errx(1, "fault thread not done yet???");
>   system("cat /proc/$PPID/smaps | head -n55");
>   printf("\n\n");
>
>   // release the anon_vma
>   SYSCHK(munmap(area+0x1000, 0x2000));
>
>   // release spam
>   for (int i=3D0; i<10000; i++)
>     SYSCHK(munmap(vmas[i], 0x1000));
>
>   // wait for RCU
>   sleep(2);
>
>   // trigger UAF?
>   printf("trying to trigger uaf...\n");
>   SYSCHK(madvise(area, 0x1000, 21/*MADV_PAGEOUT*/));
> }
>
>
> You should get an ASAN splat like:
>
> BUG: KASAN: use-after-free in folio_lock_anon_vma_read+0x9d/0x2f0
> Read of size 8 at addr ffff8880053a2660 by task normal/549
>
> CPU: 1 PID: 549 Comm: normal Not tainted 6.5.0-rc2-00073-ge599e16c16a1-di=
rty #292
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x36/0x50
>  print_report+0xcf/0x660
> [...]
>  kasan_report+0xc7/0x100
> [...]
>  folio_lock_anon_vma_read+0x9d/0x2f0
>  rmap_walk_anon+0x282/0x350
> [...]
>  folio_referenced+0x277/0x2a0
> [...]
>  shrink_folio_list+0xc9f/0x15c0
> [...]
>  reclaim_folio_list+0xdc/0x1f0
> [...]
>  reclaim_pages+0x211/0x280
> [...]
>  madvise_cold_or_pageout_pte_range+0x2ea/0x6a0
> [...]
>  walk_pgd_range+0x6c5/0xb90
> [...]
>  __walk_page_range+0x27f/0x290
> [...]
>  walk_page_range+0x1fd/0x230
> [...]
>  madvise_pageout+0x1cd/0x2d0
> [...]
>  do_madvise+0xb58/0x1280
> [...]
>  __x64_sys_madvise+0x62/0x70
>  do_syscall_64+0x3b/0x90
> [...]
>
>
>  mm/mmap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3eda23c9ebe7..3937479d0e07 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -615,6 +615,7 @@ static inline int dup_anon_vma(struct vm_area_struct =
*dst,
>          * anon pages imported.
>          */
>         if (src->anon_vma && !dst->anon_vma) {
> +               vma_start_write(dst);
>                 dst->anon_vma =3D src->anon_vma;
>                 return anon_vma_clone(dst, src);
>         }
>
> base-commit: e599e16c16a16be9907fb00608212df56d08d57b
> --
> 2.41.0.487.g6d72f3e995-goog
>
