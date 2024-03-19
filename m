Return-Path: <linux-kernel+bounces-107636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A187FF72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C4F283579
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F981753;
	Tue, 19 Mar 2024 14:20:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0248120F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858023; cv=none; b=h/zCBhzqsw61J4YTZLND3J/dcf+sNPKLmafvkgfdT0Tp0iMGXgaT7qYCJaqQSTx6vhg7visefcgwO7qdYsLIm+CDvKVQVEg5KJgoQIK6ZJFF1qijPC/y880RvaHJx0x60ZQuy8LKQohjxMNs1SH0UnL153ddIRdPlq5l7K1w7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858023; c=relaxed/simple;
	bh=GLbxYrXg8mXxjrmR6+SdA9SoSheCqqhGIEidBHJPmR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT/UsayvCWF7zpXAPcBskwjpyOk/rOLGA2r3Rv4uilW95A/Tu2nY1dO6Bkd1Cx36Hm8RdgWxoGxsEDB8tcTSjQpvpt56nnlHEsof3mHL3k58Ep0yIv54+YITh0bIigMGpX6PL/EwEq1Z/hNVw6bpNYD1Wrxk5ZK1UmyZEM+H8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B88A106F;
	Tue, 19 Mar 2024 07:20:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442423F762;
	Tue, 19 Mar 2024 07:20:19 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:20:16 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: support running as a guest in a vm
Message-ID: <ZfmfIN_ODYq9MvOq@bogus>
References: <20240307092132.943881-1-jens.wiklander@linaro.org>
 <ZereCD7kJxP+vzHN@lpieralisi>
 <CAHUa44Har+TLBXOgz4EqekEu7fKWgFeCuOa0i8UiNLfen4tJiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44Har+TLBXOgz4EqekEu7fKWgFeCuOa0i8UiNLfen4tJiw@mail.gmail.com>

On Fri, Mar 08, 2024 at 01:35:05PM +0100, Jens Wiklander wrote:
> On Fri, Mar 8, 2024 at 10:44 AM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >
> > On Thu, Mar 07, 2024 at 10:21:32AM +0100, Jens Wiklander wrote:
> > > Add support for running the driver in a guest to a hypervisor. The main
> > > difference is that the notification interrupt is retrieved
> > > with FFA_FEAT_NOTIFICATION_PENDING_INT and that
> > > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> >
> > I have a couple of questions about these changes, comments below.
> >
> > > FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hypervisor has
> > > chosen to notify its guest of pending notifications.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 45 ++++++++++++++++++-------------
> > >  1 file changed, 27 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > > index f2556a8e9401..c183c7d39c0f 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -1306,17 +1306,28 @@ static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
> > >       ffa_notification_info_get();
> > >  }
> > >
> > > +static int ffa_get_notif_intid(int *intid)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, intid, NULL);
> > > +     if (!ret)
> > > +             return 0;
> > > +     ret = ffa_features(FFA_FEAT_NOTIFICATION_PENDING_INT, 0, intid, NULL);
> > > +     if (!ret)
> > > +             return 0;
> >
> > I think that both interrupts should be probed in eg a host and the
> > actions their handlers should take are different.
> >

+1, I have the same opinion.

