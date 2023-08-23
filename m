Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C8784DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjHWAu7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 20:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHWAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:50:58 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04821E66;
        Tue, 22 Aug 2023 17:50:39 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-48d0dbd62fbso1085774e0c.0;
        Tue, 22 Aug 2023 17:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692751838; x=1693356638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyMgRhYU9G+QtE8w0+IVqsL5N0OkKQo9/1AmARUv6+8=;
        b=hP3qFmKEVVCZ4+wPxWwQip8CCSldf/EfrzNoiidG2TZerBgOzJh9awSezAL14KRN2a
         eX36c6j2+GMk3ev9KDFAiQOM5fb11hAqWGkgGxFP/hJ/HzlakB9KW+4rpO11s9cUK9ia
         DFqDwPlxkzpbNLYJ/QJr/t2FsEF687eXkCtHSzUBagaicXf12be2tHr9xqJKF7bgAGL2
         xTWRBzSYXYoR9ICY6pwU0ODe7cCGRr87bSXyIroIsa9uXAS1HvX7svjQFV+dW3+ZXiAc
         olcrAUq/Z9St9NDXMuK4gonZVa9sc1B63rsy1xMYo5fmoOaZEUgxLdK0la2DY6b2zwem
         iO4Q==
X-Gm-Message-State: AOJu0Yz/lRvN5fB5WmR1gsGKdeOLlX5s68SZHPgiziOl5wkDltqe83tv
        E3F+9Hlf3wTg2CZmg+uXmtK/5Mdj4WHTGqtwdIpw4iTU
X-Google-Smtp-Source: AGHT+IF+q9chTK36QO/Yr/CDvZNxTbY8y5o2yQIG5ifA3m+Qtu13ER3+8ZnhDuOyyaWwB281Ou/V/EXGCSdX8WvlTW0=
X-Received: by 2002:a05:6122:4083:b0:48f:8891:5ecd with SMTP id
 cb3-20020a056122408300b0048f88915ecdmr4053883vkb.8.1692751837929; Tue, 22 Aug
 2023 17:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025822.3859771-1-namhyung@kernel.org> <20230811025822.3859771-2-namhyung@kernel.org>
 <ZNu2KrbgFPY69K2+@kernel.org> <ZNu47CYXV0nuav+G@kernel.org>
In-Reply-To: <ZNu47CYXV0nuav+G@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Aug 2023 17:50:26 -0700
Message-ID: <CAM9d7ciZaH1KkGannC=69FgtyOO7M_1opu-xgdDCkske+en1jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add perf record sample filtering test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
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

Hi Arnaldo,

On Tue, Aug 15, 2023 at 10:42 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 15, 2023 at 02:30:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Aug 10, 2023 at 07:58:22PM -0700, Namhyung Kim escreveu:
> > >   $ sudo ./perf test 'sample filter' -v
> > >    94: perf record sample filtering (by BPF) tests                     :
> > >   --- start ---
> > >   test child forked, pid 3817527
> > >   Checking BPF-filter privilege
> > >   Basic bpf-filter test
> > >   Basic bpf-filter test [Success]
> > >   Failing bpf-filter test
> > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > >   Failing bpf-filter test [Success]
> > >   Group bpf-filter test
> > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > >   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> > >   Group bpf-filter test [Success]
> > >   test child finished with 0
> > >   ---- end ----
> > >   perf record sample filtering (by BPF) tests: Ok
> >
> > [root@five ~]# perf test -v "by BPF"
> >  91: perf record sample filtering (by BPF) tests                     :
> > --- start ---
> > test child forked, pid 64165
> > Checking BPF-filter privilege
> > Basic bpf-filter test
> >  ffffffff97f4f688
> >  ffffffff97f73859
> >  ffffffff97412ce6
> >  ffffffff976da215
> >  ffffffff973a92bf
> >  ffffffff97376ad7
> >  ffffffff97f73859
> <SNIP
> >  ffffffff971fdca5
> >  ffffffff9737dbc4
> >  ffffffff971b4e04
> > Basic bpf-filter test [Failed invalid output]
> > test child finished with -1
> > ---- end ----
> > perf record sample filtering (by BPF) tests: FAILED!
> > [root@five ~]#
> >
> > [root@five ~]# uname -a
> > Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > [root@five ~]#
>
> Above was on a AMD Ryzen 5950X, the following was on a lenovo t480s,
> Intel notebook:

Thanks for the test.  I think it's a matter of the kernel version
rather than the CPU vendor.  6.1 or before will fail the check
in the beginning but 6.2 kernel lacks a feature to set sample
flags for some fields and silently accept all samples.  IIRC it's
added in v6.3.

Probably I need to add a version check in the error path.

Thanks,
Namhyung

>
> [root@quaco ~]# uname -a
> Linux quaco 6.4.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 27 20:01:18 UTC 2023 x86_64 GNU/Linux
> [root@quaco ~]# perf test "filter"
>  30: Filter hist entries                                             : Ok
>  36: Filter fds with revents mask in a fdarray                       : Ok
>  67: dlfilter C API                                                  : Ok
>  91: perf record sample filtering (by BPF) tests                     : Ok
> [root@quaco ~]# perf test -v "by BPF"
>  91: perf record sample filtering (by BPF) tests                     :
> --- start ---
> test child forked, pid 273609
> Checking BPF-filter privilege
> Basic bpf-filter test
> Basic bpf-filter test [Success]
> Failing bpf-filter test
> Error: task-clock event does not have PERF_SAMPLE_CPU
> Failing bpf-filter test [Success]
> Group bpf-filter test
> Error: task-clock event does not have PERF_SAMPLE_CPU
> Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> Group bpf-filter test [Success]
> test child finished with 0
> ---- end ----
> perf record sample filtering (by BPF) tests: Ok
> [root@quaco ~]#
