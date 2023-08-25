Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D27887B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbjHYMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbjHYMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C41BC9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692967328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U81j4kbmLIfbag5jx+rwwJ6qC54Rpz5edh2L4xFg6cA=;
        b=Or4XCHC60nou8lA92qe0DZO9l5QhNl6C8lh4tLiQZtgXPCrHxDR5HU9OB4W0yv1qbMYvaf
        +0kSbcHE+o9PFh+UVldZlA8DuxcTFw/Bstcdwcv8+X3cPW+fgqqKEnxb3UUCCzA713iGg7
        gwW9dl/7a0/ae+ElgESdxJhMy3pg070=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-MGReuxB9MQyyEWAJnwlT3w-1; Fri, 25 Aug 2023 08:42:05 -0400
X-MC-Unique: MGReuxB9MQyyEWAJnwlT3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95A22808E61;
        Fri, 25 Aug 2023 12:42:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 025B1492C13;
        Fri, 25 Aug 2023 12:42:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 14:41:18 +0200 (CEST)
Date:   Fri, 25 Aug 2023 14:41:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
Message-ID: <20230825124115.GA13849@redhat.com>
References: <20230821150909.GA2431@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821150909.GA2431@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it seems that you are not going to take these preparatory
cleanups ;)

I'll resend along with the s/next_thread/__next_thread/ change.
I was going to do the last change later, but this recent discussion
https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/
makes me think we should do this right now.

On 08/21, Oleg Nesterov wrote:
>
> 1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
>    can safely iterate the task->thread_group list. Even if this task exits
>    right after get_pid_task() (or goto retry) and pid_alive() returns 0.
>
>    Kill the unnecessary pid_alive() check.
>
> 2. next_thread() simply can't return NULL, kill the bogus "if (!next_task)"
>    check.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/bpf/task_iter.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c4ab9d6cdbe9..4d1125108014 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -75,15 +75,8 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>  		return NULL;
>
>  retry:
> -	if (!pid_alive(task)) {
> -		put_task_struct(task);
> -		return NULL;
> -	}
> -
>  	next_task = next_thread(task);
>  	put_task_struct(task);
> -	if (!next_task)
> -		return NULL;
>
>  	saved_tid = *tid;
>  	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
> --
> 2.25.1.362.g51ebf55
>
>

