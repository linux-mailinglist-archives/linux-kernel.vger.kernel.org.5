Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9D7ADEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjIYS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:29:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2595
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:29:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41513d2cca7so64421cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695666589; x=1696271389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PMYRfehl7AKwIuYYv4VYHbWKGFD1AMTVVElbcrzeIk=;
        b=qxik4R9HkVKTqGeIWOJhuEN3oz8egBGnDC/O1lXDBmQStvd0vqtovtXGQHbVYd8ga+
         r7/eQLEHJ5vbSAqWX90YpdUTxOltKsk+vHqDz48rq0BjQ3hSNFgEaW2yTcFjf+SVWaaJ
         n7V3ibpg9NXiL5ptxcK8d89Kan3koLe1lijZ8EQHQ8ZfmytvVeXLKCguiRfpmQrkFXEA
         TwFEY3ksv2Vg1u20J3FHxatFtQlaE2q8/SpitKwgr0nJanFfx18+uZWaUWZJssEP2FN4
         JjKPXUvJZ1ZxqzJYSbl4RS4/Vr+dCcjkoxWcEHwubM8pXF7Zo3vptSkSrK4K+l9o5ZKO
         VusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666589; x=1696271389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PMYRfehl7AKwIuYYv4VYHbWKGFD1AMTVVElbcrzeIk=;
        b=f/R7IeUqEU/tgzHVoIUN15XGbUmaunqasb5dbAlMZS670tJonmRY8mtML949HZV7ON
         EDGkga16Qf2ibBa8r05tE8Z1VC6TLdV1roCgceQd/i7i53F8QRCSkdm8h0FR1XMBEaRf
         fygJEXvgmr53BXi6FvcpxWPrkvy3CVTmorANmHFoCWDOwP9mFEAj16LSixWf8xSPimbw
         j9n62alpnH01awcHSzLfQmqWN7B/zRMaGYpXianzQRCInVI8s6OraeyjW4FV46ACKMeo
         NRRvHD1vqS+yHoRuRpMzljhyWdT9/mUBJDSL0TwWp5T503zGHwHL8ktmiyabJY7fSgZj
         mZ0A==
X-Gm-Message-State: AOJu0YzY/PsbvEzjPGucpEroIzle5yKiuv0huSszSBbHyrCTUg4KwC4K
        fHC0tFluExPJAp3SbGvaiq5i98M1fe13RfO9zWHbLA==
X-Google-Smtp-Source: AGHT+IHicwa9QDTeTPHHU8BVtkrgHPiklf5M3rzkcoONXTpM6moVUBITlBvKtKVa9IkskmrsHPc6ryXwgvT56Sv09eY=
X-Received: by 2002:ac8:5a46:0:b0:410:88dc:21b with SMTP id
 o6-20020ac85a46000000b0041088dc021bmr45741qta.26.1695666589355; Mon, 25 Sep
 2023 11:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230925061824.3818631-1-weilin.wang@intel.com>
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 25 Sep 2023 11:29:34 -0700
Message-ID: <CAP-5=fU-jTKpo8j=7t_xbgnmQDT2+BcmmRY7SWb8e7tyRS7hQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/25] Perf stat metric grouping with hardware information
To:     weilin.wang@intel.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 11:19=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Perf stat metric grouping generates event groups that are provided to ker=
nel for
> data collection using the hardware counters. Sometimes, the grouping migh=
t fail
> and kernel has to retry the groups because generated groups do not fit in=
 the
