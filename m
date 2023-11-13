Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0C7EA253
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjKMRst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 12:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKMRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:48:47 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA410D0;
        Mon, 13 Nov 2023 09:48:44 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2802c41b716so3960394a91.1;
        Mon, 13 Nov 2023 09:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699897724; x=1700502524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHxxWuzhuHifOjaxS/FCFB05xrYXFz5bzw/7tvFHZXE=;
        b=RzpsL2urr1hf/OsWBKcUczkuH5CCtlTP6dygF1Bm6Fe95HPVMUU3hZyvTleB8F5d73
         Ghzf8YP+EQO6o8h1Tkyp/HiQ6C9lJWrl3mvR/O3dGYXJnBALNRK9HWbnripONYt0iGgj
         RU2puY54w6ldo3dYdxIbJxbMAWyQlZ5SYq/tFLsJ/e3/5jxG8/ooZkFcDKiGqspTsPjI
         RSImhRZ7b9IgR3Noo19owTfiezWh+pF/EFThX37i8uj6/NgIgkLKXBeI79bmQzw7SVm2
         JFQVZHFcRklbJvFoG0dYozBduDS8uNqPEfgMis6CHcXzWHGpAZtskLjtCiaWOyY92rCF
         kM1g==
X-Gm-Message-State: AOJu0YwGiHbfcEFJai5N2pWxfte/5A1+N5EyLYJ+vg/PgJhy27r6+Oqx
        2JJQDN15zl2R3U4GElFYGndubBrm5x4C6jHY5PA=
X-Google-Smtp-Source: AGHT+IGjl5BRE9fKEal5UsGKyrSxp53dOxq4767hZdhJxEwk9uyJih1rc8TDLSZqIVLABxPHbuS3GzfRIKZENv+QcJU=
X-Received: by 2002:a17:90b:3ec5:b0:283:2a1b:b18a with SMTP id
 rm5-20020a17090b3ec500b002832a1bb18amr4485434pjb.26.1699897724214; Mon, 13
 Nov 2023 09:48:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble> <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <20231113172106.GA12501@noisy.programming.kicks-ass.net>
In-Reply-To: <20231113172106.GA12501@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Nov 2023 09:48:32 -0800
Message-ID: <CAM9d7chg8c4yftXgAyZZyLuYJQaWYDTa9YY5x-S+Mb-8SM8K-A@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
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

On Mon, Nov 13, 2023 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 13, 2023 at 08:56:39AM -0800, Namhyung Kim wrote:
>
> > Ok, then BPF gets no user call stacks even with sframes.
>
> Well, you could obviously run another BPF program at return to user and
> stitch there.

Right, maybe some more work needed for bpf_get_stackid()
but it seems possible.

>
> > Ok, but ...
>
> > If the task is preempted, the call stack would be from another
> > task (if it also has the pending call stacks) and we need to
> > check which user call stack matches which kernel call stack.
> > So there's no guarantee we can just use adjacent samples.
>
> So upon requesting a user backtrace for the task it could request a
> token (from eg a global atomic u64 in the most crude case) and place
> this in the task_struct. The backtrace will emit this as forward
> reference for the user trace.
>
> Once the task_work generates the user stacktrace, it will again dump
> this token along with the user unwind, after which it will reset the
> token for this this task (to 0).

Yeah, I thought something like this first, but then I thought
"can we just use PID for this?"

Thanks,
Namhyung
