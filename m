Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF77B4481
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 00:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjI3Wch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjI3Wcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 18:32:36 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD44D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 15:32:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c268676a9so184048317b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696113153; x=1696717953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7JE6FdV5XE51KbJlLsKekhO+HUOeLTbb75teYm0T+s=;
        b=utvlAfeBPKAlM77PkEYElBQXcORY8Bc0BmHFbnknHI4pHTFWCX32brwU03k0IYLRVY
         Ug6ISUzNZFqKLH5YDnQVntDiNpVwTPpl2Sg/3duSoykK+Is4V7Cc9H7gRr8Ec62PKYfL
         j4ATxXJtA7z44u8BS5i2LJERdAaI3U6YDGhHTa5e9oKSo5c24fb+mJ/UBgOmQxjSgKUG
         qfi+ei+jDprPFi8uAJX8yR9wI8gBd5033Dwtb+1mqRoWCn9Yc8FJ395ZxdjrQTzvEx0m
         gK/HHG5pALe9w1XH+TBlNsHplWJK6Vm2TVU3w7VUv08k0SPx1mExogO0HF0B2tWwrkFW
         9A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696113153; x=1696717953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7JE6FdV5XE51KbJlLsKekhO+HUOeLTbb75teYm0T+s=;
        b=b2DS9coeJ4ardTMN4AEZwnOVHGE+BYoUxg4sSl1u/XQSi6BCTew8mCNk7CkxmB4z0D
         pN6s7uOeSLjJYZdtazMxfrt2jpMylMH2CUyH9Su/WUePefGNtK2B4tn2NwX0TJzpn7HS
         GvNXjQWloBpsXM5ECzS4gqR3wT79Wu4q24EVbhdF4d8J4fGcQRxf92DSFXiLlAcV4ACU
         fMMp+3sqtpqG3JQCBJeTyT9esaLklumEw+13mNHXg58B3gB+URgkfNHdLTgMIoJr2LSq
         RCKeWKJHriCHFn5mw3Hhhlrxl7pY13UAx4kDl4J+CTqtopv6X3UX5gdKmlWTcSi6g8ba
         oNdw==
X-Gm-Message-State: AOJu0YyJbAcrZ54KwhPZ8GU81WGUY61Ojaio2wOgP03jUW1UZql7i5TF
        +rUV+dRIIxvd1TXOmbEN7BrAuv/2ZuJHyLvhvhasmIu5YhMVxET4u/1XMQ==
X-Google-Smtp-Source: AGHT+IEc2uaOHMJ2jq1Zry4MdkoARPVZP3hQF4iREDYH3d+mYgYhvs1gwKr8O3b0Vw6yXGdxkNukrBml9Gs1dBO/Jgk=
X-Received: by 2002:a81:4fc3:0:b0:570:7b4d:f694 with SMTP id
 d186-20020a814fc3000000b005707b4df694mr7855334ywb.3.1696113152983; Sat, 30
 Sep 2023 15:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <202309141353492446199@zte.com.cn> <202309141710195376952@zte.com.cn>
In-Reply-To: <202309141710195376952@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 30 Sep 2023 15:32:19 -0700
Message-ID: <CAJuCfpHV+Tf+-YqdWFwQNAeQJU5aqOM56R2GzbehFaFQcHuxAg@mail.gmail.com>
Subject: Re: [PATCH linux-next] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
To:     yang.yang29@zte.com.cn
Cc:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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


Ok, sorry for the delay. I wanted to check for any side-effects and
recheck the whole logic since the code has changed quite a bit since
it was introduced...
I think this optimization is safe and won't have side-effects, however
I haven't tested it yet. One small comment above and when you post the
V2 please include peterz@infradead.org. Peter is hosting PSI in his
tree, so he is the maintainer you absolutely need :)

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

It's not technically wrong and does not have side-effects today but to
be safe, please update group->rtpoll_next_update *after* you call
update_triggers() and update group->rtpoll_total. This will prevent
bugs if update_triggers() uses group->rtpoll_next_update in the future
and I think it makes more sense to set the next update time after we
finished the current update. So, the code should look something like:

        if (now >=3D group->rtpoll_next_update) {
                if (changed_states & group->rtpoll_states) {
                        update_triggers(group, now, PSI_POLL);
                        memcpy(group->rtpoll_total, group->total[PSI_POLL],
                                sizeof(group->rtpoll_total));
                }
                group->rtpoll_next_update =3D now + group->rtpoll_min_perio=
d;
        }

Thanks,
Suren.

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
