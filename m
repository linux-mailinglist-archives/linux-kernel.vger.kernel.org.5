Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95576C355
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHBDIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjHBDIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:08:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609F1985;
        Tue,  1 Aug 2023 20:08:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe463420fbso2175113e87.3;
        Tue, 01 Aug 2023 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945696; x=1691550496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEHf2Vr7UcV8sRpiLYWB5RSkih+MiyH6YPF+pMyGQFU=;
        b=Oy/Zd7LIS6lnJJ0Nursy02iCL6MGJ+RwTNgRJQ0+/8TAJbMNhq5QIXqBXDVk8y/v38
         ZVu8oa49P+2nlDYe3iFAfIoH65wCO9OWGPaqSnh0jQOzQIwVmo7LR1wKsoi4j32f1DKP
         49Pgut1mxJYhumvjdchH7zn1NlXVc/9ur+VfukgScGMsLSqGIpZI5tUEtZnhOuMOFbjn
         ha/rg4lX7B+37vpWPxDPbuFVH3BbKd8hjQQUztp2KlqQbOnu/Et59tH3HdGM2NnPQhR9
         NJtmaf8T+bwr6XlgFP1C8EhnHKoQqQMMuESkXpfkDAGdg0WC+ZXvYSK5anL5V/2+8+ff
         HJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945696; x=1691550496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEHf2Vr7UcV8sRpiLYWB5RSkih+MiyH6YPF+pMyGQFU=;
        b=l0uUxlLtD1sWxbS3GOBNaQkt7E9jre5GJrKeEWgXnbHAiOFYIwok5Tw59+ubBA60iF
         ka1HzedNKJxrYmmEijklw6AlZv4WIoWjz04pRUn2wuw5REV6zVqM89UZdqbdd3oiNLi/
         WRw3p8z4aadSZ2mAABTQg66r0zOqg8kAUSWiiAMszhleamwPluWou2zwMbDhQcAbwvDW
         7VASKC51UELC2MCbNvSavWboQkxnPEIeUZEjOWCRYs/uJCMCINeXyL69vpyS1quJnyd2
         eMDXUK2c+MB+ctCmmmJhKI6qewMbytbxR/eX5dY2TiPGw0LHEjpA9zBGlnk++nK5FgJS
         scAA==
X-Gm-Message-State: ABy/qLZnXCQMvnwuV2WHw37Qvc5mIFSTEd5cA83D3M5I9WptBnE8Jdh6
        eJKOxrYHjZ16i5GOgWFNfzUPo0c0Gt6TCvwkoVc=
X-Google-Smtp-Source: APBJJlF7Qn9npxJ32kpkPSSHbbBYTkYefy8YfwqVsxU5Wn64RnG+Vdcj09ZK1gOubopjg4zCJBprznkAthaKfZoE3Po=
X-Received: by 2002:ac2:4dbb:0:b0:4fb:c657:3376 with SMTP id
 h27-20020ac24dbb000000b004fbc6573376mr3514495lfe.29.1690945695792; Tue, 01
 Aug 2023 20:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-7-zegao@tencent.com>
 <20230801101908.4ccc81c8@gandalf.local.home>
In-Reply-To: <20230801101908.4ccc81c8@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 2 Aug 2023 11:08:04 +0800
Message-ID: <CAD8CoPC_vH2FtAaMEjqSmKCKq+pq5ktbbLuWHm4WD2H_t2RWKg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] libtraceevent: prefer to use prev_state_char
 introduced in sched_switch
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fair enough! Already did this in perf fixes. Will push a v4
to do this.

Thanks,
Ze


On Tue, Aug 1, 2023 at 10:19=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue,  1 Aug 2023 17:01:24 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Since the sched_switch tracepoint introduces a new variable to
> > report sched-out task state in symbolic char, we prefer to use
> > it to spare from knowing internal implementations in kernel.
> >
> > Also we keep the old parsing logic intact but sync the state char
> > array with the latest kernel.
>
> This should be two patches. First sync the state char array and then add
> your state_char change. The two changes are agnostic to each other, and
> should be separate commits. Same goes for the perf changes.
>
> -- Steve
>
>
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  plugins/plugin_sched_switch.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switc=
h.c
> > index 8752cae..4c57322 100644
> > --- a/plugins/plugin_sched_switch.c
> > +++ b/plugins/plugin_sched_switch.c
> > @@ -11,7 +11,7 @@
> >
> >  static void write_state(struct trace_seq *s, int val)
> >  {
> > -     const char states[] =3D "SDTtZXxW";
> > +     const char states[] =3D "SDTtXZPIp";
> >       int found =3D 0;
> >       int i;
> >
> > @@ -99,7 +99,12 @@ static int sched_switch_handler(struct trace_seq *s,
> >       if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) =3D=
=3D 0)
> >               trace_seq_printf(s, "[%d] ", (int) val);
> >
> > -     if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) =
=3D=3D 0)
> > +     //find if has prev_state_char, otherwise fallback to prev_state
> > +     if (tep_find_field(event, "prev_state_char")) {
> > +             if (tep_get_field_val(s,  event, "prev_state_char", recor=
d, &val, 1) =3D=3D 0)
> > +                     trace_seq_putc(s, (char) val);
> > +     }
> > +     else if (tep_get_field_val(s,  event, "prev_state", record, &val,=
 1) =3D=3D 0)
> >               write_state(s, val);
> >
> >       trace_seq_puts(s, " =3D=3D> ");
>
