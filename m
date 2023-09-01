Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8678F918
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbjIAH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:29:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5F10D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:29:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58caaedb20bso18733017b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693553356; x=1694158156; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LW3hHQLLB7chZFzQzoqJF0V/Isvx2JGSHv0+TQLQ+U=;
        b=a0cQlyU+wy12nJq3e18eCAkkoq9QwDg92kplUTpKz/xu/IV3erV016s4cUZVzh0jqW
         L9mib5gW2+S813XwWXya0hHKXfJJV++c1vc+Uz7Dn87hkJHfMN2ITUZpCGaZ8M8M4w9o
         WnTG3jaUrZy0dSPZiMyZwx+JlJOZypMXOU31cZIesg4t5k2ilXDgCV51D3uHF33WsuLw
         Tt2yZ0ZDtU3sw+c7Jp2JAxlF6QGN205qUGE9067B4XfS/+bQ3ldmslN8RJKtaqxtsHA9
         d6TXvweWv6+Y9Mt919cXMHgqf3tIkON7mJ2JUqg0W3cTwH0HmFFB6FlMO/+eOkGE4hCn
         O4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693553356; x=1694158156;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LW3hHQLLB7chZFzQzoqJF0V/Isvx2JGSHv0+TQLQ+U=;
        b=ixOC9L/e+8UZB2FlLnFk0wf8jtjnTKDMPJXmTr1QSOk8PHda0AhALqz5B284eQJ/Nj
         hz5+DFtsBjclF37YOKe86R4LoX2UJ2IEOki9OMrf5D0ehkTo95gYIgheixm1hQUkEpfH
         4Ty0hPf5KfNRismmL0/jOmMUk6BxWVa80tfAym2cOn+QfTbAnEm5k+UGpy5XmKlBxlBp
         PG10Lvucvq7wg1Z3++Gil6qthZmCUCFOjAgstXDbGq+r8IPEgW2i1E9YUSehyOVTaBe/
         qD9aax/WTYOAFchel38LTRgXntHCFogT9r+8a3LVCqD8c9Og6I+uwkHac5J3CKSyCcFr
         tm/g==
X-Gm-Message-State: AOJu0YwaIlh3rJwmg0l9Eu5A3Z7L0G+3OebAi11qROPYF7lEhUX3g4lJ
        GPnqL5AulSQ+TmhVqYWkTeoP5g==
X-Google-Smtp-Source: AGHT+IHYTT7ITidyIX5/cLirH9qENQ5ZkDTlXFDxmVfuerWktFS//V5VtHC8epHEM5ckxMnPsUOpQQ==
X-Received: by 2002:a05:6902:188a:b0:ced:abcd:62e5 with SMTP id cj10-20020a056902188a00b00cedabcd62e5mr2432793ybb.7.1693553356372;
        Fri, 01 Sep 2023 00:29:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v13-20020a25fc0d000000b00d6861b49f01sm767447ybd.65.2023.09.01.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 00:29:15 -0700 (PDT)
Date:   Fri, 1 Sep 2023 00:29:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: Re: 6.6/regression/bisected - after commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
 system stopped booting
In-Reply-To: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com>
Message-ID: <3548ca67-ce58-3bc6-fef5-348b98d7678b@google.com>
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-707783301-1693553355=:17635"
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-707783301-1693553355=:17635
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Sep 2023, Mikhail Gavrilov wrote:

> Hi,
> next release cycle, and another regression.
> Yesterday after another kernel update in Fedora Rawhide system stopped bo=
oting.

Many thanks for reporting, Mike: I'm sorry that it never showed up
while in linux-next, leaving you to be the one to hit it again.

> Today thanks to git bisect, I found out that this is a commit:
>=20
> =E2=9D=AF git bisect bad
> a349d72fd9efc87c8fd1d16d3164752d84a7275b is the first bad commit
> commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
> Author: Hugh Dickins <hughd@google.com>
> Date:   Tue Jul 11 21:30:40 2023 -0700
>=20
>     mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
=2E..
>     Before putting them to use (several commits later), add rcu_read_lock=
() to
>     pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
>     separate commit, since it risks exposing imbalances: prior commits ha=
ve
>     fixed all the known imbalances, but we may find some have been missed=
=2E

I assume that it is such an imbalance - somewhere omitting to
pte_unmap() after a pte_offset_map(); but I cannot see where.

