Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F77EE017
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbjKPLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:46:37 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D64181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:46:34 -0800 (PST)
Message-ID: <28e179e1-c371-4212-9402-9fe3236e7b66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700135192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALy0ZOKzQLKlX8vKIj4p6bR47g5CJnR2bhwt15Sf1AE=;
        b=kVEPDUOlIKylq+XJWN9RKqCW+BiLljp+SElDWhBvu1scHc7+U8k309JrV1CjHHz/0Lgx7o
        BpCX/XGWUNPtEKGasEkoEqwEfzm0FFfYJXwp1mLYDPDspH3wQ/bxD2UI7FbaII7zUzcTcm
        rOpHU77aJXl4t8CJ1hAQ0uiNmCKOb+I=
Date:   Thu, 16 Nov 2023 06:46:24 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] bpf: task_group_seq_get_next: use __next_thread()
 rather than next_thread()
Content-Language: en-GB
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20231114163234.GA890@redhat.com>
 <34440ea4-3780-45e4-9e7c-1b36b535171b@linux.dev>
 <20231116093428.GA18748@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231116093428.GA18748@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 4:34 AM, Oleg Nesterov wrote:
> On 11/15, Yonghong Song wrote:
>> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
>>> @@ -70,15 +70,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>>   		return NULL;
>>>   retry:
>>> -	task = next_thread(task);
>>> +	task = __next_thread(task);
>>> +	if (!task)
>>> +		return NULL;
>>>   	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
>>> -	if (!next_tid || next_tid == common->pid) {
>>> -		/* Run out of tasks of a process.  The tasks of a
>>> -		 * thread_group are linked as circular linked list.
>>> -		 */
>>> -		return NULL;
>>> -	}
>>> +	if (!next_tid)
>>> +		goto retry;
>> Look at the code. Looks like next_tid should never be 0
> ...
>
>> pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
>>                          struct pid_namespace *ns)
>> {
>>          pid_t nr = 0;
>>
>>          rcu_read_lock();
>>          if (!ns)
>>                  ns = task_active_pid_ns(current);
>>          nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Please note that task_pid_ptr(task, type)) can return NULL if this
> task has already exited and called detach_pid().
>
> detach_pid() does __change_pid(task, type, NULL), please note the
>
> 	*pid_ptr = new; // NULL in this case
>
> assignment in __change_pid().
>
> IOW. The problem is not that ns can change, the problem is that
> task->thread_pid (and other pid links) can be NULL, and in this
> case pid_nr_ns() returns zero.

Thanks for explanation. I certainly missed race between task
iterator and __change_pid(). Then the patch looks good to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
>
> This code should be rewritten from the very beginning, it should
> not rely on pid_nr. If nothing else common->pid and/or pid_visiting
> can be reused. But currently my only concern is next_thread().
>
>> Other than above, the change looks good to me.
> Thanks for review!
>
> Oleg.
>
