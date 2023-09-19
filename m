Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5917A5E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjISJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjISJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:41:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4703CE5;
        Tue, 19 Sep 2023 02:41:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46962C433C7;
        Tue, 19 Sep 2023 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695116475;
        bh=jkD7ARu9jW1GDMbG85TbPYVnwG7WQLTm/KZ+zfn5d4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jEoTscbY8wOEPXbGHru7KJ4LQOZyQrNBE6q2A22qhYHOZAcx2rC9E/O9rawIqFsaw
         LwZj5jkfNJhe0RDJfrPn4zGG5s5WzkFciP+Al0x2lhKyRlgH4HE429ey8faafatYTz
         NFVIcxgoRnYmNJAsnI/qpiRj9TuEmWNnxr+L5Q25x9AT8vUblpIHQfg4bgtCrGZq6j
         5tFrGZERh2fWOJlKAEXvuH8Xc/YZpykJtdG7V9DwM/SKOvy5ie3PyRgZe6BTrNTqj2
         sJO3h5rN46XodXA1ZwX01fm6hDQuxv16ipiXWHWsMbtCfIZTcTH/erraVk8i19hUQl
         C00SMb572JTsg==
Date:   Tue, 19 Sep 2023 18:41:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH 1/2 v3] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-Id: <20230919184109.d2382bccfc208676c64df3fb@kernel.org>
In-Reply-To: <20230918210456.3772d4fa@gandalf.local.home>
References: <20230914163504.884804272@goodmis.org>
        <20230914163535.269645249@goodmis.org>
        <20230919000129.be4971c111300d108be97a3f@kernel.org>
        <20230918210456.3772d4fa@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 21:04:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> > > @@ -144,18 +129,18 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
