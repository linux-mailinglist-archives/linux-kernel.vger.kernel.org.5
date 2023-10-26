Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEA7D835B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJZNPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJZNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A4196
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698326071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ITxJfATsg1xPCVF9l8R+7SuGMBL1Ri8aZSO801+6WD8=;
        b=KgAPhmWCvdmoqFOGJ3gvTXI/BJmPa45Gq4Pi0hyS0m+9ZAiTfsSi9jVvZuT6t5+kZs3Ry0
        cS0bdhWlyLMFsU4vHJzo3kTEBoS8qtiLJltL/nmDYojfPbSZYnB6N1qDZDebp9IKl10UjN
        3PXUTViqZDNAy+0qKTBddQk3VJBerv0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-FCMroX2NNjS2WDGfLJdQDA-1; Thu, 26 Oct 2023 09:14:29 -0400
X-MC-Unique: FCMroX2NNjS2WDGfLJdQDA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c7558b89ccso60399766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326068; x=1698930868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITxJfATsg1xPCVF9l8R+7SuGMBL1Ri8aZSO801+6WD8=;
        b=e6cSPKqym+FTgB9PANpH2f1sdAlJHUDjbIggHFTu2xRMMaZnvLOBVVD6DPS9Rpj/Az
         armL7uo8c9yftIjtcG8Jxf7bNALKfFAVMpiu9U/umXmRc08JtceMnqLLS3yAWBPWapnS
         OmE9a8f6o6SS0vwQFbqlzQJGH084dZfW08n6gyNRSgvHgt8xrHme+Wtx4zJVvw83wfgN
         rrS+zHGUi9XJ7RKZ90qGH95aaHHyeIU3PyDDfPrSgGgp+zV/fm06jP7gPDDSGrfPnEFP
         aPPj8HnHzls7LE+pFw0qbBbnCLkE/Y5qys5M71DpgUuCNpXnEOYcW5cOoLWLL5R1SyZI
         S2nQ==
X-Gm-Message-State: AOJu0Ywd31m9apHPeI4rZjOBmtAmEGrzDqKxiJZzHVdBEUnNnhJFTAcQ
        LnZoGUCtnRh4GLOo0Gd6FSnq/h6kiwiRaeC2tAc8xlp41rkXvHlmHsIFdWgwpEplZtfPhY0Extl
        Dn7GinI+TYWig9QfbzdzcrcdX
X-Received: by 2002:a17:906:9c83:b0:9a1:bd33:4389 with SMTP id fj3-20020a1709069c8300b009a1bd334389mr13653856ejc.74.1698326068175;
        Thu, 26 Oct 2023 06:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGetGp6xoa7QcxxN+Jjc+NqG3O3baXarhaB833PkwjNbYRUCF6sCIKtsgu4V0Uon7NGSJ9/og==
X-Received: by 2002:a17:906:9c83:b0:9a1:bd33:4389 with SMTP id fj3-20020a1709069c8300b009a1bd334389mr13653833ejc.74.1698326067742;
        Thu, 26 Oct 2023 06:14:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae587ce128sm11636345eje.216.2023.10.26.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:14:27 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:14:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231026091222-mutt-send-email-mst@kernel.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> functions rcu_dereference(...) to use when dereferencing a __rcu
> pointer. This functions returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointers.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>

Well yes but these need to be called under rcu_read_lock.
Who does it here?
If no one then maybe you found an actual bug and we need to
fix it not paper over it.


> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..802b7bbe3d92 100644
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
> @@ -2692,7 +2692,7 @@ __latent_entropy struct task_struct *copy_process(
>  			 */
>  			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
>  							 p->real_parent->signal->is_child_subreaper;
> -			list_add_tail(&p->sibling, &p->real_parent->children);
> +			list_add_tail(&p->sibling, &(rcu_dereference(p->real_parent)->children));
>  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);
> -- 
> 2.39.2

