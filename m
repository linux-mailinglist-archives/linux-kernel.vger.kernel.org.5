Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8D75AF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGTNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62EFC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689858377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6rTOLJG5GaCR/Syt3QSVmsmEmhVSwYUTFKI/e0y0Dg=;
        b=VZ6+wtfek9l68cYY7M8eqcsYlyGRl/P5XeJG1dizFXrNr4IRMX0iruF59o/nbScIK8KvNC
        WoktwkXJmir0cFWNmFAQ86VFQOe0rCZXHgI0Igbk44P3LI04vvQqzO6a4IOH3HV2OrFM8o
        cHdW3rtcPCOQG88fRZDKVoozayQO0b8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-125YkIxGNh2qQi_B62NKNQ-1; Thu, 20 Jul 2023 09:06:14 -0400
X-MC-Unique: 125YkIxGNh2qQi_B62NKNQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31421c900b7so467785f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858373; x=1690463173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6rTOLJG5GaCR/Syt3QSVmsmEmhVSwYUTFKI/e0y0Dg=;
        b=REqWI0ufq0pwZ5XCJ0jSmBOO+aBWvDIdGlx0qa+Tec4BAXQJtM0MSIztm2H6EAHbRk
         xW70Doljdod4CZi/ytNHcRk3QpZZ8fvZLPILZmDeRF4nJ3oealCn0UrsTXjRChlAhP+e
         jEoUIYUJ7fK1LpaQvSjXW5K1Og54z2dGYnQNO+H9Z/5zQrueT+UVn7S0CBUqw0y52y1P
         jcNllNyvTE0WgzI8kFostCKvF2715SxF0MMkgF8AkPcbKCZeGr8Tk9t8gRFxXs3q+RvZ
         k0EmzoWtwpmSW02Nh7E33PafW9oYvs3qMCZ7jn5B/zug/wpamwl0skfpQm1iJRtIplsV
         5rCg==
X-Gm-Message-State: ABy/qLbDtTK9eOVOh3aagosa2Mb0Iy05cLoqebRgB3mKEPVxyE9BPhBy
        BIlZDsk+v/qV4QfyznOvxwHX4p3PWSrMoaSTW7Wt5W1oW5af/VStdndIIU0QeziheHxG38U9VGf
        xzz9o3DZ3paK7+XyxDPGzf56kLBNTCF1S
X-Received: by 2002:a5d:58ca:0:b0:315:9fb7:bd9 with SMTP id o10-20020a5d58ca000000b003159fb70bd9mr2202712wrf.69.1689858372894;
        Thu, 20 Jul 2023 06:06:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTgv95ZuZpJ+dS1+P8teYo17qW+QbhpAI5TLWY/ih9MRHnsEEtjG3hxKcAUvUNkKjRmXY92A==
X-Received: by 2002:a5d:58ca:0:b0:315:9fb7:bd9 with SMTP id o10-20020a5d58ca000000b003159fb70bd9mr2202694wrf.69.1689858372498;
        Thu, 20 Jul 2023 06:06:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d6845000000b0031435731dfasm1311009wrw.35.2023.07.20.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:06:11 -0700 (PDT)
Date:   Thu, 20 Jul 2023 09:06:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230720090415-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202232517.8695-9-michael.christie@oracle.com>
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

On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> For vhost workers we use the kthread API which inherit's its values from
> and checks against the kthreadd thread. This results in the wrong RLIMITs
> being checked, so while tools like libvirt try to control the number of
> threads based on the nproc rlimit setting we can end up creating more
> threads than the user wanted.
> 
> This patch has us use the vhost_task helpers which will inherit its
> values/checks from the thread that owns the device similar to if we did
> a clone in userspace. The vhost threads will now be counted in the nproc
> rlimits. And we get features like cgroups and mm sharing automatically,
> so we can remove those calls.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>



Hi Mike,
So this seems to have caused a measureable regression in networking
performance (about 30%). Take a look here, and there's a zip file
with detailed measuraments attached:

