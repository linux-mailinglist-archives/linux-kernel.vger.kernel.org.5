Return-Path: <linux-kernel+bounces-138592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831089F424
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1721C23780
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189F15EFD6;
	Wed, 10 Apr 2024 13:24:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EB115E7FD;
	Wed, 10 Apr 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755446; cv=none; b=Pj/pvOy8GxzMrR5yb5Z3ECKagAFsbH6hYP4K4nMAgZjpeUU5dgErz+epnhXoH4pfRFmjxS1hPICj0Pf24Ni5THZYC07lGiDzdUut4sVM2WqefP2X1bKNb3V8JRvxfoo1CEb3mIM037g9dmKI4KJkKKthOqldipQGL0Co3UDvrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755446; c=relaxed/simple;
	bh=smc0dd2Hljy1BFflS7XGq1OlXzh6nMSx794vVITK+uM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyLYDWS3oVYaFdvYuDqTElkwvUvWx1vwQtQjz4+xxQhdiXGfIKGU+kg61NpPQjmLP7aO7UnSURRpUFXUNTYqwpeTrE7IevAD0vaouHTtldPnFi9nZHophCcDvI1+Hr8Yi+TTbF7ym0MGKDK8qW8sVMR1QROQm21zFxPe1O72LIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF3Qk73l2z67G9n;
	Wed, 10 Apr 2024 21:22:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CB063140CF4;
	Wed, 10 Apr 2024 21:24:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:24:00 +0100
Date: Wed, 10 Apr 2024 14:23:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Message-ID: <20240410142359.00003dea@Huawei.com>
In-Reply-To: <20240409150536.9933-4-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-4-miguel.luis@oracle.com>
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

On Tue,  9 Apr 2024 15:05:32 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> mapping and unmaping a cpu at the stage of extra cpu enumeration is
> architecture specific which depends on CONFIG_ACPI_HOTPLUG_CPU so let's
> isolate that functionality from architecture independent one.

Should we consider renaming acpi_map_cpu() to arch_acpi_map_cpu()
to make the arch specific nature of that call more obvious?
I think that has caused more confusion in the discussion than
whether it is hotplug specific or not.

As mentioned in patch 2, fairly sure this needs to go before that
patch.

Jonathan

> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  drivers/acpi/acpi_processor.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 9ea58b61d741..c6e2f64a056b 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -194,8 +194,21 @@ static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr)
>  	pr_info("CPU%d has been hot-added\n", pr->id);
>  	pr->flags.need_hotplug_init = 1;
>  }
> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> +{
> +	return acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> +}
> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *pr)
> +{
> +	acpi_unmap_cpu(pr->id);
> +}
>  #else
>  static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr) {}
> +static int acpi_processor_hotplug_map_cpu(struct acpi_processor *pr)
> +{
> +	return 0;
> +}
> +static void acpi_processor_hotplug_unmap_cpu(struct acpi_processor *pr) {}
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
>  /* Enumerate extra CPUs */
> @@ -215,13 +228,13 @@ static int acpi_processor_enumerate_extra(struct acpi_processor *pr)
>  	cpu_maps_update_begin();
>  	cpus_write_lock();
>  
> -	ret = acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
> +	ret = acpi_processor_hotplug_map_cpu(pr);
>  	if (ret)
>  		goto out;
>  
>  	ret = arch_register_cpu(pr->id);
>  	if (ret) {
> -		acpi_unmap_cpu(pr->id);
> +		acpi_processor_hotplug_unmap_cpu(pr);
>  		goto out;
>  	}
>  