> It looks like the hang happens so early that when booting into a
> working kernel and running "journalctl -b -1" I see in the console the
> log of the previous kernel which was booted before the problematic
> kernel.
> Therefore, I apologize that I can't provide the kernel logs.
> I can provides only photos when backtrace appears on my monitor:
> Here we waiting: https://ibb.co/5xmm0BH
> And then I see backtrace: https://ibb.co/TLLGFNP
>=20
> Unfortunately I can't revert commit
> a349d72fd9efc87c8fd1d16d3164752d84a7275b for testing more fresh builds
> because of conflicts.
>=20
> My hardware: https://linux-hardware.org/?probe=3Ddd5735f315
> I also attached kernel build config and full bisect log.

Thanks for all the info, which has helped in several ways.  The only
thing I can do is to offer you a debug (and then keep running) patch -
suitable for the config you showed there, not for anyone else's config.

I've never used stackdepot before, but I've tried this out in good and
bad cases, and expect it to work for you, shedding light on where is
going wrong - machine should boot up fine, and in dmesg you'll find one
stacktrace between "WARNING: pte_map..." and "End of pte_map..." lines.

To apply on top of a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
rcu_read_unlock()s"), the bad end point of your bisection; but if you
prefer, I can provide a version to go on top of whatever later Linus
commit suits you.

Patch not for general consumption, just for Mike's debugging:
please report back the stacktrace shown - thanks!

Hugh

---
 include/linux/pgtable.h |  5 +----
 mm/memory.c             |  1 +
 mm/mremap.c             |  1 +
 mm/pgtable-generic.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5134edcec668..131392f1c33e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -106,10 +106,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned lo=
ng address)
 {
 =09return pte_offset_kernel(pmd, address);
 }
-static inline void pte_unmap(pte_t *pte)
-{
-=09rcu_read_unlock();
-}
+void pte_unmap(pte_t *pte);
 #endif
=20
 /* Find an entry in the second-level page table.. */
diff --git a/mm/memory.c b/mm/memory.c
index 44d11812a88f..b1ee8ab51978 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1033,6 +1033,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct=
 vm_area_struct *src_vma,
 =09=09ret =3D -ENOMEM;
 =09=09goto out;
 =09}
+=09pte_unmap(NULL);=09/* avoid warning when knowingly nested */
 =09src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
 =09if (!src_pte) {
 =09=09pte_unmap_unlock(dst_pte, dst_ptl);
diff --git a/mm/mremap.c b/mm/mremap.c
index 11e06e4ab33b..56d981add487 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -175,6 +175,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t =
*old_pmd,
 =09=09err =3D -EAGAIN;
 =09=09goto out;
 =09}
+=09pte_unmap(NULL);=09/* avoid warning when knowingly nested */
 =09new_pte =3D pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
 =09if (!new_pte) {
 =09=09pte_unmap_unlock(old_pte, old_ptl);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 400e5a045848..87cbdc73beda 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -232,11 +232,47 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,=
 unsigned long address,
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
=20
+#include <linux/stacktrace.h>
+#include <linux/stackdepot.h>
+#include <linux/timekeeping.h>
+
+static depot_stack_handle_t depot_stack;
+
+static void pte_map(void)
+{
+=09static bool done =3D false;
+=09unsigned long entries[16];
+=09unsigned int nr_entries;
+
+=09/* rcu_read_lock(); */
+=09if (raw_smp_processor_id() !=3D 0 || done)
+=09=09return;
+=09if (depot_stack) {
+=09=09pr_warn("WARNING: pte_map was not pte_unmapped:\n");
+=09=09stack_depot_print(depot_stack);
+=09=09pr_warn("End of pte_map warning.\n");
+=09=09done =3D true;
+=09=09return;
+=09}
+=09nr_entries =3D stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+=09depot_stack =3D stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+=09if (ktime_get_seconds() > 1800)=09/* give up after half an hour */
+=09=09done =3D true;
+}
+
+void pte_unmap(pte_t *pte)
+{
+=09/* rcu_read_unlock(); */
+=09if (raw_smp_processor_id() !=3D 0)
+=09=09return;
+=09depot_stack =3D 0;
+}
+
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
 =09pmd_t pmdval;
=20
-=09rcu_read_lock();
+=09pte_map();
 =09pmdval =3D pmdp_get_lockless(pmd);
 =09if (pmdvalp)
 =09=09*pmdvalp =3D pmdval;
@@ -250,7 +286,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,=
 pmd_t *pmdvalp)
 =09}
 =09return __pte_map(&pmdval, addr);
 nomap:
-=09rcu_read_unlock();
+=09pte_unmap(NULL);
 =09return NULL;
 }
=20
--=20
2.35.3
---1463760895-707783301-1693553355=:17635--
