Return-Path: <linux-kernel+bounces-96768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C287612D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D3281482
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263A53E17;
	Fri,  8 Mar 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjKtxVRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACB53E02
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891087; cv=none; b=ILAv4l+V6VuINgEBgFYQBeSdg+sfjq4Ua4PKJGFJOGzeiW3B7E3xFRxUuJ9NQBoCKbNx2VQPf/uB2oYF2Gni71DehsswT7WU4Gu4Fh8F/C0OAe/NUikOLfcbYnip2Cv1pSmJC2osuen6l9YqDENEs8DXPsgtD/KBPaHuTlJDRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891087; c=relaxed/simple;
	bh=dhCRHUOf+No5thmyInV2kItMPlwlkJ39kGLp27sVq+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELOZxCDlpXy2QDOZQWXQtRHG+XZ6fQ3FA6CkmXYZGOpjCRn3W5tS+ETObrRCN10RYQX+32+ZinVrQKD+dQJl8pWxKhQSWoz/7LAnR4T/oiZ1kzRuLD3LqpEOVX9yXluQOkdHJnJ4fp7HtuHhVGig6TLgHDVSaHTlb8P9MZJhtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjKtxVRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAF4C433F1;
	Fri,  8 Mar 2024 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709891085;
	bh=dhCRHUOf+No5thmyInV2kItMPlwlkJ39kGLp27sVq+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjKtxVRaIV/9UKxC/7pMrd8ucfWvFjfyVCEM2bwcSPO+4LK0Z5DboJ8GDP0K4YG+E
	 CblwNV1U9CoVUAmW0MSfaqcmTSFD0HZ5RcEBqj6w78dUmyrCMMYyPpkwYYZ95hOfow
	 5dG1EDmI7UQjmOWUP/1SEjGHictZ6OKyc3lCR0raZcaA2Hzkxn8SC7iEm7bMQ5fnhi
	 /Ih4g/5W8crbOh1hrj95YHEdBzEjp6H1BfQ42Pzt7ev7F/wZPkjEOzBXQ6JweAxa5M
	 wrJtwQWdjiu+Dq0BSW1Eydi5jz7KvViG56q50Xiw/+rics0XLW4dwlykb6KIyJBEy/
	 PQATOQe6jDERw==
Date: Fri, 8 Mar 2024 10:44:40 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: support running as a guest in a vm
Message-ID: <ZereCD7kJxP+vzHN@lpieralisi>
References: <20240307092132.943881-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307092132.943881-1-jens.wiklander@linaro.org>

On Thu, Mar 07, 2024 at 10:21:32AM +0100, Jens Wiklander wrote:
> Add support for running the driver in a guest to a hypervisor. The main
> difference is that the notification interrupt is retrieved
> with FFA_FEAT_NOTIFICATION_PENDING_INT and that
> FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.

I have a couple of questions about these changes, comments below.

> FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hypervisor has
> chosen to notify its guest of pending notifications.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/firmware/arm_ffa/driver.c | 45 ++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index f2556a8e9401..c183c7d39c0f 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -1306,17 +1306,28 @@ static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
>  	ffa_notification_info_get();
>  }
>  
> +static int ffa_get_notif_intid(int *intid)
> +{
> +	int ret;
> +
> +	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, intid, NULL);
> +	if (!ret)
> +		return 0;
> +	ret = ffa_features(FFA_FEAT_NOTIFICATION_PENDING_INT, 0, intid, NULL);
> +	if (!ret)
> +		return 0;

I think that both interrupts should be probed in eg a host and the
actions their handlers should take are different.

> +
> +	pr_err("Failed to retrieve one of scheduler Rx or notif pending interrupts\n");
> +	return ret;
> +}
> +
>  static int ffa_sched_recv_irq_map(void)
>  {
> -	int ret, irq, sr_intid;
> +	int ret, irq, intid;
>  
> -	/* The returned sr_intid is assumed to be SGI donated to NS world */
> -	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
> -	if (ret < 0) {
> -		if (ret != -EOPNOTSUPP)
> -			pr_err("Failed to retrieve scheduler Rx interrupt\n");
> +	ret = ffa_get_notif_intid(&intid);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (acpi_disabled) {
>  		struct of_phandle_args oirq = {};
> @@ -1329,12 +1340,12 @@ static int ffa_sched_recv_irq_map(void)
>  
>  		oirq.np = gic;
>  		oirq.args_count = 1;
> -		oirq.args[0] = sr_intid;
> +		oirq.args[0] = intid;
>  		irq = irq_create_of_mapping(&oirq);
>  		of_node_put(gic);
>  #ifdef CONFIG_ACPI
>  	} else {
> -		irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
> +		irq = acpi_register_gsi(NULL, intid, ACPI_EDGE_SENSITIVE,
>  					ACPI_ACTIVE_HIGH);
>  #endif

This means that for both schedule receiver interrupt and notification
pending interrupt we would end up calling FFA_NOTIFICATION_INFO_GET (?),
which is not correct AFAIK, for many reasons.

If there is a pending notification for a VM, a scheduler receiver
interrupt is triggered in the host. This would end up calling
FFA_NOTIFICATION_INFO_GET(), that is destructive (calling it again in
the notified *guest* - in the interrupt handler triggered by the
hypervisor - would not return the pending notifications for it).

Therefore, the action for the pending notification interrupt should
be different and should just call FFA_NOTIFICATION_GET.

Please let me know if that matches your understanding, this
hunk is unclear to me.

>  	}
> @@ -1442,17 +1453,15 @@ static void ffa_notifications_setup(void)
>  	int ret, irq;
>  
>  	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
> -	if (ret) {
> -		pr_info("Notifications not supported, continuing with it ..\n");
> -		return;
> -	}
> +	if (!ret) {
>  
> -	ret = ffa_notification_bitmap_create();
> -	if (ret) {
> -		pr_info("Notification bitmap create error %d\n", ret);
> -		return;
> +		ret = ffa_notification_bitmap_create();
> +		if (ret) {
> +			pr_err("notification_bitmap_create error %d\n", ret);
> +			return;
> +		}
> +		drv_info->bitmap_created = true;
>  	}
> -	drv_info->bitmap_created = true;

This boils down to saying that FFA_NOTIFICATION_BITMAP_CREATE is not
implemented for a VM (because the hypervisor should take care of issuing
that call before the VM is created), so if the feature is not present
that does not mean that notifications aren't supported.

It is just about removing a spurious log.

Is that correct ?

Thanks,
Lorenzo

>  
>  	irq = ffa_sched_recv_irq_map();
>  	if (irq <= 0) {
> -- 
> 2.34.1
> 

