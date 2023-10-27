Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6F7D8EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjJ0GvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B0116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698389420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXHKqBoYoz/bbf5vHc18YlN8Sqw/t3HDn4UL/zx+cXA=;
        b=EETcaowNrdo04mjNMRl8GY+Pr8mFJd+mRCfpKz69q6KM1/puu08SVn3RWOjUWav4WRmTMC
        8IKIJJCpw1mnBDdoENl3s2Fa7bqGe9g/I2MMTKqRLPgG0WP8I4wd916hhBqt5fhUwpeFzL
        bAttSaAGbJ8oUbopEAkxmCQusvgOe2c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-YTeM8Vi1OBaypf24cZ3t7A-1; Fri, 27 Oct 2023 02:50:19 -0400
X-MC-Unique: YTeM8Vi1OBaypf24cZ3t7A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52310058f1eso3246083a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698389418; x=1698994218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXHKqBoYoz/bbf5vHc18YlN8Sqw/t3HDn4UL/zx+cXA=;
        b=M/sIA67L9hsVaXLUdUsm1ycinWUYPRxBBBO04MkR+ICj/7mvEBf9G2R7csiV29Hhl0
         T8DwWbGw23+JOxGwfMrVigluIaj+iBdJhO/HMKpw83iFcF4h9S1Kuar7aD9Ft3uJ57L9
         mlc8f9/z4dbBYPd0ObVyhtuEEYP+gsyw0LDcG60owEIuDRQKWx2WNzn5fCJYyS2n74PJ
         ktKjuzHcQ7891zsfvQxuC7kguxkSn9HQCLV7tMNhNPC0KWKukNGBMitk2utgRwUKOyew
         /ItQFG6oyoBRqidMJT40wCSmJkZIJEmRn4r7/X9OVIevgKrAwqeom3IhGU/TgsWZ+UX4
         jcvA==
X-Gm-Message-State: AOJu0YzRbHPICym/IH5CukzgeXavXB0OktMJ9b9IxE4UPgIOxXNoRRHr
        aUnrsqTIPpqkrjXeEXnD+MyG+C3VI1dWB7fJjhV0rXLa1mb99tt/UkekH4Z2tkgKjkU31/zHlns
        EZOGjez0QaotzYIIM9mWEnltt
X-Received: by 2002:a50:9ecb:0:b0:53e:e623:6a47 with SMTP id a69-20020a509ecb000000b0053ee6236a47mr2425189edf.4.1698389418342;
        Thu, 26 Oct 2023 23:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkVPAkDzj+U3xbbVCAqVFQdnAbNKebHtXDjfvyRn2KyzHxudgu4lXhGeW2B7p4FGbfDasXRQ==
X-Received: by 2002:a50:9ecb:0:b0:53e:e623:6a47 with SMTP id a69-20020a509ecb000000b0053ee6236a47mr2425173edf.4.1698389418012;
        Thu, 26 Oct 2023 23:50:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:52a8:fc3f:6e84:948f:e841])
        by smtp.gmail.com with ESMTPSA id s22-20020a508d16000000b005401a4184ddsm746731eds.27.2023.10.26.23.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:50:17 -0700 (PDT)
Date:   Fri, 27 Oct 2023 02:50:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231027024528-mutt-send-email-mst@kernel.org>
References: <20231026114632-mutt-send-email-mst@kernel.org>
 <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:07:13PM +0530, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> functions

function

> rcu_dereference(...) to use when dereferencing a __rcu
> pointer.


... inside rcu read side critical sections.

> This functions

function

> returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointers.

pointer

> 
>

Extra empty line here.
 

Did you test this with lockdep on or did you just build it?
Include info on how the patch was tested pls.

> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>

> ---

Changelog?


>  kernel/fork.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..e78649974669 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	retval = -EAGAIN;
>  	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> -		if (p->real_cred->user != INIT_USER &&
> +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_cleanup_count;
>  	}
> @@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
>  			 * tasklist_lock with adding child to the process tree
>  			 * for propagate_has_child_subreaper optimization.
>  			 */
> -			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
> -							 p->real_parent->signal->is_child_subreaper;
> -			list_add_tail(&p->sibling, &p->real_parent->children);
> +			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
> +							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
> +			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
>  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);

It looks like you are calling rcu_dereference outside of
read side critical section and that does not look right to me.
Test with lockdep on.

> -- 
> 2.39.2

