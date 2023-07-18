Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071D57578AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGRJ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGRJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:57:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC5E19A3;
        Tue, 18 Jul 2023 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689674217; x=1721210217;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qbLXGWFFYEJCgQzOxVWO4TdnwGiMCCXFlEgS+DMnSY8=;
  b=D35mX2wcPpFRdvSOcLPTJzME/t0oAeBAEUGzkF1sZbsTjAxTMsyb9Dcm
   lA0hA7lgv1aYaHy/Zf7esoOol+uhlJXE5fY5DyAFy+8oqikOEkVrgH4D2
   Fa/mD/JYm+11zeWtVSlMu2RUYV4QH1Y4f60N68mB0ZbCHJUszGAYMCWs3
   vezNdi1P0zKUyC8PGz1OMKFl/QY2e3WTHCVtOHaKwvu5memBSAVgXJ8nf
   qFvBE08Mb9Q9Kq9/mQQkYCUMaI7YaUzHAyggGVo8p7pMhvwxplPxQTWis
   EVGubmbUJIcrZNXyH8gIOIg8Na4j4lfYdtmEU/Z2/LJKzlxm90Cxt19xT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368804826"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="368804826"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 02:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673847913"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="673847913"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 02:56:52 -0700
Message-ID: <c4b7fb70-7b2e-74e9-576f-33b29e8801cd@intel.com>
Date:   Tue, 18 Jul 2023 12:56:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/7] perf evlist: Skip dummy event sample_type check
 for evlist_config
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-6-yangjihong1@huawei.com>
 <5797e5a7-a85f-4f7c-1649-88f8f9ff7a6b@intel.com>
 <44645529-0ee6-fe69-bc03-fefbc6f73d4d@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <44645529-0ee6-fe69-bc03-fefbc6f73d4d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/23 12:30, Yang Jihong wrote:
> Hello,
> 
> On 2023/7/17 22:41, Adrian Hunter wrote:
>> On 15/07/23 06:29, Yang Jihong wrote:
>>> The dummp event does not contain sampls data. Therefore, sample_type does
>>> not need to be checked.
>>>
>>> Currently, the sample id format of the actual sampling event may be changed
>>> after the dummy event is added.
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> ---
>>>   tools/perf/util/record.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
>>> index 9eb5c6a08999..0240be3b340f 100644
>>> --- a/tools/perf/util/record.c
>>> +++ b/tools/perf/util/record.c
>>> @@ -128,6 +128,13 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>>>           evlist__for_each_entry(evlist, evsel) {
>>>               if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>>>                   continue;
>>> +
>>> +            /*
>>> +             * Skip the sample_type check for the dummy event
>>> +             * because it does not have any samples anyway.
>>> +             */
>>> +            if (evsel__is_dummy_event(evsel))
>>> +                continue;
>>
>> Sideband event records have "ID samples" so the sample type still matters.
>>
> Okay, will remove this patch in next version.
> 
> Can I ask a little more about this?
> 
> Use PERF_SAMPLE_IDENTIFICATION instead of PERF_SAMPLE_ID because for samples of type PERF_RECORD_SAMPLE, there may be different record formats due to different *sample_type* settings, so the fixed SAMPLE_ID  location mode PERF_SAMPLE_NAME is required here.
> 
> However, for the sideband event, the samples of the PERF_RECORD_SAMPLE type is not recorded (only PERF_RECORD_MMAP, PERF_RECORD_COMM, and so on). Therefore, the "use sample identifier "check can be skipped here.
> 
> That's my understanding of PERF_SAMPLE_IDENTIFICATION . If there is any error, please help to correct it.
> 
> *Sideband event records have "ID samples" so the sample type still matters.*
> 
> Does this mean that sideband will also record samples of type PERF_RECORD_SAMPLE? What exactly is the sampling data?

No.  There are additional members as defined by struct sample_id for PERF_RECORD_MMAP:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/perf_event.h?h=v6.4#n872

