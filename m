Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6C7891E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHYWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjHYWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:45:35 -0400
Received: from out-253.mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6926B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:45:32 -0700 (PDT)
Message-ID: <7ed83b2c-fc96-1d6e-d442-b4261190a9de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693003530; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v++m0JHK5ut12ahV9/U/V2CybGJd/X/eMM503xFtOFg=;
        b=p886CdUMsrNSGecPTiJbomCaZTxW+AaGvtIbWz0fU+fmGpvno/BP9Q8dcQCJ0Q9YKXwmNu
        9gKWNkfxBcB+vTf1vTWwrlrv4zXYrLT6efiZlcRmfp3Abm0l9MZ3SziqaN04iKPGV3IXSD
        ELdUKlO2HHocvB5ijr0pHltdB54IgHg=
Date:   Fri, 25 Aug 2023 15:45:21 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 1/6] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
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
References: <20230825161939.GA16859@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825161939.GA16859@redhat.com>
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



On 8/25/23 9:19 AM, Oleg Nesterov wrote:
> 1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
>     can safely iterate the task->thread_group list. Even if this task exits
>     right after get_pid_task() (or goto retry) and pid_alive() returns 0.
> 
>     Kill the unnecessary pid_alive() check.
> 
> 2. next_thread() simply can't return NULL, kill the bogus "if (!next_task)"
>     check.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

__unhash_process() tries to detach_pid() (pid_alive() may become false)
and ist_del_rcu(&p->thread_group). So yes, next_thread() should be safe
to grab next_task since &task->thread_group is rcu protected. So

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/task_iter.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c4ab9d6cdbe9..4d1125108014 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -75,15 +75,8 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		return NULL;
>   
>   retry:
> -	if (!pid_alive(task)) {
> -		put_task_struct(task);
> -		return NULL;
> -	}
> -
>   	next_task = next_thread(task);
>   	put_task_struct(task);
> -	if (!next_task)
> -		return NULL;
>   
>   	saved_tid = *tid;
>   	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
