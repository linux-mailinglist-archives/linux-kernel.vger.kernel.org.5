Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098FE7AC9D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjIXNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B6CF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE0C433C7;
        Sun, 24 Sep 2023 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695563453;
        bh=vdCMjIA+d2QX5zaaLzI+lmNeBSEC2rO41zae3sOn+sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lPmiwWFzH9szAr12Oh0Br2I63QKAsLE2GMJE6QhccIiS+Yqn8k2SGIHqjadtryFVF
         mdB1O07lZ+ErgVdjOViWXBWehBPnPhDH5Hj8fLtUSWytNuIWnWxFPVycRAsutchP1J
         oyjMdSTADVgNePPpvR+w/n/FWsvCgTLRVVNhy0qidLtrBUy2z5SrqgX8pd19x7loYw
         eKSrtgi3sK7YCMeUg/oWkLklqHZI5uDraDFCLVosJbH5vyi07bzLMpl5BohvMgOCGy
         Lhs/qQpD0epKc6JRa9y4H1H+RouPYr5d31qTGeZwGXUK7TYKg0tqc8twXlgwjzmr40
         oDBsO6/hJwRaA==
Date:   Sun, 24 Sep 2023 22:50:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH] eventfs: Remember what dentries were created on dir
 open
Message-Id: <20230924225047.a35c3ed15f05a35399747d56@kernel.org>
In-Reply-To: <20230920221537.521e2562@gandalf.local.home>
References: <20230920221537.521e2562@gandalf.local.home>
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

