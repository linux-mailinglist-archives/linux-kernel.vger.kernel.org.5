Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6957A7005
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjITBRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B060BD;
        Tue, 19 Sep 2023 18:17:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A44C433C7;
        Wed, 20 Sep 2023 01:17:32 +0000 (UTC)
Date:   Tue, 19 Sep 2023 21:18:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH 1/2 v3] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20230919211804.230edf1e@gandalf.local.home>
In-Reply-To: <20230919184109.d2382bccfc208676c64df3fb@kernel.org>
References: <20230914163504.884804272@goodmis.org>
        <20230914163535.269645249@goodmis.org>
        <20230919000129.be4971c111300d108be97a3f@kernel.org>
        <20230918210456.3772d4fa@gandalf.local.home>
        <20230919184109.d2382bccfc208676c64df3fb@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 18:41:09 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > >  	ti = get_tracefs(inode);
> > > >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> > > > @@ -375,10 +485,18 @@ static int eventfs_release(struct inode *inode, struct file *file)
> > > >  
> > > >  	ei = ti->private;
> > > >  	idx = srcu_read_lock(&eventfs_srcu);
> > > > -	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> > > > +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> > > >  				 srcu_read_lock_held(&eventfs_srcu)) {
> > > >  		mutex_lock(&eventfs_mutex);
> > > > -		dentry = ef->dentry;
> > > > +		dentry = ei_child->dentry;
> > > > +		mutex_unlock(&eventfs_mutex);    
> > > 
> > > If someone add a directory via eventfs_create_dir() in parallel, is this
> > > local mutex_lock able to protect from that? (usually it may not happen.)  
> > 
> > That would require an event being added and created at the same time. Not
> > sure that is possible.
> > 
> > We could try it?  
> 
> Not sure, but both eventfs_release() and eventfs_create_dir() will be
> called from dynamic events, right? But the dynamic events will protect
> the create/delete operation with a mutex, so it should not happen if
> I understand correctly.
> But if the eventfs requires such external exclusion for the operation,
> it should be commented.

Hmm, actually looking at this, it's worse than what you stated. This is
called when a directory is closed. So if you had:

	open(dir);

	// look at all the content of this dir to create dentries

	// another task creates a new entry and looks at it too.

	close(dir);

Now we iterate over all the dentries of the dir and dput it.

I think this will cause the ref counts to get out of sync. I'll have to try
to create this scenario and see what happens.



> 
> >   
> > >   
> > > > +		if (dentry)
> > > > +			dput(dentry);
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < ei->nr_entries; i++) {
> > > > +		mutex_lock(&eventfs_mutex);
> > > > +		dentry = ei->d_children[i];
> > > >  		mutex_unlock(&eventfs_mutex);    
> > > 
> > > Ditto. Maybe I'm misunderstanding how eventfs_mutex is used.  
> > 
> > I'll have to go back and look at this part on why I had this. I think it
> > was to make sure ei->d_children existed. But it may also need a test too. I
> > don't remember. :-/  

I believe this is to keep this and create_file_dentry() in sync.

But I need to look deeper. I'm still very new with understanding how all
this file system code works :-p

-- Steve

