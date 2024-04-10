Return-Path: <linux-kernel+bounces-138589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0989F41B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB44285B75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51A16DEA5;
	Wed, 10 Apr 2024 13:20:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061C16D9CE;
	Wed, 10 Apr 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755238; cv=none; b=didh9KUjKJsHqUYTNo9cTSewsSWXWuaEFzBN/vncvUxTrcR+jrx1q5ZwtiYXovjinraVA9/SQljZpsJf5nW8ivVRJmn9afeY9a0o+X4IdYMO8c8FgFIk8BmQ0yNyjJ0L4iBLBWUQ8FcUyCyz8RzCA1MyORobpiqIwhVvlpdYxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755238; c=relaxed/simple;
	bh=Ah83pRPX1XJc0PtJx8IWGwWChbeBm2MlPW3n6CYktTM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQGZa/mHlNZC3ybP1CR2dQDOWa/RazyBbUFvhgll6mdpozL612VWs9u2g1AuJrNU5wFeu7JQkJEaUWlse+/OGU+06SiGsqKfgPWnn+zonfJoPqW4c4RwHsetUxvDLd7B/xLV2/QI8uKS9DtfWd6sQkezjl7TrWovyATz4Uo9aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF3H56Kpyz6K7JW;
	Wed, 10 Apr 2024 21:15:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 43B4A1400CA;
	Wed, 10 Apr 2024 21:20:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:20:32 +0100
Date: Wed, 10 Apr 2024 14:20:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate cpu hotpug init delay
Message-ID: <20240410142031.00007036@Huawei.com>
In-Reply-To: <20240409150536.9933-3-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-3-miguel.luis@oracle.com>
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

On Tue,  9 Apr 2024 15:05:31 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Delaying a hotplugged CPU initialization depends on
> CONFIG_ACPI_HOTPLUG_CPU. Isolate that.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>

Again, needs more explanation. Post the full set with the v4 vCPU
HP patches on top of this so we can see how it is used.

I guess the aim here is to share the bulk of this code between
the present and enabled paths? Whilst I think they should look
more similar actual code sharing seems like a bad idea for a
couple of reasons.

Imagine an arch that supports both present and enabled setting (so vCPU HP and
CPU HP) on that this function will be defined but will not be the right
thing to do for vCPU HP.  Note that in theory this is true of x86 but no one
has added support for the 'online capable bit' yet.

The impression for the _present() path will be that acpi_process_hotplug_delay_init()
should be called, and that's not true.  That should be obvious in the code
not hidden behind a stubbed out function.

Finally, you've pulled acpi_process_enumearte_extra out of the CONFIG_ACPI_HOTPLUG_CPU
block and I'm fairly sure it still has acpi_map_cpu() calls which aren't
defined yet for now ACPI_HOTPLUG_CPU configs.

Jonathan

> ---
>  drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 37e8b69113dd..9ea58b61d741 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -184,7 +184,22 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>  
>  /* Initialization */
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr)
> +{
> +	/*
> +	 * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
> +	 * to delay cpu_idle/throttling initialization and do it when the CPU
> +	 * gets online for the first time.
> +	 */
> +	pr_info("CPU%d has been hot-added\n", pr->id);
> +	pr->flags.need_hotplug_init = 1;
> +}
> +#else
> +static void acpi_processor_hotplug_delay_init(struct acpi_processor *pr) {}
> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +/* Enumerate extra CPUs */
> +static int acpi_processor_enumerate_extra(struct acpi_processor *pr)
>  {
>  	unsigned long long sta;
>  	acpi_status status;
> @@ -210,25 +225,12 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  		goto out;
>  	}
>  
> -	/*
> -	 * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
> -	 * to delay cpu_idle/throttling initialization and do it when the CPU
> -	 * gets online for the first time.
> -	 */
> -	pr_info("CPU%d has been hot-added\n", pr->id);
> -	pr->flags.need_hotplug_init = 1;
> -
> +	acpi_processor_hotplug_delay_init(pr);
>  out:
>  	cpus_write_unlock();
>  	cpu_maps_update_done();
>  	return ret;
>  }
> -#else
> -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> -{
> -	return -ENODEV;
> -}
> -#endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
>  static int acpi_evaluate_processor(struct acpi_device *device,
>  				   struct acpi_processor *pr,
> @@ -347,7 +349,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 *  because cpuid <-> apicid mapping is persistent now.
>  	 */
>  	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> -		int ret = acpi_processor_hotadd_init(pr);
> +		int ret = acpi_processor_enumerate_extra(pr);
>  
>  		if (ret)
>  			return ret;


