Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098657B546F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjJBOCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjJBOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:02:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D357AD;
        Mon,  2 Oct 2023 07:01:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so6848651a12.3;
        Mon, 02 Oct 2023 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696255316; x=1696860116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UauITAAdbAizY420BZjAWNimaCBJBrxsT9/MiLYkYCY=;
        b=cLx777u+p9Rgm634XxCEsfUxkmwTPR+uCK9KjPNx5h0u5VBoxPM5Em65NjxCYZEjwt
         6Wu/4AqdK4sY3JnByyAtLzdn14RdObAgRa4pQAqLquOrKl+CR49+7oPFdhQtZMV+vq2C
         1XUoHxzbcv7NH8BQMnUf9wP64C/LTiZk89xlTP0/l0kuId8e/eDNIh9WhRhN6C05aCdf
         v9dgiuuP1YEHFUOgt3w3N33fdgTkzXrFV9f2FOu0pzm4q4fMWuC3jKn3DJW5/aVujp5a
         loBszT6ESXK1tsYyHb72OjuyH7pTPUNre2HIu58KzUmjYDvNEL/WZ9AFmgRxQRr5nrAo
         2ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255316; x=1696860116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UauITAAdbAizY420BZjAWNimaCBJBrxsT9/MiLYkYCY=;
        b=BnOaHThwR5POjvfCrkBcQDeCkA+qGYjeWXpJhScbhYBvWeLL435l/5zuYnGjlG2HW5
         aE9ld3zdxp+1gi2N5FsyFSrKvoQF6epGBSGU4nJwTm9moM+s8yOc01rxApE7oSD6+EFL
         sWOQxVhp0FvQq5rLC5c7hO6hHAjjSYWoPawDd38kh0AK8moom6lcjIMiCGnE9E6Nn1ZX
         at9yiZ5Vq/UV4INt+30k9lRf9kn3BN17yxOPtBC/OeqFs+VdvigHEznIz0EPQUqsD6Ly
         0NrPw9Q2PwHwAqCQ4Z4ww9tjL8Z071e8z0Z+az5c1Z27v2OJKb2BJ/fSqD4atphMhbXY
         whyg==
X-Gm-Message-State: AOJu0Ywf4ERWEN1t+sg4qmeqgZgI6jdLgX8ONzGft8B0NcjkngYY1lJl
        3QT6nKAgjlrlTq7hbyiP7py6VKnyomRXm2XxGpw=
X-Google-Smtp-Source: AGHT+IGLhbsOrnS0Hw2Orc+D1zlEA5N7mZUlSAShX1TUFFLG/Cfr6osMBY8oG6JkUPgS7IkP2wgV1CHB2oaT9q+XGAI=
X-Received: by 2002:aa7:db50:0:b0:52b:db31:3c5c with SMTP id
 n16-20020aa7db50000000b0052bdb313c5cmr10272973edt.0.1696255315573; Mon, 02
 Oct 2023 07:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230926142058.1370-1-Nicholas.Lowell@gmail.com> <20230930040357.14fcbdf4@rorschach.local.home>
In-Reply-To: <20230930040357.14fcbdf4@rorschach.local.home>
From:   Nick Lowell <nicholas.lowell@gmail.com>
Date:   Mon, 2 Oct 2023 10:01:44 -0400
Message-ID: <CAFEqNJ0kskvj+hipFcqdhkzaFrA+bNtGX2Yk29yJoQ54_t7aVg@mail.gmail.com>
Subject: Re: [PATCH] trace: tracing_event_filter: fast path when no subsystem filters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again in plain text mode.
Thanks for the great feedback!  Hopefully my inline comments/questions
aren't garbled.

On Sat, Sep 30, 2023 at 4:04=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 26 Sep 2023 10:20:58 -0400
> Nicholas Lowell <nicholas.lowell@gmail.com> wrote:
>
> > From: Nicholas Lowell <nlowell@lexmark.com>
> >
> > If there are no filters in the event subsystem, then there's no
> > reason to continue and hit the potentially time consuming
> > tracepoint_synchronize_unregister function.  This should give
> > a speed up for initial disabling/configuring
> >
> > Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
> > ---
> >  kernel/trace/trace_events_filter.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_ev=
ents_filter.c
> > index 33264e510d16..93653d37a132 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1317,22 +1317,29 @@ void free_event_filter(struct event_filter *fil=
ter)
> >       __free_filter(filter);
> >  }
> >
> > -static inline void __remove_filter(struct trace_event_file *file)
> > +static inline int __remove_filter(struct trace_event_file *file)
> >  {
> >       filter_disable(file);
> > -     remove_filter_string(file->filter);
> > +     if (file->filter)
> > +             remove_filter_string(file->filter);
> > +     else
> > +             return 0;
> > +
> > +     return 1;
>
> The above looks awkward. What about:
>
>         if (!file->filter)
>                 return 0;
>
>         remove_filter_string(file->filter);
>         return 1;
>
> ?
>
> Or better yet:
>
>         if (!file->filter)
>                 return false;
>
>         remove_filter_string(file->filter);
>         return true;
>

Is it safe to assume you would like the function's return type to
change from int to bool if I go with option 2?

> and ...
>
> >  }
> >
> > -static void filter_free_subsystem_preds(struct trace_subsystem_dir *di=
r,
> > +static int filter_free_subsystem_preds(struct trace_subsystem_dir *dir=
,
> >                                       struct trace_array *tr)
> >  {
> >       struct trace_event_file *file;
> > +     int i =3D 0;
>
> We don't really need a counter. It's either do the synchronization or
> we don't.
>
>         bool do_sync =3D false;
>
> >
> >       list_for_each_entry(file, &tr->events, list) {
> >               if (file->system !=3D dir)
> >                       continue;
> > -             __remove_filter(file);
> > +             i +=3D __remove_filter(file);
>
>                 if (remove_filter(file))
>                         do_sync =3D true;
>
> >       }
>
>         return do_sync;
>

Going to assume the same here--that return type should change from int to b=
ool.

> > +     return i;
> >  }
> >
> >  static inline void __free_subsystem_filter(struct trace_event_file *fi=
le)
> > @@ -2411,7 +2418,9 @@ int apply_subsystem_event_filter(struct trace_sub=
system_dir *dir,
> >       }
> >
> >       if (!strcmp(strstrip(filter_string), "0")) {
> > -             filter_free_subsystem_preds(dir, tr);
> > +             if (filter_free_subsystem_preds(dir, tr) =3D=3D 0)
> > +                     goto out_unlock;
> > +
>
>                 /* If nothing was freed, we do not need to sync */
>                 if (!filter_free_subsystem_preds(dir, tr))
>                         goto out_unlock;
>
> And yes, add the comment.
>
> And actually, in that block with the goto out_unlock, we should have:
>
>                 if (!filter_free_subsystem_preds(dir, tr)) {
>                         if (!(WARN_ON_ONCE(system->filter))
>                                 goto out_unlock;
>                 }
>

Can you explain why the WARN_ON_ONCE should be in a conditional?
Don't we still want the original conditional to cause the goto regardless?

                if (!filter_free_subsystem_preds(dir, tr)) {
                        WARN_ON_ONCE(system->filter);
                        goto out_unlock;
                }

> If there were no preds, ideally there would be no subsystem filter. But
> if that's not the case, we need to warn about that and then continue.
>
> -- Steve
>
> >               remove_filter_string(system->filter);
> >               filter =3D system->filter;
> >               system->filter =3D NULL;
>
