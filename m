Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF07995FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjIIDJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjIIDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0E1FC0;
        Fri,  8 Sep 2023 20:09:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D875CC433C8;
        Sat,  9 Sep 2023 03:09:29 +0000 (UTC)
Date:   Fri, 8 Sep 2023 23:09:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel
 events directory
Message-ID: <20230908230947.09e1565f@gandalf.local.home>
In-Reply-To: <20230908164553.aff280695dd77b2b9cab35b8@kernel.org>
References: <20230907024710.866917011@goodmis.org>
        <20230907024803.250873643@goodmis.org>
        <20230908164553.aff280695dd77b2b9cab35b8@kernel.org>
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

On Fri, 8 Sep 2023 16:45:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi, 
> 
> On Wed, 06 Sep 2023 22:47:11 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Currently when rmdir on an instance is done, eventfs_remove_events_dir()
> > is called and it does a dput on the dentry and then frees the
> > eventfs_inode that represents the events directory.
> > 
> > But there's no protection against a reader reading the top level events
> > directory at the same time and we can get a use after free error. Instead,
> > use the dput() associated to the dentry to also free the eventfs_inode
> > associated to the events directory, as that will get called when the last
> > reference to the directory is released.
> > 
> > Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/
> > 
> > Cc: Ajay Kaher <akaher@vmware.com>
> > Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from eventfs")
> > Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230905183332.628d7cc0@gandalf.local.home
> >  - Removed left over "ei" variable (kernel test robot)
> > 
> >  fs/tracefs/event_inode.c | 17 ++++++++++++-----
> >  fs/tracefs/inode.c       |  2 +-
> >  fs/tracefs/internal.h    |  5 +++--
> >  3 files changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index fa1a1679a886..609ccb5b7cfc 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> > @@ -185,17 +185,27 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
> >  
> >  /**
> >   * eventfs_set_ef_status_free - set the ef->status to free
> > + * @ti: the tracefs_inode of the dentry
> >   * @dentry: dentry who's status to be freed
> >   *
> >   * eventfs_set_ef_status_free will be called if no more
> >   * references remain
> >   */
> > -void eventfs_set_ef_status_free(struct dentry *dentry)
> > +void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> >  {
> >  	struct tracefs_inode *ti_parent;
> > +	struct eventfs_inode *ei;
> >  	struct eventfs_file *ef;
> >  
> >  	mutex_lock(&eventfs_mutex);
> > +
> > +	/* The top level events directory may be freed by this */
> > +	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> > +		ei = ti->private;
> > +		kfree(ei);  
> 
> Don't we need to clear 'ti->private' here to avoid accessing
> (or double free) ti->private somewhare?

I don't think it's needed but I did add it to

  https://lore.kernel.org/linux-trace-kernel/20230907175859.6fedbaa2@gandalf.local.home/

Which you reviewed.

> 
> > +		goto out;
> > +	}
> > +
> >  	ti_parent = get_tracefs(dentry->d_parent->d_inode);
> >  	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> >  		goto out;  
> 
> Here, I guess this "!(ti_parent->flags & TRACEFS_EVENT_INODE)" means this
> inode is TRACEFS_EVENT_TOP_INODE, so this check may not be needed,
> is this correct?

The check isn't needed but I like to keep it because it will break things
badly if it is every called on something that is not an EVENT_INODE.

We could add a WARN() here if not, but this code is not critical if it is
called without it set.

-- Steve
