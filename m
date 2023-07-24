Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B575EF38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGXJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGXJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:34:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CE129;
        Mon, 24 Jul 2023 02:34:39 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8ZjQ6cJ2z1KCBV;
        Mon, 24 Jul 2023 17:33:46 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:34:35 +0800
Date:   Mon, 24 Jul 2023 17:34:18 +0800
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
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v3 0/3] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
Message-ID: <20230724093418.ntluetxruz3ufqnl@M910t>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
 <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
 <20230724040229.eipq7i43v4xcrq3p@M910t>
 <05b67e8c-6ba0-5774-93fd-d390ac4e3b19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <05b67e8c-6ba0-5774-93fd-d390ac4e3b19@intel.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:44:12AM +0300, Adrian Hunter wrote:
> On 24/07/23 07:02, Changbin Du wrote:
> > On Thu, Jul 20, 2023 at 01:00:58PM +0300, Adrian Hunter wrote:
> >> On 18/07/23 06:33, Changbin Du wrote:
> >>> This adds a new option '--workload-attr' to set the sched_policy/priority/mask
> >>> of the workload to reduce system noise.
> >>>
> >>> $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls
> >>
> >> Not really sold on the need for this, but maybe it could be
> >> simpler.
> >> What about just adding a hook for a command (e.g. script) to
> >> run before exec'ing the workload e.g.
> >>
> >> --configure-workload=blah.sh
> >>
> >> results in perf doing system("blah.sh 12345") where 12345
> >> is the workload PID.
> >>
> >> Then maybe you could do:
> >>
> >> --configure-workload="taskset -p 0x3"
> >>
> > Acctually, we already have such option for perf-stat.
> > 
> > 	--post <command>  command to run after to the measured command
> >         --pre <command>   command to run prior to the measured command
> > 
> > By involving a shell script we can do more complex setup. But sometimes I just
> > need to set sched attributes. For example, to investigate the impact of
> > various compiler optimizations. In this case, I don't want a script. This is the
> > original purpose I try to add this new option.
> 
> There is also command schedtool, but what exactly is the problem
> with a script?
> 
> > 
There is no problem with a script, just a shortcut for convenience. When I want
to share perf investigation with somebody, I just need to share a single commandline.
Anyway nothing bad, right? :)


-- 
Cheers,
Changbin Du
