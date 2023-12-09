Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA780B3B2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjLIKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F2C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702118552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
        b=czHkUlaRiaNFarIf6BSDsjk88VT9tvhozYXPxIXUCUsU23g9TIrnlziiDoKha1CmmfKduO
        fstOCHzGxgW31FGX+UT7NbBStab/JULX1Moikmk0df3Z+R/0IU2oGGeu6bM+GtHKXojTK0
        zAxPpMNgGAd0ec6MER5K97T9Q7at8bI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-ES1rarCwOI6_gYNRqZ01Ow-1; Sat, 09 Dec 2023 05:42:30 -0500
X-MC-Unique: ES1rarCwOI6_gYNRqZ01Ow-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3d4d6417so17967935e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118549; x=1702723349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
        b=qStFiU14v6+w6Su3WSSjpy277woNp2YNJ4dASHvG0yEDWvvxnAmJtTMtONLg6R8y/W
         hUr+NrW6y/2DEdawjaWHgdVViYIBkaELKqLMBR9WN8d2KHbU1x+BoZCoB/HqGn9smmhV
         IIyLOX+PECiIN6NSEdQAobTjd/GIBea9VOin7NOBQDtAITfnjDfePhoRkkw8+I0loCCr
         VmQn382dtAlaLZmSfSUf2pI8lufyC8fAsCF2jKEtXW/erRrZsnHFkQp1MPyNHYeU9OWn
         wpCDfvEYv9Wsc/Bm1jatqINOM+PkXVCL7jJ2z1PT0eA2WI3DS5cN593Z2t0gTdkQQw43
         zkKw==
X-Gm-Message-State: AOJu0YxeGXqb9dXgdoe5To+WnkVFvEfXZ3pTnjLFVO4Ewk3AQc3Yjzzt
        U6W5Rt6d6JrKKqe6RKGmEMdv1QF2K24XNfNy3FFbytoFzDstDVq5qbfpEAzLWHml1HED7tjAZuO
        fg7ZZQe7R+tcW/CaV3auN2sJQ
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347247wmp.305.1702118549572;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdC86jKPcminvAV1YfnbyeFnlInlsAzYlkskejvPuH6o846ik+MKMa3TBW5xfIsAmcSOb+EA==
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347239wmp.305.1702118549151;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b004060f0a0fd5sm6031663wmf.13.2023.12.09.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:42:28 -0800 (PST)
Date:   Sat, 9 Dec 2023 05:42:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231209053443-mutt-send-email-mst@kernel.org>
References: <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53044.123120806415900549@us-mta-342.us.mimecast.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:41:38PM +0100, Tobias Huschle wrote:
> On Fri, Dec 08, 2023 at 05:31:18AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> > > On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > > > 
> > > > > I dug a little deeper on what the vhost is doing. I'm not an expert on
> > > > > virtio whatsoever, so these are just educated guesses that maybe
> > > > > someone can verify/correct. Please bear with me probably messing up 
> > > > > the terminology.
> > > > > 
> > > > > - vhost is looping through available queues.
> > > > > - vhost wants to wake up a kworker to process a found queue.
> > > > > - kworker does something with that queue and terminates quickly.
> > > > > 
> > > > > What I found by throwing in some very noisy trace statements was that,
> > > > > if the kworker is not woken up, the vhost just keeps looping accross
> > > > > all available queues (and seems to repeat itself). So it essentially
> > > > > relies on the scheduler to schedule the kworker fast enough. Otherwise
> > > > > it will just keep on looping until it is migrated off the CPU.
> > > > 
> > > > 
> > > > Normally it takes the buffers off the queue and is done with it.
> > > > I am guessing that at the same time guest is running on some other
> > > > CPU and keeps adding available buffers?
> > > > 
> > > 
> > > It seems to do just that, there are multiple other vhost instances
> > > involved which might keep filling up thoses queues. 
> > > 
> > 
> > No vhost is ever only draining queues. Guest is filling them.
> > 
> > > Unfortunately, this makes the problematic vhost instance to stay on
> > > the CPU and prevents said kworker to get scheduled. The kworker is
> > > explicitly woken up by vhost, so it wants it to do something.
> > > 
> > > At this point it seems that there is an assumption about the scheduler
> > > in place which is no longer fulfilled by EEVDF. From the discussion so
> > > far, it seems like EEVDF does what is intended to do.
> > > 
> > > Shouldn't there be a more explicit mechanism in use that allows the
> > > kworker to be scheduled in favor of the vhost?
> > > 
> > > It is also concerning that the vhost seems cannot be preempted by the
> > > scheduler while executing that loop.
> > 
> > 
> > Which loop is that, exactly?
> 
> The loop continously passes translate_desc in drivers/vhost/vhost.c
> That's where I put the trace statements.
> 
> The overall sequence seems to be (top to bottom):
> 
> handle_rx
> get_rx_bufs
> vhost_get_vq_desc
> vhost_get_avail_head
> vhost_get_avail
> __vhost_get_user_slow
> translate_desc               << trace statement in here
> vhost_iotlb_itree_first

I wonder why do you keep missing cache and re-translating.
Is pr_debug enabled for you? If not could you check if it
outputs anything?
Or you can tweak:

#define vq_err(vq, fmt, ...) do {                                  \
                pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
                if ((vq)->error_ctx)                               \
                                eventfd_signal((vq)->error_ctx, 1);\
        } while (0)

to do pr_err if you prefer.

> These functions show up as having increased overhead in perf.
> 
> There are multiple loops going on in there.
> Again the disclaimer though, I'm not familiar with that code at all.


So there's a limit there: vhost_exceeds_weight should requeue work:

        } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_len)));

then we invoke scheduler each time before re-executing it:


{       
        struct vhost_worker *worker = data;
        struct vhost_work *work, *work_next;
        struct llist_node *node;
        
        node = llist_del_all(&worker->work_list);
        if (node) {
                __set_current_state(TASK_RUNNING);

                node = llist_reverse_order(node);
                /* make sure flag is seen after deletion */
                smp_wmb();
                llist_for_each_entry_safe(work, work_next, node, node) {
                        clear_bit(VHOST_WORK_QUEUED, &work->flags);
                        kcov_remote_start_common(worker->kcov_handle);
                        work->fn(work);
                        kcov_remote_stop();
                        cond_resched();
                }
        }

        return !!node;
}       

These are the byte and packet limits:

/* Max number of bytes transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others. */
#define VHOST_NET_WEIGHT 0x80000

/* Max number of packets transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others with small
 * pkts.
 */
#define VHOST_NET_PKT_WEIGHT 256


Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?

-- 
MST

