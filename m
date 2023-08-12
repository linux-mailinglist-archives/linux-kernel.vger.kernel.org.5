Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A20A779DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHLHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHLHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:38:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF84419A4;
        Sat, 12 Aug 2023 00:38:14 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNCC12HpMzTmNK;
        Sat, 12 Aug 2023 15:36:13 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 15:38:12 +0800
Message-ID: <b5dbdbeb-be3a-3434-0909-0697d8cb15bf@huawei.com>
Date:   Sat, 12 Aug 2023 15:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
 <20230811152525.2511f8f0@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230811152525.2511f8f0@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/12 03:25, Steven Rostedt wrote:
> On Thu, 10 Aug 2023 20:39:05 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
>> there are more data being read out than expected.
> 
> Honestly the real fix is to prevent that use case. We should probably have
> access to trace_pipe lock all the per_cpu trace_pipes too.
> 
> -- Steve
> 

Hi~

Reproduction testcase is show as below, it can always reproduce the
issue in v5.10, and after this patch, the testcase passed.

In v5.10, when run `cat trace_pipe > /tmp/myfile &`, it call
sendfile() to transmit data from trace_pipe into /tmp/myfile. And in
kernel, .splice_read() of trace_pipe is called then the issue is
reproduced.

However in the newest v6.5, this reproduction case didn't run into the
.splice_read() of trace_pipe, because after commit 97ef77c52b78 ("fs:
check FMODE_LSEEK to control internal pipe splicing"), non-seekable
trace_pipe cannot be sendfile-ed.

``` repro.sh
#!/bin/bash


do_test()
{
         local trace_dir=/sys/kernel/tracing
         local trace=${trace_dir}/trace
         local old_trace_lines
         local new_trace_lines
         local tempfiles
         local testlog="trace pipe concurrency issue"
         local pipe_pids
         local i
         local write_cnt=1000
         local read_cnt=0
         local nr_cpu=`nproc`

         # 1. At first, clear all ring buffer
         echo > ${trace}

         # 2. Count how many lines in trace file now
         old_trace_lines=`cat ${trace} | wc -l`

         # 3. Close water mark so that reader can read as event comes
         echo 0 > ${trace_dir}/buffer_percent

         # 4. Read percpu trace_pipes into local file on background.
         #    Splice read must be used under command 'cat' so that the racy
         #    issue can be reproduced !!!
         i=0
         while [ ${i} -lt ${nr_cpu} ]; do
                 tempfiles[${i}]=/tmp/percpu_trace_pipe_${i}
                 cat ${trace_dir}/per_cpu/cpu${i}/trace_pipe > 
${tempfiles[${i}]} &
                 pipe_pids[${i}]=$!
                 let i=i+1
         done

         # 5. Read main trace_pipe into local file on background.
         #    The same, splice read must be used to reproduce the issue !!!
         tempfiles[${i}]=/tmp/main_trace_pipe
         cat ${trace_dir}/trace_pipe > ${tempfiles[${i}]} &
         pipe_pids[${i}]=$!

         echo "Take a break, let readers run."
         sleep 3

         # 6. Write events into ring buffer through trace_marker, so that
         #    hungry readers start racing these events.
         i=0
         while [ ${i} -lt ${write_cnt} ]; do
                 echo "${testlog} <${i}>" > ${trace_dir}/trace_marker
                 let i=i+1
         done

         # 7. Wait until all events being consumed
         new_trace_lines=`cat ${trace} | wc -l`
         while [ "${new_trace_lines}" != "${old_trace_lines}" ]; do
                 new_trace_lines=`cat ${trace} | wc -l`
                 sleep 1
         done
         echo "All written events have been consumed."

         # 8. Kill all readers and count the events readed
         i=0
         while [ ${i} -lt ${#pipe_pids[*]} ]; do
                 local num

                 kill -9 ${pipe_pids[${i}]}
                 wait ${pipe_pids[${i}]}
                 num=`cat ${tempfiles[${i}]} | grep "${testlog}" | wc -l`
                 let read_cnt=read_cnt+num
                 let i=i+1
         done

         # 9. Expect to read events as much as write
         if [ "${read_cnt}" != "${write_cnt}" ]; then
                 echo "Test fail: write ${write_cnt} but read 
${read_cnt} !!!"
                 return 1
         fi

         # 10. Clean temp files if test success
         i=0
         while [ ${i} -lt ${#tempfiles[*]} ]; do
                 rm ${tempfiles[${i}]}
                 let i=i+1
         done
         return 0
}

do_test
```

-- Zheng Yejian
