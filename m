Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435179D287
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjILNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjILNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:41:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A290210D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:41:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so9248239e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694526067; x=1695130867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EyBoKrrgVqVxJWLjv8x5ZZvGhoL5wahDhw68BgqSFMw=;
        b=Tp1CGVjZM3r0EXxTfv7vkiXBUxkCuxQwY4zKa7svZ4uyt4ZF+bzzslpN7O5Vw1k+n3
         /izqSAxlIirQlYxhTZJELfj0V2+nhctbHqNq3eeeval9ZZFQXJFMZZy3tXgMoGpHWSoi
         pPAR3zCjpi4p+5h1wqBR3e0B2Tf4MYVIGS9eurF+mzzU9H7guZlWY4S4ba2m9pzqn5sv
         9FOC1rBp/3JQ6wUEZzoO22OYdHSWYQeOWGkT/IqjryMqoNUDwvDToKwB38P9TTjwhFBF
         JmN8Fx0CCsEkRzpElFHVDu+lIdO66LnSO0GGvWTNLWlpg8W/AIzu0ZMTZGE6LjUKW7Vv
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526067; x=1695130867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyBoKrrgVqVxJWLjv8x5ZZvGhoL5wahDhw68BgqSFMw=;
        b=khVaqm+PMs+V0ws0VaRROfod0mZ7D8QJaLYa1K7a+bc1fN8pJcZUAN4QFkJsets0Z7
         3F8wnslWPR5jSEHEp7bmBc0LPSntj6U5K9P9aWaB+fwin3OVjKBVVab4GcPZ2IMOCbg1
         moqCU8ZHYs2Ttw66PMRZ9IsTK409ba/mHgp7xyqtZm/o6H1YLvY69V6Ka1ENz9yLaJLs
         kQe0odTVT37FChBFqxqyjwfwGJOHxOP18z9nZd4DAJL3E5My13Ht6xBRy6RGdVnsu6bj
         muXJD2whVHn0GWi6abQ3nYWVWzv9fULqBDazbXhUXx+KPl2FX6VAHk9b+kHcqJKbg0EK
         YDpg==
X-Gm-Message-State: AOJu0YwYuRn0AJitlEMgpDvVO/GAoqHsYQyvZ5IqojyQlFt/vYgRyTPN
        nd44ytaAnBs1I0cuBPsPd7jeNZYH16kS8cq2eIU=
X-Google-Smtp-Source: AGHT+IEpthUtIkT6CfVIvWC1etoTQnQaLox/Jk17XoBtwp+G8BuBcY1bcUkngFzkBmjMb5Vk9jjwAw==
X-Received: by 2002:a05:6512:3eb:b0:500:9214:b308 with SMTP id n11-20020a05651203eb00b005009214b308mr9028699lfq.65.1694526066722;
        Tue, 12 Sep 2023 06:41:06 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id r5-20020a19ac45000000b00501c673e773sm1720905lfc.39.2023.09.12.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:41:06 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:41:04 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH RFT 08/12] firmware: arm_ffa: Initial support for
 scheduler receiver interrupt
Message-ID: <20230912134104.GC4160483@rayden>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
 <20230803-ffa_v1-1_notif-v1-8-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803-ffa_v1-1_notif-v1-8-6613ff2b1f81@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Thu, Aug 03, 2023 at 08:02:12PM +0100, Sudeep Holla wrote:
