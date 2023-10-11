Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E977C5A29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjJKRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJKRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:22:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670418F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:22:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F7C433C7;
        Wed, 11 Oct 2023 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697044971;
        bh=rBh43S+W6CxycVEAGf2HKGXDn2LUSdZAQRElC4xSzrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ncBKtWIvFTVbc7pX+AXJe8+7MzQKKtpYQ2aCu7U8MxwAdytHJIvjPs5GRwbY+JdDB
         kuT6n0A8Zl03pVtr9KpXkSIMfq6ev0/s9JRuTfIHfrxqS9Q9taYaPVGJNE20Kx0+Wn
         aFpxpDKQney9zD5nC+0+0xyEKywVfQhcjqcQdFwI=
Date:   Wed, 11 Oct 2023 10:22:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     keescook@chromium.org, brauner@kernel.org, jeffxu@google.com,
        frederic@kernel.org, mcgrof@kernel.org, cyphar@cyphar.com,
        rongtao@cestc.cn, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] pid_ns: support pidns switching between sibling
Message-Id: <20231011102231.5464c68ddd9e89deb9aa0ca9@linux-foundation.org>
In-Reply-To: <20231011065446.53034-1-cuiyunhui@bytedance.com>
References: <20231011065446.53034-1-cuiyunhui@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 14:54:46 +0800 Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> In the scenario of container acceleration, when a target pstree
> is cloned from a temp pstree, we hope that the cloned process is
> inherently in the target's pid namespace.
> Examples of what we expected:
> 
> /* switch to target ns first. */
> setns(target_ns, CLONE_NEWPID);
> if(!fork()) {
> /* Child */
> ...
> }
> /* switch back */
> setns(temp_ns, CLONE_NEWPID);
> 
> However, it is limited by the existing implementation, CAP_SYS_ADMIN
> has been checked in pidns_install(), so remove the limitation that only
> by traversing parent can switch pidns.
> 

(cc Eric)

> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -389,7 +389,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
>  {
>  	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct pid_namespace *active = task_active_pid_ns(current);
> -	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
> +	struct pid_namespace *new = to_pid_ns(ns);
>  
>  	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
>  	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
> @@ -406,12 +406,6 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
>  	if (new->level < active->level)
>  		return -EINVAL;
>  
> -	ancestor = new;
> -	while (ancestor->level > active->level)
> -		ancestor = ancestor->parent;
> -	if (ancestor != active)
> -		return -EINVAL;
> -
>  	put_pid_ns(nsproxy->pid_ns_for_children);
>  	nsproxy->pid_ns_for_children = get_pid_ns(new);
>  	return 0;
> -- 
> 2.20.1
