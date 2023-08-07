Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7C771DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHGKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHGKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC20F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B24ED61752
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A08CC433C8;
        Mon,  7 Aug 2023 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691402842;
        bh=Uv5zC7CcGAuZ45DEWXjoO01qZYZ8oJelyTSANIWsPGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxDfW69l+ppyEz5Q8liy4iru3HZTR1Wgj03dX4LToffsmt90W9d5oheSaYQJoS08s
         FLke3ovgXABVu8JPB296r50us980IqTPo8FT2qXX7DkMO6YKHWYs8O8/nbjNkBD8pK
         SyLevmntbQTbrQ0yuK23KMnHYJqLemQ2NRTWHh+xEDMwLmh0yqLH9YJ2vZK4NqGJcV
         3SlknAU44CgTS05wHzH56kWSSpyvyEL15uZ82BdYEJ1A/oTYnZkCPhVQLD21w/Pexq
         k1e+HDxflzsdbADhyrng9ZRpwrcn50lw727VuZCmQgOvfGuGoy1XUAnwQbbM2zfZi5
         KHtATPXBSebPQ==
Date:   Mon, 7 Aug 2023 12:07:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
References: <20230807085203.819772-1-david@readahead.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807085203.819772-1-david@readahead.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Oleg,

A question for you below.

On Mon, Aug 07, 2023 at 10:52:03AM +0200, David Rheinsberg wrote:
> A pidfd can currently only be created for tasks that are thread-group
> leaders and not reaped. This patch changes the pidfd-core to allow for
> pidfds on reapead thread-group leaders as well.
> 
> A pidfd can outlive the task it refers to, and thus user-space must
> already be prepared that the task underlying a pidfd is gone at the time
> they get their hands on the pidfd. For instance, resolving the pidfd to
> a PID via the fdinfo must be prepared to read `-1`.
> 
> Despite user-space knowing that a pidfd might be stale, several kernel
> APIs currently add another layer that checks for this. In particular,
> SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
> but returns a stale pidfd if the task is reaped immediately after the
> respective alive-check.
> 
> This has the unfortunate effect that user-space now has two ways to
> check for the exact same scenario: A syscall might return
> EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
> particular reason to distinguish both cases. This also propagates
> through user-space APIs, which pass on pidfds. They must be prepared to
> pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
> stale pidfd from the kernel.
> 
> This patch changes the core pidfd helpers to allow creation of pidfds
> even if the PID is no longer linked to any task. This only affects one
> of the three pidfd users that currently exist:
> 
>  1) fanotify already tests for a linked TGID-task manually before
>     creating the PIDFD, thus it is not directly affected by this change.
>     However, note that the current fanotify code fails with an error if
>     the target process is reaped exactly between the TGID-check in
>     fanotify and the test in pidfd_prepare(). With this patch, this
>     will no longer be the case.
> 
>  2) pidfd_open(2) calls find_get_pid() before creating the pidfd, thus
>     it is also not directly affected by this change.
>     Again, similar to fanotify, there is a race between the
>     find_get_pid() call and pidfd_prepare(), which currently causes
>     pidfd_open(2) to return EINVAL rather than ESRCH if the process is
>     reaped just between those two checks. With this patch, this will no
>     longer be the case.
> 
>  3) SO_PEERPIDFD will be affected by this change and from now on return
>     stale pidfds rather than EINVAL if the respective peer task is
>     reaped already.
> 
> Given that users of SO_PEERPIDFD must already deal with stale pidfds,
> this change hopefully simplifies the API of SO_PEERPIDFD, and all
> dependent user-space APIs (e.g., GetConnectionCredentials() on D-Bus
> driver APIs). Also note that SO_PEERPIDFD is still pending to be
> released with linux-6.5.
> 
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
>  kernel/fork.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b18..4dde19a8c264 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2161,7 +2161,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   * Allocate a new file that stashes @pid and reserve a new pidfd number in the
>   * caller's file descriptor table. The pidfd is reserved but not installed yet.
>   *
> - * The helper verifies that @pid is used as a thread group leader.
> + * The helper verifies that @pid is/was used as a thread group leader.
>   *
>   * If this function returns successfully the caller is responsible to either
>   * call fd_install() passing the returned pidfd and pidfd file as arguments in
> @@ -2180,7 +2180,14 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   */
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>  {
> -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +	if (!pid)
> +		return -EINVAL;
> +
> +	/*
> +	 * Non thread-group leaders cannot have pidfds, but we allow them for
> +	 * reaped thread-group leaders.
> +	 */
> +	if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTYPE_TGID))
>  		return -EINVAL;

TL;DR userspace wants to be able to get a pidfd to an already reaped
thread-group leader. I don't see any issues with this.

But I'm not entirely clear how to make it safe so that we can
distinguish between @pid not being used as a thread-group leader and
PIDTYPE_TGID having already been detached from @pid. IOW, we need a
snapshot of PIDTYPE_PID and PIDTYPE_TGID so that we can compare the
returned tasks (Or another way to achieve a similar result.).

Any thoughts?
