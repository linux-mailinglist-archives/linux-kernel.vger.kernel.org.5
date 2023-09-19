Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676147A6CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjISVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjISVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:10:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED1BD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:09:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27489f78e52so3750869a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695157795; x=1695762595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvIEfiigHClNF0zDtmOt3K3WnUjsJmS7BEsVemoJ0UI=;
        b=AKZrh+Cy5uVqaenOdnafPoUp4zECxc1ihqu5cBs1+UnR21b5DWIcNr+6JKv55nFyqB
         eLZaCn/jSPWol2xrjwJsH55vP8w/x8TjNjm/0KUICyIGzkjbI3sq7ft8fyYusxqJkN5d
         hunXCE9RU2Gp642dpVMjfDsuOhT3yKdtRvE6pvfDUOJwoIkTo7+BPzgXwSWMzLKOBEYc
         P26nuh97DLKuuhnArzKSaAHVnVBgy48W432e05W8xGZTWRQErY32XNq5v2xzflwoixet
         U0MRXut8OiAcfKYTOIyKiq40xQqRQfXEiVu6KV4VIU/dXQfLRJTB729fJu06mlG2V04z
         Y5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157795; x=1695762595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvIEfiigHClNF0zDtmOt3K3WnUjsJmS7BEsVemoJ0UI=;
        b=OHku9DAcXlO9iUEJVmGXTf7xJfs+byoOlOOwknCshM3qHo0rZQnUNEwN6xa+ap13nu
         VeC1jFUTp+Z7CSl3TEaoiritmpWDwJgtxadnxveu6YvNqxBS9sNBeKfd7iEzQNXh1eOm
         sUHUcVrEU5TVSnB2dFmqW3WkUWchaxxc7fDw/5bGk8kjvIj9i1d6goh+vux4s1XeIcJV
         YHD/TNs8T/SHzebVrMAqmG6RQ+k3aUhUaO9FA36yZKW4seN3zXJ3o+A0aw1u8lW+coVt
         nH+ds4HW6kxFURFo8QWch5XrgQvbUlrr00Bns/hSZPNWIdbYHr1Pg2s6TIkuf7nJCDSO
         OzHw==
X-Gm-Message-State: AOJu0Yy7aoLv9QhpUF2ThskRyFawi8DetTN+PdNwNQXPUiq0YqGB4ucP
        eG2+FOB/sbBIyzhbTexZbpQ9vV57WjMss7M0oeI=
X-Google-Smtp-Source: AGHT+IGNfJwxXxR2k0CiS0SuKc89Kp3NfhqIFIY69wej3IBe2VVWG4GgZ5VymqqXKmbW4lGu7cGc26mxi8sfUzErFKM=
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id
 gb15-20020a17090b060f00b002719237a07fmr889618pjb.32.1695157795347; Tue, 19
 Sep 2023 14:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918211608.3580629-1-surenb@google.com> <ZQlhaO1C5kf8zGjf@dhcp22.suse.cz>
In-Reply-To: <ZQlhaO1C5kf8zGjf@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 19 Sep 2023 14:09:43 -0700
Message-ID: <CAHbLzkpV8+0Bn_mpGODDbRsAOmDexG_JofUKQEVW-tGPJB-iyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: lock VMAs skipped by a failed queue_pages_range()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, hughd@google.com, vbabka@suse.cz,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 1:53=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 18-09-23 14:16:08, Suren Baghdasaryan wrote:
> > When queue_pages_range() encounters an unmovable page, it terminates
> > its page walk. This walk, among other things, locks the VMAs in the ran=
ge.
> > This termination might result in some VMAs being left unlock after
> > queue_pages_range() completes. Since do_mbind() continues to operate on
> > these VMAs despite the failure from queue_pages_range(), it will encoun=
ter
> > an unlocked VMA.
> > This mbind() behavior has been modified several times before and might
> > need some changes to either finish the page walk even in the presence
> > of unmovable pages or to error out immediately after the failure to
> > queue_pages_range(). However that requires more discussions, so to
> > fix the immediate issue, explicitly lock the VMAs in the range if
> > queue_pages_range() failed. The added condition does not save much
> > but is added for documentation purposes to understand when this extra
> > locking is needed.
>
> The semantic of the walk in this case is really clear as mud. I was
> trying to reconstruct the whole picture and it really hurts... Then I
> found http://lkml.kernel.org/r/CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5=
ofkhL-uvw@mail.gmail.com
> and that helped a lot. Let's keep it a reference at least in the email
> thread here for future.

FYI, I'm working on a fix for the regression mentioned in that series,
and Hugh has some clean up and enhancement for that too.

>
> > Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during t=
he walk")
> > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000f392a60604a65085@google=
.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I cannot say I like the patch (it looks like a potential double locking
> unless you realize this lock is special) but considering this might be ju=
st
> temporal I do not mind.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
> > ---
> >  mm/mempolicy.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 42b5567e3773..cbc584e9b6ca 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start, unsigne=
d long len,
> >       vma_iter_init(&vmi, mm, start);
> >       prev =3D vma_prev(&vmi);
> >       for_each_vma_range(vmi, vma, end) {
> > +             /* If queue_pages_range failed then not all VMAs might be=
 locked */
> > +             if (ret)
> > +                     vma_start_write(vma);
> >               err =3D mbind_range(&vmi, vma, &prev, start, end, new);
> >               if (err)
> >                       break;
> > --
> > 2.42.0.459.ge4e396fd5e-goog
>
> --
> Michal Hocko
> SUSE Labs
