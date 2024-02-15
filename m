Return-Path: <linux-kernel+bounces-66892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833FD856336
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5E11F226E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E712C7FB;
	Thu, 15 Feb 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOkAVF7K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488452D600;
	Thu, 15 Feb 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000279; cv=none; b=j9ZIt0iXDzhXhUC9OcW+/1s50j6/72ntkapYKzeCkfX32i0H3B9vvNsotPmatSUNosJQL7U/t1XFSgGAgt4kuPBJUGVe1Mn/UNxkI7/2H2St85LaCN9WuSZUH1tjRxf1W9QGYWzZ+8He+yCNLVGVNtnxftVH1euz7E4KkUxXm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000279; c=relaxed/simple;
	bh=pGTBzABlH08Gq8Fd6dQA9/1Tc2CnTZsxXjOd5UVLxC0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q+YnrM1lpt2ysGnXNM5bJYoSujdkn+KJwvttBo8fXJuxhXaZDQ2mhT1eRP79RXlngf5XAE71hwFfxyQvdZtimNamxfze8HWcLxW4psW8cijAnEP8VPwJYJ+4UQ6fDc7RfOqA/fUAjFYPvrBwGvZXgXgYMIrKmbkXy0NDzNC+P08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOkAVF7K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708000278; x=1739536278;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pGTBzABlH08Gq8Fd6dQA9/1Tc2CnTZsxXjOd5UVLxC0=;
  b=dOkAVF7KczzXaQ7zCTPQQUVgTnuZJYvhzNa9nRUjzrEiyhOXb2HG6jo9
   PxwP1+fLjkehVB3CnkN6wjtB8EzuD8i1OP6yKpHLEiZtL6kpbYqD6/h41
   308tDv7PfFGddDRsKDtLZZzcaMQ6Al7r/Rkxouf/Zo4KnDQnREUxbiv1N
   nDH4WDDcHKCibKlr6JnWX9Ay/wyD2CXP4T0zvolHWso+9KWS5xozYflaH
   rJtOPcKaznvQI10N/zNVL8jI24a5z8r+l9bzeweaOjt2blqs0OwN1chGb
   CxoNkL+caWgtb9Oja+tmj/ONpcSd6UtwspI3BD6WBdTVYEEdfOej57Lka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19502191"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19502191"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="41008560"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:31:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Feb 2024 14:31:09 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] platform/x86: wmi: Check if event data is not NULL
In-Reply-To: <20240214070433.2677-3-W_Armin@gmx.de>
Message-ID: <e03b600e-6ad2-1dd1-c4af-56ebfce51f12@linux.intel.com>
References: <20240214070433.2677-1-W_Armin@gmx.de> <20240214070433.2677-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Armin Wolf wrote:

> WMI event drivers which do not have no_notify_data set expect
> that each WMI event contains valid data. Evaluating _WED however
> might return no data, which can cause issues with such drivers.
> 
> Fix this by validating that evaluating _WED did return data.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 34d8f55afaad..8a916887c546 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1211,6 +1211,7 @@ static void wmi_notify_driver(struct wmi_block *wblock)
>  {
>  	struct wmi_driver *driver = drv_to_wdrv(wblock->dev.dev.driver);
>  	struct acpi_buffer data = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj = NULL;
>  	acpi_status status;
> 
>  	if (!driver->no_notify_data) {
> @@ -1219,12 +1220,18 @@ static void wmi_notify_driver(struct wmi_block *wblock)
>  			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
>  			return;
>  		}
> +
> +		obj = data.pointer;
> +		if (!obj) {
> +			dev_warn(&wblock->dev.dev, "Event contains not event data\n");
> +			return;
> +		}
>  	}
> 
>  	if (driver->notify)
> -		driver->notify(&wblock->dev, data.pointer);
> +		driver->notify(&wblock->dev, obj);
> 
> -	kfree(data.pointer);
> +	kfree(obj);

Hi Armin,

While looking into this patch, I failed to connect the mention of 
no_notify_data in the commit message with the code change that does
nothing differently based no_notify_data being set or not, AFAICT.

It could be just that you need to explain things better in the commit 
message, I'm not sure.

-- 
 i.


