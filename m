Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6277DECBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjKBGA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjKBGA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:00:56 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A832136;
        Wed,  1 Nov 2023 23:00:54 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso550579a91.3;
        Wed, 01 Nov 2023 23:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698904854; x=1699509654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7sJxaZR3sZtUdEi8so+QgQKNnLkiEyQfQp6cbd46+M=;
        b=fFIDUpecYRlVp0D5pKvrn5EbfcFNhiEsxDS5qSCPlUWDk2ECVJR3fFBu+WE/o9N4up
         sV/Ti/cvCEg3iBLZ4HYVboOsQUMfG/bYoz2sgyFi02DS2omLwxJgWDrZphq/e4KmB9Z6
         Nr3TuzoYOyYzRnZWknOU9pJqAEunwDI3mScaxTUiRQl1AqWteDPnW0fEL+00h4s9cpOv
         w31UxVnqe0Db++nkO+tV12+morXH9nFEL15KrGaS9UTJ4a9Jkk3LwdaoH5fPm/UhyBcI
         1enKHmHJuuAsM5PRX50xcSY4HXOSQImMzX6ctZRMRBDgfjivH0IqOC/RbKZ/RX7E9dIT
         fl2w==
X-Gm-Message-State: AOJu0Yy5IWoBrvkNEhOMQO+UlKUZdbsIHDPnYfKkaVjCR3C3l8X55M99
        AAEfV1DuKYNyvNefSV2M0dx9R/daQFtDtc1bX9Q=
X-Google-Smtp-Source: AGHT+IH6+y7swXL7j3RAXG1QsA0AgXdwSi3Rgzy8GDw/e26SSaefQSQzZEdVM30CfkvCypBS/GX5DZWXv7Tz5/PIf7g=
X-Received: by 2002:a17:90a:10c9:b0:280:b062:208 with SMTP id
 b9-20020a17090a10c900b00280b0620208mr4517916pje.35.1698904853536; Wed, 01 Nov
 2023 23:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com> <ZUEfXU34ZijKe8aA@kernel.org>
 <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
In-Reply-To: <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Nov 2023 23:00:42 -0700
Message-ID: <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and --thread
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
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

On Wed, Nov 1, 2023 at 7:35 AM Nick Forrington <nick.forrington@arm.com> wrote:
>
>
> On 31/10/2023 15:38, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
> >> Improve error reporting for command line arguments.
> >>
> >> Display error/usage if neither --map or --thread are specified (rather
> >> than a non user-friendly error "Unknown type of information").
> >>
> >> Display error/usage if both --map and --thread are specified (rather
> >> than ignoring "--map" and displaying only thread information).
> > Shouldn't one of them be the default so that we type less for the most
> > common usage?
> >
> > - Arnaldo
> >
>
> There isn't an obvious choice (to me) for which would be the default.
>
> Both options display completely different data/outputs, so I think it
> makes sense to be explicit about which data is requested.

Maybe we can default to display both. :)

Thanks,
Namhyung

>
>
> An alternative could be to use sub-commands e.g. "perf lock info
> threads" or just "perf lock threads", although changing the existing
> options would be more disruptive.
>
>
> Cheers,
> Nick
>
> >> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> >> ---
> >>   tools/perf/builtin-lock.c | 25 +++++++++++++++++++++++++
> >>   1 file changed, 25 insertions(+)
> >>
> >> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> >> index 3aa8ba5ad928..cf29f648d291 100644
> >> --- a/tools/perf/builtin-lock.c
> >> +++ b/tools/perf/builtin-lock.c
> >> @@ -2021,6 +2021,27 @@ static int check_lock_report_options(const struct option *options,
> >>      return 0;
> >>   }
> >>
> >> +static int check_lock_info_options(const struct option *options,
> >> +                               const char * const *usage)
> >> +{
> >> +    if (!info_map && !info_threads) {
> >> +            pr_err("Requires one of --map or --threads\n");
> >> +            parse_options_usage(usage, options, "map", 0);
> >> +            parse_options_usage(NULL, options, "threads", 0);
> >> +            return -1;
> >> +
> >> +    }
> >> +
> >> +    if (info_map && info_threads) {
> >> +            pr_err("Cannot show map and threads together\n");
> >> +            parse_options_usage(usage, options, "map", 0);
> >> +            parse_options_usage(NULL, options, "threads", 0);
> >> +            return -1;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static int check_lock_contention_options(const struct option *options,
> >>                                       const char * const *usage)
> >>
> >> @@ -2709,6 +2730,10 @@ int cmd_lock(int argc, const char **argv)
> >>                      if (argc)
> >>                              usage_with_options(info_usage, info_options);
> >>              }
> >> +
> >> +            if (check_lock_info_options(info_options, info_usage) < 0)
> >> +                    return -1;
> >> +
> >>              /* recycling report_lock_ops */
> >>              trace_handler = &report_lock_ops;
> >>              rc = __cmd_report(true);
> >> --
> >> 2.42.0
> >>
> >>
