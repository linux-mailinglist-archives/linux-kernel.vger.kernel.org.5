Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1B7A2D8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjIPCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjIPCoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:44:20 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED8106
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:44:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58dfe2d5b9aso38268567b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694832251; x=1695437051; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISPnyLNUfhuOEH21ItuTRLONf/o/+Vp6ZXvrFb0oXUg=;
        b=t0L7XEnehnrU5Zvss8N/KYmO0ArDUoll+ZSkJZtka7pDLUsxe73T9vha8AgKwUa5Z7
         +CTqPlgHEUaROqelCYqFzftLflOCvL2rNSc7cuD9cb3x52LxLh5qARleB84hCdZJSe47
         iNrAJE5yaGl68AO3PN6t/ZySVeNWtBMqWXcdDuFBHFUdB554aVUC+1CYss0AGUkCFaa4
         TtHhVkD50b+rwWccjrdlj7WLHbG5RUAs+DdUCDUuQaeJwivTfg7NGBl5UnzRyShliL13
         URGLuJ0/3bSwhaMojRCj/xgbq8clSCoDGu7reUGsOTdsrOaWjjttHk7oAyf2/+aBgmFg
         29Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694832251; x=1695437051;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISPnyLNUfhuOEH21ItuTRLONf/o/+Vp6ZXvrFb0oXUg=;
        b=GIqCNLJzHeizLLK8jPpe8vb3BWUD6Q2NJ5PwCgTkTACYbXigKizDQygOqzHpyKVR2Y
         oYVHcky77TJmFtt1c+5m17cm08VZo0HtWzcc9m7u2JaSeoMr/t0/0XhLZFmFCmiscRgC
         pA2uXdVipyheIVm/sTEZOYKdGXodOOZ+PyMBr7z+Ic3DbBMidTouokkpVBYSkZ/gr1DX
         7Rskow7yQ9FvrhUkAtkxe9gVWHoi8MicGKv5JZcOVRvt0N6i2VOvpW2jzRoeNhhx/guc
         aAGZ34mbqfK46GVj/upuU1D1QMdmI1gZNL22jhptnsSWISntN8T27bB13dyRaoaNS0fI
         bQPw==
X-Gm-Message-State: AOJu0YwoV6vAJi77hFxhSHRLO1bcsWTajhFV2oS64qUt7hUfet1fimSD
        T7bKepwwkdp2DyFF2BlCUMYDDQ==
X-Google-Smtp-Source: AGHT+IGkD9tRpts+Kot+QJ/QB//55QmamJf5bkfILtPqQYnfwt1OagBcnZkLMkIDPTkUlIdrBRajkg==
X-Received: by 2002:a81:6d0f:0:b0:59b:e9d5:a41c with SMTP id i15-20020a816d0f000000b0059be9d5a41cmr3982610ywc.22.1694832251056;
        Fri, 15 Sep 2023 19:44:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q5-20020a815c05000000b0058fc7604f45sm1182997ywb.130.2023.09.15.19.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 19:44:10 -0700 (PDT)
Date:   Fri, 15 Sep 2023 19:43:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Suren Baghdasaryan <surenb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
In-Reply-To: <CAJuCfpE8jnvL23W6fY4_HZf-969aEgvR3-LGRTUC-SFhPFju+w@mail.gmail.com>
Message-ID: <c5c51578-efdc-7de-2238-4039fb1b6c36@google.com>
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com> <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com> <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com> <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com> <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <CAJuCfpGO4bRZaDJv5Vuf2wLh3t4hE=5EqDObm_UfcQk4B08PrQ@mail.gmail.com> <CAJuCfpE8jnvL23W6fY4_HZf-969aEgvR3-LGRTUC-SFhPFju+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-168202884-1694832249=:16517"
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

---1463760895-168202884-1694832249=:16517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Sep 2023, Suren Baghdasaryan wrote:
> On Fri, Sep 15, 2023 at 9:09=E2=80=AFAM Suren Baghdasaryan <surenb@google=
=2Ecom> wrote:
> >
> > Thanks for the feedback, Hugh!
> > Yeah, this positive err handling is kinda weird. If this behavior (do
> > as much as possible even if we fail eventually) is specific to mbind()
> > then we could keep walk_page_range() as is and lock the VMAs inside
> > the loop that calls mbind_range() with a condition that ret is
> > positive. That would be the simplest solution IMHO. But if we expect
> > walk_page_range() to always apply requested page_walk_lock policy to
> > all VMAs even if some mm_walk_ops returns a positive error somewhere
> > in the middle of the walk then my fix would work for that. So, to me
> > the important question is how we want walk_page_range() to behave in
> > these conditions. I think we should answer that first and document
> > that. Then the fix will be easy.
>=20
> I looked at all the cases where we perform page walk while locking
> VMAs and mbind() seems to be the only one that would require
> walk_page_range() to lock all VMAs even for a failed walk.

Yes, I can well believe that.

> So, I suggest this fix instead and I can also document that if
> walk_page_range() fails it might not apply page_walk_lock policy to
> the VMAs.
>=20
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..cbc584e9b6ca 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start,
> unsigned long len,
>          vma_iter_init(&vmi, mm, start);
>          prev =3D vma_prev(&vmi);
>          for_each_vma_range(vmi, vma, end) {
> +                /* If queue_pages_range failed then not all VMAs
> might be locked */
> +                if (ret)
> +                        vma_start_write(vma);
>                  err =3D mbind_range(&vmi, vma, &prev, start, end, new);
>                  if (err)
>                          break;
>=20
> If this looks good I'll post the patch. Matthew, Hugh, anyone else?

Yes, I do prefer this, to adding those pos ret mods into the generic
pagewalk.  The "if (ret)" above being just a minor optimization, that
I would probably not have bothered with (does it even save any atomics?)
- but I guess it helps as documentation.

I think it's quite likely that mbind() will be changed sooner or later
not to need this; but it's much the best to fix this vma locking issue
urgently as above, without depending on any mbind() behavioral discussions.

Thanks,
Hugh
---1463760895-168202884-1694832249=:16517--
