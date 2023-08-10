Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391527780E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjHJS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjHJS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F82696
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691693830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcj+tDm8JEghFQmSsjSMzUhYwNpXARHk6T+1xXCWR28=;
        b=BY3abEbj534MANSx61yKvWgj8fDL6UT5ZEWW+Vm47yY9oLDuHVDMsGdLrA/fS87qK+yqlD
        T9Uz1HzuxyQBHmAxo89PHwdeqZ098N5NHnPe/AklraKskY+lPWJn4U/kRYwkkdHmTrrVBE
        AjH/7oVDmwYNjq1pENbjaREQvO/G4LA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-HQQVg6gQNAOOUckrMDaR7w-1; Thu, 10 Aug 2023 14:57:09 -0400
X-MC-Unique: HQQVg6gQNAOOUckrMDaR7w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9ba3d6191so14208941fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693827; x=1692298627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcj+tDm8JEghFQmSsjSMzUhYwNpXARHk6T+1xXCWR28=;
        b=O2UWzuFm6JdNtfjm9vO+JJg3s/ZAlzEwIJq6jxY9l0Cs2q/DkGKDnKc+kw6/XNjBhW
         9tg8IMIDorgdt94PZF/hmojZm/8uvHdVgMshV2wBqdtB669xC3abiVCbx+emmuBA1pvK
         cpqctKnnqFTEYCN2vAs0Tyoj5TBkNw7U6J99fDieALMRBbcw35KYaqwjnjg+7/ZKdytF
         JJT0MdVAysBjgu8S0v6MOh/mX06TI8rxwaY6VicpGwedzKek3qqBb9JIOTcf2SDiRUFd
         uBPQ3yaHkwr+91w6Dsbwrk1ZsHSrl0l39n1mBj9Hu18R6HdZlp9aIeMw3lGhAXS5nxX2
         T2ew==
X-Gm-Message-State: AOJu0YyjsoZ5M+iXN78LPGKoipJm7cdNGKEEKEBL4aeGXO1n5DM51QZ9
        NonJGY4yiWLO5LvP2OYV4b3RKqSqCBj7R4uUfpXzeZ15k3RtYTS5tYkYyXbZyWhM1fe+P0+RlKH
        FuJxQyxjfQSseP+9RyyCFABrj
X-Received: by 2002:a05:6512:3e06:b0:4f8:4512:c844 with SMTP id i6-20020a0565123e0600b004f84512c844mr3345566lfv.48.1691693827600;
        Thu, 10 Aug 2023 11:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjOQhPtdsz07nsN78L6/m9BnGD+oeQzzTg0A1y1+etFBqOapEHl8thpyvELgSFyQLw02rLAA==
X-Received: by 2002:a05:6512:3e06:b0:4f8:4512:c844 with SMTP id i6-20020a0565123e0600b004f84512c844mr3345550lfv.48.1691693827235;
        Thu, 10 Aug 2023 11:57:07 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7c68d000000b005231e1780aasm1116137edq.91.2023.08.10.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:57:06 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:57:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     michael.christie@oracle.com
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230810145528-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> >> For vhost workers we use the kthread API which inherit's its values from
> >> and checks against the kthreadd thread. This results in the wrong RLIMITs
> >> being checked, so while tools like libvirt try to control the number of
> >> threads based on the nproc rlimit setting we can end up creating more
> >> threads than the user wanted.
> >>
> >> This patch has us use the vhost_task helpers which will inherit its
> >> values/checks from the thread that owns the device similar to if we did
> >> a clone in userspace. The vhost threads will now be counted in the nproc
> >> rlimits. And we get features like cgroups and mm sharing automatically,
> >> so we can remove those calls.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> > Hi Mike,
> > So this seems to have caused a measureable regression in networking
> > performance (about 30%). Take a look here, and there's a zip file
> > with detailed measuraments attached:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> > 
> > 
> > Could you take a look please?
> > You can also ask reporter questions there assuming you
> > have or can create a (free) account.
> > 
> 
> Sorry for the late reply. I just got home from vacation.
> 
> The account creation link seems to be down. I keep getting a
> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
> 
> Can you give me Quan's email?
> 
> I think I can replicate the problem. I just need some extra info from Quan:
> 
> 1. Just double check that they are using RHEL 9 on the host running the VMs.
> 2. The kernel config
> 3. Any tuning that was done. Is tuned running in guest and/or host running the
> VMs and what profile is being used in each.
> 4. Number of vCPUs and virtqueues being used.
> 5. Can they dump the contents of:
> 
> /sys/kernel/debug/sched
> 
> and
> 
> sysctl  -a
> 
> on the host running the VMs.
> 
> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
> the scheduler to batch:
> 
> ps -T -o comm,pid,tid $QEMU_THREAD
> 
> then for each vhost thread do:
> 
> chrt -b -p 0 $VHOST_THREAD
> 
> Does that end up increasing perf? When I do this I see throughput go up by
> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
> It's just a difference I noticed when running some other tests.


Mike I'm unsure what to do at this point. Regressions are not nice
but if the kernel is released with the new userspace api we won't
be able to revert. So what's the plan?

-- 
MST

