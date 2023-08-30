Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF078DE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbjH3TCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbjH3NyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:54:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C66E8;
        Wed, 30 Aug 2023 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693403652; x=1724939652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rtq69h4qZ2EkA6x+rroXCRLlxT7UgdpyhcZo5aYhKAs=;
  b=RseUZsgZ4dZlJpwYPt1yYf9WbpbHDNwfyf2xaMFOAWq4A2ThZIrOY02k
   OEIWYBo8w9qXsZxw5TZM+PI/U6Lq4ZOtmg+n219O6Eldvkn/OxvTvTC/L
   TttpllCB39OZkNjLkGAo8Hvbsr7+nGTBJyQxR8JBPdeVbtjK/aYZMcDvV
   B2v2l2dqrtdXOr+ClrQPZ/vcj0Zi8moKGXhbk3BepZVfbC2BM983+XXC9
   I730MhAo6FQ7pCBjxvD5STlgI9NOmAQheH0pyvIk4V+B/AYIqLdMUS7wS
   9ywM3zGszJxy5hC5kp2ZHoKZNAVM/aHMDEZESPjP1HAwpY1P+SXb8N44+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374559186"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="374559186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="732641474"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="732641474"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.102])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:54:08 -0700
Message-ID: <8cc59832-6dcd-0270-ede9-a06ee3e6a66c@intel.com>
Date:   Wed, 30 Aug 2023 16:54:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/4] perf tools: Convert to
 perf_record_header_attr_id()
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230825152552.112913-1-namhyung@kernel.org>
 <20230825152552.112913-3-namhyung@kernel.org>
 <150a4c24-6082-cf74-035d-c6cf4dacc46d@intel.com>
 <CAM9d7cg5vaD6zUThLWSpL-j3nXJgs3PK=_ensRw8P0Xye-VcfA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cg5vaD6zUThLWSpL-j3nXJgs3PK=_ensRw8P0Xye-VcfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/23 05:15, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Mon, Aug 28, 2023 at 12:59 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 25/08/23 18:25, Namhyung Kim wrote:
>>> Instead of accessing the attr.id directly, use the
>>> perf_record_header_attr_id() helper to handle old versions.
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/util/header.c           | 2 +-
>>>  tools/perf/util/session.c          | 4 ++--
>>>  tools/perf/util/synthetic-events.c | 2 +-
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index f89321cbfdee..63967c34157d 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>>> @@ -4408,7 +4408,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
>>>       if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
>>>               return -ENOMEM;
>>>
>>> -     ids = (void *)&event->attr.attr + event->attr.attr.size;
>>> +     ids = perf_record_header_attr_id(event);
>>>       for (i = 0; i < n_ids; i++) {
>>>               perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
>>>       }
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index 00d18c74c090..1e9aa8ed15b6 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -833,8 +833,8 @@ static void perf_event__hdr_attr_swap(union perf_event *event,
>>>       perf_event__attr_swap(&event->attr.attr);
>>>
>>>       size = event->header.size;
>>> -     size -= (void *)&event->attr.id - (void *)event;
>>> -     mem_bswap_64(event->attr.id, size);
>>> +     size -= perf_record_header_attr_id(event) - (void *)event;
>>> +     mem_bswap_64(perf_record_header_attr_id(event), size);
>>
>> Should this and below also be a fix for stable?
> 
> Then it'd need the perf_record_header_attr_id() change as well.
> Also I'm not sure if it's really needed for stable as it's a pipe output
> (saved to a file though) so very unlikely to have a different endian.
> 
> Thanks,
> Namhyung

Ok

For the patch set:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>>
>>>  }
>>>
>>>  static void perf_event__event_update_swap(union perf_event *event,
>>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>>> index 45714a2785fd..a0579c7d7b9e 100644
>>> --- a/tools/perf/util/synthetic-events.c
>>> +++ b/tools/perf/util/synthetic-events.c
>>> @@ -2145,7 +2145,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *
>>>               return -ENOMEM;
>>>
>>>       ev->attr.attr = *attr;
>>> -     memcpy(ev->attr.id, id, ids * sizeof(u64));
>>> +     memcpy(perf_record_header_attr_id(ev), id, ids * sizeof(u64));
>>>
>>>       ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
>>>       ev->attr.header.size = (u16)size;
>>

