Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B278FA78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348720AbjIAJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjIAJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:08:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8454E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:08:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58fb8963617so19336747b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693559308; x=1694164108; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQp453fyxfLaIMKLm7m/qCORi7oMVxxUFQzr/Nzu5P4=;
        b=omMeTqAZh9YOnCeyIIexTEZAPCykXPr/iRQmb2Rwjd5dcsvpNtm94YsDNz843Y/h8h
         y0mVVNtt72LHSI/Qf3m6SW779CRPDlEjJdgS6rPGooVhiajWV6SEesZ7ofM9hqIRVHzX
         YHPVUMa78Wn/00G6RWgaHETRM62vzMkZMi0YcqBBNrX4E3q01ruko7SZOtLJ1/3RigJE
         fTOntuRdEn25vY2o08D5UsQI2iqbbuCcvhA7TFyg3y9zq74arLAD8z5QttO44/3lggea
         aVrMIpLhBU9ArZMFTnHDZ9VqtlTFxRohN6NFw0B1nIB08huDowBh4q+AIL06B7kL2xzJ
         1tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559308; x=1694164108;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQp453fyxfLaIMKLm7m/qCORi7oMVxxUFQzr/Nzu5P4=;
        b=IwbVl2v2zBZ6BaIarTOwCkVKzF86k1SFGHJnNT1hlMTVz8MpEdGVBqKXBKATnJ60fN
         Ssaqu7fN9SUM8zIdVRwOQTC2X6ey1mnU2uyA3V4230Po4XOlj3MBu6IsCt6SZZZrS2kM
         Jt0baaEQEymhGs0RnwdwLwrkxEyKd6nSakq11X+RgSHpswRIZEwCd+XcvdfB0xdm5oqn
         G7mFpq2k7jAfixc7ltf9T3VvGWmCwH4OOTixsvxH7VVJiX1g5v7qCRM4kpUcA019mw8f
         B33KZQP1k6W0CD9CB+lpdN9SnI6dcmrbzdcC3t/cntJfTeJcuM+3bSGnV0AU77Ri5Ieb
         81eA==
X-Gm-Message-State: AOJu0YwoxEBInIT8COMeeXXnPYS0fR1OPUVvuAkFtGr4Z74dVVluY2Hu
        yNyIjkOiy0NQZdqCxMM2zLnlUAU84mlhgEoG09nHDA==
X-Google-Smtp-Source: AGHT+IHcez0sRgs5TYw0I8gyY+EH/oBmuOE7IGCCPuDhc8AqV6eyui+E7HM9ojHfdeHqBTEcVYJWuA==
X-Received: by 2002:a0d:e305:0:b0:58d:7599:676a with SMTP id m5-20020a0de305000000b0058d7599676amr1997048ywe.37.1693559307844;
        Fri, 01 Sep 2023 02:08:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b005832fe29034sm959288ywd.89.2023.09.01.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:08:27 -0700 (PDT)
Date:   Fri, 1 Sep 2023 02:08:18 -0700 (PDT)
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
In-Reply-To: <CABXGCsOyamBvQ=Y-M9HQBTfEDfaRwGqzXqayBm7L259Q+t+gJQ@mail.gmail.com>
Message-ID: <98eb1ba4-5bd3-ee7-1a88-47b054dc938@google.com>
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com> <3548ca67-ce58-3bc6-fef5-348b98d7678b@google.com> <CABXGCsOyamBvQ=Y-M9HQBTfEDfaRwGqzXqayBm7L259Q+t+gJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1745119313-1693559307=:19235"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1745119313-1693559307=:19235
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Sep 2023, Mikhail Gavrilov wrote:
> On Fri, Sep 1, 2023 at 12:29=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> >
> >
> > Thanks for all the info, which has helped in several ways.  The only
> > thing I can do is to offer you a debug (and then keep running) patch -
> > suitable for the config you showed there, not for anyone else's config.
> >
> > I've never used stackdepot before, but I've tried this out in good and
> > bad cases, and expect it to work for you, shedding light on where is
> > going wrong - machine should boot up fine, and in dmesg you'll find one
> > stacktrace between "WARNING: pte_map..." and "End of pte_map..." lines.
> >
> > To apply on top of a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
> > rcu_read_unlock()s"), the bad end point of your bisection; but if you
> > prefer, I can provide a version to go on top of whatever later Linus
> > commit suits you.
> >
> > Patch not for general consumption, just for Mike's debugging:
> > please report back the stacktrace shown - thanks!
> >
>=20
> Thanks for digging into the problem.
> With the attached patch I got FTBFS when build kernel at commit a349d72fd=
9ef.
>=20
>=20
>   LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>   MODPOST Module.symvers
> ERROR: modpost: "pte_unmap" [arch/x86/kvm/kvm.ko] undefined!
> ERROR: modpost: "pte_unmap" [drivers/vfio/vfio_iommu_type1.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:144: Module.symvers] Error 1
> make[1]: *** [/home/mikhail/packaging-work/git/linux/Makefile:1984:
> modpost] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Sorry about that, please try this instead, adds EXPORT_SYMBOL(pte_unmap).

---
 include/linux/pgtable.h |  5 +----
 mm/memory.c             |  1 +
 mm/mremap.c             |  1 +
 mm/pgtable-generic.c    | 41 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 42 insertions(+), 6 deletions(-)

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
index 400e5a045848..958ee5cf91b1 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -232,11 +232,48 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,=
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
+EXPORT_SYMBOL(pte_unmap);
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
@@ -250,7 +287,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,=
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
---1463760895-1745119313-1693559307=:19235--
