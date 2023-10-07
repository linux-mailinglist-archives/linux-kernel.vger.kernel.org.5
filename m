Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7357BC6E4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbjJGKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJGKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30ACF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBBEC433C7;
        Sat,  7 Oct 2023 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696675491;
        bh=n+l6H67FyrFoT6zCCz+wXsQRTxrbHcq5kgMdtUC6y/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+7WaScq3Qo5yHZIuP3GDWysfDzft4xspCJ8L0Rd+To49F9TYBGqbvlTJbjY9gKJ6
         utolpf4YekZiplmWqIoTwgNnJEbQMTlrcDiUFCLAjntbJSGi539SsYPzLpshnL2BBr
         +RJ2xEhh4YhNw2khPesbA9Ski3X5XBsQPNPZiLGzO2G3YkLTrOZYa7tefJ69uSS+de
         hdpUX+v1u92nbP902NoRegWk4yoc5Z/yBLFEQCrwWk3ROtW45KgjXI96KaXzayPvEX
         rDPQR9567ikmk3SAYlW86V8ibPryMUkxVVE5tkl4NBs0EzkDAQlroP6RAPi8/dmuAX
         p59XWuY6Bp1lQ==
Date:   Sat, 7 Oct 2023 19:44:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH v4] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-Id: <20231007194445.444c1447fc694cefd31bfecd@kernel.org>
In-Reply-To: <20231003184059.4924468e@gandalf.local.home>
References: <20231003184059.4924468e@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 18:40:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of having a descriptor for every file represented in the eventfs
> directory, only have the directory itself represented. Change the API to
> send in a list of entries that represent all the files in the directory
> (but not other directories). The entry list contains a name and a callback
> function that will be used to create the files when they are accessed.
> 
> struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
> 						const struct eventfs_entry *entries,
> 						int size, void *data);
> 
> is used for the top level eventfs directory, and returns an eventfs_inode
> that will be used by:
> 
> struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
> 					 const struct eventfs_entry *entries,
> 					 int size, void *data);
> 
> where both of the above take an array of struct eventfs_entry entries for
> every file that is in the directory.
> 
> The entries are defined by:
> 
> typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
> 				const struct file_operations **fops);
> 
> struct eventfs_entry {
> 	const char			*name;
> 	eventfs_callback		callback;
> };
> 
> Where the name is the name of the file and the callback gets called when
> the file is being created. The callback passes in the name (in case the
> same callback is used for multiple files), a pointer to the mode, data and
> fops. The data will be pointing to the data that was passed in
> eventfs_create_dir() or eventfs_create_events_dir() but may be overridden
> to point to something else, as it will be used to point to the
> inode->i_private that is created. The information passed back from the
> callback is used to create the dentry/inode.
> 
> If the callback fills the data and the file should be created, it must
> return a positive number. On zero or negative, the file is ignored.
> 
> This logic may also be used as a prototype to convert entire pseudo file
> systems into just-in-time allocation.
> 
> The "show_events_dentry" file has been updated to show the directories,
> and any files they have.
> 
> With just the eventfs_file allocations:
> 
>  Before after deltas for meminfo (in kB):
> 
>    MemFree:		-14360
>    MemAvailable:	-14260
>    Buffers:		40
>    Cached:		24
>    Active:		44
>    Inactive:		48
>    Inactive(anon):	28
>    Active(file):	44
>    Inactive(file):	20
>    Dirty:		-4
>    AnonPages:		28
>    Mapped:		4
>    KReclaimable:	132
>    Slab:		1604
>    SReclaimable:	132
>    SUnreclaim:		1472
>    Committed_AS:	12
> 
>  Before after deltas for slabinfo:
> 
>    <slab>:		<objects>	[ * <size> = <total>]
> 
>    ext4_inode_cache	27		[* 1184 = 31968 ]
>    extent_status	102		[*   40 = 4080 ]
>    tracefs_inode_cache	144		[*  656 = 94464 ]
>    buffer_head		39		[*  104 = 4056 ]
>    shmem_inode_cache	49		[*  800 = 39200 ]
>    filp			-53		[*  256 = -13568 ]
>    dentry		251		[*  192 = 48192 ]
>    lsm_file_cache	277		[*   32 = 8864 ]
>    vm_area_struct	-14		[*  184 = -2576 ]
>    trace_event_file	1748		[*   88 = 153824 ]
>    kmalloc-1k		35		[* 1024 = 35840 ]
>    kmalloc-256		49		[*  256 = 12544 ]
>    kmalloc-192		-28		[*  192 = -5376 ]
>    kmalloc-128		-30		[*  128 = -3840 ]
>    kmalloc-96		10581		[*   96 = 1015776 ]
>    kmalloc-64		3056		[*   64 = 195584 ]
>    kmalloc-32		1291		[*   32 = 41312 ]
>    kmalloc-16		2310		[*   16 = 36960 ]
>    kmalloc-8		9216		[*    8 = 73728 ]
> 
>  Free memory dropped by 14,360 kB
>  Available memory dropped by 14,260 kB
>  Total slab additions in size: 1,771,032 bytes
> 
> With this change:
> 
>  Before after deltas for meminfo (in kB):
> 
>    MemFree:		-12084
>    MemAvailable:	-11976
>    Buffers:		32
>    Cached:		32
>    Active:		72
>    Inactive:		168
>    Inactive(anon):	176
>    Active(file):	72
>    Inactive(file):	-8
>    Dirty:		24
>    AnonPages:		196
>    Mapped:		8
>    KReclaimable:	148
>    Slab:		836
>    SReclaimable:	148
>    SUnreclaim:		688
>    Committed_AS:	324
> 
>  Before after deltas for slabinfo:
> 
>    <slab>:		<objects>	[ * <size> = <total>]
> 
>    tracefs_inode_cache	144		[* 656 = 94464 ]
>    shmem_inode_cache	-23		[* 800 = -18400 ]
>    filp			-92		[* 256 = -23552 ]
>    dentry		179		[* 192 = 34368 ]
>    lsm_file_cache	-3		[* 32 = -96 ]
>    vm_area_struct	-13		[* 184 = -2392 ]
>    trace_event_file	1748		[* 88 = 153824 ]
>    kmalloc-1k		-49		[* 1024 = -50176 ]
>    kmalloc-256		-27		[* 256 = -6912 ]
>    kmalloc-128		1864		[* 128 = 238592 ]
>    kmalloc-64		4685		[* 64 = 299840 ]
>    kmalloc-32		-72		[* 32 = -2304 ]
>    kmalloc-16		256		[* 16 = 4096 ]
>    total = 721352
> 
>  Free memory dropped by 12,084 kB
>  Available memory dropped by 11,976 kB
>  Total slab additions in size:  721,352 bytes
> 
> That's over 2 MB in savings per instance for free and available memory,
> and over 1 MB in savings per instance of slab memory.
> 

