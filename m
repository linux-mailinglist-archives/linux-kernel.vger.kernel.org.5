Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3575A7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGTHYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjGTHX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:23:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E963C1FCD;
        Thu, 20 Jul 2023 00:23:55 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R640W4psjzrRh8;
        Thu, 20 Jul 2023 15:23:07 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 15:23:52 +0800
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event()
 helper
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com>
 <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <993bd68c-c0ec-4960-d3b0-bd2dbda82402@huawei.com>
Date:   Thu, 20 Jul 2023 15:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/20 0:44, Ian Rogers wrote:
> On Fri, Jul 14, 2023 at 8:31 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
>> tracking to the evlist. We may need to search for the dummy event for
>> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>>
>> evlist__findnew_tracking_event() also deal with system_wide maps if
>> system_wide is true.
> 
> I'm wondering if we can simplify the naming in the API, we have "dummy
> event" which makes sense as we literally call the event "dummy",
> "sideband" which refers to the kind of samples/events the dummy event
> will record but "tracking" I think tends to get used as a verb rather
> than a noun. So I think evlist__findnew_tracking_event should be
> evlist__findnew_dummy_event.
> 
Uh, from the discussion that followed, it seems that there is no 
consensus yet...
If there is a clear consensus on whether to use "dummy event" or 
"tracking event", I will change the name of the API.

I think sideband event is equivalent to tracking event (refer 
evsel__config(), tracking events include task, mmap, mmap2, and comm 
sideband events, which are all sideband).

tracking event are instances of dummy event. For example, we create 
another dummy event to record the text poke event of ksymbol (refer perf 
record --kcore).

An evlist contains only one tracking event, but can contain multiple 
dummy events.

Thanks,
Yang
