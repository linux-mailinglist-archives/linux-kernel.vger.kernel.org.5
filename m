Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5C7D8F16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbjJ0HBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2966C116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698390028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kneXyjLJZE3jGCsWvtlzo7wk7NDYW1E0EHUPjV/fnfg=;
        b=KNTkAosUznBMYUHCeEdKN81NjPW7wym7htMqKeI5TpiceCOk8Mu79XaRCzjG33WRvkY8pd
        vn2odBhkzqvdQZ1nRA8TkkntQ95An2nvx+YaTvl8ivp5Ca/TVYq0nl926hMJD2yzOAS568
        8cHG9qHdb+oYIiY8fpyHpOYrVgAYqos=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-EKPzb5QvN9GipZ9bGB2NPw-1; Fri, 27 Oct 2023 03:00:25 -0400
X-MC-Unique: EKPzb5QvN9GipZ9bGB2NPw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso1816334a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390023; x=1698994823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kneXyjLJZE3jGCsWvtlzo7wk7NDYW1E0EHUPjV/fnfg=;
        b=NqElqAjbb4Z5vwEV6+pymWQmzhXYdY7+8i7TPb3S6qHZIYVXLTNyJTl6T7PAtu3aWD
         eqkabTs2SstgGIeb3IOopeBpT/lWpjfR0ly45tUz903SS9IYnhGnklMK4M6FdeK8igWN
         PoxhrT2gd7pw5QJcpP0djhB+T6slU2jOmwHBfkqKkWCmyMovNWwjVHzYiHhJIHbhvRc4
         0yBTpb9NrH0IcBNHzb/tNShtGnBBhYKFpvbPL8MbN9pij9PcIxjPj6SbwTM12mHFHDCG
         wEvXShBCcHoKXIOtg9WV+la1j3mycFDN8rFrJOyeekHtGtU86SbGV9iyrZwgH+8Ejzdl
         4dXg==
X-Gm-Message-State: AOJu0Yzl3WVH+X5fHUnWJeVMrfSb/kGyFQK/U5Z9GZEsg66xH9Ciyk73
        zTYikvtj5rOMdm7Blqwe8FXGHnTPFLozcyt/FELm5e/NoUK+Nt5o+toMvwarhiW90u/aRVJFOnJ
        27Tme/ccNbV4smKqFX+/TjJ7W
X-Received: by 2002:a50:d4d7:0:b0:53d:e91b:7158 with SMTP id e23-20020a50d4d7000000b0053de91b7158mr2339297edj.0.1698390023682;
        Fri, 27 Oct 2023 00:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuPBIUVLzDiahv/oYNrf+QZILAUuEQMuZYQKJL5znspjpOYG05EoUK7ekAjj+2nvq2CSM7VQ==
X-Received: by 2002:a50:d4d7:0:b0:53d:e91b:7158 with SMTP id e23-20020a50d4d7000000b0053de91b7158mr2339264edj.0.1698390023340;
        Fri, 27 Oct 2023 00:00:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:52a8:fc3f:6e84:948f:e841])
        by smtp.gmail.com with ESMTPSA id d25-20020a50cd59000000b0053e469f6505sm753876edj.26.2023.10.27.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:00:22 -0700 (PDT)
Date:   Fri, 27 Oct 2023 03:00:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231027025029-mutt-send-email-mst@kernel.org>
References: <20231026114632-mutt-send-email-mst@kernel.org>
 <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
 <db40353c-bee5-491c-b301-f994258ed0f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db40353c-bee5-491c-b301-f994258ed0f9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:11:47PM +0530, Abhinav Singh wrote:
> On 10/27/23 12:07, Abhinav Singh wrote:
> > This patch fixes the warning about directly dereferencing a pointer
> > tagged with __rcu annotation.
> > 
> > Dereferencing the pointers tagged with __rcu directly should
> > always be avoided according to the docs.



> There is a rcu helper
> > functions rcu_dereference(...) to use when dereferencing a __rcu
> > pointer. This functions returns the non __rcu tagged pointer which
> > can be dereferenced just like a normal pointers.
> > 
> > 
> > Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> > ---
> >   kernel/fork.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 10917c3e1f03..e78649974669 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
> >   	retval = -EAGAIN;
> >   	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > -		if (p->real_cred->user != INIT_USER &&
> > +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
> >   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> >   			goto bad_fork_cleanup_count;
> >   	}
> > @@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
> >   			 * tasklist_lock with adding child to the process tree
> >   			 * for propagate_has_child_subreaper optimization.
> >   			 */
> > -			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
> > -							 p->real_parent->signal->is_child_subreaper;
> > -			list_add_tail(&p->sibling, &p->real_parent->children);
> > +			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
> > +							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
> > +			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
> >   			list_add_tail_rcu(&p->tasks, &init_task.tasks);
> >   			attach_pid(p, PIDTYPE_TGID);
> >   			attach_pid(p, PIDTYPE_PGID);
> 
> For this particular file I have resolved the rcu pointer dereferencing issue
> and I have tested the above by using qemu using this command
> qemu-system-x86_64 \
> 	-m 2G \
> 	-smp 2 \
> 	-kernel /home/abhinav/linux_work/linux/arch/x86/boot/bzImage \
> 	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> 	-drive file=/home/abhinav/linux_work/boot_images/bullseye.img,format=raw \
> 	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> 	-net nic,model=e1000 \
> 	-enable-kvm \
> 	-nographic \
> 	-pidfile vm.pid \
> 	2>&1 | tee vm.log
> it booted without any issues.

Did you enable lockdep in your kernel?
CONFIG_PROVE_LOCKING and CONFIG_PROVE_RCU in particular.

-- 
MST

