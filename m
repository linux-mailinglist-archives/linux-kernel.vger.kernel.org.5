Return-Path: <linux-kernel+bounces-138567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEF89F3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B428D68D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD64515E213;
	Wed, 10 Apr 2024 13:13:27 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D813D2BC;
	Wed, 10 Apr 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754807; cv=none; b=E07/qNxY+H/zNX4HxsWQMXbneMSAzbXSu3k1aaxKXN0dBX70Cyk8b24d1Dy1Rzdw+MPU0ttEqK8eJ6beNUiX/jW8n61HJZgNqkrYLUwAV+LYIZCsEXW2EdB1DHpX0ScqVd7Vihm3I3m/ncwCT9JCpmwi2Z9mpmNWbua9nJy3U5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754807; c=relaxed/simple;
	bh=/KPq2zgQ/ewuOwgYMo/IV7fAo0zdk9l7jmJKfZm3w3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3VcOUoGykpZn88pXgSICdQqZLC7M6UUJRYbDxQ+Q6SA/ordhNMW4mxD5fKGdCvQNndsrC40y0Mh8TGQbxhcan0qjUQSviNnEYECgQHFkXgN9Vq639yqm3e0G0JszkT7PebHMQs/mZl8Sw3dnmVR6FP15pa0mSm4DOYCNoRnf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF36p4gRYz6K9Jd;
	Wed, 10 Apr 2024 21:08:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 072F3140CF4;
	Wed, 10 Apr 2024 21:13:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:13:21 +0100
Date: Wed, 10 Apr 2024 14:13:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/4] ACPI: processor: refactor
 acpi_processor_get_info: evaluation of processor declaration
Message-ID: <20240410141320.00004199@Huawei.com>
In-Reply-To: <20240409150536.9933-2-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-2-miguel.luis@oracle.com>
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

On Tue,  9 Apr 2024 15:05:30 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Isolate the evaluation of processor declaration into its own function.
> 
> No functional changes.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>

Hi Miguel,

I'd like more description in each patch of 'why' the change is useful. 

A few comments inline.

Jonathan

> ---
>  drivers/acpi/acpi_processor.c | 78 +++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 7a0dd35d62c9..37e8b69113dd 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -230,15 +230,59 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  }
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
> +static int acpi_evaluate_processor(struct acpi_device *device,
> +				   struct acpi_processor *pr,
> +				   union acpi_object *object,
> +				   int *device_declaration)

I'd use a bool * for device_declaration.

> +{
> +	struct acpi_buffer buffer = { sizeof(union acpi_object), object };
> +	acpi_status status = AE_OK;

Status always written so don't initialize it.

> +	unsigned long long value;
> +
> +	/*
> +	 * Declarations via the ASL "Processor" statement are deprecated.

Be clear where they are deprecated. i.e. the ACPI spec and which version and
under what circumstances. 

Or don't say it. From Linux kernel point of view we need to support this anyway
for a long long time, so knowing they are deprecated in the ACPI spec
isn't really of interest.

> +	 */
> +	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
> +		/* Declared with "Processor" statement; match ProcessorID */
> +		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
> +		if (ACPI_FAILURE(status)) {
> +			dev_err(&device->dev,
> +				"Failed to evaluate processor object (0x%x)\n",
> +				status);
> +			return -ENODEV;
> +		}
> +
> +		value = object->processor.proc_id;
> +		goto out;

I'd keep the if / else form of the original code. I think it's easier to follow given
this really is choosing between 2 options.

> +	}
> +
> +	/*
> +	 * Declared with "Device" statement; match _UID.
> +	 */
> +	status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
> +					NULL, &value);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&device->dev,
> +			"Failed to evaluate processor _UID (0x%x)\n",
> +			status);
> +		return -ENODEV;
> +	}
> +
> +	*device_declaration = 1;
> +out:
> +	pr->acpi_id = value;

Maybe better to pass in the pr->handle, and return value so
pr->acpi_id is set at the caller rather than setting it in
this helper function?  That will keep the pr->x setting
all in one place.

> +	return 0;
> +}
> +
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
>  	union acpi_object object = { 0 };
> -	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>  	struct acpi_processor *pr = acpi_driver_data(device);
>  	int device_declaration = 0;
>  	acpi_status status = AE_OK;
>  	static int cpu0_initialized;
>  	unsigned long long value;
> +	int ret;
>  
>  	acpi_processor_errata();
>  
> @@ -252,32 +296,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	} else
>  		dev_dbg(&device->dev, "No bus mastering arbitration control\n");
>  
> -	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
> -		/* Declared with "Processor" statement; match ProcessorID */
> -		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
> -		if (ACPI_FAILURE(status)) {
> -			dev_err(&device->dev,
> -				"Failed to evaluate processor object (0x%x)\n",
> -				status);
> -			return -ENODEV;
> -		}
> -
> -		pr->acpi_id = object.processor.proc_id;
> -	} else {
> -		/*
> -		 * Declared with "Device" statement; match _UID.
> -		 */
> -		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
> -						NULL, &value);
> -		if (ACPI_FAILURE(status)) {
> -			dev_err(&device->dev,
> -				"Failed to evaluate processor _UID (0x%x)\n",
> -				status);
> -			return -ENODEV;
> -		}
> -		device_declaration = 1;
> -		pr->acpi_id = value;
> -	}
> +	/*
> +	 * Evaluate processor declaration.
Given function name (which is well named!) I don't see the comment adding anything.
So I'd drop the comment.
> +	 */
> +	ret = acpi_evaluate_processor(device, pr, &object, &device_declaration);
> +	if (ret)
> +		return ret;
>  
>  	if (acpi_duplicate_processor_id(pr->acpi_id)) {
>  		if (pr->acpi_id == 0xff)


