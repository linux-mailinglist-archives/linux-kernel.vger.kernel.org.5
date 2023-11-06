Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E167E194B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjKFD7E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 22:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjKFD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:59:03 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C7EBF;
        Sun,  5 Nov 2023 19:59:00 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2943011a12.1;
        Sun, 05 Nov 2023 19:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699243140; x=1699847940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEdoTvgGm7uaeRMpxpJUiRCbk25iqfmxfW6IznSRR4k=;
        b=wAaHvs2KpBGLKpnrkB7I1GLIFdcdqWNOlu2Qfx4TU7Gh0gomvyOFXKEmq7AapXKCci
         IgKbhp4Cu7nZpvfbJYQ2oHR5WNaSKEKVoUqkZ9S0EstMhqMwjSD7QKuGLOzv6jI+rdp3
         RAyqtvS7D5FaCGiFeiqSh1MdRrQgtCVXB8lvhhK32hvxTUQQ3iIje5EoSrsHoLVoQBlx
         DczNb5VYf0KE8EF86KymxcdOoqARn/7r4UC8seQqRtEK6lag/ThwrOdvwgL6u0Xj/sZj
         PJgRpAmH+gAOGWLA1Q8c7w27DsDR5xKDKO74uBhGOR/6QseSVG0Mh1zOTUHzer+D0djP
         Gb3Q==
X-Gm-Message-State: AOJu0Yzr1C0sO4W08V8oOtW8s6KntMb9opBk4w7POxnF0M01yTBoSIJL
        HvJ+SL62t96+8Ah8v3RviZqHHLfs+m5NLfoQ0Vs=
X-Google-Smtp-Source: AGHT+IGqXRhIlSp9n7LFeXq/QU+32ZT64Xuy7q9+PMfg8AU/WfX/S5FEsO/v4jpm1n/CJstkJIgz1QiglBCnSl6U2JY=
X-Received: by 2002:a17:90b:1c01:b0:280:280c:efe3 with SMTP id
 oc1-20020a17090b1c0100b00280280cefe3mr12716575pjb.14.1699243140100; Sun, 05
 Nov 2023 19:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com> <CAP-5=fXgy95LsYLbbWN85prBs43jvGehOcwYFK-ZK2cOqCyPJA@mail.gmail.com>
In-Reply-To: <CAP-5=fXgy95LsYLbbWN85prBs43jvGehOcwYFK-ZK2cOqCyPJA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 19:58:49 -0800
Message-ID: <CAM9d7ch9pXWZdFKf5zrQZg+nrf_0YpVro5vvkkO+LPfoLTynPQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Sun, Nov 5, 2023 at 1:35 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Nov 5, 2023 at 9:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The rwsem is only after used for writing so switch to a mutex that has
> > > better error checking.
> >
> > Hmm.. ok.  It doesn't make sense to use rwsem without readers.
> >
> > >
> > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
> >
> > But I'm not sure this is a fix.  Other than that,
>
> Thanks Namhyung, it fixes the case that you enable RWS_ERRORCHECK in
> rwsem.h as the rwsem static initialization is wrong for a mutex.

Sounds like we need a separate fix.  Maybe you need to
add a static initializer macro depending on the config.

Thanks,
Namhyung
