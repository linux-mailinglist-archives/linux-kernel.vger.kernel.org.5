Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B47BE117
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377420AbjJINrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377478AbjJINqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:46:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4FA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:46:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17DFC433C8;
        Mon,  9 Oct 2023 13:46:40 +0000 (UTC)
Date:   Mon, 9 Oct 2023 09:47:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH v4] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20231009094759.054616e3@gandalf.local.home>
In-Reply-To: <20231007194445.444c1447fc694cefd31bfecd@kernel.org>
References: <20231003184059.4924468e@gandalf.local.home>
        <20231007194445.444c1447fc694cefd31bfecd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 19:44:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> [...]
> > @@ -118,6 +72,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
> >  	if (WARN_ON_ONCE(!S_ISREG(mode)))
> >  		return NULL;
> >  
> > +	WARN_ON_ONCE(!parent);  
> 
> Nit: This looks a wrong case and should not create a file under root directory.
>      So it should return NULL. (but it shouldn't happen.)

Yes it should never happen (hence the warn on), but if it does happen, it
shouldn't cause any real harm, so I decided not to return early.

> 
> >  	dentry = eventfs_start_creating(name, parent);
> >  
> >  	if (IS_ERR(dentry))  
> 
>


> > +static struct dentry *
> > +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
> > +		   struct dentry *parent, const char *name, umode_t mode, void *data,
> > +		   const struct file_operations *fops, bool lookup)
> > +{
> > +	struct dentry *dentry;
> > +	bool invalidate = false;
> > +
> > +	mutex_lock(&eventfs_mutex);
> > +	/* If the e_dentry already has a dentry, use it */
> > +	if (*e_dentry) {
> > +		/* lookup does not need to up the ref count */
> > +		if (!lookup)
> > +			dget(*e_dentry);
> > +		mutex_unlock(&eventfs_mutex);
> > +		return *e_dentry;
> > +	}
> > +	mutex_unlock(&eventfs_mutex);
> > +
> > +	/* The lookup already has the parent->d_inode locked */
> > +	if (!lookup)
> > +		inode_lock(parent->d_inode);
> > +
> > +	dentry = create_file(name, mode, parent, data, fops);
> > +
> > +	if (!lookup)
> > +		inode_unlock(parent->d_inode);
> > +
> > +	mutex_lock(&eventfs_mutex);
> > +
> > +	if (IS_ERR_OR_NULL(dentry)) {
> > +		/*
> > +		 * When the mutex was released, something else could have
> > +		 * created the dentry for this e_dentry. In which case
> > +		 * use that one.
> > +		 *
> > +		 * Note, with the mutex held, the e_dentry cannot have content
> > +		 * and the ei->is_freed be true at the same time.
> > +		 */
> > +		WARN_ON_ONCE(ei->is_freed);
> > +		dentry = *e_dentry;
> > +		/* The lookup does not need to up the dentry refcount */
> > +		if (dentry && !lookup)
> > +			dget(dentry);
> > +		mutex_unlock(&eventfs_mutex);
> > +		return dentry;
> > +	}
> > +
> > +	if (!*e_dentry && !ei->is_freed) {
> > +		*e_dentry = dentry;
> > +		dentry->d_fsdata = ei;  
> 
> Nit: If we use LSB for existing flag, this should be checked. e.g. WARN_ON_ONCE(ei & 1).

But ei->is_freed is set before we set that LSB. Why should we check it here
if we already checked ei->is_freed?

> 
> 
> > +	} else {
> > +		/*
> > +		 * Should never happen unless we get here due to being freed.
> > +		 * Otherwise it means two dentries exist with the same name.
> > +		 */
> > +		WARN_ON_ONCE(!ei->is_freed);
> > +		invalidate = true;
> > +	}
> > +	mutex_unlock(&eventfs_mutex);
> > +
> > +	if (invalidate)
> > +		d_invalidate(dentry);
> > +
> > +	if (lookup || invalidate)
> > +		dput(dentry);
> > +
> > +	return invalidate ? NULL : dentry;
> > +}
> > +
> >  /**
> >   * eventfs_post_create_dir - post create dir routine
> > - * @ef: eventfs_file of recently created dir
> > + * @ei: eventfs_inode of recently created dir
> >   *
> >   * Map the meta-data of files within an eventfs dir to their parent dentry
> >   */
> > -static void eventfs_post_create_dir(struct eventfs_file *ef)
> > +static void eventfs_post_create_dir(struct eventfs_inode *ei)
> >  {
> > -	struct eventfs_file *ef_child;
> > +	struct eventfs_inode *ei_child;
> >  	struct tracefs_inode *ti;
> >  
> >  	/* srcu lock already held */
> >  	/* fill parent-child relation */
> > -	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
> > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > -		ef_child->d_parent = ef->dentry;
> > +		ei_child->d_parent = ei->dentry;
> >  	}
> >  
> > -	ti = get_tracefs(ef->dentry->d_inode);
> > -	ti->private = ef->ei;
> > +	ti = get_tracefs(ei->dentry->d_inode);
> > +	ti->private = ei;
> >  }
> >  
> >  /**
> > - * create_dentry - helper function to create dentry
> > - * @ef: eventfs_file of file or directory to create
> > - * @parent: parent dentry
> > - * @lookup: true if called from lookup routine
> > + * create_dir_dentry - Create a directory dentry for the eventfs_inode
> > + * @ei: The eventfs_inode to create the directory for
> > + * @parent: The dentry of the parent of this directory
> > + * @lookup: True if this is called by the lookup code
> >   *
> > - * Used to create a dentry for file/dir, executes post dentry creation routine
> > + * This creates and attaches a directory dentry to the eventfs_inode @ei.
> >   */
> >  static struct dentry *
> > -create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> > +create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
> >  {
> >  	bool invalidate = false;
> > -	struct dentry *dentry;
> > +	struct dentry *dentry = NULL;
> >  
> >  	mutex_lock(&eventfs_mutex);
> > -	if (ef->is_freed) {
> > -		mutex_unlock(&eventfs_mutex);
> > -		return NULL;
> > -	}
> > -	if (ef->dentry) {
> > -		dentry = ef->dentry;
> > -		/* On dir open, up the ref count */
> > +	if (ei->dentry) {
> > +		/* If the dentry already has a dentry, use it */
> > +		dentry = ei->dentry;
> > +		/* lookup does not need to up the ref count */
> >  		if (!lookup)
> >  			dget(dentry);
> >  		mutex_unlock(&eventfs_mutex);
> > @@ -302,42 +343,44 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> >  	}
> >  	mutex_unlock(&eventfs_mutex);
> >  
> > +	/* The lookup already has the parent->d_inode locked */
> >  	if (!lookup)
> >  		inode_lock(parent->d_inode);
> >  
> > -	if (ef->ei)
> > -		dentry = create_dir(ef->name, parent, ef->data);
> > -	else
> > -		dentry = create_file(ef->name, ef->mode, parent,
> > -				     ef->data, ef->fop);
> > +	dentry = create_dir(ei->name, parent);
> >  
> >  	if (!lookup)
> >  		inode_unlock(parent->d_inode);
> >  
> >  	mutex_lock(&eventfs_mutex);
> > -	if (IS_ERR_OR_NULL(dentry)) {
> > -		/* If the ef was already updated get it */
> > -		dentry = ef->dentry;
> > +
> > +	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
> > +		/*
> > +		 * When the mutex was released, something else could have
> > +		 * created the dentry for this e_dentry. In which case
> > +		 * use that one.
> > +		 *
> > +		 * Note, with the mutex held, the e_dentry cannot have content
> > +		 * and the ei->is_freed be true at the same time.
> > +		 */
> > +		dentry = ei->dentry;
> >  		if (dentry && !lookup)
> >  			dget(dentry);
> >  		mutex_unlock(&eventfs_mutex);
> >  		return dentry;
> >  	}
> >  
> > -	if (!ef->dentry && !ef->is_freed) {
> > -		ef->dentry = dentry;
> > -		if (ef->ei)
> > -			eventfs_post_create_dir(ef);
> > -		dentry->d_fsdata = ef;
> > +	if (!ei->dentry && !ei->is_freed) {
> > +		ei->dentry = dentry;
> > +		eventfs_post_create_dir(ei);
> > +		dentry->d_fsdata = ei;  
> 
> Ditto.

And again, the LSB is set after ei->is_freed is set.

> 
> >  	} else {
> > -		/* A race here, should try again (unless freed) */
> > -		invalidate = true;
> > -
> >  		/*
> >  		 * Should never happen unless we get here due to being freed.
> >  		 * Otherwise it means two dentries exist with the same name.
> >  		 */
> > -		WARN_ON_ONCE(!ef->is_freed);
> > +		WARN_ON_ONCE(!ei->is_freed);
> > +		invalidate = true;
> >  	}
> >  	mutex_unlock(&eventfs_mutex);
> >  	if (invalidate)
> > @@ -349,50 +392,82 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> >  	return invalidate ? NULL : dentry;
> >  }
> >  
> > -static bool match_event_file(struct eventfs_file *ef, const char *name)
> > -{
> > -	bool ret;
> > -
> > -	mutex_lock(&eventfs_mutex);
> > -	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
> > -	mutex_unlock(&eventfs_mutex);
> > -
> > -	return ret;
> > -}
> > -
> >  /**
> >   * eventfs_root_lookup - lookup routine to create file/dir
> >   * @dir: in which a lookup is being done
> >   * @dentry: file/dir dentry
> > - * @flags: to pass as flags parameter to simple lookup
> > + * @flags: Just passed to simple_lookup()
> >   *
> > - * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
> > - * list of meta data to find the information needed to create the file/dir.
> > + * Used to create dynamic file/dir with-in @dir, search with-in @ei
> > + * list, if @dentry found go ahead and create the file/dir
> >   */
> > +
> >  static struct dentry *eventfs_root_lookup(struct inode *dir,
> >  					  struct dentry *dentry,
> >  					  unsigned int flags)
> >  {
> > +	const struct file_operations *fops;
> > +	const struct eventfs_entry *entry;
> > +	struct eventfs_inode *ei_child;
> >  	struct tracefs_inode *ti;
> >  	struct eventfs_inode *ei;
> > -	struct eventfs_file *ef;
> >  	struct dentry *ret = NULL;
> > +	const char *name = dentry->d_name.name;
> > +	bool created = false;
> > +	umode_t mode;
> > +	void *data;
> >  	int idx;
> > +	int i;
> > +	int r;
> >  
> >  	ti = get_tracefs(dir);
> >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> >  		return NULL;
> >  
> > -	ei = ti->private;
> > +	/* Grab srcu to prevent the ei from going away */
> >  	idx = srcu_read_lock(&eventfs_srcu);
> > -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > +
> > +	/*
> > +	 * Grab the eventfs_mutex to consistent value from ti->private.
> > +	 * This s
> > +	 */
> > +	mutex_lock(&eventfs_mutex);
> > +	ei = READ_ONCE(ti->private);
> > +	mutex_unlock(&eventfs_mutex);
> > +
> > +	if (!ei)
> > +		goto out;
> > +
> > +	data = ei->data;
> > +
> > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > -		if (!match_event_file(ef, dentry->d_name.name))
> > +		if (strcmp(ei_child->name, name) != 0)
> >  			continue;
> >  		ret = simple_lookup(dir, dentry, flags);  
> 
> Don't we check this return value?

It's the return code from this function.

It shouldn't affect the next lines.

> 
> > -		create_dentry(ef, ef->d_parent, true);
> > +		create_dir_dentry(ei_child, ei->dentry, true);
> > +		created = true;
> >  		break;
> >  	}
> > +
> > +	if (created)
> > +		goto out;
> > +
> > +	for (i = 0; i < ei->nr_entries; i++) {
> > +		entry = &ei->entries[i];
> > +		if (strcmp(name, entry->name) == 0) {
> > +			void *cdata = data;
> > +			r = entry->callback(name, &mode, &cdata, &fops);
> > +			if (r <= 0)
> > +				continue;
> > +			ret = simple_lookup(dir, dentry, flags);  
> 
> Ditto.

The same as above. It's just the return code of the function.

> 
> > +			create_file_dentry(ei, &ei->d_children[i],
> > +					   ei->dentry, name, mode, cdata,
> > +					   fops, true);
> > +			break;
> > +		}
> > +	}
> > + out:
> >  	srcu_read_unlock(&eventfs_srcu, idx);
> >  	return ret;
> >  }  
> [...]
> > @@ -2400,15 +2416,134 @@ event_define_fields(struct trace_event_call *call)
> >  	return ret;
> >  }
> >  
> > +static int event_callback(const char *name, umode_t *mode, void **data,
> > +			  const struct file_operations **fops)
> > +{
> > +	struct trace_event_file *file = *data;
> > +	struct trace_event_call *call = file->event_call;
> > +
> > +	if (strcmp(name, "format") == 0) {
> > +		*mode = TRACE_MODE_READ;
> > +		*fops = &ftrace_event_format_fops;
> > +		*data = call;
> > +		return 1;
> > +	}
> > +
> > +	/*
> > +	 * Only event directories that can be enabled should have
> > +	 * triggers or filters, with the exception of the "print"
> > +	 * event that can have a "trigger" file.
> > +	 */
> > +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
> > +		if (call->class->reg && strcmp(name, "enable") == 0) {
> > +			*mode = TRACE_MODE_WRITE;
> > +			*fops = &ftrace_enable_fops;
> > +			return 1;
> > +		}
> > +
> > +		if (strcmp(name, "filter") == 0) {
> > +			*mode = TRACE_MODE_WRITE;
> > +			*fops = &ftrace_event_filter_fops;
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
> > +	    strcmp(trace_event_name(call), "print") == 0) {
> > +		if (strcmp(name, "trigger") == 0) {
> > +			*mode = TRACE_MODE_WRITE;
> > +			*fops = &event_trigger_fops;
> > +			return 1;
> > +		}
> > +	}
> > +
> > +#ifdef CONFIG_PERF_EVENTS
> > +	if (call->event.type && call->class->reg &&
> > +	    strcmp(name, "id") == 0) {
> > +		*mode = TRACE_MODE_READ;
> > +		*data = (void *)(long)call->event.type;
> > +		*fops = &ftrace_event_id_fops;
> > +		return 1;
> > +	}
> > +#endif
> > +
> > +#ifdef CONFIG_HIST_TRIGGERS
> > +	if (strcmp(name, "hist") == 0) {
> > +		*mode = TRACE_MODE_READ;
> > +		*fops = &event_hist_fops;
> > +		return 1;
> > +	}
> > +#endif
> > +#ifdef CONFIG_HIST_TRIGGERS_DEBUG
> > +	if (strcmp(name, "hist_debug") == 0) {
> > +		*mode = TRACE_MODE_READ;
> > +		*fops = &event_hist_debug_fops;
> > +		return 1;
> > +	}
> > +#endif
> > +#ifdef CONFIG_TRACE_EVENT_INJECT
> > +	if (call->event.type && call->class->reg &&
> > +	    strcmp(name, "inject") == 0) {
> > +		*mode = 0200;
> > +		*fops = &event_inject_fops;
> > +		return 1;
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > +
> >  static int
> > -event_create_dir(struct dentry *parent, struct trace_event_file *file)
> > +event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
> >  {
> >  	struct trace_event_call *call = file->event_call;
> > -	struct eventfs_file *ef_subsystem = NULL;
> >  	struct trace_array *tr = file->tr;
> > -	struct eventfs_file *ef;
> > +	struct eventfs_inode *e_events;
> > +	struct eventfs_inode *ei;
> >  	const char *name;
> > +	int nr_entries;
> >  	int ret;
> > +	static struct eventfs_entry event_entries[] = {
> > +		{
> > +			.name		= "enable",
> > +			.callback	= event_callback,
> > +		},
> > +		{
> > +			.name		= "filter",
> > +			.callback	= event_callback,
> > +		},
> > +		{
> > +			.name		= "trigger",
> > +			.callback	= event_callback,
> > +		},
> > +		{
> > +			.name		= "format",
> > +			.callback	= event_callback,
> > +		},
> > +#ifdef CONFIG_PERF_EVENTS
> > +		{
> > +			.name		= "id",
> > +			.callback	= event_callback,
> > +		},
> > +#endif
> > +#ifdef CONFIG_HIST_TRIGGERS
> > +		{
> > +			.name		= "hist",
> > +			.callback	= event_callback,
> > +		},
> > +#endif
> > +#ifdef CONFIG_HIST_TRIGGERS_DEBUG
> > +		{
> > +			.name		= "hist_debug",
> > +			.callback	= event_callback,
> > +		},
> > +#endif
> > +#ifdef CONFIG_TRACE_EVENT_INJECT
> > +		{
> > +			.name		= "inject",
> > +			.callback	= event_callback,
> > +		},
> > +#endif  
> 
> Q: I wonder why these uses the same 'event_callback'? it seems those have
> different callbacks...

It really is just a preference. I could have it use a different callback,
but if you look at the event_callback(), it looks at the name passed in to
determine what to do. So yes, they do different things when the name passed
in is different.


> [...]
> 
> > +static int events_callback(const char *name, umode_t *mode, void **data,
> > +			   const struct file_operations **fops)
> > +{
> > +	if (strcmp(name, "enable") == 0) {
> > +		*mode = TRACE_MODE_WRITE;
> > +		*fops = &ftrace_tr_enable_fops;
> > +		return 1;
> > +	}
> > +
> > +	if (strcmp(name, "header_page") == 0)
> > +		*data = ring_buffer_print_page_header;
> > +
> > +	else if (strcmp(name, "header_event") == 0)
> > +		*data = ring_buffer_print_entry_header;
> > +
> > +	else
> > +		return 0;
> > +
> > +	*mode = TRACE_MODE_READ;
> > +	*fops = &ftrace_show_header_fops;
> > +	return 1;
> > +}
> > +
> >  /* Expects to have event_mutex held when called */
> >  static int
> >  create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
> >  {
> > -	struct dentry *d_events;
> > +	struct eventfs_inode *e_events;
> >  	struct dentry *entry;
> > -	int error = 0;
> > +	int nr_entries;
> > +	static struct eventfs_entry events_entries[] = {
> > +		{
> > +			.name		= "enable",
> > +			.callback	= events_callback,
> > +		},
> > +		{
> > +			.name		= "header_page",
> > +			.callback	= events_callback,
> > +		},
> > +		{
> > +			.name		= "header_event",
> > +			.callback	= events_callback,
> > +		},
> > +	};  
> 
> Here too.

Same reason.

> 
> Thank you,
> 

Thanks for reviewing.

-- Steve