> hardware counters correctly. In some other cases, the groupings are colle=
cted
> correctly, however, they left some hardware counters unused.
>
> To improve these inefficiencies, we would like to propose a hardware awar=
e
> grouping method that does metric/event grouping based on event counter
> restriction rules and the availability of hardware counters in the system=
. This
> method is generic as long as all the restriction rules could be provided =
from
> the pmu-event JSON files.
>
> This patch set includes code that does hardware aware grouping and update=
d
> pmu-event JSON files for four platforms (SapphireRapids, Icelakex, Cascad=
elakex,
> and Tigerlake) for your testing and experimenting. We've successfully tes=
ted
> these patches on three platforms (SapphireRapids, Icelakex, and Cascadela=
kex)
> with topdown metrics from TopdownL1 to TopdownL6.
>
> There are some optimization opportunities that we might implement in the =
future:
> 1) Better NMI hanlding: when NMI watchdog is enabled, we reduce the defau=
lt_core
> total counter size by one. This could be improved to better utilize the c=
ounter.

Thanks Weilin! I'm checking out the series. Hopefully the NMI watchdog
perf event can go away soon with the buddy scheme:
https://lore.kernel.org/lkml/20230527014153.2793931-1-dianders@chromium.org=
/
But better NMI handling would be true for people without the latest kernel.

Thanks,
Ian

> 2) Fill important events into unused counter for better counter utlizatio=
n:
> there might be some unused counters scattered in the groups. We could con=
sider
> to add important events in this slots if necessary. This could help incre=
ase the
> multiplexing percentage and help improve accuracy if the event is critica=
l.
>
> Remaining questions for dicussion:
> 3) Where to start grouping from? The current implementation start groupin=
g by
> combining all the events into a single list. This step deduplicates event=
s. But
> it does not maintain the relationship of events according to the metrics,=
 i.e.
