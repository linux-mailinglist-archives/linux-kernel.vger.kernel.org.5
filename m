Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026F7D7815
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJYWiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046618F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:38:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1650DC433C8;
        Wed, 25 Oct 2023 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698273489;
        bh=8ZaHognKBbv1lYU2FsHlrUv1uDTrt8DMUrzopQve/O4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApOY5nA4miFuLqeB+YF2sa6yf/8IKMkCxFPnNxhh6+lkUMoy4dXMMeLTjuWHgzRsv
         nFNlJhztM+XPFSHjUj+M6bBeWCs9uaD9GfqtjfF6EW1GYCxRYsMm1QsCWHDEkCuFr9
         WGRadwkV+tpV0oQURFB8OA4XT6I3A0rdrGItdT0g=
Date:   Wed, 25 Oct 2023 15:38:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     brauner@kernel.org, surenb@google.com, mst@redhat.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Fixing warning of directly dereferencing  __rcu tagged
Message-Id: <20231025153807.8db950f1db82b2c9ecd03758@linux-foundation.org>
In-Reply-To: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
References: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 03:58:11 +0530 Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:

> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should 
> always be avoided according to the docs. There is a rcu helper 
> functions rcu_dereference(...) to use when dereferencing a __rcu 
> pointer. This functions returns the non __rcu tagged pointer. 

Seems sensible.

> Like normal pointer there should be a check for null case when 
> further dereferencing the returned dereferenced __rcu pointer.

Why is this?

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2369,7 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	retval = -EAGAIN;
>  	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> -		if (p->real_cred->user != INIT_USER &&
> +		const struct cred *real_cred = rcu_dereference(p->real_cred);
> +
> +		if (real_cred && real_cred->user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_cleanup_count;

The old code assumes that p->read_cred cannot be NULL and the new code
does nothing to make it possible that `real_cred' can be NULL?

In other words, I see no reason to add this new check for NULL?
