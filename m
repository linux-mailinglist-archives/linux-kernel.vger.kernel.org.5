Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF78107AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378182AbjLMBd4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 20:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378145AbjLMBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:33:54 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02FB7;
        Tue, 12 Dec 2023 17:34:01 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so4657121b3a.0;
        Tue, 12 Dec 2023 17:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431241; x=1703036041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL8WQ6XQifHuAl5/6bibXSmjCD6Q0OYVm2RrMW20160=;
        b=Dj9xxVLGyJ/Ein3/G6+yxCuYRH9f8Koi2yNVSXQQDby3iEYadeA4hwiQmBs3N59/M4
         VLiiJ9TKhqKdTLLyZkQPXxCsg+XTDobHkBtuBZ6LNjLJVOMYDCEsI5hwsFgZvtpVBTvt
         prcTFRRDdHufRGOM8fQqBhMEv7B2AOMu5yE99ysBT6CcJkax2Ylc4pMHH6cZyLup7BkB
         vSXpSEUvTFljQTOBUuZU8L+53XM9xup4245/ZkW71QeEoyfL4Lr4aKf9/jBEHsYkKEm+
         cXyHEUfpuwOf9xeYPpwTTbtKeH/w7bJBqoRRUUtCBT8rTy8kixAV/9jBv76ZOSoxhAng
         7Y/A==
X-Gm-Message-State: AOJu0YzyZJwP70yxyG8YSAo19PqpbsJt2QnxnPK7jBAnuJEi8TdBfu/i
        nksalzl/QERBx6Os+AGmVSItm6ZFq+HPFEO+m3I=
X-Google-Smtp-Source: AGHT+IEhmNLmhGxrtCgZOy7pCkCFeOrqo6QXJpKEFM9cw7GkYQJG+xBQkr1qR4/tejyjGGUgs3t5wUdovowNAca85qM=
X-Received: by 2002:a05:6a00:2301:b0:6c3:4bf2:7486 with SMTP id
 h1-20020a056a00230100b006c34bf27486mr9484517pfh.7.1702431240694; Tue, 12 Dec
 2023 17:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com> <20231207050433.1426834-3-irogers@google.com>
 <CAM9d7cgRZp3PieHDvsdFXG+pNG0TTKoAaH6ZxC1XAnrvRLE1Pw@mail.gmail.com> <CAP-5=fXuZCkbAU0wakLyu3svpvUjzugAOjZzeGg9jZyJRXpoDA@mail.gmail.com>
In-Reply-To: <CAP-5=fXuZCkbAU0wakLyu3svpvUjzugAOjZzeGg9jZyJRXpoDA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 17:33:49 -0800
Message-ID: <CAM9d7cjcuz1ifeHUC=kqNsZVHn_jUsM-XWQRoXD1MVzRcoZ-kQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 3:54 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Dec 11, 2023 at 3:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Dec 6, 2023 at 9:04 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb.
> > >
> > > As getdents64 may be missing from libc, add support using syscall.
> >
> > Unfortunately my alpine build has:
> >
> > In file included from util/machine.c:2:
> > /build/libapi/include/api/io_dir.h:17:23: error: conflicting types for
> > 'getdents'; have 'ssize_t(int,  void *, size_t)' {aka 'long int(int,
> > void *, long unsigned int)'}
> >    17 | static inline ssize_t getdents64(int fd, void *dirp, size_t count)
> >       |                       ^~~~~~~~~~
> > /usr/include/dirent.h:52:5: note: previous declaration of 'getdents'
> > with type 'int(int,  struct dirent *, size_t)' {aka 'int(int,  struct
> > dirent *, long unsigned int)'}
> >    52 | int getdents(int, struct dirent *, size_t);
> >       |     ^~~~~~~~
>
> Presumably there is a #define getdents64 getdents .. Could we stop
> caring about this version of Alpine linux?

Right, there's a #define:

https://git.musl-libc.org/cgit/musl/tree/include/dirent.h#n68

But I'm not sure ignoring Alpine linux is a good idea.
Maybe we can add a #undef right before?

Thanks,
Namhyung