> events required by one metric may not be collected at the same time. Anot=
her
> type of starting point would be grouping each individual metric and then =
try to
> merge the groups.
> 4) Any comments, suggestions, new ideas?
> 5) If you are interested to test the patch out and the pmu-event JSON fil=
es of
> your testing platform is not provided here, please let me know so that I =
could
> provide you the files.
>
>
> Weilin Wang (25):
>   perf stat: Add hardware-grouping cmd option to perf stat
>   perf stat: Add basic functions for the hardware-grouping stat cmd
>     option
>   perf pmu-events: Add functions in jevent.py
>   perf pmu-events: Add counter info into JSON files for SapphireRapids
>   perf pmu-events: Add event counter data for Cascadelakex
>   perf pmu-events: Add event counter data for Icelakex
>   perf stat: Add helper functions for hardware-grouping method
>   perf stat: Add functions to get counter info
>   perf stat: Add helper functions for hardware-grouping method
>   perf stat: Add helper functions to hardware-grouping method
>   perf stat: Add utility functions to hardware-grouping method
>   perf stat: Add more functions for hardware-grouping method
>   perf stat: Add functions to hardware-grouping method
>   perf stat: Add build string function and topdown events handling in
>     hardware-grouping
>   perf stat: Add function to combine metrics for hardware-grouping
>   perf stat: Update keyword core to default_core to adjust to the
>     changes for events with no unit
>   perf stat: Handle taken alone in hardware-grouping
>   perf stat: Handle NMI in hardware-grouping
>   perf stat: Handle grouping method fall back in hardware-grouping
>   perf stat: Code refactoring in hardware-grouping
>   perf stat: Add tool events support in hardware-grouping
>   perf stat: Add TSC support in hardware-grouping
>   perf stat: Fix a return error issue in hardware-grouping
>   perf stat: Add check to ensure correctness in platform that does not
>     support hardware-grouping
>   perf pmu-events: Add event counter data for Tigerlake
>
>  tools/lib/bitmap.c                            |   20 +
>  tools/perf/builtin-stat.c                     |    7 +
>  .../arch/x86/cascadelakex/cache.json          | 1237 ++++++++++++
>  .../arch/x86/cascadelakex/counter.json        |   17 +
>  .../arch/x86/cascadelakex/floating-point.json |   16 +
>  .../arch/x86/cascadelakex/frontend.json       |   68 +
>  .../arch/x86/cascadelakex/memory.json         |  751 ++++++++
>  .../arch/x86/cascadelakex/other.json          |  168 ++
>  .../arch/x86/cascadelakex/pipeline.json       |  102 +
>  .../arch/x86/cascadelakex/uncore-cache.json   | 1138 +++++++++++
>  .../x86/cascadelakex/uncore-interconnect.json | 1272 +++++++++++++
>  .../arch/x86/cascadelakex/uncore-io.json      |  394 ++++
>  .../arch/x86/cascadelakex/uncore-memory.json  |  509 +++++
>  .../arch/x86/cascadelakex/uncore-power.json   |   25 +
>  .../arch/x86/cascadelakex/virtual-memory.json |   28 +
>  .../pmu-events/arch/x86/icelakex/cache.json   |   98 +
>  .../pmu-events/arch/x86/icelakex/counter.json |   17 +
>  .../arch/x86/icelakex/floating-point.json     |   13 +
>  .../arch/x86/icelakex/frontend.json           |   55 +
>  .../pmu-events/arch/x86/icelakex/memory.json  |   53 +
>  .../pmu-events/arch/x86/icelakex/other.json   |   52 +
>  .../arch/x86/icelakex/pipeline.json           |   92 +
>  .../arch/x86/icelakex/uncore-cache.json       |  965 ++++++++++
>  .../x86/icelakex/uncore-interconnect.json     | 1667 +++++++++++++++++
>  .../arch/x86/icelakex/uncore-io.json          |  966 ++++++++++
>  .../arch/x86/icelakex/uncore-memory.json      |  186 ++
>  .../arch/x86/icelakex/uncore-power.json       |   26 +
>  .../arch/x86/icelakex/virtual-memory.json     |   22 +
>  .../arch/x86/sapphirerapids/cache.json        |  104 +
>  .../arch/x86/sapphirerapids/counter.json      |   17 +
>  .../x86/sapphirerapids/floating-point.json    |   25 +
>  .../arch/x86/sapphirerapids/frontend.json     |   98 +-
>  .../arch/x86/sapphirerapids/memory.json       |   44 +
>  .../arch/x86/sapphirerapids/other.json        |   40 +
>  .../arch/x86/sapphirerapids/pipeline.json     |  118 ++
>  .../arch/x86/sapphirerapids/uncore-cache.json |  534 +++++-
>  .../arch/x86/sapphirerapids/uncore-cxl.json   |   56 +
>  .../sapphirerapids/uncore-interconnect.json   |  476 +++++
>  .../arch/x86/sapphirerapids/uncore-io.json    |  373 ++++
>  .../x86/sapphirerapids/uncore-memory.json     |  391 ++++
>  .../arch/x86/sapphirerapids/uncore-power.json |   24 +
>  .../x86/sapphirerapids/virtual-memory.json    |   20 +
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   65 +
>  .../arch/x86/tigerlake/counter.json           |    7 +
>  .../arch/x86/tigerlake/floating-point.json    |   13 +
>  .../arch/x86/tigerlake/frontend.json          |   56 +
>  .../pmu-events/arch/x86/tigerlake/memory.json |   31 +
>  .../pmu-events/arch/x86/tigerlake/other.json  |    4 +
>  .../arch/x86/tigerlake/pipeline.json          |   96 +
>  .../x86/tigerlake/uncore-interconnect.json    |   11 +
>  .../arch/x86/tigerlake/uncore-memory.json     |    6 +
>  .../arch/x86/tigerlake/uncore-other.json      |    1 +
>  .../arch/x86/tigerlake/virtual-memory.json    |   20 +
>  tools/perf/pmu-events/jevents.py              |  179 +-
>  tools/perf/pmu-events/pmu-events.h            |   26 +-
>  tools/perf/util/metricgroup.c                 |  927 +++++++++
>  tools/perf/util/metricgroup.h                 |   82 +
>  tools/perf/util/pmu.c                         |    5 +
>  tools/perf/util/pmu.h                         |    1 +
>  tools/perf/util/stat.h                        |    1 +
>  60 files changed, 13790 insertions(+), 25 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json
>
> --
> 2.39.3
>