> > >  }
> > >  
> > >  /**
> > > - * eventfs_set_ef_status_free - set the ef->status to free
> > > + * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
> > >   * @ti: the tracefs_inode of the dentry
> > > - * @dentry: dentry who's status to be freed
> > > + * @dentry: dentry which has the reference to remove.
> > >   *
> > > - * eventfs_set_ef_status_free will be called if no more
> > > - * references remain
> > > + * Remove the association between a dentry from an eventfs_inode.
> > >   */
> > > -void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> > > +void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> > >  {
> > >  	struct tracefs_inode *ti_parent;
> > > +	struct eventfs_inode *ei_child, *tmp;
> > >  	struct eventfs_inode *ei;
> > > -	struct eventfs_file *ef, *tmp;
> > > +	int i;
> > >  
> > >  	/* The top level events directory may be freed by this */
> > >  	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> > > @@ -166,9 +151,9 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> > >  		ei = ti->private;
> > >  
> > >  		/* Record all the top level files */
> > > -		list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > > +		list_for_each_entry_srcu(ei_child, &ei->children, list,
> > >  					 lockdep_is_held(&eventfs_mutex)) {
> > > -			list_add_tail(&ef->del_list, &ef_del_list);
> > > +			list_add_tail(&ei_child->del_list, &ef_del_list);
> > >  		}  
> > 
> > Do we really need to move all ei::children to ef_del_list (this must be
> > ei_del_list)? Because we removed ei from ti->private under eventfs_mutex
> > is locked, no one can access the ei::childrenn anymore?
> 
> Part of this is paranoia, just like why I set ti->private to NULL again. It
> shouldn't be accessed, but just in case it is, I want to make sure it
> doesn't cause any hard to find bugs. I rather have this than to chase down
> some hard to find bug if this ever becomes not the case.
> 
> And I wanted to be consistent. As ei->children should only be iterated with
> srcu or eventfs_mutex held. I really don't want to have that list iterated
> without any locking.
> 
> Note, this is a slow path, where it's better to be safe than efficient.

OK, so this is done intentionally. I got it.

> 
> > 
> > >  
> > >  		/* Nothing should access this, but just in case! */
> > > @@ -177,11 +162,13 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> > >  		mutex_unlock(&eventfs_mutex);
> > >  
> > >  		/* Now safely free the top level files and their children */
> > > -		list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
> > > -			list_del(&ef->del_list);
> > > -			eventfs_remove(ef);
> > > +		list_for_each_entry_safe(ei_child, tmp, &ef_del_list, del_list) {  
> > 
> > I mean now we can safely use ei->children here.
> 
> Like I said, I don't want to iterate it without a lock.
> eventfs_remove_dir() grabs the eventfs_lock, so it can't be held during the
> loop.

OK.


> 
> > 
> > > +			list_del(&ei_child->del_list);
> > > +			eventfs_remove_dir(ei_child);
> > >  		}
> > >  
> > > +		kfree_const(ei->name);
> > > +		kfree(ei->d_children);
> > >  		kfree(ei);
> > >  		return;
> > >  	}
> > > @@ -192,68 +179,162 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> > >  	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> > >  		goto out;
> > >  
> > > -	ef = dentry->d_fsdata;
> > > -	if (!ef)
> > > +	ei = dentry->d_fsdata;
> > > +	if (!ei)
> > >  		goto out;
> > >  
> > >  	/*
> > > -	 * If ef was freed, then the LSB bit is set for d_fsdata.
> > > +	 * If ei was freed, then the LSB bit is set for d_fsdata.
> > >  	 * But this should not happen, as it should still have a
> > >  	 * ref count that prevents it. Warn in case it does.
> > >  	 */
> > > -	if (WARN_ON_ONCE((unsigned long)ef & 1))
> > > +	if (WARN_ON_ONCE((unsigned long)ei & 1))
> > >  		goto out;
> > >  
> > > +	/* This could belong to one of the files of the ei */
> > > +	if (ei->dentry != dentry) {
> > > +		for (i = 0; i < ei->nr_entries; i++) {
> > > +			if (ei->d_children[i] == dentry)
> > > +				break;
> > > +		}
> > > +		if (WARN_ON_ONCE(i == ei->nr_entries))
> > > +			goto out;
> > > +		ei->d_children[i] = NULL;
> > > +	} else {
> > > +		ei->dentry = NULL;
> > > +	}
> > > +
> > >  	dentry->d_fsdata = NULL;
> > > -	ef->dentry = NULL;
> > > -out:
> > > + out:
> > > +	mutex_unlock(&eventfs_mutex);
> > > +}
> > > +
> 
> 
> 
> > >  /**
> > > - * create_dentry - helper function to create dentry
> > > - * @ef: eventfs_file of file or directory to create
> > > - * @parent: parent dentry
> > > - * @lookup: true if called from lookup routine
> > > + * create_dir_dentry - Create a directory dentry for the eventfs_inode
> > > + * @ei: The eventfs_inode to create the directory for
> > > + * @parent: The dentry of the parent of this directory
> > > + * @lookup: True if this is called by the lookup code
> > >   *
> > > - * Used to create a dentry for file/dir, executes post dentry creation routine
> > > + * This creates and attaches a directory dentry to the eventfs_inode @ei.
> > >   */
> > >  static struct dentry *
> > > -create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> > > +create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
> > >  {
> > >  	bool invalidate = false;
> > > -	struct dentry *dentry;
> > > +	struct dentry *dentry = NULL;
> > >  
> > >  	mutex_lock(&eventfs_mutex);
> > > -	if (ef->is_freed) {
> > > -		mutex_unlock(&eventfs_mutex);
> > > -		return NULL;
> > > -	}
> > > -	if (ef->dentry) {
> > > -		dentry = ef->dentry;
> > > -		/* On dir open, up the ref count */
> > > +	if (ei->dentry) {
> > > +		/* If the dentry already has a dentry, use it */
> > > +		dentry = ei->dentry;
> > > +		/* lookup does not need to up the ref count */
> > >  		if (!lookup)
> > >  			dget(dentry);
> > >  		mutex_unlock(&eventfs_mutex);
> > > @@ -261,42 +342,50 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> > >  	}
> > >  	mutex_unlock(&eventfs_mutex);
> > >  
> > > +	/* The lookup already has the parent->d_inode locked */
> > >  	if (!lookup)
> > >  		inode_lock(parent->d_inode);
> > >  
> > > -	if (ef->ei)
> > > -		dentry = create_dir(ef->name, parent, ef->data);
> > > -	else
> > > -		dentry = create_file(ef->name, ef->mode, parent,
> > > -				     ef->data, ef->fop);
> > > +	dentry = create_dir(ei->name, parent);
> > >  
> > >  	if (!lookup)
> > >  		inode_unlock(parent->d_inode);
> > >  
> > >  	mutex_lock(&eventfs_mutex);
> > > -	if (IS_ERR_OR_NULL(dentry)) {
> > > -		/* If the ef was already updated get it */
> > > -		dentry = ef->dentry;
> > > +
> > > +	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
> > > +		/*
> > > +		 * When the mutex was released, something else could have
> > > +		 * created the dentry for this e_dentry. In which case
> > > +		 * use that one.
> > > +		 *
> > > +		 * Note, with the mutex held, the e_dentry cannot have content
> > > +		 * and the ei->is_freed be true at the same time.
> > > +		 */
> > > +		dentry = ei->dentry;
> > >  		if (dentry && !lookup)
> > >  			dget(dentry);
> > >  		mutex_unlock(&eventfs_mutex);
> > >  		return dentry;
> > >  	}
> > >  
> > > -	if (!ef->dentry && !ef->is_freed) {
> > > -		ef->dentry = dentry;
> > > -		if (ef->ei)
> > > -			eventfs_post_create_dir(ef);
> > > -		dentry->d_fsdata = ef;
> > > +	if (!ei->dentry && !ei->is_freed) {
> > > +		ei->dentry = dentry;
> > > +		eventfs_post_create_dir(ei);
> > > +		dentry->d_fsdata = ei;
> > >  	} else {
> > > -		/* A race here, should try again (unless freed) */
> > > +		/*
> > > +		 * Should never happen unless we get here due to being freed.
> > > +		 * Otherwise it means two dentries exist with the same name.
> > > +		 */
> > > +		WARN_ON_ONCE(!ei->is_freed);
> > >  		invalidate = true;
> > >  
> > >  		/*
> > >  		 * Should never happen unless we get here due to being freed.
> > >  		 * Otherwise it means two dentries exist with the same name.
> > >  		 */
> > > -		WARN_ON_ONCE(!ef->is_freed);
> > > +		WARN_ON_ONCE(!ei->is_freed);  
> > 
> > Do we need to repeat this same WARN_ON_ONCE() again?
> 
> Nope. That probably happened from my many rebases I did no this code.
> 
> > 
> > >  	}
> > >  	mutex_unlock(&eventfs_mutex);
> > >  	if (invalidate)
> > > @@ -308,50 +397,70 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> > >  	return invalidate ? NULL : dentry;
> > >  }
> > >  
> > > -static bool match_event_file(struct eventfs_file *ef, const char *name)
> > > -{
> > > -	bool ret;
> > > -
> > > -	mutex_lock(&eventfs_mutex);
> > > -	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
> > > -	mutex_unlock(&eventfs_mutex);
> > > -
> > > -	return ret;
> > > -}
> > > -
> > >  /**
> > >   * eventfs_root_lookup - lookup routine to create file/dir
> > >   * @dir: in which a lookup is being done
> > >   * @dentry: file/dir dentry
> > > - * @flags: to pass as flags parameter to simple lookup
> > > + * @flags: Just passed to simple_lookup()
> > >   *
> > > - * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
> > > - * list of meta data to find the information needed to create the file/dir.
> > > + * Used to create dynamic file/dir with-in @dir, search with-in @ei
> > > + * list, if @dentry found go ahead and create the file/dir
> > >   */
> > > +
> > >  static struct dentry *eventfs_root_lookup(struct inode *dir,
> > >  					  struct dentry *dentry,
> > >  					  unsigned int flags)
> > >  {
> > > +	const struct file_operations *fops;
> > > +	const struct eventfs_entry *entry;
> > > +	struct eventfs_inode *ei_child;
> > >  	struct tracefs_inode *ti;
> > >  	struct eventfs_inode *ei;
> > > -	struct eventfs_file *ef;
> > >  	struct dentry *ret = NULL;
> > > +	const char *name = dentry->d_name.name;
> > > +	bool created = false;
> > > +	umode_t mode;
> > > +	void *data;
> > >  	int idx;
> > > +	int i;
> > > +	int r;
> > >  
> > >  	ti = get_tracefs(dir);
> > >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> > >  		return NULL;
> > >  
> > >  	ei = ti->private;  
> > 
> > Just for make sure, can we access 'ti->private' safely here, because I saw
> > eventfs_set_ef_status_free() modifies it under eventfs_mutex. 
> > I guess this is called with some inode reference so it is not removed.
> > (but in that case, why we need eventfs_mutex in eventfs_set_ef_status_free()...?)
> 
> eventfs_mutex is used to protect modifying the list. srcu is used to
> protect the iteration of the list.
> 
> This code is called via the vfs layer. Hmm, maybe I should take the eventfs_mutex() here:
> 
> 	idx = srcu_read_lock(&eventfs_srcu);
> 	mutex_lock(eventfs_mutex);
> 	ei = ti->private;
> 	mutex_unlock(eventfs_mutex);
> 
> 	if (!ei)
> 		goto out;
> 
> Just in case there's a way that ei can be deleted while the list is being walked.
> 
> Hmm.

Yeah. If we can 'get' the refcount on 'ei' while holding the eventfs_mutex,
it ensures 'ei' is there until we 'put' it.

> 
> > 
> > > +	data = ei->data;
> > > +
> > >  	idx = srcu_read_lock(&eventfs_srcu);
> > > -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> > >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > > -		if (!match_event_file(ef, dentry->d_name.name))
> > > +		if (strcmp(ei_child->name, name) != 0)
> > >  			continue;
> > >  		ret = simple_lookup(dir, dentry, flags);
> > > -		create_dentry(ef, ef->d_parent, true);
> > > +		create_dir_dentry(ei_child, ei->dentry, true);
> > > +		created = true;
> > >  		break;
> > >  	}
> > > +
> > > +	if (created)
> > > +		goto out;
> > > +
> > > +	for (i = 0; i < ei->nr_entries; i++) {
> > > +		entry = &ei->entries[i];
> > > +		if (strcmp(name, entry->name) == 0) {
> > > +			void *cdata = data;
> > > +			r = entry->callback(name, &mode, &cdata, &fops);
> > > +			if (r <= 0)
> > > +				continue;
> > > +			ret = simple_lookup(dir, dentry, flags);
> > > +			create_file_dentry(ei, &ei->d_children[i],
> > > +					   ei->dentry, name, mode, cdata,
> > > +					   fops, true);
> > > +			break;
> > > +		}
> > > +	}
> > > + out:
> > >  	srcu_read_unlock(&eventfs_srcu, idx);
> > >  	return ret;
> > >  }
> > > @@ -363,11 +472,12 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
> > >   */
> > >  static int eventfs_release(struct inode *inode, struct file *file)
> > >  {
> > > +	struct eventfs_inode *ei_child;
> > >  	struct tracefs_inode *ti;
> > >  	struct eventfs_inode *ei;
> > > -	struct eventfs_file *ef;
> > >  	struct dentry *dentry;
> > >  	int idx;
> > > +	int i;
> > >  
> > >  	ti = get_tracefs(inode);
> > >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> > > @@ -375,10 +485,18 @@ static int eventfs_release(struct inode *inode, struct file *file)
> > >  
> > >  	ei = ti->private;
> > >  	idx = srcu_read_lock(&eventfs_srcu);
> > > -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> > >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > >  		mutex_lock(&eventfs_mutex);
> > > -		dentry = ef->dentry;
> > > +		dentry = ei_child->dentry;
> > > +		mutex_unlock(&eventfs_mutex);  
> > 
> > If someone add a directory via eventfs_create_dir() in parallel, is this
> > local mutex_lock able to protect from that? (usually it may not happen.)
> 
> That would require an event being added and created at the same time. Not
> sure that is possible.
> 
> We could try it?

Not sure, but both eventfs_release() and eventfs_create_dir() will be
called from dynamic events, right? But the dynamic events will protect
the create/delete operation with a mutex, so it should not happen if
I understand correctly.
But if the eventfs requires such external exclusion for the operation,
it should be commented.

> 
> > 
> > > +		if (dentry)
> > > +			dput(dentry);
> > > +	}
> > > +
> > > +	for (i = 0; i < ei->nr_entries; i++) {
> > > +		mutex_lock(&eventfs_mutex);
> > > +		dentry = ei->d_children[i];
> > >  		mutex_unlock(&eventfs_mutex);  
> > 
> > Ditto. Maybe I'm misunderstanding how eventfs_mutex is used.
> 
> I'll have to go back and look at this part on why I had this. I think it
> was to make sure ei->d_children existed. But it may also need a test too. I
> don't remember. :-/

Thanks :)

> 
> 
> > 
> > >  		if (dentry)
> > >  			dput(dentry);
> > > @@ -390,94 +508,140 @@ static int eventfs_release(struct inode *inode, struct file *file)
> > >  /**
> > >   * dcache_dir_open_wrapper - eventfs open wrapper
> > >   * @inode: not used
> > > - * @file: dir to be opened (to create its child)
> > > + * @file: dir to be opened (to create it's children)
> > >   *
> > > - * Used to dynamically create the file/dir within @file. @file is really a
> > > - * directory and all the files/dirs of the children within @file will be
> > > - * created. If any of the files/dirs have already been created, their
> > > - * reference count will be incremented.
> > > + * Used to dynamic create file/dir with-in @file, all the
> > > + * file/dir will be created. If already created then references
> > > + * will be increased
> > >   */
> > >  static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
> > >  {
> > > +	const struct file_operations *fops;
> > > +	const struct eventfs_entry *entry;
> > > +	struct eventfs_inode *ei_child;
> > >  	struct tracefs_inode *ti;
> > >  	struct eventfs_inode *ei;
> > > -	struct eventfs_file *ef;
> > > -	struct dentry *dentry = file_dentry(file);
> > > +	struct dentry *parent = file_dentry(file);
> > >  	struct inode *f_inode = file_inode(file);
> > > +	const char *name = parent->d_name.name;
> > > +	umode_t mode;
> > > +	void *data;
> > >  	int idx;
> > > +	int i;
> > > +	int r;
> > >  
> > >  	ti = get_tracefs(f_inode);
> > >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> > >  		return -EINVAL;
> > >  
> > >  	ei = ti->private;
> > > +	data = ei->data;
> > > +
> > >  	idx = srcu_read_lock(&eventfs_srcu);
> > > -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> > >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > > -		create_dentry(ef, dentry, false);
> > > +		create_dir_dentry(ei_child, parent, false);
> > > +	}
> > > +
> > > +	for (i = 0; i < ei->nr_entries; i++) {
> > > +		void *cdata = data;
> > > +		entry = &ei->entries[i];
> > > +		name = entry->name;
> > > +		r = entry->callback(name, &mode, &cdata, &fops);
> > > +		if (r <= 0)
> > > +			continue;
> > > +		create_file_dentry(ei, &ei->d_children[i],
> > > +				       parent, name, mode, cdata, fops, false);
> > >  	}
> > >  	srcu_read_unlock(&eventfs_srcu, idx);
> > >  	return dcache_dir_open(inode, file);
> > >  }
> > >  
> 
> 
> > >  /**
> > >   * eventfs_remove - remove eventfs dir or file from list
> > > - * @ef: eventfs_file to be removed.
> > > + * @ei: eventfs_inode to be removed.
> > >   *
> > >   * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
> > >   */
> > > -void eventfs_remove(struct eventfs_file *ef)
> > > +void eventfs_remove_dir(struct eventfs_inode *ei)
> > >  {
> > > -	struct eventfs_file *tmp;
> > > -	LIST_HEAD(ef_del_list);
> > > +	struct eventfs_inode *tmp;
> > > +	LIST_HEAD(ei_del_list);
> > >  	struct dentry *dentry_list = NULL;
> > >  	struct dentry *dentry;
> > > +	int i;
> > >  
> > > -	if (!ef)
> > > +	if (!ei)
> > >  		return;
> > >  
> > >  	mutex_lock(&eventfs_mutex);
> > > -	eventfs_remove_rec(ef, &ef_del_list, 0);
> > > -	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
> > > -		if (ef->dentry) {
> > > -			unsigned long ptr = (unsigned long)dentry_list;
> > > -
> > > -			/* Keep the dentry from being freed yet */
> > > -			dget(ef->dentry);
> > > -
> > > -			/*
> > > -			 * Paranoid: The dget() above should prevent the dentry
> > > -			 * from being freed and calling eventfs_set_ef_status_free().
> > > -			 * But just in case, set the link list LSB pointer to 1
> > > -			 * and have eventfs_set_ef_status_free() check that to
> > > -			 * make sure that if it does happen, it will not think
> > > -			 * the d_fsdata is an event_file.
> > > -			 *
> > > -			 * For this to work, no event_file should be allocated
> > > -			 * on a odd space, as the ef should always be allocated
> > > -			 * to be at least word aligned. Check for that too.
> > > -			 */
> > > -			WARN_ON_ONCE(ptr & 1);
> > > -
> > > -			ef->dentry->d_fsdata = (void *)(ptr | 1);
> > > -			dentry_list = ef->dentry;
> > > -			ef->dentry = NULL;
> > > -		}
> > > -		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
> > > +	eventfs_remove_rec(ei, &ei_del_list, 0);
> > > +
> > > +	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
> > > +		for (i = 0; i < ei->nr_entries; i++)
> > > +			unhook_dentry(&ei->d_children[i], &dentry_list);
> > > +		unhook_dentry(&ei->dentry, &dentry_list);
> > > +		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
> > >  	}
> > >  	mutex_unlock(&eventfs_mutex);
> > >  
> > > @@ -783,8 +814,8 @@ void eventfs_remove(struct eventfs_file *ef)
> > >  		mutex_lock(&eventfs_mutex);
> > >  		/* dentry should now have at least a single reference */
> > >  		WARN_ONCE((int)d_count(dentry) < 1,
> > > -			  "dentry %p less than one reference (%d) after invalidate\n",
> > > -			  dentry, d_count(dentry));
> > > +			  "dentry %px (%s) less than one reference (%d) after invalidate\n",
> > > +			  dentry, dentry->d_name.name, d_count(dentry));  
> > 
> > Do we need to check this? Even if someone can access to this dentry, it will
> > use a dput(), so *that dput()* or *the below dput()* will release the dentry,
> > doesn't it?
> 
> I triggered this warning a lot in my development, so I'd like to keep it!

