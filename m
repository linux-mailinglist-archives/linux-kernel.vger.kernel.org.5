Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898E9779C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjHLBp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 21:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHLBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 21:45:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE4170E;
        Fri, 11 Aug 2023 18:45:54 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RN3PK0M9lzrRrr;
        Sat, 12 Aug 2023 09:44:37 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 09:45:52 +0800
Message-ID: <52369719-dbc7-7cb5-f766-877d24c8400c@huawei.com>
Date:   Sat, 12 Aug 2023 09:45:52 +0800
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Sorry, I didn't make clear here. It not just read more but also lost
some data. My case is that, for example:
   1) Inject 3 events into ring_buffer: event1, event2, event3;
   2) Concurrently splice_read through trace_pipes;
   3) Then actually read out: event1, event3, event3. No event2, but 2 
event3.

> 
> Honestly the real fix is to prevent that use case. We should probably have
> access to trace_pipe lock all the per_cpu trace_pipes too.

Yes, we could do that, but would it seem not that effective?
because per_cpu trace_pipe only read its own ring_buffer and not race
with ring_buffers in other cpus.

> 
> -- Steve
> 

