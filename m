Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C479D5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjILQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjILQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:06:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0B6B10DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:06:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D056DC15;
        Tue, 12 Sep 2023 09:07:15 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A142C3F738;
        Tue, 12 Sep 2023 09:06:37 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:06:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH RFT 08/12] firmware: arm_ffa: Initial support for
 scheduler receiver interrupt
Message-ID: <20230912160634.lvaq5s5frx6ju2hs@bogus>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
 <20230803-ffa_v1-1_notif-v1-8-6613ff2b1f81@arm.com>
 <20230912134104.GC4160483@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912134104.GC4160483@rayden>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:41:04PM +0200, Jens Wiklander wrote:
> Hi Sudeep,
> 
> On Thu, Aug 03, 2023 at 08:02:12PM +0100, Sudeep Holla wrote:
> > The Framework uses the schedule receiver interrupt to inform the
> > receiver’s scheduler that the receiver must be run to handle a pending
> > notification. A receiver’s scheduler can obtain the description of the
> > schedule receiver interrupt by invoking the FFA_FEATURES interface.
> > 
> > The delivery of the physical schedule receiver interrupt from the secure
> > state to the non-secure state depends upon the state of the interrupt
> > controller as configured by the hypervisor.
> > 
> > The schedule seceiver interrupt is assumed to be a PPI. The Arm GIC
> > specification defines 16 SGIs. It recommends that they are equally
> > divided between the non-secure and secure states. OS like Linux kernel
> > in the non-secure state typically do not have SGIs to spare. The usage
> > of SGIs in the secure state is however limited. It is more likely that
> > software in the Secure world does not use all the SGIs allocated to it.
> > 
> > It is recommended that the secure world software donates an unused SGI
> > to the normal world for use as the schedule receiver interrupt. This
> > implies that secure world software must configure the SGI in the GIC
> > as a non-secure interrupt before presenting it to the normal world.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 183 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 175 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 77ca9753e3f0..84c934a0ec14 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -22,15 +22,20 @@
> >  #define DRIVER_NAME "ARM FF-A"
> >  #define pr_fmt(fmt) DRIVER_NAME ": " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/arm_ffa.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/cpuhotplug.h>
> >  #include <linux/device.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/mm.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/slab.h>
> > +#include <linux/smp.h>
> >  #include <linux/uuid.h>
> >  
> >  #include "common.h"
> > @@ -76,6 +81,10 @@ static inline int ffa_to_linux_errno(int errno)
> >  	return -EINVAL;
> >  }
> >  
> > +struct ffa_pcpu_irq {
> > +	struct ffa_drv_info *info;
> > +};
> > +
> >  struct ffa_drv_info {
> >  	u32 version;
> >  	u16 vm_id;
> > @@ -85,6 +94,12 @@ struct ffa_drv_info {
> >  	void *tx_buffer;
> >  	bool mem_ops_native;
> >  	bool bitmap_created;
> > +	unsigned int sched_recv_irq;
> > +	unsigned int cpuhp_state;
> > +	struct ffa_pcpu_irq __percpu *irq_pcpu;
> > +	struct workqueue_struct *notif_pcpu_wq;
> > +	struct work_struct irq_work;
> > +	bool info_get_64b;
> >  };
> >  
> >  static struct ffa_drv_info *drv_info;
> > @@ -910,9 +925,147 @@ static void ffa_setup_partitions(void)
> >  	kfree(pbuf);
> >  }
> >  
> > +/* FFA FEATURE IDs */
> > +#define FFA_FEAT_NOTIFICATION_PENDING_INT	(1)
> > +#define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)
> > +#define FFA_FEAT_MANAGED_EXIT_INT		(3)
> > +
> > +static irqreturn_t irq_handler(int irq, void *irq_data)
> > +{
> > +	struct ffa_pcpu_irq *pcpu = irq_data;
> > +	struct ffa_drv_info *info = pcpu->info;
> > +
> > +	queue_work(info->notif_pcpu_wq, &info->irq_work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
> > +{
> > +	struct ffa_drv_info *info = container_of(work, struct ffa_drv_info,
> > +						 irq_work);
> > +
> > +	ffa_notification_info_get(info->info_get_64b);
> > +}
> > +
> > +static int ffa_sched_recv_irq_map(void)
> > +{
> > +	int ret, irq, sr_intid;
> > +
> > +	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
> > +	if (ret < 0) {
> > +		if (ret != -EOPNOTSUPP)
> > +			pr_err("Failed to retrieve scheduler Rx interrupt\n");
> > +		return ret;
> > +	}
> > +
> > +	if (acpi_disabled) {
> > +		struct of_phandle_args oirq = {};
> > +		struct device_node *gic;
> > +
> > +		gic = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> 
> "arm,gic-v3" might be good enough for now, but eventually we may need more scalable probing.
> 
> > +		if (!gic)
> > +			return -ENXIO;
> > +
> > +		oirq.np = gic;
> > +		oirq.args_count = 1;
> > +		oirq.args[0] = sr_intid;
> > +		irq = irq_create_of_mapping(&oirq);
> 
> You mention (or try to ;-)) in the commit message that SGIs only are
> assumed for now. A comment here stating that fact wouldn't hurt.
>

Fair enough, I will add.

> I'm trying to test this on QEMU, but I can't seem to recieve the SGI in
> the kernel. I've donated the previously secure SGI-8 at boot (simple
> patch in TF-A) before the kernel starts. I've verified with GDB that
> QEMU has accepted the write to ICC_ASGI1R_EL1 while in secure world, but
> it seems it never triggers when switching back to normal world. I'm
> starting to suspect that irq_create_of_mapping() might not update SGI-8
> properly. Perhaps something more is needed when donating SGI-8 on the
> kernel side.
> 
> Did you have this working in your tests?

Nope, I haven't been able to get a working end-to-end stack and hence RFT.
However I had tried to test just the SGI part but did have some hacks which
I have lost. I wanted to check if those changes were just for my testing or
is indeed needed in the kernel. I will try to dig more details.

-- 
Regards,
Sudeep
