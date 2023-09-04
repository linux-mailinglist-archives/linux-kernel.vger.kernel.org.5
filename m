Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85BC791653
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352823AbjIDLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjIDLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:42:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B77E18C;
        Mon,  4 Sep 2023 04:42:26 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RfRWT145BzTkJY;
        Mon,  4 Sep 2023 19:39:49 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 19:42:22 +0800
Subject: Re: [RFC v1 01/16] perf kwork: Fix incorrect and missing free atom in
 work_push_atom()
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
 <20230812084917.169338-2-yangjihong1@huawei.com>
 <CAP-5=fUVY9eL-t4Ya5bqHz7gDKDSi9=kvDgMdGmb02Yh8LhVaA@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <7655189d-1fbe-c5d7-f1aa-d1e8b4db0bfe@huawei.com>
Date:   Mon, 4 Sep 2023 19:42:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUVY9eL-t4Ya5bqHz7gDKDSi9=kvDgMdGmb02Yh8LhVaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/9/4 12:05, Ian Rogers wrote:
> On Sat, Aug 12, 2023 at 1:52 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> 1. Atoms are managed in page mode and should be released using atom_free()
>>     instead of free().
>> 2. When the event does not match, the atom needs to free.
>>
>> Fixes: f98919ec4fcc ("perf kwork: Implement 'report' subcommand")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
Thanks for review-by tag.
>> ---
>>   tools/perf/builtin-kwork.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index 14bf7a8429e7..73b5dc099a8a 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -406,12 +406,14 @@ static int work_push_atom(struct perf_kwork *kwork,
>>
>>          work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
>>          if (work == NULL) {
>> -               free(atom);
>> +               atom_free(atom);
> 
> Presumably this is fixing a memory-leak. It would be nice if kwork had
> perf tests, then our builds with -fsanitize=address would highlight
> this kind of issue. Here is a build command I use for this:
> make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g
> -fno-omit-frame-pointer -fsanitize=address" BUILD_BPF_SKEL=1
> NO_LIBTRACEEVENT=1
> 
Okay, I'm going to add the kwork test in perf tests.

Thanks,
Yang
