Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2653F762BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGZGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGZGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:40:18 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657119A1;
        Tue, 25 Jul 2023 23:40:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VoFo2qO_1690353609;
Received: from 30.221.150.4(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoFo2qO_1690353609)
          by smtp.aliyun-inc.com;
          Wed, 26 Jul 2023 14:40:11 +0800
Message-ID: <4bb466a6-f64f-954c-0d4b-a140a555bffe@linux.alibaba.com>
Date:   Wed, 26 Jul 2023 14:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/4] perf jevents: Support more event fields
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690100513-61165-3-git-send-email-renyu.zj@linux.alibaba.com>
 <13cdb7cb-e6c0-5b85-3ccf-adb3b0ed36e0@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <13cdb7cb-e6c0-5b85-3ccf-adb3b0ed36e0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/25 下午5:41, John Garry 写道:
> On 23/07/2023 09:21, Jing Zhang wrote:
>> The usual event descriptions are "event=xxx" or "config=xxx", while the
>> event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.
>>
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
>> no longer added by default. EventidCode and Type are added to the event
>> field, and ConfigCode is moved into the event field.
> 
> What does "ConfigCode is moved into the event field" mean?
> 

What I want to express is to move "ConfigCode" into the event_filed array which can also guarantee its original function. like this:
event_fields = [
	  ...
          ('AnyThread', 'any='),
          ('PortMask', 'ch_mask='),
          ('ConfigCode', 'config='),
	  ...
]

Haha, my English language proficiency still needs improvement, please forgive me.

>>
> 
> There should be perf tool self-tests cases for this, see tests/pmu-events.c and tests/parse-events.c, like "umask" is tested
> 

Ok, will do.


Thanks,
Jing
