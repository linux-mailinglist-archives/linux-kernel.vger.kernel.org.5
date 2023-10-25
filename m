Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C757D78F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjJYXwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJYXun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:50:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840121724
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:50:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC170C433C8;
        Wed, 25 Oct 2023 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698277803;
        bh=6OD+Y8pC8d8yXq2muD5OMoXQ/nN+x9qvm8b1lOdybRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SslKzLdRm4iZqyvE7RbWtt9Aksd3C7S8t9WOVMqHiU01qLnnWfuOI1acjomn6Ofqt
         VEyftpRTUL5xrZsrV9ynMdQ1Mw14ccax3sXuh9QwSgUxCb9n6TWhiCYepofTpd15yG
         scVTwOaavC2imdr1NJVbokiFhzuK+aQM2cujCQJs=
Date:   Wed, 25 Oct 2023 16:50:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     brauner@kernel.org, surenb@google.com, mst@redhat.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Fixing warning of directly dereferencing __rcu tagged
Message-Id: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
In-Reply-To: <c4688c53-4206-4d54-aed9-f877697e8073@gmail.com>
References: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
        <20231025153807.8db950f1db82b2c9ecd03758@linux-foundation.org>
        <c4688c53-4206-4d54-aed9-f877697e8073@gmail.com>
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

On Thu, 26 Oct 2023 04:57:42 +0530 Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:

> On 10/26/23 04:08, Andrew Morton wrote:
> >> +++ b/kernel/fork.c
> >> @@ -2369,7 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
> >>   
> >>   	retval = -EAGAIN;
> >>   	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> >> -		if (p->real_cred->user != INIT_USER &&
> >> +		const struct cred *real_cred = rcu_dereference(p->real_cred);
> >> +
> >> +		if (real_cred && real_cred->user != INIT_USER &&
> >>   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> >>   			goto bad_fork_cleanup_count;
> > 
> > The old code assumes that p->read_cred cannot be NULL and the new code
> > does nothing to make it possible that `real_cred' can be NULL?
> > 
> > In other words, I see no reason to add this new check for NULL?
> 
> Thank you for the response!
> 
> I thought it will be better to have check before accessing it, just so 
> we dont have any segmentation fault in future.

That would be adding code which has no effect?

> Also I just noticed there are two more places where direct dereferencing 
> of __rcu pointer is done in this same file. Should I do those changes in 
> this patch ?

I don't see why.  rcu_dereference(p) cannot return NULL if `p' is non-NULL?
