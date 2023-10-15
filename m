Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A087C9AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJOSyB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Oct 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:54:00 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5595A9;
        Sun, 15 Oct 2023 11:53:58 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2b1b25547so1493621b6e.3;
        Sun, 15 Oct 2023 11:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697396035; x=1698000835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G81DqXs3X1Zjdsq9mf6OJafYAWE3ifxu15bBycQsx0=;
        b=ZIQdbTq6V0lh1rCrIEysHM8lL3OVjgOJOKyafMgnLnoMtbDMpSIy+eSGEhW9q7G8WS
         KJ5ng4CYaZfHEdySjUbBrjDXrds94MpoXm5Ks1a/S7J6tnr5pTpyaFGAmde42GFHy/U8
         Vtr0KlQEpM+Nu9RuuoJt9j24NiNRYF+wnWfe4ZSpfvpczLtpxrmEDtAXSg5eA4v/mNTX
         LP8xiKupOIhMMetMXRIwS1LBjzgwBRRwVWHO0sENpkRrC9kzqlcKBc8/GbWgg6HMr5xj
         ixJFhcKi/6IzaPYI01jBDw0m66rYE0VAJr8F7hXH4N7c17veFRXblKP3iyPkUKlgxnOf
         3Qdg==
X-Gm-Message-State: AOJu0YwT0jwDdGp6cIdul3BYN4rGWzxE252mziLJXQxisAPCLl3FgRfI
        dyJXoVER2BEgWJdIst6BRFNHmE8F8n/dU7Rc7hg=
X-Google-Smtp-Source: AGHT+IGL2NAuYiF3Tzso4tRw/ILA5Rg4oP3DMOWmIRCsRHcxo91zB3yKdweqyKe0YdP8r9gI41njaqN2r/bzpoA5UYA=
X-Received: by 2002:a05:6808:1146:b0:3ae:156f:d312 with SMTP id
 u6-20020a056808114600b003ae156fd312mr52398901oiu.34.1697396035616; Sun, 15
 Oct 2023 11:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231013232435.1012585-1-namhyung@kernel.org> <ZSpU2Q7A9ViZe7DB@gmail.com>
In-Reply-To: <ZSpU2Q7A9ViZe7DB@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 15 Oct 2023 11:53:44 -0700
Message-ID: <CAM9d7cgcxz7qn9LskQcZtwGhPbnd7rEXzJr5L2iwhO7iHh0ywA@mail.gmail.com>
Subject: Re: [PATCH v2] perf bench sched pipe: Add -G/--cgroups option
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 1:44 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Namhyung Kim <namhyung@kernel.org> wrote:
>
> > +     cgrp_send = cgroup__new(p, /*do_open=*/true);
> > +     if (cgrp_send == NULL) {
> > +             fprintf(stderr, "cannot open sender cgroup: %s", p);
> > +             goto out;
> > +     }
>
> Maybe in this case print out a small suggestion of how to create this
> particular cgroup?
>
> Most distro users and even kernel developers don't ever have to create
> new cgroups.
>
> Maybe even allow the creation of new cgroups for this testing, if they
> don't already exist? As long as we don't delete any cgroups I don't think
> much harm can be done - and the increase in usability is substantial.

I'm not sure if it's ok create a new cgroup and leave it after the use.
Anyway, none of the existing subcommands create new cgroups
IIUC and I think it'd be ok to print a message on how to create one.

>
> > +static void enter_cgroup(struct cgroup *cgrp)
> > +{
> > +     char buf[32];
> > +     int fd, len;
> > +     pid_t pid;
> > +
> > +     if (cgrp == NULL)
> > +             return;
> > +
> > +     if (threaded)
> > +             pid = syscall(__NR_gettid);
> > +     else
> > +             pid = getpid();
> > +
> > +     snprintf(buf, sizeof(buf), "%d\n", pid);
> > +     len = strlen(buf);
> > +
> > +     /* try cgroup v2 interface first */
> > +     if (threaded)
> > +             fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> > +     else
> > +             fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> > +
> > +     /* try cgroup v1 if failed */
> > +     if (fd < 0)
> > +             fd = openat(cgrp->fd, "tasks", O_WRONLY);
> > +
> > +     if (fd < 0) {
> > +             printf("failed to open cgroup file in %s\n", cgrp->name);
> > +             return;
> > +     }
> > +
> > +     if (write(fd, buf, len) != len)
> > +             printf("cannot enter to cgroup: %s\n", cgrp->name);
>
> The failures here should probably result in termination of the run with an
> error code, not just messages which are easy to skip in automated tests?

Right, I'll make the change.

Thanks,
Namhyung
