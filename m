Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B47A33D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjIQF15 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjIQF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:27:37 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F31AD;
        Sat, 16 Sep 2023 22:27:28 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7926b7f8636so86506039f.1;
        Sat, 16 Sep 2023 22:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928448; x=1695533248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzRftMfR+qB5FSzonRS1Mmq5OWomLaO6LI1sl+SH1Lw=;
        b=RqQZqHAkrCtjb8z6FNZmp/dCR78/Xcknju9+DzsvLwZtQi+KcYooVGY50H8updOQ3M
         JTmqY9d2vDanxSxWPGXaEkd0c9oSWQhWXfs0y/iSHmggp7NJCXUXpN8WZnVWQZdwvCcn
         /NYXbkavzdQaeRPthmbY03PiDmsf+Xeq28ppuAbzJUtuWHJAs3ZU3v0bnIT1nc+1XxOb
         SspK6LvZlGEZPR6EAZnoD2hI3FDdtYu9BF33l81gSzeHm13c18FFRu6oQE8KBW+Mg4Mj
         CMvOjzFCKdiGzbXxR9A6gEEc5xoCZpTn+Mg+JnLnaVwWdRJS0FHxY1Rz1TzFXAnDoxfc
         j+VA==
X-Gm-Message-State: AOJu0YxbqRaaEXXzFEiFTB+vnx8YipE+aaHjPVwp/BfxLLd7pNZnGxy8
        DTcUIDEm06bIEaZIKK9J3Y5V8VQHXhsi0go5ugE=
X-Google-Smtp-Source: AGHT+IFv586Np5Rd7lqzI1XUDf/FEYjv1lh76oFG0h5hLyaZBU1EhWP4hFvHwN+h+3L5YBKoqfA0cTmnUeRlL42qKko=
X-Received: by 2002:a5e:a808:0:b0:794:eb37:b0da with SMTP id
 c8-20020a5ea808000000b00794eb37b0damr5660549ioa.2.1694928447734; Sat, 16 Sep
 2023 22:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230914022425.1489035-1-irogers@google.com>
In-Reply-To: <20230914022425.1489035-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:27:15 -0700
Message-ID: <CAM9d7ci_jHVEU2PStMHudOYGnx9aLdhYT=_5vCJiyjc_YyrtVw@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Ensure all alias variables are initialized
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 13, 2023 at 7:24 PM Ian Rogers <irogers@google.com> wrote:
>
> Fix an error detected by memory sanitizer:
> ```
> ==4033==WARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x55fb0fbedfc7 in read_alias_info tools/perf/util/pmu.c:457:6
>     #1 0x55fb0fbea339 in check_info_data tools/perf/util/pmu.c:1434:2
>     #2 0x55fb0fbea339 in perf_pmu__check_alias tools/perf/util/pmu.c:1504:9
>     #3 0x55fb0fbdca85 in parse_events_add_pmu tools/perf/util/parse-events.c:1429:32
>     #4 0x55fb0f965230 in parse_events_parse tools/perf/util/parse-events.y:299:6
>     #5 0x55fb0fbdf6b2 in parse_events__scanner tools/perf/util/parse-events.c:1822:8
>     #6 0x55fb0fbdf8c1 in __parse_events tools/perf/util/parse-events.c:2094:8
>     #7 0x55fb0fa8ffa9 in parse_events tools/perf/util/parse-events.h:41:9
>     #8 0x55fb0fa8ffa9 in test_event tools/perf/tests/parse-events.c:2393:8
>     #9 0x55fb0fa8f458 in test__pmu_events tools/perf/tests/parse-events.c:2551:15
>     #10 0x55fb0fa6d93f in run_test tools/perf/tests/builtin-test.c:242:9
>     #11 0x55fb0fa6d93f in test_and_print tools/perf/tests/builtin-test.c:271:8
>     #12 0x55fb0fa6d082 in __cmd_test tools/perf/tests/builtin-test.c:442:5
>     #13 0x55fb0fa6d082 in cmd_test tools/perf/tests/builtin-test.c:564:9
>     #14 0x55fb0f942720 in run_builtin tools/perf/perf.c:322:11
>     #15 0x55fb0f942486 in handle_internal_command tools/perf/perf.c:375:8
>     #16 0x55fb0f941dab in run_argv tools/perf/perf.c:419:2
>     #17 0x55fb0f941dab in main tools/perf/perf.c:535:3
> ```
>
> Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files
> from sysfs")
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools, thanks!

Namhyung
