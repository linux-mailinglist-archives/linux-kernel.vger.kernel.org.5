Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129447891FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHYWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHYWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:52:14 -0400
Received: from out-246.mta1.migadu.com (out-246.mta1.migadu.com [IPv6:2001:41d0:203:375::f6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3481BCC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:52:11 -0700 (PDT)
Message-ID: <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693003930; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDACEyhLY5VaJttMj8jtwadbBBMJBdF6mgbDTPYbnVE=;
        b=Cc8qJ4a2yv5pEZsrTAph9YdjObWppAt3B3k9vkL0Wky5f6/4kTZAz272ec4JbxDnOs/WRE
        IV9OLPNTpFasGPYSt0wMj1gZ/waNj+C+t8verTtFliV1eNqKLRqmXhldZD25LO5Afl8Bvd
        9wR8S2/YkEFKc9+G4ZpOwNi52JXt/lQ=
Date:   Fri, 25 Aug 2023 15:52:02 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com> <20230825170406.GA16800@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825170406.GA16800@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 10:04 AM, Oleg Nesterov wrote:
> Forgot to mention in the changelog...
> 
> In any case this doesn't look right. ->group_leader can exit before other
> threads, call exit_files(), and in this case task_group_seq_get_next() will
> check task->files == NULL.

It is okay. This won't be affecting correctness. We will end with
calling bpf program for 'next_task'.

> 
> On 08/25, Oleg Nesterov wrote:
>>
>> Unless I am notally confused it is wrong. We are going to return or
>> skip next_task so we need to check next_task-files, not task->files.
>>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> ---
>>   kernel/bpf/task_iter.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 1589ec3faded..2264870ae3fc 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>
>>   	common->pid_visiting = *tid;
>>
>> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
>> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>>   		task = next_task;
>>   		goto retry;
>>   	}
>> --
>> 2.25.1.362.g51ebf55
> 
> 
