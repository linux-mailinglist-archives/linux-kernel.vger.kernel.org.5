Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFE77CC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjHOMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbjHOMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:25:35 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A72726;
        Tue, 15 Aug 2023 05:24:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VprzgML_1692102258;
Received: from 30.221.150.39(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VprzgML_1692102258)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 20:24:20 +0800
Message-ID: <a5a5ca95-e4c7-74a9-c875-9feea7a1b642@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 20:24:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/7] perf jevents: Support more event fields
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
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
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fXFZffdRMFH+aFzFech2pjbfYyQ+fx+E-YnfMBHifD4gw@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fXFZffdRMFH+aFzFech2pjbfYyQ+fx+E-YnfMBHifD4gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/15 上午6:31, Ian Rogers 写道:
> On Mon, Aug 7, 2023 at 12:51 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> The usual event descriptions are "event=xxx" or "config=xxx", while the
>> event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.
> 
> I found this difficult to read in relation to the code. Perhaps:
> 
> The previous code assumes an event has either an "event=" or "config"
> field at the beginning. For CMN neither of these may be present, as an
> event is typically "type=xx,eventid=xxx".
> 

Thank you for providing a more accurate and readable description.
I was indeed struggling with how to describe the problem more accurately before.

> I think the use of the name "type" here is unfortunate. It conflicts
> with the PMU's type as defined in perf_event_attr.
> 

I agree, but it would require modifying the driver, which is not currently being
considered. In the meantime, I can describe the event_field as ('NodeType', 'type=').

> In general I think the jevents.py code needs improving, the
> event_fields dictionary is convoluted, we shouldn't be afraid to
> change the event json for example to get rid of things like ExtSel, we
> should really ensure the formats in the events are valid for the PMU
> they are for.
> 
>> $cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
>> type=0x5,eventid=0x3
>>
>> When adding aliases for events described as "event=xxx" or "config=xxx",
>> EventCode or ConfigCode can be used in the JSON files to describe the
>> events. But "eventid=xxx, type=xxx" cannot be supported at present.
>>
>> If EventCode and ConfigCode is not added in the alias JSON file, the
>> event description will add "event=0" by default. So, even if the event
>> field is added to supplement "eventid=xxx" and "type=xxx", the final
>> parsing result will be "event=0, eventid=xxx, type=xxx".
>>
>> Therefore, when EventCode and ConfigCode are missing in JSON, "event=0" is
>> no longer added by default. EventIdCode and Type are added to the event
>> field, and ConfigCode is moved into the event_field array which can also
>> guarantee its original function.
> 
> A useful test can be to build with JEVENTS_ARCH=all and confirm the
> before and after change generated pmu-events.c is the same.
> 

Okay, I will test it right away.

>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>  tools/perf/pmu-events/jevents.py | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index f57a8f2..9c0f63a 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -275,12 +275,6 @@ class JsonEvent:
>>        }
>>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>>
>> -    eventcode = 0
>> -    if 'EventCode' in jd:
>> -      eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
>> -    if 'ExtSel' in jd:
>> -      eventcode |= int(jd['ExtSel']) << 8
>> -    configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
>>      self.name = jd['EventName'].lower() if 'EventName' in jd else None
>>      self.topic = ''
>>      self.compat = jd.get('Compat')
>> @@ -317,7 +311,15 @@ class JsonEvent:
>>      if precise and self.desc and '(Precise Event)' not in self.desc:
>>        extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
>>                                                                   'event)')
>> -    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
>> +    eventcode = None
>> +    if 'EventCode' in jd:
>> +      eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
>> +    if 'ExtSel' in jd:
>> +      if eventcode is None:
>> +        eventcode = int(jd['ExtSel']) << 8
>> +      else:
>> +        eventcode |= int(jd['ExtSel']) << 8
>> +    event = f'event={llx(eventcode)}' if eventcode is not None else None
>>      event_fields = [
>>          ('AnyThread', 'any='),
>>          ('PortMask', 'ch_mask='),
>> @@ -327,10 +329,13 @@ class JsonEvent:
>>          ('Invert', 'inv='),
>>          ('SampleAfterValue', 'period='),
>>          ('UMask', 'umask='),
>> +        ('ConfigCode', 'config='),
> 
> This loses the int and potential base conversion of ConfigCode.
> Clearly the code was taking care to maintain this behavior so I
> suspect this change has broken something. JEVENTS_ARCH=all should
> reveal the answer.
> 

You are correct, I compared the generated pmu-events.c files before and after,
and they are indeed different, with before:config=0x5 vs after:config=0x05. I will keep the
original way of handling ConfigCode in the next version.

>> +        ('Type', 'type='),
>> +        ('EventIdCode', 'eventid='),
>>      ]
>>      for key, value in event_fields:
>>        if key in jd and jd[key] != '0':
>> -        event += ',' + value + jd[key]
>> +        event = event + ',' + value + jd[key] if event is not None else value + jd[key]
> 
> Perhaps initialize event above to the empty string then:
> 
> if key in jd and jd[key] != '0':
>   if event:
>      event += ','
>   event += value + jd[key]
> 

If the event is None, the statement event += value + jd[key] would result in an error.
So, maybe I can use the following way:

if event:
    event += ',' + value + jd[key]
else:
    event = value + jd[key]


Thanks,
Jing
