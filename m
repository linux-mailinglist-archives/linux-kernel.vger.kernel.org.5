Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D076764170
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjGZVvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGZVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:51:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AEFA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:51:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so33575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690408294; x=1691013094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/DQhcgtu922pQLC21kJm/tt2ZF3dA+O3ehlQ8Mq7SY=;
        b=UO/isL6/HLbaEZSQKrxXYX3XYOeGvlWQSZRGM3TsqdGsXuu38hVMfIWnV58sC4vL9l
         bSPOdFLS+GJxda8nhUvXuZOZK1OVfAKExTxLRvpdEDMQzrrjFztUDvZN6y8BpxSBOHaE
         mtwgJ0yYgU7IbeItctRrswgngNFYMzwWDplyPiy/czQghhCQ+135HhT69pERN5cGS29+
         jO2KRsRp2tr4pdXxVtUu5nvGvfH1YGjX4TMZnM80j5xPjsimep47Qg4i2FbynXK2y8xz
         q5Qg89oI9YYHDf7YxXxsBjDso+GPPXV4kH1wgPgmwL8EygI8nmSw1JTGRSo33F8WoTFA
         xIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408294; x=1691013094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/DQhcgtu922pQLC21kJm/tt2ZF3dA+O3ehlQ8Mq7SY=;
        b=hPweo/+gAFgfWQTWlefrnRW5kdTq4zT+Un4vlGeYcPGzXNk3+URbkRdD4QUNFZ3Xh2
         La5FoGNkt0ZW/m6UQCeNLQDPFwMvE1F4fo/LwyREVtQf8BVJ2zMp6/0Iv5uyo4mjDD2d
         I18DYlPMyENa1SlC/Fzqyy8C1DRtGkqY8d4FgV1wU7pRCe8ATRwFfwkIMTrKx6l38n09
         X7j2Nqqw7PFCN6010qBLMi0AyCQDA4HJwF2YZYjSyMNTbDs5uB/MZ7OTgePwkrgq3gCG
         juUGpbcyJ+u67DUd1bfC0CEVacbEC8A7hIjisha/i4Ss4/mrPGb3f6hObfYXrlTWleSG
         aunw==
X-Gm-Message-State: ABy/qLbPLFvBi3UgRAxobhwu3EbhDRTwA1PYQylP7ekyhkekAuZ5H4d9
        u0+JIQZoxxnRXpzevxvktoEGdp5aOMMOvnkfwgGv4Q==
X-Google-Smtp-Source: APBJJlH3fbElG+U0R3Oqh4ZxT607Nuqbr2/hIgOf2+o6YECzw2j9CVI9NeOQ5Vg8Wd7Q3XNIA5nj6/n1WJ3Jh1UaBJg=
X-Received: by 2002:a05:600c:690d:b0:3f1:70d1:21a6 with SMTP id
 fo13-20020a05600c690d00b003f170d121a6mr30058wmb.0.1690408294088; Wed, 26 Jul
 2023 14:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <20230726214103.3261108-4-jannh@google.com>
In-Reply-To: <20230726214103.3261108-4-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Jul 2023 23:50:57 +0200
Message-ID: <CAG48ez00FhfjTReO8+B43tEXuzFcat1mQs3jxu_eGFzEp2Vsag@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Fix anon_vma memory ordering
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:42=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> A read of vma->anon_vma under mmap_lock in read mode (in particular in
> anon_vma_prepare()) can race with a concurrent update under mmap_lock
> in read mode plus pagetable lock (in __prepare_anon_vma()).
> However, the only allowed concurrent update is one that changes
> vma->anon_vma from NULL to a non-NULL pointer; once vma->anon_vma has
> been set to a non-NULL value, it will keep that value as long as the
> mmap lock is held in read mode.
[...]
> @@ -1072,7 +1071,15 @@ static int anon_vma_compatible(struct vm_area_stru=
ct *a, struct vm_area_struct *
>  static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, st=
ruct vm_area_struct *a, struct vm_area_struct *b)
>  {
>         if (anon_vma_compatible(a, b)) {
> -               struct anon_vma *anon_vma =3D READ_ONCE(old->anon_vma);
> +               /*
> +                * Pairs with smp_store_release() in __anon_vma_prepare()=
.
> +                *
> +                * We could get away with a READ_ONCE() here, but
> +                * smp_load_acquire() ensures that the following
> +                * list_is_singular() check on old->anon_vma_chain doesn'=
t race
> +                * with __anon_vma_prepare().

Of course I only realize directly after sending this patch that this
comment only holds...

> +                */
> +               struct anon_vma *anon_vma =3D smp_load_acquire(&old->anon=
_vma);
>
>                 if (anon_vma && list_is_singular(&old->anon_vma_chain))
>                         return anon_vma;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0c0d8857dfce..83bc4267269f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -210,8 +210,9 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>         anon_vma_lock_write(anon_vma);
>         /* page_table_lock to protect against threads */
>         spin_lock(&mm->page_table_lock);
> +       /* no need for smp_load_acquire() here, the lock prevents concurr=
ency */
>         if (likely(!vma->anon_vma)) {
> -               vma->anon_vma =3D anon_vma;
> +               smp_store_release(&vma->anon_vma, anon_vma);
>                 anon_vma_chain_link(vma, avc, anon_vma);

... if we move the smp_store_release() down by one line here.

>                 anon_vma->num_active_vmas++;
>                 allocated =3D NULL;
