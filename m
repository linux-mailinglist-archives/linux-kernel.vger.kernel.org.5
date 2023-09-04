Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1924B791660
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352847AbjIDLqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352841AbjIDLqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:46:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E3CC6;
        Mon,  4 Sep 2023 04:46:05 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfRZs5m1Hz1DDXx;
        Mon,  4 Sep 2023 19:42:45 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 19:46:03 +0800
Subject: Re: [RFC v1 05/16] perf kwork: Overwrite original atom in the list
 when a new atom is pushed.
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
 <20230812084917.169338-6-yangjihong1@huawei.com>
 <CAP-5=fWLmRWPdnxSG1AcyxzaupUAn9sX0M-dtDB1dd7-FCEhrw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <91cb7bea-3bec-b40c-24a2-be9052a30937@huawei.com>
Date:   Mon, 4 Sep 2023 19:46:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWLmRWPdnxSG1AcyxzaupUAn9sX0M-dtDB1dd7-FCEhrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/9/4 12:13, Ian Rogers wrote:
> On Sat, Aug 12, 2023 at 1:52 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> work_push_atom() supports nesting. Currently, all supported kworks are not
>> nested. A `overwrite` parameter is added to overwrite the original atom in
>> the list.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/builtin-kwork.c | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index 42ea59a957ae..f620911a26a2 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -392,9 +392,10 @@ static int work_push_atom(struct perf_kwork *kwork,
>>                            struct evsel *evsel,
>>                            struct perf_sample *sample,
>>                            struct machine *machine,
>> -                         struct kwork_work **ret_work)
>> +                         struct kwork_work **ret_work,
>> +                         bool overwrite)
> 
> kerneldoc would be useful. Pushing something seems self-evident but
> what does overwrite mean without reading the code?

Okay, I'll add comments.

> 
>>   {
>> -       struct kwork_atom *atom, *dst_atom;
>> +       struct kwork_atom *atom, *dst_atom, *last_atom;
>>          struct kwork_work *work, key;
>>
>>          BUG_ON(class->work_init == NULL);
>> @@ -427,6 +428,17 @@ static int work_push_atom(struct perf_kwork *kwork,
>>          if (ret_work != NULL)
>>                  *ret_work = work;
>>
>> +       if (overwrite) {
>> +               last_atom = list_last_entry_or_null(&work->atom_list[src_type],
>> +                                                   struct kwork_atom, list);
>> +               if (last_atom) {
>> +                       atom_del(last_atom);
>> +
>> +                       kwork->nr_skipped_events[src_type]++;
>> +                       kwork->nr_skipped_events[KWORK_TRACE_MAX]++;
>> +               }
>> +       }
>> +
>>          list_add_tail(&atom->list, &work->atom_list[src_type]);
>>
>>          return 0;
>> @@ -502,7 +514,7 @@ static int report_entry_event(struct perf_kwork *kwork,
>>   {
>>          return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
>>                                KWORK_TRACE_MAX, evsel, sample,
>> -                             machine, NULL);
>> +                             machine, NULL, true);
> 
> nit: for constant arguments it can be useful to add parameter names
> which can enable checks like clang-tidy's bugprone argument:
> https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-comment.html
> This would make this:
>          return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
>                                KWORK_TRACE_MAX, evsel, sample,
>                                machine, /*ret_work=*/NULL, /*overwite=*/true);
> 
Thanks for your advice, will add parameter names later.

Thanks,
Yang
