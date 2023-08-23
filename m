Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9877853F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjHWJ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHWJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:26:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D681E5FCD;
        Wed, 23 Aug 2023 02:12:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30EAE1042;
        Wed, 23 Aug 2023 02:13:31 -0700 (PDT)
Received: from [10.57.3.6] (unknown [10.57.3.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6FD3F740;
        Wed, 23 Aug 2023 02:12:46 -0700 (PDT)
Message-ID: <166d2a93-0d86-b106-e996-d74fb4521aa2@arm.com>
Date:   Wed, 23 Aug 2023 10:12:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/8] perf jevents: Support more event fields
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-5-git-send-email-renyu.zj@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1692606977-92009-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-21 09:36, Jing Zhang wrote:
> The previous code assumes an event has either an "event=" or "config"
> field at the beginning. For CMN neither of these may be present, as an
> event is typically "type=xx,eventid=xxx".
> 
> If EventCode and ConfigCode is not added in the alias JSON file, the
> event description will add "event=0" by default. So, even if the event
> field is added "eventid=xxx" and "type=xxx", the CMN events final
> parsing result will be "event=0, eventid=xxx, type=xxx".
> 
> Therefore, when EventCode and ConfigCode are missing in JSON, "event=0"
> is no longer added by default. And add EventIdCode and Type to the event
> field.
> 
> I compared pmu_event.c before and after compiling with JEVENT_ARCH=all,
> they are consistent.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   tools/perf/pmu-events/jevents.py | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index f57a8f2..369c8bf 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -275,11 +275,14 @@ class JsonEvent:
>         }
>         return table[unit] if unit in table else f'uncore_{unit.lower()}'
>   
> -    eventcode = 0
> +    eventcode = None
>       if 'EventCode' in jd:
>         eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
>       if 'ExtSel' in jd:
> -      eventcode |= int(jd['ExtSel']) << 8
> +      if eventcode is None:
> +        eventcode = int(jd['ExtSel']) << 8
> +      else:
> +        eventcode |= int(jd['ExtSel']) << 8
>       configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
>       self.name = jd['EventName'].lower() if 'EventName' in jd else None
>       self.topic = ''
> @@ -317,7 +320,11 @@ class JsonEvent:
>       if precise and self.desc and '(Precise Event)' not in self.desc:
>         extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
>                                                                    'event)')
> -    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
> +    event = None
> +    if eventcode is not None:
> +      event = f'event={llx(eventcode)}'
> +    elif configcode is not None:
> +      event = f'config={llx(configcode)}'
>       event_fields = [
>           ('AnyThread', 'any='),
>           ('PortMask', 'ch_mask='),
> @@ -327,10 +334,15 @@ class JsonEvent:
>           ('Invert', 'inv='),
>           ('SampleAfterValue', 'period='),
>           ('UMask', 'umask='),
> +        ('NodeType', 'type='),
> +        ('EventIdCode', 'eventid='),

FWIW, this smells like another brewing scalability problem, given that 
these are entirely driver-specific. Not sure off-hand how feasible it 
might be, but my instinct says that a neat solution would be to encode 
them right in the JSON, e.g.:

	"FormatAttr": { "type": 0x5 }

such that jevents should then only really need to consider whether an 
event is defined in terms of a raw "ConfigCode", one or more 
"FormatAttr"s which it can then parse dynamically, or reasonable special 
cases like "EventCode" (given how "event" is one of the most commonly 
used formats).

Thanks,
Robin.

>       ]
>       for key, value in event_fields:
>         if key in jd and jd[key] != '0':
> -        event += ',' + value + jd[key]
> +        if event:
> +          event += ',' + value + jd[key]
> +        else:
> +          event = value + jd[key]
>       if filter:
>         event += f',{filter}'
>       if msr:
