Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426827AF796
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjI0A6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjI0A4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:56:41 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431047EC0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:14:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59f6e6b206fso72620037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695773669; x=1696378469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=836+RGF+4ingLSsLOsmJ4N8SHLPHvEKpqyLADo/H7gE=;
        b=Dsj+JlOxoUgscnEpSClDWQytTMyqqOgQ7C2Pwta66tF2ZJok9RkfjGiaVnkfeVvkoG
         5G9Rs340kfBVRNZVQY2KDoIckPLrCTTf1KMZlhSsW72Z2pIdDDbSyOMYbv48WcGO1G/X
         rNoi64A7mUDW0sFZCgm9UGz/0oZS9WwMTdOkXTSxn+BlXnQ8PjELTGyoKyr3SMlwb12v
         br37G3y8GHPoJj+SkDxb6d6XbNNyW4TXdfWshSnGisf4oQIRmCf4ANrKxOIWuJQSilxg
         fl4wkrFMWi242w65XmI5uUCUGK2hvyRNo0H7i4CRjA1s0InCJPl4HpPMaelS01sddAnr
         IPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773669; x=1696378469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=836+RGF+4ingLSsLOsmJ4N8SHLPHvEKpqyLADo/H7gE=;
        b=xFNuPxvfwQoiojsZ+PqDW9MrgTX9xpkhVbXPPHKJz/sLxdy3GMK+9pxNvBQoOPQ+TA
         hbRF8mfKX/scY/Fh5l5hdauA/aTxumZuqKrBj1enIqCfJLBCQesTEBqUzlnzCrCiw7sQ
         4z0BWP5/KReXD4AFuRUDyudFPgTaxtFEb394W2nIAiQZ2WcxhA8F8bHFw7jC1RLtothl
         C09EBZqJDFdtKycZ7+q4pp9eTJ+OEKoJJB1fMV0GVDaPHP93oh7n6/K2PvJYZ/qlsTAB
         OfkmLVHxj8yqGOik+X8WXYveUZ0vo227w335/beWE8TUm5I5k0A4gmdDAZaoxqEd9lDZ
         xlHA==
X-Gm-Message-State: AOJu0YwRfczZ7wVIXa6zLBgnA5C3pa09r/V2CyARoRmg25MwQjjIP1+q
        tGPRreOymj3Z3a7Wxd07k4py6ZGifUT4ukq1ZAEePQ==
X-Google-Smtp-Source: AGHT+IHBO4yUnteIjCq8GArpB1Oh1gyuZWxM0TgZ8SwiG6cfn+VQmLs+Gxhy7hUbTgp+fUKKr2kTq99PeZnJzcjtLJk=
X-Received: by 2002:a81:df0e:0:b0:59c:b61:898b with SMTP id
 c14-20020a81df0e000000b0059c0b61898bmr453029ywn.52.1695773669125; Tue, 26 Sep
 2023 17:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <202309141353492446199@zte.com.cn> <202309141710195376952@zte.com.cn>
In-Reply-To: <202309141710195376952@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 26 Sep 2023 17:14:16 -0700
Message-ID: <CAJuCfpG2aEv50KFWu4m8isg9dDWQxY9uCGhm=Y0N0AaqPHir8Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
To:     yang.yang29@zte.com.cn
Cc:     hannes@cmpxchg.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 14, 2023 at 2:10=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> Update_total in update_triggers() is also only used by psi_rtpoll_work().
> And when changed_states & group->rtpoll_states is true, update_total
> should also be true, so try to delete update_total, please see below:

Sorry, I know I owe a review here. I'll try to review it by the end of
this week.
Suren.

>
> ---
>  kernel/sched/psi.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 81fca77397f6..744ba8b4e029 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -434,14 +434,13 @@ static u64 window_update(struct psi_window *win, u6=
4 now, u64 value)
>         return growth;
>  }
>
> -static u64 update_triggers(struct psi_group *group, u64 now, bool *updat=
e_total,
> +static void update_triggers(struct psi_group *group, u64 now,
>                                                    enum psi_aggregators a=
ggregator)
>  {
>         struct psi_trigger *t;
>         u64 *total =3D group->total[aggregator];
>         struct list_head *triggers;
>         u64 *aggregator_total;
> -       *update_total =3D false;
>
>         if (aggregator =3D=3D PSI_AVGS) {
>                 triggers =3D &group->avg_triggers;
> @@ -471,14 +470,6 @@ static u64 update_triggers(struct psi_group *group, =
u64 now, bool *update_total,
>                  * events without dropping any).
>                  */
>                 if (new_stall) {
> -                       /*
> -                        * Multiple triggers might be looking at the same=
 state,
> -                        * remember to update group->polling_total[] once=
 we've
> -                        * been through all of them. Also remember to ext=
end the
> -                        * polling time if we see new stall activity.
> -                        */
> -                       *update_total =3D true;
> -
>                         /* Calculate growth since last update */
>                         growth =3D window_update(&t->win, now, total[t->s=
tate]);
>                         if (!t->pending_event) {
> @@ -499,8 +490,6 @@ static u64 update_triggers(struct psi_group *group, u=
64 now, bool *update_total,
>                 /* Reset threshold breach flag once event got generated *=
/
>                 t->pending_event =3D false;
>         }
> -
> -       return now + group->rtpoll_min_period;
>  }
>
>  static u64 update_averages(struct psi_group *group, u64 now)
> @@ -561,7 +550,6 @@ static void psi_avgs_work(struct work_struct *work)
>         struct delayed_work *dwork;
>         struct psi_group *group;
>         u32 changed_states;
> -       bool update_total;
>         u64 now;
>
>         dwork =3D to_delayed_work(work);
> @@ -580,7 +568,7 @@ static void psi_avgs_work(struct work_struct *work)
>          * go - see calc_avgs() and missed_periods.
>          */
>         if (now >=3D group->avg_next_update) {
> -               update_triggers(group, now, &update_total, PSI_AVGS);
> +               update_triggers(group, now, PSI_AVGS);
>                 group->avg_next_update =3D update_averages(group, now);
>         }
>
> @@ -636,7 +624,6 @@ static void psi_rtpoll_work(struct psi_group *group)
>  {
>         bool force_reschedule =3D false;
>         u32 changed_states;
> -       bool update_total;
>         u64 now;
>
>         mutex_lock(&group->rtpoll_trigger_lock);
> @@ -702,10 +689,13 @@ static void psi_rtpoll_work(struct psi_group *group=
)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total, PSI_POLL);
> -               if (update_total)
> +               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
> +
> +               if (changed_states & group->rtpoll_states) {
> +                       update_triggers(group, now, PSI_POLL);
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
> +               }
>         }
>
>         psi_schedule_rtpoll_work(group,
> --
> 2.25.1