> > > +
> > > +     pr_err("Failed to retrieve one of scheduler Rx or notif pending interrupts\n");
> > > +     return ret;
> > > +}
> > > +
> > >  static int ffa_sched_recv_irq_map(void)
> > >  {
> > > -     int ret, irq, sr_intid;
> > > +     int ret, irq, intid;
> > >
> > > -     /* The returned sr_intid is assumed to be SGI donated to NS world */
> > > -     ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
> > > -     if (ret < 0) {
> > > -             if (ret != -EOPNOTSUPP)
> > > -                     pr_err("Failed to retrieve scheduler Rx interrupt\n");
> > > +     ret = ffa_get_notif_intid(&intid);
> > > +     if (ret)
> > >               return ret;
> > > -     }
> > >
> > >       if (acpi_disabled) {
> > >               struct of_phandle_args oirq = {};
> > > @@ -1329,12 +1340,12 @@ static int ffa_sched_recv_irq_map(void)
> > >
> > >               oirq.np = gic;
> > >               oirq.args_count = 1;
> > > -             oirq.args[0] = sr_intid;
> > > +             oirq.args[0] = intid;
> > >               irq = irq_create_of_mapping(&oirq);
> > >               of_node_put(gic);
> > >  #ifdef CONFIG_ACPI
> > >       } else {
> > > -             irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
> > > +             irq = acpi_register_gsi(NULL, intid, ACPI_EDGE_SENSITIVE,
> > >                                       ACPI_ACTIVE_HIGH);
> > >  #endif
> >
> > This means that for both schedule receiver interrupt and notification
> > pending interrupt we would end up calling FFA_NOTIFICATION_INFO_GET (?),
> > which is not correct AFAIK, for many reasons.
> >
> > If there is a pending notification for a VM, a scheduler receiver
> > interrupt is triggered in the host. This would end up calling
> > FFA_NOTIFICATION_INFO_GET(), that is destructive (calling it again in
> > the notified *guest* - in the interrupt handler triggered by the
> > hypervisor - would not return the pending notifications for it).
> >
> > Therefore, the action for the pending notification interrupt should
> > be different and should just call FFA_NOTIFICATION_GET.
> >
> > Please let me know if that matches your understanding, this
> > hunk is unclear to me.

As you can expect, the above matches my understanding too.

>
> This patch was made from the assumption that this FF-A driver is a
> guest driver, that is, FFA_NOTIFICATION_INFO_GET lands in the
> Hypervisor at EL2. The FFA_NOTIFICATION_INFO_GET call is needed to
> know which FFA_NOTIFICATION_GET calls should be dispatched in this VM,
> to retrieve global notifications and per vCPU notifications.
>

OK and I assume this aligns with the below excerpts from the spec about
FFA_NOTIFICATION_INFO_GET:
"
This ABI is invoked by a VM at the Non-secure virtual FF-A instance with the
SMC or HVC conduits to request the Hypervisor to return the list of SPs and
VMs that have pending notifications. The Hypervisor returns the list of those
endpoints whose schedulers are implemented in the calling VM.
"

But if OPTEE driver in the VM/guest is the scheduler for the OPTEE SP,
then I would expect the FF-A driver to just register for SRI. It can't be
NPI as that contradicts with above.

> If the FF-A driver is supposed to be a host driver instead, then I
> wonder where we should have the guest driver.
>

At least so far we haven't found a strong reason to have different versions
for each.

> For clarification, my setup has Xen as hypervisor at EL2 (doing the
> host processing), TF-A as SPMD at EL3, and OP-TEE as SPMC at S-EL1.
> I'm testing this on QEMU. I'm going to post the Xen patches relating
> to this quite soon.
>

OK, thanks for the setup info.

> I believe that until now the FF-A driver has worked under the
> assumption that it's a non-secure physical FF-A instance. With
> hypervisor at EL2 it becomes a virtual FF-A instance.
>

Agreed.

> >
> > >       }
> > > @@ -1442,17 +1453,15 @@ static void ffa_notifications_setup(void)
> > >       int ret, irq;
> > >
> > >       ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
> > > -     if (ret) {
> > > -             pr_info("Notifications not supported, continuing with it ..\n");
> > > -             return;
> > > -     }
> > > +     if (!ret) {
> > >
> > > -     ret = ffa_notification_bitmap_create();
> > > -     if (ret) {
> > > -             pr_info("Notification bitmap create error %d\n", ret);
> > > -             return;
> > > +             ret = ffa_notification_bitmap_create();
> > > +             if (ret) {
> > > +                     pr_err("notification_bitmap_create error %d\n", ret);
> > > +                     return;
> > > +             }
> > > +             drv_info->bitmap_created = true;
> > >       }
> > > -     drv_info->bitmap_created = true;
> >
> > This boils down to saying that FFA_NOTIFICATION_BITMAP_CREATE is not
> > implemented for a VM (because the hypervisor should take care of issuing
> > that call before the VM is created), so if the feature is not present
> > that does not mean that notifications aren't supported.
> >
> > It is just about removing a spurious log.
> >
> > Is that correct ?
>
> No, this is about not aborting notification setup just because we have
> a hypervisor that handles the FFA_NOTIFICATION_BITMAP_CREATE call.

Understood.

> With this patch, if ffa_get_notif_intid() fails, then we don't have
> support for notifications.
>

But I still don't understand the mixup of SRI and NPI in your usecase
model. It should be just SRI. NPI handler must just use NOTIFICATION_GET
and not INFO_GET as Lorenzo has explained above.

--
Regards,
Sudeep