https://bugzilla.redhat.com/show_bug.cgi?id=2222603


Could you take a look please?
You can also ask reporter questions there assuming you
have or can create a (free) account.



> ---
>  drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
>  drivers/vhost/vhost.h |  4 +--
>  2 files changed, 13 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 74378d241f8d..d3c7c37b69a7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,11 +22,11 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> -#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/vhost_task.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
>  #include <linux/kcov.h>
> @@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->task);
> +		wake_up_process(dev->worker->vtsk->task);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
> @@ -336,17 +336,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  static int vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
> -	struct vhost_dev *dev = worker->dev;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> -	kthread_use_mm(dev->mm);
> -
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -		if (kthread_should_stop()) {
> +		if (vhost_task_should_stop(worker->vtsk)) {
>  			__set_current_state(TASK_RUNNING);
>  			break;
>  		}
> @@ -368,7 +365,7 @@ static int vhost_worker(void *data)
>  				schedule();
>  		}
>  	}
> -	kthread_unuse_mm(dev->mm);
> +
>  	return 0;
>  }
>  
> @@ -509,31 +506,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
> -struct vhost_attach_cgroups_struct {
> -	struct vhost_work work;
> -	struct task_struct *owner;
> -	int ret;
> -};
> -
> -static void vhost_attach_cgroups_work(struct vhost_work *work)
> -{
> -	struct vhost_attach_cgroups_struct *s;
> -
> -	s = container_of(work, struct vhost_attach_cgroups_struct, work);
> -	s->ret = cgroup_attach_task_all(s->owner, current);
> -}
> -
> -static int vhost_attach_cgroups(struct vhost_dev *dev)
> -{
> -	struct vhost_attach_cgroups_struct attach;
> -
> -	attach.owner = current;
> -	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> -	vhost_work_queue(dev, &attach.work);
> -	vhost_dev_flush(dev);
> -	return attach.ret;
> -}
> -
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -580,14 +552,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
>  
>  	dev->worker = NULL;
>  	WARN_ON(!llist_empty(&worker->work_list));
> -	kthread_stop(worker->task);
> +	vhost_task_stop(worker->vtsk);
>  	kfree(worker);
>  }
>  
>  static int vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct task_struct *task;
> +	struct vhost_task *vtsk;
>  	int ret;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> @@ -595,27 +567,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
>  		return -ENOMEM;
>  
>  	dev->worker = worker;
> -	worker->dev = dev;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
>  
> -	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> -	if (IS_ERR(task)) {
> -		ret = PTR_ERR(task);
> +	vtsk = vhost_task_create(vhost_worker, worker, NUMA_NO_NODE);
> +	if (!vtsk) {
> +		ret = -ENOMEM;
>  		goto free_worker;
>  	}
>  
> -	worker->task = task;
> -	wake_up_process(task); /* avoid contributing to loadavg */
> -
> -	ret = vhost_attach_cgroups(dev);
> -	if (ret)
> -		goto stop_worker;
> -
> +	worker->vtsk = vtsk;
> +	vhost_task_start(vtsk, "vhost-%d", current->pid);
>  	return 0;
>  
> -stop_worker:
> -	kthread_stop(worker->task);
>  free_worker:
>  	kfree(worker);
>  	dev->worker = NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 2f6beab93784..3af59c65025e 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -16,6 +16,7 @@
>  #include <linux/irqbypass.h>
>  
>  struct vhost_work;
> +struct vhost_task;
>  typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>  
>  #define VHOST_WORK_QUEUED 1
> @@ -26,9 +27,8 @@ struct vhost_work {
>  };
>  
>  struct vhost_worker {
> -	struct task_struct	*task;
> +	struct vhost_task	*vtsk;
>  	struct llist_head	work_list;
> -	struct vhost_dev	*dev;
>  	u64			kcov_handle;
>  };
>  
> -- 
> 2.25.1

