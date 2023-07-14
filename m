Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B90753301
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjGNHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjGNHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:19:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F830E8;
        Fri, 14 Jul 2023 00:19:36 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R2N7M2t7jzNmSX;
        Fri, 14 Jul 2023 15:16:15 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 14 Jul
 2023 15:19:32 +0800
Date:   Fri, 14 Jul 2023 15:19:14 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: add new option '--workload-attr' to set workload
 sched_policy/priority/mask
Message-ID: <20230714071914.3jro4kfcvhun2ptd@M910t>
References: <20230713085831.395112-1-changbin.du@huawei.com>
 <b1127b63-6c6a-e42e-ce6c-cf4f24bbc5a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b1127b63-6c6a-e42e-ce6c-cf4f24bbc5a1@intel.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:06:31AM +0300, Adrian Hunter wrote:
> On 13/07/23 11:58, Changbin Du wrote:
> > To get consistent benchmarking results, sometimes we need to set the
> > sched_policy/priority/mask of the workload to reduce system noise.
> > 
> > For example, CPU binding is required on big.little system.
> > 
> >   $ perf stat -r 10 -- taskset -c 0 ls
> > 
> > Nevertheless, the 'taskset' is also counted here.
> > 
> > To get away of the middleman, this adds a new option '--workload-attr' to
> > do the same jobs for stat and record commands.
> > 
> >   $ sudo perf stat --workload-attr fifo,40,0x1 -- ls
> > 
> > Above will make 'ls' run on CPU #0 with fifo scheduler and realtime
> > priority is 40.
> 
> Aren't there ways to set up a process then start perf using -p <pid>
> then let the process continue.
>
By that you need a mechanism to pause the new spawnned process and wait perf to
attach. Or setup the sched properties by the app itself. But sometimes we just
simply want to run the app through and measure some events. With
--workload-attr, we do not need extra setup works.

-- 
Cheers,
Changbin Du
