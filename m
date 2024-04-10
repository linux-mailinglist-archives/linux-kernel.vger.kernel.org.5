Return-Path: <linux-kernel+bounces-138606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5789F452
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4681C203F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A915ECEB;
	Wed, 10 Apr 2024 13:31:08 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F7158D76;
	Wed, 10 Apr 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755868; cv=none; b=ue7gTIxzsXlJVNTj4yz5R1JS8tYvyDlLUM2CxVvMpIYtyYUBfLGL23WqGlRUP97D+mbkuBUm4syxDyBTlB44NK7WoSomIugJIqpAQUuGaNlQmXoxrQoUScAD1HBCAsXVB+ZFKo1ddF3LiJytNbiH98auNs6M/Ngh3l5KFI4OR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755868; c=relaxed/simple;
	bh=T81nWrifqkrF1jPgKRiL81vtI/6DX3N2s7ITSs9oN0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwweA1rqUuIWdkUGO8NMREGxSv/3cIguqtnzkxyXl3etN89OnYVQCJYVyGQPUdDXGHx7CHDdZJejZEgZGpw7/ZcCIlR8Ahzy+KPCupARGz1c1UMOYnPYTcQZoqg8uvY5vdXM5YTyie8END4GeYgVQGhqts8ppsE2vYmdEDeD4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF3WC2Z6Bz6K7FW;
	Wed, 10 Apr 2024 21:26:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E091400CA;
	Wed, 10 Apr 2024 21:31:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:31:02 +0100
Date: Wed, 10 Apr 2024 14:31:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 4/4] ACPI: processor: refactor
 acpi_processor_remove: isolate acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
Message-ID: <20240410143101.00001f5a@Huawei.com>
In-Reply-To: <20240409150536.9933-5-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-5-miguel.luis@oracle.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  9 Apr 2024 15:05:33 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> acpi_unmap_cpu is architecture dependent. Isolate it.
> The pre-processor guard for detach may now be restricted to
> cpu unmap.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Again the why question isn't answered by the patch description.

I assume this is to try and resolve the remove question of releasing
resources that was outstanding on vCPU HP v4 series Russell posted.

I've not looked as closely at the remove path as the add one yet, but
my gut feeling is same issue applies.
This code that runs in here should not be dependent on whether
CONFIG_ACPI_HOTPLUG_CPU is enabled or not.  What we do for the
make disabled flow should not run a few of the steps in 
acpi_processor_remove() we should make that clear by calling
a different function that doesn't have those steps.

> ---
>  drivers/acpi/acpi_processor.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c6e2f64a056b..edcd6a8d4735 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -492,6 +492,14 @@ static int acpi_processor_add(struct acpi_device *device,
>  }
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr)
> +{
> +	acpi_unmap_cpu(pr->id);
> +}
> +#else
> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr) {}
> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
>  /* Removal */
>  static void acpi_processor_remove(struct acpi_device *device)
>  {
> @@ -524,7 +532,7 @@ static void acpi_processor_remove(struct acpi_device *device)
>  
>  	/* Remove the CPU. */
>  	arch_unregister_cpu(pr->id);
> -	acpi_unmap_cpu(pr->id);
> +	acpi_processor_hotunplug_unmap_cpu(pr);
>  
>  	cpus_write_unlock();
>  	cpu_maps_update_done();
> @@ -535,7 +543,6 @@ static void acpi_processor_remove(struct acpi_device *device)
>  	free_cpumask_var(pr->throttling.shared_cpu_map);
>  	kfree(pr);
>  }
> -#endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>  bool __init processor_physically_present(acpi_handle handle)
> @@ -660,9 +667,7 @@ static const struct acpi_device_id processor_device_ids[] = {
>  static struct acpi_scan_handler processor_handler = {
>  	.ids = processor_device_ids,
>  	.attach = acpi_processor_add,
> -#ifdef CONFIG_ACPI_HOTPLUG_CPU
>  	.detach = acpi_processor_remove,
> -#endif
>  	.hotplug = {
>  		.enabled = true,
>  	},


