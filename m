Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9247A9D44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjIUTaY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIUT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:46 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53090A5C;
        Thu, 21 Sep 2023 11:51:13 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7927f24140eso50866239f.2;
        Thu, 21 Sep 2023 11:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322272; x=1695927072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=927YGkKs9cOI0OBx9K68ikts5Bj4cqpKV/mGal0pmf4=;
        b=hR0zUi1pNquD4AVwOfoUVjQ+SyXNPmDCMazVz1sWHXHskNJYOZf3F3g4L203DSlnN8
         R72fDPZdffWQx8ulPRzVZP4oHP1n3HDyyJIIdPi23U4L+V8abapzDwId9Kkgeeacezgq
         RvX1flR0EA0LgvLtNCwh9urvZ80YLTwyjCjtYG0UdZmON5Tu2VuZjPb4z6e0Nv6rBdrc
         AnRqv11IEkWbUBtDVaQq8V22nK0UFoDdxGO6gUQPg42PPuJ36oatnYlA9PAM2HfuM3kA
         S1HXr8LCpT6T4+Jes+S0KnLuhAPc7w+jG4cBTutzxJdpaKag0hPy19R9oIb47WMSrUq1
         m7RA==
X-Gm-Message-State: AOJu0Yz28kcmXHxK4+BBS1MmVWKsvuawVZorAnwI5TFsIHYrw26UbS9o
        QuRbPVryYWL6A66kcrcZQdWnNGzt5sgRxGc+8T8=
X-Google-Smtp-Source: AGHT+IFCRnmb9RFnnNv//e1c/N4sP5uRW/BEm+8kn2RCvmvtaqtXUD+Oi5HDT9gVhD0DAQum+voPrIJXpasczwc/R14=
X-Received: by 2002:a5d:8b93:0:b0:786:fff8:13c2 with SMTP id
 p19-20020a5d8b93000000b00786fff813c2mr7163981iol.11.1695322272169; Thu, 21
 Sep 2023 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230914164028.363220-1-irogers@google.com>
In-Reply-To: <20230914164028.363220-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Sep 2023 11:51:01 -0700
Message-ID: <CAM9d7cigt0ELQVkrrfZJ6ctNRZcTZqzbnnOwNpoMz9V=oQ5j2Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix tracepoint name memory leak
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        He Kuang <hekuang@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 14, 2023 at 9:40 AM Ian Rogers <irogers@google.com> wrote:
>
> Fuzzing found that an invalid tracepoint name would create a memory
> leak with an address sanitizer build:
> ```
> $ perf stat -e '*:o/' true
> event syntax error: '*:o/'
>                        \___ parser error
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list available events
>
> =================================================================
> ==59380==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 4 byte(s) in 2 object(s) allocated from:
>     #0 0x7f38ac07077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
>     #1 0x55f2f41be73b in str util/parse-events.l:49
>     #2 0x55f2f41d08e8 in parse_events_lex util/parse-events.l:338
>     #3 0x55f2f41dc3b1 in parse_events_parse util/parse-events-bison.c:1464
>     #4 0x55f2f410b8b3 in parse_events__scanner util/parse-events.c:1822
>     #5 0x55f2f410d1b9 in __parse_events util/parse-events.c:2094
>     #6 0x55f2f410e57f in parse_events_option util/parse-events.c:2279
>     #7 0x55f2f4427b56 in get_value tools/lib/subcmd/parse-options.c:251
>     #8 0x55f2f4428d98 in parse_short_opt tools/lib/subcmd/parse-options.c:351
>     #9 0x55f2f4429d80 in parse_options_step tools/lib/subcmd/parse-options.c:539
>     #10 0x55f2f442acb9 in parse_options_subcommand tools/lib/subcmd/parse-options.c:654
>     #11 0x55f2f3ec99fc in cmd_stat tools/perf/builtin-stat.c:2501
>     #12 0x55f2f4093289 in run_builtin tools/perf/perf.c:322
>     #13 0x55f2f40937f5 in handle_internal_command tools/perf/perf.c:375
>     #14 0x55f2f4093bbd in run_argv tools/perf/perf.c:419
>     #15 0x55f2f409412b in main tools/perf/perf.c:535
>
> SUMMARY: AddressSanitizer: 4 byte(s) leaked in 2 allocation(s).
> ```
> Fix by adding the missing destructor.
>
> Fixes: 865582c3f48e ("perf tools: Adds the tracepoint name parsing support")
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
