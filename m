Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4D752F69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjGNCcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 22:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:31:56 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C429C2D63;
        Thu, 13 Jul 2023 19:31:49 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4815756d742so435313e0c.1;
        Thu, 13 Jul 2023 19:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301909; x=1691893909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nTW7gc06oCO+awj0xYoLUkZXhqvUKiuD24Yf6fhtuE=;
        b=YtWDI73dY00nez3A+XO3CPqLDhZSS1sxSz4DvDpMrBcA+N/HgwY+Bv+L+hylYez5D0
         4BtKlT1FuIFCAJ7jEdHucn/sv7OqMN2F1wgdFkdwVGpHcjUaXifeVh1KN1iFTCP4CKNU
         Sa9TlZi0JhARPCzI5P7piIOAQnO0y7B2yRQuxEiFuTEUy6raKTKKp41wGnnPbsugkjuf
         6a/Zxm0LHYJ3N3ZwW7C54doaGS4LZkxTHU7obQNlM31jkMbKW9ZJV5b7zqN2UNG40xJg
         jnwDhpoxw3i/pSdSWSBYG4gFcudFlqEDFEXl/j4M/NDAwiGzBoZMTsR2RcMKpy0lfOmH
         a2ew==
X-Gm-Message-State: ABy/qLYlvHJMYCoWPSNIXwlXtqbP4dl5v7I4nQBhY0T3QokMrQ6Q/Fjf
        w9NGWKMdTz9K/zJYoVPRgWKhL0fAKeP6iM0wE5Y=
X-Google-Smtp-Source: APBJJlFcM/c6143DXDXfpL/riNtIJbjA6mt/IFwh6YTX0AAQ6hBrc+1QjH+nTBRYi5xUjsXKyAVVsqbO0Pd20e5AIHU=
X-Received: by 2002:a1f:bfd8:0:b0:47e:6e24:7672 with SMTP id
 p207-20020a1fbfd8000000b0047e6e247672mr1885895vkf.13.1689301908691; Thu, 13
 Jul 2023 19:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fXT3a4JE6u8zXf3=xFbOGTre3WD63SMPrA_iSVpgHjDVA@mail.gmail.com>
In-Reply-To: <CAP-5=fXT3a4JE6u8zXf3=xFbOGTre3WD63SMPrA_iSVpgHjDVA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 13 Jul 2023 19:31:36 -0700
Message-ID: <CAM9d7cjRhOQfihjg9ddKBmNCkW7CAG3NMWPkJQOAs5MHUxQUuA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] scripts: python: Add trace end processing and JSON output
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup and Ian,

On Wed, Jul 12, 2023 at 10:28 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jul 10, 2023 at 4:13 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > Inside the trace end function the final output will be dumped
> > to standard output in JSON gecko format. Additionally, constants
> > such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
> > PRODUCT are defined to provide contextual information.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
>
> Acked-by: Ian Rogers <irogers@google.com>

I'm ok with this change too but I think it can be squashed to
patch 1/6 as I think it'd make it more self-contained.  Of course
you might change time and thread to have empty values.

>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 34 ++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 0b8a86bdcab1..39818a603265 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -24,8 +24,40 @@ from Core import *
> >  thread_map = {}
> >  start_time = None
> >
> > +# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user
> > +CATEGORIES = [
> > +    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> > +    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> > +]
>
> A follow up could be to make these command line options, defaulting to
> orange and yellow.

Sounds good.

>
> > +
> > +# The product name is used by the profiler UI to show the Operating system and Processor.
> > +PRODUCT = os.popen('uname -op').read().strip()

I'm not against this but having a command name (or full
command line) of the target process as a title might be better.
But I'm not sure if the python scripting engine exposed the info
(like in perf report --header-only) to the script.

Thanks,
Namhyung


> > +
> >  def trace_end():
> > -       pass
> > +    thread_array = thread_map.values()))
> > +
> > +    result = {
> > +        'meta': {
> > +            'interval': 1,
> > +            'processType': 0,
> > +            'product': PRODUCT,
> > +            'stackwalk': 1,
> > +            'debug': 0,
> > +            'gcpoison': 0,
> > +            'asyncstack': 1,
> > +            'startTime': start_time,
> > +            'shutdownTime': None,
> > +            'version': 24,
> > +            'presymbolicated': True,
> > +            'categories': CATEGORIES,
> > +            'markerSchema': []
> > +            },
> > +        'libs': [],
> > +        'threads': thread_array,
> > +        'processes': [],
> > +        'pausedRanges': []
> > +    }
> > +    json.dump(result, sys.stdout, indent=2)
> >
> >  def process_event(param_dict):
> >         global start_time
> > --
> > 2.34.1
> >