On Wed, 20 Sep 2023 22:15:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Using the following code with libtracefs:
> 
> 	int dfd;
> 
> 	// create the directory events/kprobes/kp1
> 	tracefs_kprobe_raw(NULL, "kp1", "schedule_timeout", "time=$arg1");
> 
> 	// Open the kprobes directory
> 	dfd = tracefs_instance_file_open(NULL, "events/kprobes", O_RDONLY);
> 
> 	// Do a lookup of the kprobes/kp1 directory (by looking at enable)
> 	tracefs_file_exists(NULL, "events/kprobes/kp1/enable");
> 
> 	// Now create a new entry in the kprobes directory
> 	tracefs_kprobe_raw(NULL, "kp2", "schedule_hrtimeout", "expires=$arg1");
> 
> 	// Do another lookup to create the dentries
> 	tracefs_file_exists(NULL, "events/kprobes/kp2/enable"))
> 
> 	// Close the directory
> 	close(dfd);
> 
> What happened above, the first open (dfd) will call
> dcache_dir_open_wrapper() that will create the dentries and up their ref
> counts.
> 
> Now the creation of "kp2" will add another dentry within the kprobes
> directory.
> 
> Upon the close of dfd, eventfs_release() will now do a dput for all the
> entries in kprobes. But this is where the problem lies. The open only
> upped the dentry of kp1 and not kp2. Now the close is decrementing both
> kp1 and kp2, which causes kp2 to get a negative count.
> 
> Doing a "trace-cmd reset" which deletes all the kprobes cause the kernel
> to crash! (due to the messed up accounting of the ref counts).
> 
> To solve this, save all the dentries that are opened in the
> dcache_dir_open_wrapper() into an array, and use this array to know what
> dentries to do a dput on in eventfs_release().
> 
> Since the dcache_dir_open_wrapper() calls dcache_dir_open() which uses the
> file->private_data, we need to also add a wrapper around dcache_readdir()
> that uses the cursor assigned to the file->private_data. This is because
> the dentries need to also be saved in the file->private_data. To do this
> create the structure:
> 
>   struct dentry_list {
> 	void		*cursor;
> 	struct dentry	**dentries;
>   };
> 
> Which will hold both the cursor and the dentries. Some shuffling around is
> needed to make sure that dcache_dir_open() and dcache_readdir() only see
> the cursor.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230919211804.230edf1e@gandalf.local.home/

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
> Reported-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 87 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index b23bb0957bb4..1c5c6a1ff4cc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -30,6 +30,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  					  struct dentry *dentry,
>  					  unsigned int flags);
>  static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
> +static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
>  static int eventfs_release(struct inode *inode, struct file *file);
>  
>  static const struct inode_operations eventfs_root_dir_inode_operations = {
> @@ -39,7 +40,7 @@ static const struct inode_operations eventfs_root_dir_inode_operations = {
>  static const struct file_operations eventfs_file_operations = {
>  	.open		= dcache_dir_open_wrapper,
>  	.read		= generic_read_dir,
> -	.iterate_shared	= dcache_readdir,
> +	.iterate_shared	= dcache_readdir_wrapper,
>  	.llseek		= generic_file_llseek,
>  	.release	= eventfs_release,
>  };
> @@ -356,6 +357,11 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  	return ret;
>  }
>  
> +struct dentry_list {
> +	void			*cursor;
> +	struct dentry		**dentries;
> +};
> +
>  /**
>   * eventfs_release - called to release eventfs file/dir
>   * @inode: inode to be released
> @@ -364,26 +370,25 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  static int eventfs_release(struct inode *inode, struct file *file)
>  {
>  	struct tracefs_inode *ti;
> -	struct eventfs_inode *ei;
> -	struct eventfs_file *ef;
> -	struct dentry *dentry;
> -	int idx;
> +	struct dentry_list *dlist = file->private_data;
> +	void *cursor;
> +	int i;
>  
>  	ti = get_tracefs(inode);
>  	if (!(ti->flags & TRACEFS_EVENT_INODE))
>  		return -EINVAL;
>  
> -	ei = ti->private;
> -	idx = srcu_read_lock(&eventfs_srcu);
> -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> -				 srcu_read_lock_held(&eventfs_srcu)) {
> -		mutex_lock(&eventfs_mutex);
> -		dentry = ef->dentry;
> -		mutex_unlock(&eventfs_mutex);
> -		if (dentry)
> -			dput(dentry);
> +	if (WARN_ON_ONCE(!dlist))
> +		return -EINVAL;
> +
> +	for (i = 0; dlist->dentries[i]; i++) {
> +		dput(dlist->dentries[i]);
>  	}
> -	srcu_read_unlock(&eventfs_srcu, idx);
> +
> +	cursor = dlist->cursor;
> +	kfree(dlist->dentries);
> +	kfree(dlist);
> +	file->private_data = cursor;
>  	return dcache_dir_close(inode, file);
>  }
>  
> @@ -402,22 +407,70 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>  	struct tracefs_inode *ti;
>  	struct eventfs_inode *ei;
>  	struct eventfs_file *ef;
> +	struct dentry_list *dlist;
> +	struct dentry **dentries = NULL;
>  	struct dentry *dentry = file_dentry(file);
> +	struct dentry *d;
>  	struct inode *f_inode = file_inode(file);
> +	int cnt = 0;
>  	int idx;
> +	int ret;
>  
>  	ti = get_tracefs(f_inode);
>  	if (!(ti->flags & TRACEFS_EVENT_INODE))
>  		return -EINVAL;
>  
> +	if (WARN_ON_ONCE(file->private_data))
> +		return -EINVAL;
> +
> +	dlist = kmalloc(sizeof(*dlist), GFP_KERNEL);
> +	if (!dlist)
> +		return -ENOMEM;
> +
>  	ei = ti->private;
>  	idx = srcu_read_lock(&eventfs_srcu);
>  	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		create_dentry(ef, dentry, false);
> +		d = create_dentry(ef, dentry, false);
> +		if (d) {
> +			struct dentry **tmp;
> +
> +			tmp = krealloc(dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
> +			if (!tmp)
> +				break;
> +			tmp[cnt] = d;
> +			tmp[cnt + 1] = NULL;
> +			cnt++;
> +			dentries = tmp;
> +		}
>  	}
>  	srcu_read_unlock(&eventfs_srcu, idx);
> -	return dcache_dir_open(inode, file);
> +	ret = dcache_dir_open(inode, file);
> +
> +	/*
> +	 * dcache_dir_open() sets file->private_data to a dentry cursor.
> +	 * Need to save that but also save all the dentries that were
> +	 * opened by this function.
> +	 */
> +	dlist->cursor = file->private_data;
> +	dlist->dentries = dentries;
> +	file->private_data = dlist;
> +	return ret;
> +}
> +
> +/*
> + * This just sets the file->private_data back to the cursor and back.
> + */
> +static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
> +{
> +	struct dentry_list *dlist = file->private_data;
> +	int ret;
> +
> +	file->private_data = dlist->cursor;
> +	ret = dcache_readdir_wrapper;
> +	dlist->cursor = file->private_data;
> +	file->private_data = dlist;
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
