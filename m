Return-Path: <linux-kernel+bounces-135136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5A89BB85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A69280E25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D34595C;
	Mon,  8 Apr 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtvdTwny"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF764176B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568068; cv=none; b=HEhuDlZ7J45sO/LP1GRq6mABJA+/knZ87L7PiMITOrtt955LBqNd+yCt11vf0cqBqDYkjNbGOc41u1uTmDWCXYMl/Dvpth3TcFSXoqa0nb5FW5NIRG1Y605/5Eidw6k4XIhO7U/48blAaoxkiFH3kEIPUuiEKjOfl0yi+cuMASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568068; c=relaxed/simple;
	bh=LlWw5D5iq3eRsOKi/6cRekmwRU6E2z6fXUzoAVyRkgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6scoGbD1irnNcn8KkfkEjxcHUE2TO4q09yjX4hvPJBECrXDn/LYZx7U88TeUYj4BefLMC4m2iYrgdu3C3l3Q85LycW6yz5ytfWgeMTsBxZqxSN473rJVtNNerf4iSIWSe+HMXS03aP1aFyRfiGOQnnqn6giujI8g8iVq1dsaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtvdTwny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712568066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXql7UyGB0xfCaYsiXkmotNqC4Ch89jqlagi6eSTNP4=;
	b=TtvdTwnyeE8jL6BVawSrz3gj74oxe8k3jfOgLkJcgowRAVf7k7RwV00wl0B3Zna+/wxo1Z
	NyzEoaQB1TyRTeiccznsA7su9rJ7YCH1E9xqLklTonVrlyySr2MS2DW7D20214tA5qTWgs
	oH5yq0DcR0MB4c7c6+G6l0agMF6Fmtg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-sgBduvWiPtiIjsbqHDM2uA-1; Mon, 08 Apr 2024 05:21:02 -0400
X-MC-Unique: sgBduvWiPtiIjsbqHDM2uA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51abd0d7c6so183969866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568061; x=1713172861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXql7UyGB0xfCaYsiXkmotNqC4Ch89jqlagi6eSTNP4=;
        b=B/XHuW6mxNeIdjoFlzhY38bhHWspI5ihzCGDPR10ht++SyT+yQXtWykeXWYhR9Vp2a
         JChD+5hTR5aUL5ZQMx+CBy2ItU+cpbdinVzeZXOCKfcwXpu2gpEJkvZUby/n9bAXMRei
         Ynw/zlrjCUASZ/OjgnC6ryuYqR6j6fXjo591uIlzaL7jn3NcgIQILOH4U83rSzLRj+Zf
         kAaSAesqKmvRWNMgSdy5EXv+0zbHNg9SmcSobiRq/uLxjOTsy4grGBGaRc2xbRq5ZUTr
         wflYOFpEQOZcPMJ4NJDV5bzHP6Go38rMe2GtwFOT/7b/+fMA18rneVGzgPaB+TirMfi8
         DljA==
X-Forwarded-Encrypted: i=1; AJvYcCWAov4lSBLvRujivBtzDgECahnjvvK54jSQRR4XZ1KuRzGgOW/QGECoQFqIsIAmWSPO8YPIsz7xuRyQ8e2C6meJGMvlZ7wnD6ecxkxl
X-Gm-Message-State: AOJu0YzRL2YjGbBC/krQiEJJDq13UsHV39K1VNUwKWqrilOyPBKso7ZY
	R5u/B1q12ITUtBHhiM5VwwiomIngiEZk+OPy39PA4veKUr1fmbeLh28+42iJ/jEkTjLZr7ue8q0
	ftSV1xi0yxhZoX4DkKiwDaE3xBVTt/KEpYt81y5+xlAZmu4Gssjw+5NAy2+RuBw==
X-Received: by 2002:a17:906:af7b:b0:a46:1d4b:d81 with SMTP id os27-20020a170906af7b00b00a461d4b0d81mr5221302ejb.62.1712568061725;
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWOk6NEUrk9lnCfVbhMKNrjuoMqwfAbqHURxAw52jR4biGZq5z+GiQk0FKFdfGm0nyfmNnwA==
X-Received: by 2002:a17:906:af7b:b0:a46:1d4b:d81 with SMTP id os27-20020a170906af7b00b00a461d4b0d81mr5221290ejb.62.1712568061420;
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b00a51d0690052sm1617988ejb.124.2024.04.08.02.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
Message-ID: <2dd4f820-8b94-4e9b-909c-b43cb40bfc99@redhat.com>
Date: Mon, 8 Apr 2024 11:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/27/24 10:45 PM, Armin Wolf wrote:
> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
> on all CPUs"), the ACPI core allows multiple notify calls to be active
> at the same time. This means that two instances of quickstart_notify()
> running at the same time can mess which each others input sequences.
> 
> Fix this by protecting the input sequence with a mutex.
> 
> Compile-tested only.
> 
> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> This applies on the branch "review-hans". Maybe we could somehow
> document the concurrency rules for ACPI notify handlers?
> ---
>  drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> index ba3a7a25dda7..e40f852d42c1 100644
> --- a/drivers/platform/x86/quickstart.c
> +++ b/drivers/platform/x86/quickstart.c
> @@ -18,6 +18,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> @@ -35,6 +36,7 @@
> 
>  struct quickstart_data {
>  	struct device *dev;
> +	struct mutex input_lock;	/* Protects input sequence during notify */
>  	struct input_dev *input_device;
>  	char input_name[32];
>  	char phys[32];
> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u32 event, void *context)
> 
>  	switch (event) {
>  	case QUICKSTART_EVENT_RUNTIME:
> +		mutex_lock(&data->input_lock);
>  		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
> +		mutex_unlock(&data->input_lock);
> +
>  		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>  		break;
>  	default:
> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *context)
>  	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify);
>  }
> 
> +static void quickstart_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
>  static int quickstart_probe(struct platform_device *pdev)
>  {
>  	struct quickstart_data *data;
> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_device *pdev)
>  	data->dev = &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, data);
> 
> +	mutex_init(&data->input_lock);
> +	ret = devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &data->input_lock);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* We have to initialize the device wakeup before evaluating GHID because
>  	 * doing so will notify the device if the button was used to wake the machine
>  	 * from S5.
> --
> 2.39.2
> 