OK, I was just curious why we are doing this here.

> 
> > 
> > 
> > >  		mutex_unlock(&eventfs_mutex);
> > >  		dput(dentry);
> > >  	}
> > > diff --git a/fs/tracefs/event_show.c b/fs/tracefs/event_show.c
> > > index 66dece7cc810..35e8f5d805ea 100644
> > > --- a/fs/tracefs/event_show.c
> > > +++ b/fs/tracefs/event_show.c
> > > @@ -25,7 +25,7 @@ static void *e_next(struct seq_file *m, void *v, loff_t *pos)
> > >  	int level = elist->level;
> > >  	struct list_head *head = elist->head[level];
> > >  	struct list_head *next = elist->next[level];
> > > -	struct eventfs_file *ef;
> > > +	struct eventfs_inode *ei;
> > >  
> > >  	(*pos)++;
> > >  
> > > @@ -42,12 +42,12 @@ static void *e_next(struct seq_file *m, void *v, loff_t *pos)
> > >  		elist->next[level] = next;
> > >  	}
> > >  
> > > -	ef = list_entry(next, struct eventfs_file, list);
> > > +	ei = list_entry(next, struct eventfs_inode, list);
> > >  
> > >  	/* For each entry (not at the bottom) do a breadth first search */
> > > -	if (ef->ei && !list_empty(&ef->ei->e_top_files) && level < 2) {
> > > +	if (!list_empty(&ei->children) && level < 2) {
> > >  		elist->level = ++level;
> > > -		head = &ef->ei->e_top_files;
> > > +		head = &ei->children;
> > >  		elist->head[level] = head;
> > >  		next = head;
> > >  		/*
> > > @@ -57,13 +57,13 @@ static void *e_next(struct seq_file *m, void *v, loff_t *pos)
> > >  	}
> > >  
> > >  	elist->next[level] = next->next;
> > > -	return ef;
> > > +	return ei;
> > >  }
> > >  
> > >  static void *e_start(struct seq_file *m, loff_t *pos)
> > >  {
> > >  	struct event_list *elist = m->private;
> > > -	struct eventfs_file *ef = NULL;
> > > +	struct eventfs_inode *ei = NULL;
> > >  	loff_t l;
> > >  
> > >  	mutex_lock(&eventfs_mutex);
> > > @@ -72,25 +72,31 @@ static void *e_start(struct seq_file *m, loff_t *pos)
> > >  	elist->next[0] = elist->head[0]->next;
> > >  
> > >  	for (l = 0; l <= *pos; ) {
> > > -		ef = e_next(m, ef, &l);
> > > -		if (!ef)
> > > +		ei = e_next(m, ei, &l);
> > > +		if (!ei)
> > >  			break;
> > >  	}
> > > -	return ef;
> > > +	return ei;
> > >  }
> > >  
> > >  static int e_show(struct seq_file *m, void *v)
> > >  {
> > > -	struct eventfs_file *ef = v;
> > > +	struct eventfs_inode *ei = v;
> > > +	int i;
> > >  
> > > -	seq_printf(m, "%s", ef->name);
> > > -	if (ef->ei)
> > > -		seq_putc(m, '/');
> > > +	seq_printf(m, "%s", ei->name);
> > >  
> > > -	if (ef->dentry)
> > > -		seq_printf(m, " dentry: (%d)", d_count(ef->dentry));
> > > +	if (ei->dentry)
> > > +		seq_printf(m, " dentry: (%d)", d_count(ei->dentry));
> > >  	seq_putc(m, '\n');
> > >  
> > > +	for (i = 0; i < ei->nr_entries; i++) {
> > > +		struct dentry *dentry = ei->d_children[i];
> > > +		if (dentry) {
> > > +			seq_printf(m, " %s dentry: %px (%d)\n",
> > > +				   ei->entries[i].name, dentry, d_count(dentry));
> > > +		}
> > > +	}
> > >  	return 0;
> > >  }
> > >  
> > > @@ -111,30 +117,25 @@ eventfs_show_dentry_open(struct inode *inode, struct file *file)
> > >  {
> > >  	const struct seq_operations *seq_ops = &eventfs_show_dentry_seq_ops;
> > >  	struct event_list *elist;
> > > -	struct tracefs_inode *ti;
> > >  	struct eventfs_inode *ei;
> > > -	struct dentry *dentry;
> > >  
> > > -	/* The inode private should have the dentry of the "events" directory */
> > > -	dentry = inode->i_private;
> > > -	if (!dentry)
> > > +	/* The inode private should have the eventfs_inode of the "events" directory */
> > > +	ei = inode->i_private;
> > > +	if (!ei)
> > >  		return -EINVAL;
> > >  
> > >  	elist = __seq_open_private(file, seq_ops, sizeof(*elist));
> > >  	if (!elist)
> > >  		return -ENOMEM;
> > >  
> > > -	ti = get_tracefs(dentry->d_inode);
> > > -	ei = ti->private;
> > > -
> > >  	/*
> > >  	 * Start off at level 0 (/sys/kernel/tracing/events)
> > >  	 * Initialize head to the events files and next to the
> > >  	 * first file.
> > >  	 */
> > >  	elist->level = 0;
> > > -	elist->head[0] = &ei->e_top_files;
> > > -	elist->next[0] = ei->e_top_files.next;
> > > +	elist->head[0] = &ei->children;
> > > +	elist->next[0] = ei->children.next;
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > > index 891653ba9cf3..34ffb2f8114e 100644
> > > --- a/fs/tracefs/inode.c
> > > +++ b/fs/tracefs/inode.c
> > > @@ -385,7 +385,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
> > >  
> > >  	ti = get_tracefs(inode);
> > >  	if (ti && ti->flags & TRACEFS_EVENT_INODE)
> > > -		eventfs_set_ef_status_free(ti, dentry);
> > > +		eventfs_set_ei_status_free(ti, dentry);
> > >  	iput(inode);
> > >  }
> > >  
> > > diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> > > index 461920f0133f..ea3b01c0971a 100644
> > > --- a/fs/tracefs/internal.h
> > > +++ b/fs/tracefs/internal.h
> > > @@ -9,35 +9,36 @@ enum {
> > >  	TRACEFS_EVENT_TOP_INODE		= BIT(2),
> > >  };
> > >  
> > > -struct eventfs_inode {
> > > -	struct list_head	e_top_files;
> > > +struct tracefs_inode {
> > > +	unsigned long           flags;
> > > +	void                    *private;
> > > +	struct inode            vfs_inode;
> > >  };
> > >  
> > >  /*
> > > - * struct eventfs_file - hold the properties of the eventfs files and
> > > - *                       directories.
> > > - * @name:	the name of the file or directory to create
> > > - * @d_parent:   holds parent's dentry
> > > - * @dentry:     once accessed holds dentry
> > > - * @list:	file or directory to be added to parent directory
> > > - * @ei:		list of files and directories within directory
> > > - * @fop:	file_operations for file or directory
> > > - * @iop:	inode_operations for file or directory
> > > - * @data:	something that the caller will want to get to later on
> > > - * @mode:	the permission that the file or directory should have
> > > + * struct eventfs_inode - hold the properties of the eventfs directories.
> > > + * @list:	link list into the parent directory
> > > + * @entries:	the array of entries representing the files in the directory
> > > + * @name:	the name of the directory to create  
> > 
> > @children:  link list into the child eventfs_inode
> 
> Thanks! This got chopped a few times during rebasing.
> 
> > 
> > > + * @dentry:     the dentry of the directory
> > > + * @d_parent:   pointer to the parent's dentry
> > > + * @d_children: The array of dentries to represent the files when created
> > > + * @data:	The private data to pass to the callbacks
> > > + * @nr_entries: The number of items in @entries
> > >   */
> > > -struct eventfs_file {
> > > +struct eventfs_inode {
> > > +	struct list_head		list;
> > > +	const struct eventfs_entry	*entries;
> > >  	const char			*name;
> > > -	struct dentry			*d_parent;
> > > +	struct list_head		children;
> > >  	struct dentry			*dentry;
> > > -	struct list_head		list;
> > > -	struct eventfs_inode		*ei;
> > > -	const struct file_operations	*fop;
> > > -	const struct inode_operations	*iop;
> > > +	struct dentry			*d_parent;
> > > +	struct dentry			**d_children;
> > > +	void				*data;
> > >  	/*
> > >  	 * Union - used for deletion
> > > -	 * @del_list:	list of eventfs_file to delete
> > > -	 * @rcu:	eventfs_file to delete in RCU
> > > +	 * @del_list:	list of eventfs_inode to delete
> > > +	 * @rcu:	eventfs_indoe to delete in RCU
> > >  	 * @is_freed:	node is freed if one of the above is set
> > >  	 */
> > >  	union {  
> > 
> > Thank you,
> > 
> 
> Thank you for reviewing!
> 
> I'll need to send a v2.
> 
> I'll have to do that anyway, as Linus nacked the show_eventfs_dentries file :-(


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
