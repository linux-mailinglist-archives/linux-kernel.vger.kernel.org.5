Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EAC7A9B43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjIUS5J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjIUS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:56:51 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C15880A9;
        Thu, 21 Sep 2023 11:50:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79f8e4108c3so26471939f.3;
        Thu, 21 Sep 2023 11:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322248; x=1695927048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTCB/fZzCKUJjiugycN3hEkm9G+K0NXzOwFX7H37ARA=;
        b=KkSgJGJLx5cjMH6442wjLtLTHj75WWTP+JXL8K8tmbqUbohdxmh3daTcxlf1KjcoD7
         VcmIydNufwsnyinii7ppyDzWO9IwEIc+Cb31AgO6trrNh4iYucW+PzzaspG6j3gam100
         5TtSHZLt6jtB/ztiAwJ3PMbJx1hw5Hk4HWdPg2knIfaheV/tCXJwmgtxps1NwywjSmuL
         YWW6Yvz4k3ME/YXWFnRK47qJMAqegdPgR6BSa+AVIOfHwaYfJoZBcq8vZf6hKl9Lmexp
         cENAzu1Deslgf8srgr/0e9LWA5QF+jzi3an1PBjcnxuDVtaU9g6tdb6+HBWkefIgJ7XZ
         6c4A==
X-Gm-Message-State: AOJu0YyskP09iswD2MTCHw+bd2KJ6bgto9zHtJ/mN4zEnrU9rIBjSw1K
        nJwLi9pUKAOMNw0VtcNirFu9/ZE5MIi6tWYwqdM=
X-Google-Smtp-Source: AGHT+IHquX7sNkJJbRBMHMVeIt+BWoHXIH7/ChIJDk47nk3iNWEsmhLmFyQ2RsTKp6SmKSWapOWJTzffmcoHGGp3YjY=
X-Received: by 2002:a6b:7e43:0:b0:786:25a3:ef30 with SMTP id
 k3-20020a6b7e43000000b0078625a3ef30mr7164735ioq.7.1695322248008; Thu, 21 Sep
 2023 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
 <ZQmfOO0tt9FuIkrj@kernel.org> <CAP-5=fXn=5SXqHKxaSAxs3bwQifUTVQWnrQb5A6D=3CHygfHLg@mail.gmail.com>
 <CAM9d7cgTAQ9pQfC7pNHPy1UdZr+5zD0T76EYkosV72-P7HPQjg@mail.gmail.com>
In-Reply-To: <CAM9d7cgTAQ9pQfC7pNHPy1UdZr+5zD0T76EYkosV72-P7HPQjg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Sep 2023 11:50:31 -0700
Message-ID: <CAM9d7ciso7MN3AVQEmhWxsPt3ahgfVQF=+pCsObAcQgS4CUMTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, Sep 19, 2023 at 9:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 8:40 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Sep 19, 2023 at 6:16 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Sep 18, 2023 at 04:40:15PM -0700, Namhyung Kim escreveu:
> > > > On Thu, Sep 14, 2023 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > Enable BPF skeletons by default but warn don't fail if they can't be
> > > > > supported. This was the intended behavior for Linux 6.4 but it caused
> > > > > an issue captured in this thread:
> > > > > https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/
> > > > >
> > > > > This issue isn't repeated here as the previous issue related to
> > > > > generating vmlinux.h, which is no longer performed by default as a
> > > > > checked-in vmlinux.h is used instead.
> > > > >
> > > > > Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
> > > > > to 0 disables BPF skeletons. Also, rather than fail the build due to a
> > > > > missed dependency, dependencies are checked and BPF skeletons disabled
> > > > > if they aren't present.
> > > > >
> > > > > Some related commits:
> > > > > b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
> > > > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> > > > > a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> > > > > 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
> > > > > 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
> > > > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> > > > > 1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
> > > > > a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
> > > > >
> > > > > Ian Rogers (5):
> > > > >   perf version: Add status of bpf skeletons
> > > > >   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > > > >   perf test: Update build test for changed BPF skeleton defaults
> > > > >   perf test: Ensure EXTRA_TESTS is covered in build test
> > > > >   perf test: Detect off-cpu support from build options
> > > >
> > > > Tested-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Is this verbose by default now? Maybe its something on my side, but I
> > > noticed a higher level of verbosity, can you check?
> >
> > I don't see more verbosity. Logs below.
>
> I don't see it either.

Applied to perf-tools-next, thanks!