> The Framework uses the schedule receiver interrupt to inform the
> receiver’s scheduler that the receiver must be run to handle a pending
> notification. A receiver’s scheduler can obtain the description of the
> schedule receiver interrupt by invoking the FFA_FEATURES interface.
> 
> The delivery of the physical schedule receiver interrupt from the secure
> state to the non-secure state depends upon the state of the interrupt
> controller as configured by the hypervisor.
> 
> The schedule seceiver interrupt is assumed to be a PPI. The Arm GIC
> specification defines 16 SGIs. It recommends that they are equally
> divided between the non-secure and secure states. OS like Linux kernel
> in the non-secure state typically do not have SGIs to spare. The usage
> of SGIs in the secure state is however limited. It is more likely that
> software in the Secure world does not use all the SGIs allocated to it.
> 
> It is recommended that the secure world software donates an unused SGI
> to the normal world for use as the schedule receiver interrupt. This
> implies that secure world software must configure the SGI in the GIC
> as a non-secure interrupt before presenting it to the normal world.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 183 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 175 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 77ca9753e3f0..84c934a0ec14 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -22,15 +22,20 @@
>  #define DRIVER_NAME "ARM FF-A"
>  #define pr_fmt(fmt) DRIVER_NAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/arm_ffa.h>
>  #include <linux/bitfield.h>
> +#include <linux/cpuhotplug.h>
>  #include <linux/device.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> +#include <linux/of_irq.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/smp.h>
>  #include <linux/uuid.h>
>  
>  #include "common.h"
> @@ -76,6 +81,10 @@ static inline int ffa_to_linux_errno(int errno)
>  	return -EINVAL;
>  }
>  
> +struct ffa_pcpu_irq {
> +	struct ffa_drv_info *info;
> +};
> +
>  struct ffa_drv_info {
>  	u32 version;
>  	u16 vm_id;
> @@ -85,6 +94,12 @@ struct ffa_drv_info {
>  	void *tx_buffer;
>  	bool mem_ops_native;
>  	bool bitmap_created;
> +	unsigned int sched_recv_irq;
> +	unsigned int cpuhp_state;
> +	struct ffa_pcpu_irq __percpu *irq_pcpu;
> +	struct workqueue_struct *notif_pcpu_wq;
> +	struct work_struct irq_work;
> +	bool info_get_64b;
>  };
>  
>  static struct ffa_drv_info *drv_info;
> @@ -910,9 +925,147 @@ static void ffa_setup_partitions(void)
>  	kfree(pbuf);
>  }
>  
> +/* FFA FEATURE IDs */
> +#define FFA_FEAT_NOTIFICATION_PENDING_INT	(1)
> +#define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)
> +#define FFA_FEAT_MANAGED_EXIT_INT		(3)
> +
> +static irqreturn_t irq_handler(int irq, void *irq_data)
> +{
> +	struct ffa_pcpu_irq *pcpu = irq_data;
> +	struct ffa_drv_info *info = pcpu->info;
> +
> +	queue_work(info->notif_pcpu_wq, &info->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
> +{
> +	struct ffa_drv_info *info = container_of(work, struct ffa_drv_info,
> +						 irq_work);
> +
> +	ffa_notification_info_get(info->info_get_64b);
> +}
> +
> +static int ffa_sched_recv_irq_map(void)
> +{
> +	int ret, irq, sr_intid;
> +
> +	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
> +	if (ret < 0) {
> +		if (ret != -EOPNOTSUPP)
> +			pr_err("Failed to retrieve scheduler Rx interrupt\n");
> +		return ret;
> +	}
> +
> +	if (acpi_disabled) {
> +		struct of_phandle_args oirq = {};
> +		struct device_node *gic;
> +
> +		gic = of_find_compatible_node(NULL, NULL, "arm,gic-v3");

"arm,gic-v3" might be good enough for now, but eventually we may need more scalable probing.

> +		if (!gic)
> +			return -ENXIO;
> +
> +		oirq.np = gic;
> +		oirq.args_count = 1;
> +		oirq.args[0] = sr_intid;
> +		irq = irq_create_of_mapping(&oirq);

You mention (or try to ;-)) in the commit message that SGIs only are
assumed for now. A comment here stating that fact wouldn't hurt.

I'm trying to test this on QEMU, but I can't seem to recieve the SGI in
the kernel. I've donated the previously secure SGI-8 at boot (simple
patch in TF-A) before the kernel starts. I've verified with GDB that
QEMU has accepted the write to ICC_ASGI1R_EL1 while in secure world, but
it seems it never triggers when switching back to normal world. I'm
starting to suspect that irq_create_of_mapping() might not update SGI-8
properly. Perhaps something more is needed when donating SGI-8 on the
kernel side.

Did you have this working in your tests?

Cheers,
Jens


> +		of_node_put(gic);
> +	} else {
> +		irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
> +					ACPI_ACTIVE_HIGH);
> +	}
> +
> +	if (irq <= 0) {
> +		pr_err("Failed to create IRQ mapping!\n");
> +		return -ENODATA;
> +	}
> +
> +	return irq;
> +}
> +
> +static void ffa_sched_recv_irq_unmap(void)
> +{
> +	if (drv_info->sched_recv_irq)
> +		irq_dispose_mapping(drv_info->sched_recv_irq);
> +}
> +
> +static int ffa_cpuhp_pcpu_irq_enable(unsigned int cpu)
> +{
> +	enable_percpu_irq(drv_info->sched_recv_irq, IRQ_TYPE_NONE);
> +	return 0;
> +}
> +
> +static int ffa_cpuhp_pcpu_irq_disable(unsigned int cpu)
> +{
> +	disable_percpu_irq(drv_info->sched_recv_irq);
> +	return 0;
> +}
> +
> +static void ffa_uninit_pcpu_irq(void)
> +{
> +	if (drv_info->cpuhp_state)
> +		cpuhp_remove_state(drv_info->cpuhp_state);
> +
> +	if (drv_info->notif_pcpu_wq)
> +		destroy_workqueue(drv_info->notif_pcpu_wq);
> +
> +	if (drv_info->sched_recv_irq)
> +		free_percpu_irq(drv_info->sched_recv_irq, drv_info->irq_pcpu);
> +
> +	if (drv_info->irq_pcpu)
> +		free_percpu(drv_info->irq_pcpu);
> +}
> +
> +static int ffa_init_pcpu_irq(unsigned int irq)
> +{
> +	struct ffa_pcpu_irq __percpu *irq_pcpu;
> +	int ret, cpu;
> +
> +	irq_pcpu = alloc_percpu(struct ffa_pcpu_irq);
> +	if (!irq_pcpu)
> +		return -ENOMEM;
> +
> +	for_each_present_cpu(cpu)
> +		per_cpu_ptr(irq_pcpu, cpu)->info = drv_info;
> +
> +	drv_info->irq_pcpu = irq_pcpu;
> +
> +	ret = request_percpu_irq(irq, irq_handler, "ARM-FFA", irq_pcpu);
> +	if (ret) {
> +		pr_err("Error registering notification IRQ %d: %d\n", irq, ret);
> +		return ret;
> +	}
> +
> +	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
> +	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
> +	if (!drv_info->notif_pcpu_wq)
> +		return -EINVAL;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "ffa/pcpu-irq:starting",
> +				ffa_cpuhp_pcpu_irq_enable,
> +				ffa_cpuhp_pcpu_irq_disable);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	drv_info->cpuhp_state = ret;
> +	return 0;
> +}
> +
> +static void ffa_notifications_cleanup(void)
> +{
> +	ffa_uninit_pcpu_irq();
> +	ffa_sched_recv_irq_unmap();
> +
> +	if (drv_info->bitmap_created)
> +		ffa_notification_bitmap_destroy();
> +}
> +
>  static int ffa_notifications_setup(void)
>  {
> -	int ret;
> +	int ret, irq;
>  
>  	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
>  	if (!ret) {
> @@ -924,13 +1077,23 @@ static int ffa_notifications_setup(void)
>  	}
>  	drv_info->bitmap_created = true;
>  
> -	return 0;
> -}
> +	irq = ffa_sched_recv_irq_map();
> +	if (irq <= 0)
> +		goto cleanup;
>  
> -static void ffa_notifications_cleanup(void)
> -{
> -	if (drv_info->bitmap_created)
> -		ffa_notification_bitmap_destroy();
> +	if (FFA_FN_NATIVE(NOTIFICATION_INFO_GET) ==
> +		FFA_FN64_NOTIFICATION_INFO_GET)
> +		drv_info->info_get_64b = true;
> +
> +	ret = ffa_init_pcpu_irq(irq);
> +	if (ret)
> +		goto cleanup;
> +
> +	drv_info->sched_recv_irq = irq;
> +	return 0;
> +cleanup:
> +	ffa_notifications_cleanup();
> +	return ret;
>  }
>  
>  static int __init ffa_init(void)
> @@ -988,7 +1151,11 @@ static int __init ffa_init(void)
>  
>  	ffa_set_up_mem_ops_native_flag();
>  
> -	return ffa_notifications_setup();
> +	ret = ffa_notifications_setup();
> +	if (ret)
> +		goto free_pages;
> +
> +	return 0;
>  free_pages:
>  	if (drv_info->tx_buffer)
>  		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
> 
> -- 
> 2.41.0
> 