This basically looks good to me. I have some comments on it, but mostly just
nitpicks.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

[...]
> @@ -118,6 +72,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	if (WARN_ON_ONCE(!S_ISREG(mode)))
>  		return NULL;
>  
> +	WARN_ON_ONCE(!parent);

Nit: This looks a wrong case and should not create a file under root directory.
     So it should return NULL. (but it shouldn't happen.)

>  	dentry = eventfs_start_creating(name, parent);
>  
>  	if (IS_ERR(dentry))

[...]

> @@ -233,68 +180,162 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
>  		goto out;
>  
> -	ef = dentry->d_fsdata;
> -	if (!ef)
> +	ei = dentry->d_fsdata;
> +	if (!ei)
>  		goto out;
>  
>  	/*
> -	 * If ef was freed, then the LSB bit is set for d_fsdata.
> +	 * If ei was freed, then the LSB bit is set for d_fsdata.
>  	 * But this should not happen, as it should still have a
>  	 * ref count that prevents it. Warn in case it does.
>  	 */
> -	if (WARN_ON_ONCE((unsigned long)ef & 1))
> +	if (WARN_ON_ONCE((unsigned long)ei & 1))
>  		goto out;
>  
> +	/* This could belong to one of the files of the ei */
> +	if (ei->dentry != dentry) {
> +		for (i = 0; i < ei->nr_entries; i++) {
> +			if (ei->d_children[i] == dentry)
> +				break;
> +		}
> +		if (WARN_ON_ONCE(i == ei->nr_entries))
> +			goto out;
> +		ei->d_children[i] = NULL;
> +	} else {
> +		ei->dentry = NULL;
> +	}
> +
>  	dentry->d_fsdata = NULL;
> -	ef->dentry = NULL;
> -out:
> + out:
>  	mutex_unlock(&eventfs_mutex);
>  }
>  
> +/**
> + * create_file_dentry - create a dentry for a file of an eventfs_inode
> + * @ei: the eventfs_inode that the file will be created under
> + * @e_dentry: a pointer to the d_children[] of the @ei
> + * @parent: The parent dentry of the created file.
> + * @name: The name of the file to create
> + * @mode: The mode of the file.
> + * @data: The data to use to set the inode of the file with on open()
> + * @fops: The fops of the file to be created.
> + * @lookup: If called by the lookup routine, in which case, dput() the created dentry.
> + *
> + * Create a dentry for a file of an eventfs_inode @ei and place it into the
> + * address located at @e_dentry. If the @e_dentry already has a dentry, then
> + * just do a dget() on it and return. Otherwise create the dentry and attach it.
> + */
> +static struct dentry *
> +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
> +		   struct dentry *parent, const char *name, umode_t mode, void *data,
> +		   const struct file_operations *fops, bool lookup)
> +{
> +	struct dentry *dentry;
> +	bool invalidate = false;
> +
> +	mutex_lock(&eventfs_mutex);
> +	/* If the e_dentry already has a dentry, use it */
> +	if (*e_dentry) {
> +		/* lookup does not need to up the ref count */
> +		if (!lookup)
> +			dget(*e_dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return *e_dentry;
> +	}
> +	mutex_unlock(&eventfs_mutex);
> +
> +	/* The lookup already has the parent->d_inode locked */
> +	if (!lookup)
> +		inode_lock(parent->d_inode);
> +
> +	dentry = create_file(name, mode, parent, data, fops);
> +
> +	if (!lookup)
> +		inode_unlock(parent->d_inode);
> +
> +	mutex_lock(&eventfs_mutex);
> +
> +	if (IS_ERR_OR_NULL(dentry)) {
> +		/*
> +		 * When the mutex was released, something else could have
> +		 * created the dentry for this e_dentry. In which case
> +		 * use that one.
> +		 *
> +		 * Note, with the mutex held, the e_dentry cannot have content
> +		 * and the ei->is_freed be true at the same time.
> +		 */
> +		WARN_ON_ONCE(ei->is_freed);
> +		dentry = *e_dentry;
> +		/* The lookup does not need to up the dentry refcount */
> +		if (dentry && !lookup)
> +			dget(dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return dentry;
> +	}
> +
> +	if (!*e_dentry && !ei->is_freed) {
> +		*e_dentry = dentry;
> +		dentry->d_fsdata = ei;

Nit: If we use LSB for existing flag, this should be checked. e.g. WARN_ON_ONCE(ei & 1).


> +	} else {
> +		/*
> +		 * Should never happen unless we get here due to being freed.
> +		 * Otherwise it means two dentries exist with the same name.
> +		 */
> +		WARN_ON_ONCE(!ei->is_freed);
> +		invalidate = true;
> +	}
> +	mutex_unlock(&eventfs_mutex);
> +
> +	if (invalidate)
> +		d_invalidate(dentry);
> +
> +	if (lookup || invalidate)
> +		dput(dentry);
> +
> +	return invalidate ? NULL : dentry;
> +}
> +
>  /**
>   * eventfs_post_create_dir - post create dir routine
> - * @ef: eventfs_file of recently created dir
> + * @ei: eventfs_inode of recently created dir
>   *
>   * Map the meta-data of files within an eventfs dir to their parent dentry
>   */
> -static void eventfs_post_create_dir(struct eventfs_file *ef)
> +static void eventfs_post_create_dir(struct eventfs_inode *ei)
>  {
> -	struct eventfs_file *ef_child;
> +	struct eventfs_inode *ei_child;
>  	struct tracefs_inode *ti;
>  
>  	/* srcu lock already held */
>  	/* fill parent-child relation */
> -	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
> +	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		ef_child->d_parent = ef->dentry;
> +		ei_child->d_parent = ei->dentry;
>  	}
>  
> -	ti = get_tracefs(ef->dentry->d_inode);
> -	ti->private = ef->ei;
> +	ti = get_tracefs(ei->dentry->d_inode);
> +	ti->private = ei;
>  }
>  
>  /**
> - * create_dentry - helper function to create dentry
> - * @ef: eventfs_file of file or directory to create
> - * @parent: parent dentry
> - * @lookup: true if called from lookup routine
> + * create_dir_dentry - Create a directory dentry for the eventfs_inode
> + * @ei: The eventfs_inode to create the directory for
> + * @parent: The dentry of the parent of this directory
> + * @lookup: True if this is called by the lookup code
>   *
> - * Used to create a dentry for file/dir, executes post dentry creation routine
> + * This creates and attaches a directory dentry to the eventfs_inode @ei.
>   */
>  static struct dentry *
> -create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> +create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
>  {
>  	bool invalidate = false;
> -	struct dentry *dentry;
> +	struct dentry *dentry = NULL;
>  
>  	mutex_lock(&eventfs_mutex);
> -	if (ef->is_freed) {
> -		mutex_unlock(&eventfs_mutex);
> -		return NULL;
> -	}
> -	if (ef->dentry) {
> -		dentry = ef->dentry;
> -		/* On dir open, up the ref count */
> +	if (ei->dentry) {
> +		/* If the dentry already has a dentry, use it */
> +		dentry = ei->dentry;
> +		/* lookup does not need to up the ref count */
>  		if (!lookup)
>  			dget(dentry);
>  		mutex_unlock(&eventfs_mutex);
> @@ -302,42 +343,44 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
>  	}
>  	mutex_unlock(&eventfs_mutex);
>  
> +	/* The lookup already has the parent->d_inode locked */
>  	if (!lookup)
>  		inode_lock(parent->d_inode);
>  
> -	if (ef->ei)
> -		dentry = create_dir(ef->name, parent, ef->data);
> -	else
> -		dentry = create_file(ef->name, ef->mode, parent,
> -				     ef->data, ef->fop);
> +	dentry = create_dir(ei->name, parent);
>  
>  	if (!lookup)
>  		inode_unlock(parent->d_inode);
>  
>  	mutex_lock(&eventfs_mutex);
> -	if (IS_ERR_OR_NULL(dentry)) {
> -		/* If the ef was already updated get it */
> -		dentry = ef->dentry;
> +
> +	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
> +		/*
> +		 * When the mutex was released, something else could have
> +		 * created the dentry for this e_dentry. In which case
> +		 * use that one.
> +		 *
> +		 * Note, with the mutex held, the e_dentry cannot have content
> +		 * and the ei->is_freed be true at the same time.
> +		 */
> +		dentry = ei->dentry;
>  		if (dentry && !lookup)
>  			dget(dentry);
>  		mutex_unlock(&eventfs_mutex);
>  		return dentry;
>  	}
>  
> -	if (!ef->dentry && !ef->is_freed) {
> -		ef->dentry = dentry;
> -		if (ef->ei)
> -			eventfs_post_create_dir(ef);
> -		dentry->d_fsdata = ef;
> +	if (!ei->dentry && !ei->is_freed) {
> +		ei->dentry = dentry;
> +		eventfs_post_create_dir(ei);
> +		dentry->d_fsdata = ei;

Ditto.

>  	} else {
> -		/* A race here, should try again (unless freed) */
> -		invalidate = true;
> -
>  		/*
>  		 * Should never happen unless we get here due to being freed.
>  		 * Otherwise it means two dentries exist with the same name.
>  		 */
> -		WARN_ON_ONCE(!ef->is_freed);
> +		WARN_ON_ONCE(!ei->is_freed);
> +		invalidate = true;
>  	}
>  	mutex_unlock(&eventfs_mutex);
>  	if (invalidate)
> @@ -349,50 +392,82 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
>  	return invalidate ? NULL : dentry;
>  }
>  
> -static bool match_event_file(struct eventfs_file *ef, const char *name)
> -{
> -	bool ret;
> -
> -	mutex_lock(&eventfs_mutex);
> -	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
> -	mutex_unlock(&eventfs_mutex);
> -
> -	return ret;
> -}
> -
>  /**
>   * eventfs_root_lookup - lookup routine to create file/dir
>   * @dir: in which a lookup is being done
>   * @dentry: file/dir dentry
> - * @flags: to pass as flags parameter to simple lookup
> + * @flags: Just passed to simple_lookup()
>   *
> - * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
> - * list of meta data to find the information needed to create the file/dir.
> + * Used to create dynamic file/dir with-in @dir, search with-in @ei
> + * list, if @dentry found go ahead and create the file/dir
>   */
> +
>  static struct dentry *eventfs_root_lookup(struct inode *dir,
>  					  struct dentry *dentry,
>  					  unsigned int flags)
>  {
> +	const struct file_operations *fops;
> +	const struct eventfs_entry *entry;
> +	struct eventfs_inode *ei_child;
>  	struct tracefs_inode *ti;
>  	struct eventfs_inode *ei;
> -	struct eventfs_file *ef;
>  	struct dentry *ret = NULL;
> +	const char *name = dentry->d_name.name;
> +	bool created = false;
> +	umode_t mode;
> +	void *data;
>  	int idx;
> +	int i;
> +	int r;
>  
>  	ti = get_tracefs(dir);
>  	if (!(ti->flags & TRACEFS_EVENT_INODE))
>  		return NULL;
>  
> -	ei = ti->private;
> +	/* Grab srcu to prevent the ei from going away */
>  	idx = srcu_read_lock(&eventfs_srcu);
> -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> +
> +	/*
> +	 * Grab the eventfs_mutex to consistent value from ti->private.
> +	 * This s
> +	 */
> +	mutex_lock(&eventfs_mutex);
> +	ei = READ_ONCE(ti->private);
> +	mutex_unlock(&eventfs_mutex);
> +
> +	if (!ei)
> +		goto out;
> +
> +	data = ei->data;
> +
> +	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		if (!match_event_file(ef, dentry->d_name.name))
> +		if (strcmp(ei_child->name, name) != 0)
>  			continue;
>  		ret = simple_lookup(dir, dentry, flags);

Don't we check this return value?

> -		create_dentry(ef, ef->d_parent, true);
> +		create_dir_dentry(ei_child, ei->dentry, true);
> +		created = true;
>  		break;
>  	}
> +
> +	if (created)
> +		goto out;
> +
> +	for (i = 0; i < ei->nr_entries; i++) {
> +		entry = &ei->entries[i];
> +		if (strcmp(name, entry->name) == 0) {
> +			void *cdata = data;
> +			r = entry->callback(name, &mode, &cdata, &fops);
> +			if (r <= 0)
> +				continue;
> +			ret = simple_lookup(dir, dentry, flags);

Ditto.

> +			create_file_dentry(ei, &ei->d_children[i],
> +					   ei->dentry, name, mode, cdata,
> +					   fops, true);
> +			break;
> +		}
> +	}
> + out:
>  	srcu_read_unlock(&eventfs_srcu, idx);
>  	return ret;
>  }
[...]
> @@ -2400,15 +2416,134 @@ event_define_fields(struct trace_event_call *call)
>  	return ret;
>  }
>  
> +static int event_callback(const char *name, umode_t *mode, void **data,
> +			  const struct file_operations **fops)
> +{
> +	struct trace_event_file *file = *data;
> +	struct trace_event_call *call = file->event_call;
> +
> +	if (strcmp(name, "format") == 0) {
> +		*mode = TRACE_MODE_READ;
> +		*fops = &ftrace_event_format_fops;
> +		*data = call;
> +		return 1;
> +	}
> +
> +	/*
> +	 * Only event directories that can be enabled should have
> +	 * triggers or filters, with the exception of the "print"
> +	 * event that can have a "trigger" file.
> +	 */
> +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
> +		if (call->class->reg && strcmp(name, "enable") == 0) {
> +			*mode = TRACE_MODE_WRITE;
> +			*fops = &ftrace_enable_fops;
> +			return 1;
> +		}
> +
> +		if (strcmp(name, "filter") == 0) {
> +			*mode = TRACE_MODE_WRITE;
> +			*fops = &ftrace_event_filter_fops;
> +			return 1;
> +		}
> +	}
> +
> +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
> +	    strcmp(trace_event_name(call), "print") == 0) {
> +		if (strcmp(name, "trigger") == 0) {
> +			*mode = TRACE_MODE_WRITE;
> +			*fops = &event_trigger_fops;
> +			return 1;
> +		}
> +	}
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	if (call->event.type && call->class->reg &&
> +	    strcmp(name, "id") == 0) {
> +		*mode = TRACE_MODE_READ;
> +		*data = (void *)(long)call->event.type;
> +		*fops = &ftrace_event_id_fops;
> +		return 1;
> +	}
> +#endif
> +
> +#ifdef CONFIG_HIST_TRIGGERS
> +	if (strcmp(name, "hist") == 0) {
> +		*mode = TRACE_MODE_READ;
> +		*fops = &event_hist_fops;
> +		return 1;
> +	}
> +#endif
> +#ifdef CONFIG_HIST_TRIGGERS_DEBUG
> +	if (strcmp(name, "hist_debug") == 0) {
> +		*mode = TRACE_MODE_READ;
> +		*fops = &event_hist_debug_fops;
> +		return 1;
> +	}
> +#endif
> +#ifdef CONFIG_TRACE_EVENT_INJECT
> +	if (call->event.type && call->class->reg &&
> +	    strcmp(name, "inject") == 0) {
> +		*mode = 0200;
> +		*fops = &event_inject_fops;
> +		return 1;
> +	}
> +#endif
> +	return 0;
> +}
> +
>  static int
> -event_create_dir(struct dentry *parent, struct trace_event_file *file)
> +event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  {
>  	struct trace_event_call *call = file->event_call;
> -	struct eventfs_file *ef_subsystem = NULL;
>  	struct trace_array *tr = file->tr;
> -	struct eventfs_file *ef;
> +	struct eventfs_inode *e_events;
> +	struct eventfs_inode *ei;
>  	const char *name;
> +	int nr_entries;
>  	int ret;
> +	static struct eventfs_entry event_entries[] = {
> +		{
> +			.name		= "enable",
> +			.callback	= event_callback,
> +		},
> +		{
> +			.name		= "filter",
> +			.callback	= event_callback,
> +		},
> +		{
> +			.name		= "trigger",
> +			.callback	= event_callback,
> +		},
> +		{
> +			.name		= "format",
> +			.callback	= event_callback,
> +		},
> +#ifdef CONFIG_PERF_EVENTS
> +		{
> +			.name		= "id",
> +			.callback	= event_callback,
> +		},
> +#endif
> +#ifdef CONFIG_HIST_TRIGGERS
> +		{
> +			.name		= "hist",
> +			.callback	= event_callback,
> +		},
> +#endif
> +#ifdef CONFIG_HIST_TRIGGERS_DEBUG
> +		{
> +			.name		= "hist_debug",
> +			.callback	= event_callback,
> +		},
> +#endif
> +#ifdef CONFIG_TRACE_EVENT_INJECT
> +		{
> +			.name		= "inject",
> +			.callback	= event_callback,
> +		},
> +#endif

Q: I wonder why these uses the same 'event_callback'? it seems those have
different callbacks...
[...]

> +static int events_callback(const char *name, umode_t *mode, void **data,
> +			   const struct file_operations **fops)
> +{
> +	if (strcmp(name, "enable") == 0) {
> +		*mode = TRACE_MODE_WRITE;
> +		*fops = &ftrace_tr_enable_fops;
> +		return 1;
> +	}
> +
> +	if (strcmp(name, "header_page") == 0)
> +		*data = ring_buffer_print_page_header;
> +
> +	else if (strcmp(name, "header_event") == 0)
> +		*data = ring_buffer_print_entry_header;
> +
> +	else
> +		return 0;
> +
> +	*mode = TRACE_MODE_READ;
> +	*fops = &ftrace_show_header_fops;
> +	return 1;
> +}
> +
>  /* Expects to have event_mutex held when called */
>  static int
>  create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  {
> -	struct dentry *d_events;
> +	struct eventfs_inode *e_events;
>  	struct dentry *entry;
> -	int error = 0;
> +	int nr_entries;
> +	static struct eventfs_entry events_entries[] = {
> +		{
> +			.name		= "enable",
> +			.callback	= events_callback,
> +		},
> +		{
> +			.name		= "header_page",
> +			.callback	= events_callback,
> +		},
> +		{
> +			.name		= "header_event",
> +			.callback	= events_callback,
> +		},
> +	};

Here too.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
