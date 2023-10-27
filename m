Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907D7D97E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjJ0MYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0MYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8925C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698409412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkI6B2xxBoNMxixcFLfMBk3z+VWHlMmRd9oe0BnBgsM=;
        b=EUbBWhcnySq8ZvKQsDB5zjgRJ/Muwkbo9n2ouStUovZz5oiFJVSePKmhV2543qmhdYH229
        ijsz1jD31eXxiK1dMgJYUVdPdCyZSzL90hVNnBrCUwI5pOCO6pT5XIqvgCUuTYCwUlPN0c
        KiXH3EAzAwwsb05/HfazM2B2Kw56Iec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-qQUfIefFO4Wj4C4LLyDvuw-1; Fri, 27 Oct 2023 08:23:27 -0400
X-MC-Unique: qQUfIefFO4Wj4C4LLyDvuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E336828AC9;
        Fri, 27 Oct 2023 12:23:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA3221C060AE;
        Fri, 27 Oct 2023 12:23:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Oct 2023 14:22:26 +0200 (CEST)
Date:   Fri, 27 Oct 2023 14:22:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, dhowells@redhat.com
Subject: Re: [PATCH] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231027122221.GA24128@redhat.com>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026122748.359162-1-singhabhinav9051571833@gmail.com>
 <20231026150326.GA33303@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026150326.GA33303@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26, Peter Zijlstra wrote:
>
> >  kernel/fork.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 10917c3e1f03..802b7bbe3d92 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
> >
> >  	retval = -EAGAIN;
> >  	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > -		if (p->real_cred->user != INIT_USER &&
> > +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
> >  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> >  			goto bad_fork_cleanup_count;
> >  	}
>
> This seems entirely misguided and only makes the code more confusing.
>
> AFAICT at this point @p is not life, we're constructing the new task,
> but it's not yet published, therefore no concurrency possible.
> Additionally we're not actually in an RCU critical section afaict.
>
> > @@ -2692,7 +2692,7 @@ __latent_entropy struct task_struct *copy_process(
> >  			 */
> >  			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
> >  							 p->real_parent->signal->is_child_subreaper;
> > -			list_add_tail(&p->sibling, &p->real_parent->children);
> > +			list_add_tail(&p->sibling, &(rcu_dereference(p->real_parent)->children));
> >  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
> >  			attach_pid(p, PIDTYPE_TGID);
> >  			attach_pid(p, PIDTYPE_PGID);
>
> As to the real_parent, we hold the tasklist lock, which is the write
> side lock for parent stuff, so rcu dereference is pointless here.

Agreed.

Plus I don't think this change is correct, iiuc rcu_dereference() will trigger
the run-time "suspicious rcu_dereference_check() usage" warning, it is called
without rcu_read_lock().

Oleg.

