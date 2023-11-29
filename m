Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A27FD030
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjK2H4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2H4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08CE1710
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701244605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XVJzeZJEEP99YOFg+7LBm3jmK+UXJ6uuy5vlWFPjto=;
        b=ULPuEbG+c6I7GBxd0qMZz1pNHne17c6kbmTf0H01kUp97YP4TXm/LyOMG83vYl84Qb3/yk
        YeK9iooH5IgUcB9WK2gpNRqU3jfjPxI0Y/NSJh8q59t+ZirHOhpf9/6FH7ztdWlJy/BrCt
        aIhsIiOryYBaSbiZDneFFd1L5V7DEjM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-q1J4E3tAN_qM_svTR0TLDg-1; Wed,
 29 Nov 2023 02:56:42 -0500
X-MC-Unique: q1J4E3tAN_qM_svTR0TLDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 889D91C05137;
        Wed, 29 Nov 2023 07:56:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A8EC2166B26;
        Wed, 29 Nov 2023 07:56:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Nov 2023 08:55:36 +0100 (CET)
Date:   Wed, 29 Nov 2023 08:55:32 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129075532.GE22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128140156.GC22743@redhat.com>
 <170121686264.7109.13475581089284671405@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170121686264.7109.13475581089284671405@noble.neil.brown.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29, NeilBrown wrote:
>
> On Wed, 29 Nov 2023, Oleg Nesterov wrote:
> > On 11/28, NeilBrown wrote:
> > >
> > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > work-queue thread running delayed_fput().  As you might imagine this
> > > does not end well (20 million files in the queue at the time a snapshot
> > > was taken for analysis).
> >
> > On a related note... Neil, Al, et al, can you look at
> >
> > 	[PATCH 1/3] fput: don't abuse task_work_add() when possible
> > 	https://lore.kernel.org/all/20150908171446.GA14589@redhat.com/
> >
>
> Would it make sense to create a separate task_struct->delayed_fput
> llist?

Sure, I too thought about this,

> fput() adds the file to this llist and if it was the first item on the
> list, it then adds the task_work.  That would probably request adding a
> callback_head to struct task_struct as well.

Even simpler, but perhaps I missed something...

We can add a "struct file *fput_xxx" into task_struct and f_fput_xxx into
the f_llist/f_rcuhead union in the struct file.

fput:

	if (task->fput_xxx) {
		file->f_fput_xxx = task->fput_xxx;
		task->fput_xxx = file;
	} else {
		task_work_add(...);
		// XXX: file->f_fput_xxx != NULL
		task->fput_xxx = file;
	}

____fput:

	struct file *file = task->fput_xxx;
	struct file *tail = container_of(work, ...);
	// see XXX in fput()
	tail->f_fput_xxx = NULL;
	current->fput_xxx = NULL;

	do {
		next = READ_ONCE(file->f_fput_xxx);
		__fput(file);
		file = next;
		
	} while (file);
	
Again, quite possibly I missed something, but something like this should work.

But I am still trying to find a simpler solution which doesn't need another
member in task_struct...

Oleg.

