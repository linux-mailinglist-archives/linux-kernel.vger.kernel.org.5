Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A4788D92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjHYRGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbjHYRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E791FF5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692983100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qKjBMHo1biiz/911STwdoJBuoMd8e2rBpwqZ/FJnf4=;
        b=dQ83ny07etZ5yf3h0fIY7E5y/zPy0P0Y3844p/ZiaDUrW+uwMw7dnHecwIuu8XKMfaa0M9
        n/TAWACumdCLXJJcg8yxsxN06oyVuXFRr3I2VE4RsXV0oEM3P5lJB7dI4ydd1w/VbdWPfc
        kurtX96BbyMGOxZMxtxtIPTysfMS4gk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-45FaRmCbMZGoY5f6GRu2PA-1; Fri, 25 Aug 2023 13:04:56 -0400
X-MC-Unique: 45FaRmCbMZGoY5f6GRu2PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6FA928088AE;
        Fri, 25 Aug 2023 17:04:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 752C56B2B2;
        Fri, 25 Aug 2023 17:04:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 19:04:09 +0200 (CEST)
Date:   Fri, 25 Aug 2023 19:04:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230825170406.GA16800@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825161947.GA16871@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention in the changelog...

In any case this doesn't look right. ->group_leader can exit before other
threads, call exit_files(), and in this case task_group_seq_get_next() will
check task->files == NULL.

On 08/25, Oleg Nesterov wrote:
>
> Unless I am notally confused it is wrong. We are going to return or
> skip next_task so we need to check next_task-files, not task->files.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/bpf/task_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 1589ec3faded..2264870ae3fc 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>
>  	common->pid_visiting = *tid;
>
> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>  		task = next_task;
>  		goto retry;
>  	}
> --
> 2.25.1.362.g51ebf55

