Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFD7C9148
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjJMXUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:20:39 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5532B7;
        Fri, 13 Oct 2023 16:20:38 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so9919235ab.0;
        Fri, 13 Oct 2023 16:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239238; x=1697844038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa2C969BUJQ8yo0gA0piHzbT0Go/f15MBqddSU/JLXU=;
        b=m+aEqz2ZGxtMNMshSmn1J/fYfnLOL1buXxjLGLVzt+lu8N39STQq/nW9MfSTQhQF3/
         3HrQGi0toWbXU3jN6n6p1SmpGC7M9uqpxW6WLRhV8gCSgRMc8g8VK45XJv4hAtJqgqLB
         e9lShhOYFXHigyKMmW0yKtM8PNwGnbHBsp8iZNinv7DDmzQsoCkz93svf5QooNHBbmjj
         wmPH+02jvOKoglu7o/YNfvBr+P7G+O2K0HDbISCxk7SUn4XMugAMgQRLARErnOyqO6ny
         p04a7yQm9trjEiZoezw3BK2xkRAxv6NYyAmB/VnnHTZknFQoVXgod7qSQ9WAenVTACog
         dN+g==
X-Gm-Message-State: AOJu0Yzs/HXToqIxxLdyW/PjttuEm4w1UAw2q13HFCAjBCBozbKq3MXd
        dGYvj45MudFHiTs2zXH1tJ30ba8LG4jGeBGvQcA=
X-Google-Smtp-Source: AGHT+IE0y0tvlvZ6xw48zKfwrXD2Ru9GizuXS55BY1GlJUKcsZoXsahxXTZpTwkvAxMbKckIA19S6YLDG7uCQ36bBXI=
X-Received: by 2002:a92:c08b:0:b0:357:61d7:200f with SMTP id
 h11-20020a92c08b000000b0035761d7200fmr3210991ile.12.1697239238012; Fri, 13
 Oct 2023 16:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231004204741.985422-1-namhyung@kernel.org> <ZSnHek1HlQTkfjhG@kernel.org>
 <CAM9d7cip5qmPRhWF37JH_21Q8SjKQCTBVyF_PLE-ytTFOwpasg@mail.gmail.com>
 <ZSnMxtnt7o5mLj+w@kernel.org> <CAM9d7cg75rnPpOUB4wUqUPCbsEZucOyu0sB1UwF3kk-4E8q2SA@mail.gmail.com>
In-Reply-To: <CAM9d7cg75rnPpOUB4wUqUPCbsEZucOyu0sB1UwF3kk-4E8q2SA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 13 Oct 2023 16:20:27 -0700
Message-ID: <CAM9d7cgAg7LfTvZhR3+Mh64GjhnLQZ6Pjae_8agMLABc0_weqg@mail.gmail.com>
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 1103fd658d5d..25236f339b90 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -118,9 +118,9 @@ static void enter_cgroup(struct cgroup *cgrp)
>
>         /* try cgroup v2 interface first */
>         if (threaded)
> -               fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> -       else
>                 fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> +       else
> +               fd = openat(cgrp->fd, "cgroup.progs", O_WRONLY);
>
>         /* try cgroup v1 if failed */
>         if (fd < 0)

Oh, actually it should be 'procs' instead of 'progs'.

Thanks,
Namhyung
