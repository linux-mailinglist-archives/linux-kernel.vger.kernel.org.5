Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B997891F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjHYWtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjHYWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:49:44 -0400
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C9268F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:49:42 -0700 (PDT)
Message-ID: <344aad78-c664-728c-44f1-e00373c8579c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693003780; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyM5CjZdyvP5rbAa1eGoL16wDZDIwfu/Pz/4Vy+B1PI=;
        b=jjI2aEqOzonYps2WFePyrM2cbDxW6eEJ8rQWsedwz5vISS65T3qNCL5Ykplu562yRUsZ06
        b3QiS6m94CigftlW2tRerzt0jL15zxJIs6FGD+SsBLXqDUHEg+fpOxlPGAOm5o7XEJLvKu
        KlV07GP1BzbUGtk8N0Lv/Laf90T2oWI=
Date:   Fri, 25 Aug 2023 15:49:35 -0700
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
References: <20230825161947.GA16871@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825161947.GA16871@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 9:19 AM, Oleg Nesterov wrote:
> Unless I am notally confused it is wrong. We are going to return or
> skip next_task so we need to check next_task-files, not task->files.

Thanks for capturing this. This is indeed an oversight.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/bpf/task_iter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 1589ec3faded..2264870ae3fc 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   
>   	common->pid_visiting = *tid;
>   
> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>   		task = next_task;
>   		goto retry;
>   	}
