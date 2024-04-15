Return-Path: <linux-kernel+bounces-145887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4E8A5C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85071C21ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B12156893;
	Mon, 15 Apr 2024 20:45:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806815696D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213933; cv=none; b=Gq0k0Ld9Sz6XqbXirt3pDWtetT9mBEgcwx0J2OG3/UePYHL4UWgSwFv3MclJKZDAVrYWscg7i4KhonFzNDwcW/cJOZFFyXyqPFKV81eIN9q1dfQPoJVX44ZPFgBRdRZOJ3eUknkEQhc+fGh89/VVqEj7NiItL456FxW4zeXncZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213933; c=relaxed/simple;
	bh=+/0jeKaYaUP3m3VXXQbnAijrqhupY0+Ukk/QTQkBTqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr45/shI8LkloZBWPA9KWcLXyyYcA09QbGBQrMrJ/DSQ7ZkVyQBbK2yKHO/gKP3FZ5T34Lmx61vX3b/gFLxt/y2EU2HsTeYiGPyieZ+iOlGMzaGiDU6QqRYaQHmkEKnbC/L7FV3L3XTPVMyRIOpSsd+4udTsvipVzrd692ace2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69FFF2F4;
	Mon, 15 Apr 2024 13:45:52 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0B583F738;
	Mon, 15 Apr 2024 13:45:22 -0700 (PDT)
Date: Mon, 15 Apr 2024 21:45:20 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Message-ID: <Zh2R4FZPmVOigfT9@pluto>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415101141.1591112-1-peng.fan@oss.nxp.com>

On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Support System suspend notification. Using a work struct to call
> pm_suspend. There is no way to pass suspend level to pm_suspend,
> so use MEM as of now.
> 

Hi Peng,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/scmi_power_control.c    | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

This LGTM in general, the only obsservation here is that while on
shutdown by issuing a orderly_reboot() we in fact ask PID_1 to start a
shutdown from userspace, when triggering a system suspend with pm_suspend()
we do not involve userspace in the process, but I dont think there is another
way indeed.

Thanks,
Cristian

> diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
> index 6eb7d2a4b6b1..beafca9957c7 100644
> --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> @@ -50,6 +50,7 @@
>  #include <linux/reboot.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/time64.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
> @@ -90,6 +91,7 @@ struct scmi_syspower_conf {
>  	struct notifier_block reboot_nb;
>  
>  	struct delayed_work forceful_work;
> +	struct work_struct suspend_work;
>  };
>  
>  #define userspace_nb_to_sconf(x)	\
> @@ -249,6 +251,9 @@ static void scmi_request_graceful_transition(struct scmi_syspower_conf *sc,
>  	case SCMI_SYSTEM_WARMRESET:
>  		orderly_reboot();
>  		break;
> +	case SCMI_SYSTEM_SUSPEND:
> +		schedule_work(&sc->suspend_work);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -277,7 +282,8 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
>  	struct scmi_system_power_state_notifier_report *er = data;
>  	struct scmi_syspower_conf *sc = userspace_nb_to_sconf(nb);
>  
> -	if (er->system_state >= SCMI_SYSTEM_POWERUP) {
> +	if (er->system_state >= SCMI_SYSTEM_MAX ||
> +	    er->system_state == SCMI_SYSTEM_POWERUP) {
>  		dev_err(sc->dev, "Ignoring unsupported system_state: 0x%X\n",
>  			er->system_state);
>  		return NOTIFY_DONE;
> @@ -315,6 +321,16 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void scmi_suspend_work_func(struct work_struct *work)
> +{
> +	struct scmi_syspower_conf *sc =
> +		container_of(work, struct scmi_syspower_conf, suspend_work);
> +
> +	pm_suspend(PM_SUSPEND_MEM);
> +
> +	sc->state = SCMI_SYSPOWER_IDLE;
> +}
> +
>  static int scmi_syspower_probe(struct scmi_device *sdev)
>  {
>  	int ret;
> @@ -338,6 +354,8 @@ static int scmi_syspower_probe(struct scmi_device *sdev)
>  	sc->userspace_nb.notifier_call = &scmi_userspace_notifier;
>  	sc->dev = &sdev->dev;
>  
> +	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
> +
>  	return handle->notify_ops->devm_event_notifier_register(sdev,
>  							   SCMI_PROTOCOL_SYSTEM,
>  					 SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
> -- 
> 2.37.1
> 

