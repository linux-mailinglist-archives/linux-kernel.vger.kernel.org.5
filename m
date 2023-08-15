Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53C77C58A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHOB55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjHOB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:57:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09627B0;
        Mon, 14 Aug 2023 18:57:39 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPvSn3mBJztRwy;
        Tue, 15 Aug 2023 09:54:01 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 09:57:35 +0800
Subject: Re: [PATCH v5 3/7] perf record: Move setting dummy tracking before
 record__init_thread_masks()
To:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-4-yangjihong1@huawei.com>
 <b8741176-dc9c-1ddb-6bb5-85293f3c61f7@intel.com>
 <CAP-5=fV2u+HwxwuCmz0uSo_dvbFAwwjvK_QvkorB+qbtMnwtZg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <29111bbc-61af-4452-bf73-c3b32221989f@huawei.com>
Date:   Tue, 15 Aug 2023 09:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fV2u+HwxwuCmz0uSo_dvbFAwwjvK_QvkorB+qbtMnwtZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/15 4:29, Ian Rogers wrote:
> On Thu, Aug 3, 2023 at 11:58 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 4/08/23 05:07, Yang Jihong wrote:
>>> When dummy tracking go system wide, the mmap cpu mask is changed.
> 
> As previously commented, can we improve the quality of the function
> names and commit messages? This sentence is particularly difficult to
> understand, I don't understand it.

OK. The commit messages will be modified. Please check whether the 
following description is clear:

User space tasks can migrate between CPUs, so when tracing selected 
CPUs, sideband for all CPUs is needed. In this case set the cpu map of 
the evsel to all online CPUs. This may modify the original cpu map of 
the evlist.
Therefore, need to check whether the preceding scenario exists before 
record__init_thread_masks().
Dummy tracking has been set in record__open(), move it before 
record__init_thread_masks() and add a helper for unified processing.

Thanks,
Yang
