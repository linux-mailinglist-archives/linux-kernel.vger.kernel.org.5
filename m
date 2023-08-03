Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA276DDE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjHCCNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:13:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB319F;
        Wed,  2 Aug 2023 19:13:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso769449e87.2;
        Wed, 02 Aug 2023 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691028807; x=1691633607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr8l99N0UAXqm7iLRTOZb3Ym1/MspXtXvjO4SDDXucQ=;
        b=PzkH9q21FzCw51bdRZa3uYtTqOt8jJwtm7l7OqS5dh9RpTR07ZjHRaDjM++rvV6V5B
         iBISJFND0y+gETvj9BNzEZ5kAIfd1hYGvql1JxqlTpNQBGZADTqzFymQQKo2acxMX1Ve
         OEPjU6e9rLY56BnQmQgras+/CUisU+1zf7MuqI9Uut6b/E75stL79+jt43zc0407WgiN
         4PD0Rp6nS7dX7PJJ+yCyYThIzJa+CQ+gDTWjP3HbqywJTip+iLThRQGgFij4DcABP98a
         IFuNSf39ukMf9yndshXSTmMOaVXCJVlnK/K4AQqyuytkMtQ7HonneRSNeg8+9QhL9hOY
         MMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691028807; x=1691633607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr8l99N0UAXqm7iLRTOZb3Ym1/MspXtXvjO4SDDXucQ=;
        b=DXMvyfbJ9uaSPAGr2EbvDzC5MuXy8D9e7Y3fPxlmoa076CZ6oK7MGdkgfi9B2Gymqm
         NMCgTbm9yPjS3eiKyAAZl1z+dHOSGzK11pDbsgF9vTgljUeUCvDGKWK4PzrzMjDSFBh1
         l4JHvqpzq74FkNM2CDdRKHQn+vd2fwyF/qi/61cMQpp6Ck2ln/xA44ngmPcU5asNeJpK
         PXcMjg8A6YkKZyXyDDsRxxkQi9sCs8ZBki+/8NzsE6vMwOyOormeZTmBjDaWYT2X3AXC
         OFjzNa7VG/MNkdxVXnwq17+pTLI5cqbZT7O5e3/IkskwpLBVY8wAOPoynm+TlkLvRyEK
         1iTQ==
X-Gm-Message-State: ABy/qLbBNeOG+mdMPQH5zxnQ690Pi4kwQBT/3QDBGoC2Thej+vA1qj+E
        rlHDRodnUnkndOYhjhn6mxa7G1WsKFQ70+MrfZI=
X-Google-Smtp-Source: APBJJlFwOhPDCUK6rCWKc1UNLNMZv6my2LO/4GCzDODBrrhi7TaCWiEEyrjtXES8p3JVAnXX1VwVdxgcGDiUQjbe5AI=
X-Received: by 2002:a19:5e57:0:b0:4fc:6e21:ff50 with SMTP id
 z23-20020a195e57000000b004fc6e21ff50mr5442878lfi.55.1691028807352; Wed, 02
 Aug 2023 19:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230802121116.324604-1-zegao@tencent.com> <20230802121116.324604-2-zegao@tencent.com>
 <20230802103630.45d95c06@gandalf.local.home>
In-Reply-To: <20230802103630.45d95c06@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 10:13:16 +0800
Message-ID: <CAD8CoPAPjuE5Ni2aTJcS5=M8TNOLqp3t4gfL=iWVrx39a25r2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libtraceevent: sync state char array with the kernel
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

FYI, I=E2=80=98ve already cc-ed to it.  Do you mean I need to resend this p=
atch
to linux-trace-devel@vger.kernel.org solely and exclude this one from
this series?

Regards,
Ze

On Wed, Aug 2, 2023 at 10:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed,  2 Aug 2023 08:09:56 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Update state char array to match the latest kernel
> > definitions.
>
> Can you send this separately to linux-trace-devel@vger.kernel.org?
>
> Thanks,
>
> -- Steve
>
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  plugins/plugin_sched_switch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switc=
h.c
> > index 8752cae..e0986ac 100644
> > --- a/plugins/plugin_sched_switch.c
> > +++ b/plugins/plugin_sched_switch.c
> > @@ -11,7 +11,7 @@
> >
> >  static void write_state(struct trace_seq *s, int val)
> >  {
> > -     const char states[] =3D "SDTtZXxW";
> > +     const char states[] =3D "SDTtXZPI";
> >       int found =3D 0;
> >       int i;
> >
>
