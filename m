Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24817798361
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjIHHqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjIHHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:46:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6E1BD3;
        Fri,  8 Sep 2023 00:45:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ECAC433C9;
        Fri,  8 Sep 2023 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694159158;
        bh=lEqAsTv8CextvyzTlZD9jU1g6NeN7EMYJf7tsAikhYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=thNYDKnge3qRlqSEt2tTK5/J+PJhRsSRbtUFLzG6zDKh4VeVw/ZS/xZV66PH1Phar
         nZPbl7gkAKSP16r06ghhiK92Bo1CVww7RJdosKKpQY1wm0OT6PDJSnnrIpW8mYoWp2
         uEnwjLCHU7oRMO2rLhGzBdiwQiBEY7+J6QgwSy5GCjFHM5aUL+MRzUmyIox9Zv/Nxj
         Arlvpt1XHQVyUHedb8aN2HxbCVnnpxq+kjd/oeFfCWrXwjgHqDNoHvPhz7A9JdU2oc
         s2ElH4T8ET8ruKC/hj8gx/zAYXKxfhk+kuhEsob/e7bLHd6DAqkUM7YnUurw+qTGO9
         JDvlCzKL4goLw==
Date:   Fri, 8 Sep 2023 16:45:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel
 events directory
Message-Id: <20230908164553.aff280695dd77b2b9cab35b8@kernel.org>
In-Reply-To: <20230907024803.250873643@goodmis.org>
References: <20230907024710.866917011@goodmis.org>
        <20230907024803.250873643@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Wed, 06 Sep 2023 22:47:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Currently when rmdir on an instance is done, eventfs_remove_events_dir()
> is called and it does a dput on the dentry and then frees the
> eventfs_inode that represents the events directory.
> 
> But there's no protection against a reader reading the top level events
> directory at the same time and we can get a use after free error. Instead,
> use the dput() associated to the dentry to also free the eventfs_inode
> associated to the events directory, as that will get called when the last
> reference to the directory is released.
> 
> Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/
> 
> Cc: Ajay Kaher <akaher@vmware.com>
> Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from eventfs")
> Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230905183332.628d7cc0@gandalf.local.home
>  - Removed left over "ei" variable (kernel test robot)
> 
>  fs/tracefs/event_inode.c | 17 ++++++++++++-----
>  fs/tracefs/inode.c       |  2 +-
>  fs/tracefs/internal.h    |  5 +++--
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fa1a1679a886..609ccb5b7cfc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -185,17 +185,27 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
>  
>  /**
>   * eventfs_set_ef_status_free - set the ef->status to free
> + * @ti: the tracefs_inode of the dentry
>   * @dentry: dentry who's status to be freed
>   *
>   * eventfs_set_ef_status_free will be called if no more
>   * references remain
>   */
> -void eventfs_set_ef_status_free(struct dentry *dentry)
> +void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  {
>  	struct tracefs_inode *ti_parent;
> +	struct eventfs_inode *ei;
>  	struct eventfs_file *ef;
>  
>  	mutex_lock(&eventfs_mutex);
> +
> +	/* The top level events directory may be freed by this */
> +	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> +		ei = ti->private;
> +		kfree(ei);

Don't we need to clear 'ti->private' here to avoid accessing
(or double free) ti->private somewhare?

> +		goto out;
> +	}
> +
>  	ti_parent = get_tracefs(dentry->d_parent->d_inode);
>  	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
>  		goto out;

Here, I guess this "!(ti_parent->flags & TRACEFS_EVENT_INODE)" means this
inode is TRACEFS_EVENT_TOP_INODE, so this check may not be needed,
is this correct?

Thank you,

> @@ -510,7 +520,7 @@ struct dentry *eventfs_create_events_dir(const char *name,
>  	INIT_LIST_HEAD(&ei->e_top_files);
>  
>  	ti = get_tracefs(inode);
> -	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
>  	ti->private = ei;
>  
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> @@ -806,7 +816,6 @@ void eventfs_remove(struct eventfs_file *ef)
>  void eventfs_remove_events_dir(struct dentry *dentry)
>  {
>  	struct tracefs_inode *ti;
> -	struct eventfs_inode *ei;
>  
>  	if (!dentry || !dentry->d_inode)
>  		return;
> @@ -815,8 +824,6 @@ void eventfs_remove_events_dir(struct dentry *dentry)
>  	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
>  		return;
>  
> -	ei = ti->private;
>  	d_invalidate(dentry);
>  	dput(dentry);
> -	kfree(ei);
>  }
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 3b8dd938b1c8..891653ba9cf3 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -385,7 +385,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
>  
>  	ti = get_tracefs(inode);
>  	if (ti && ti->flags & TRACEFS_EVENT_INODE)
> -		eventfs_set_ef_status_free(dentry);
> +		eventfs_set_ef_status_free(ti, dentry);
>  	iput(inode);
>  }
>  
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 69c2b1d87c46..4f2e49e2197b 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -3,7 +3,8 @@
>  #define _TRACEFS_INTERNAL_H
>  
>  enum {
> -	TRACEFS_EVENT_INODE     = BIT(1),
> +	TRACEFS_EVENT_INODE		= BIT(1),
> +	TRACEFS_EVENT_TOP_INODE		= BIT(2),
>  };
>  
>  struct tracefs_inode {
> @@ -24,6 +25,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
>  struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
>  struct dentry *eventfs_failed_creating(struct dentry *dentry);
>  struct dentry *eventfs_end_creating(struct dentry *dentry);
> -void eventfs_set_ef_status_free(struct dentry *dentry);
> +void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry);
>  
>  #endif /* _TRACEFS_INTERNAL_H */
> -- 
> 2.40.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
