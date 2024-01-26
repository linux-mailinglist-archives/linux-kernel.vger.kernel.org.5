Return-Path: <linux-kernel+bounces-40269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3083DD67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051512821AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928181D547;
	Fri, 26 Jan 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="aIsatgDc"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226B1D6A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282708; cv=none; b=B45uOuOz/ySlCpbVxG63KEr5G6qswxU+2TKf5EKubXlQK/rPuXdGQfXjCrF546sRehF9ndI0XG4epREHOBH4xp7r0Tfp+LSh2tQdaBFKPcxUtYamuAzJb/l7a4HvFJHegyAVCjZ+YCjqx9uZP7L80B+akmSk6BBfN/u1gxSBuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282708; c=relaxed/simple;
	bh=9SzX1dvBwQwI3hdnFCUjU/D5qubcTatpWJ9Qez7BiEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGUma+S6VCy2UPuE9Mvh/TiEwyT4DRszF2y4VKJf9blkSUPZX8TqVa70c+29OoBWnjzxq1sf6miglIpAsSGWfGTk6NqKmnBHZZwt6Q7wDOPv1YecowLB6SasIHD+po3MMYBr04zKpZvVL1ITiyT78UH8UhyDGEkpQg3WxLrPnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=aIsatgDc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so47395139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1706282704; x=1706887504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEkmUv2LBLWanivlisRsYqbMgDJKJ+6PtBj6LwVdhTM=;
        b=aIsatgDceg50kOo4fxFYZRDakEaOKocB4n6yssLn4Ff90bzX+UvXcSlhjdBSwxQR1c
         lX+PMLM+tqGYRLbXs8gq7TPOHZHpZc+ZvMN+qRkLA/x2N5AWpCLBPzbXbZbVz+phAhvv
         ZM3ki6RbH2ASOUj7+Un2h4Z6D/aUoLoBozFWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282704; x=1706887504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEkmUv2LBLWanivlisRsYqbMgDJKJ+6PtBj6LwVdhTM=;
        b=AQeMw+vIdrlatPmY8AKwN1ZKxum1TlAAhb0EDGtTi7DZpWQC+5yYSxS10eTMmmNaM/
         JiIt/iXpN0hmCsWq5nXv+qWhejqXxr2IKpCHXJAJIuUMUoDKAc+Crnvr29RheZdaLQ2n
         OF4uDKW27O/BkiuV9QW2fNLN4IRd5HH0eoWTQ/jamHp5UVK0x2gumF7Pz8n+D7ak/+Y1
         OIvwDyKQZMSQ53oOKHorjrnIUpv9RQp+eXuOCa38v/zucEHnE7P2O0mZwbK3kLiqhVO+
         +AISonH9iU9nqXZGFaUOuBzZeFaqo/jWjBqtHw5q7vvwv+PFRaaifbYwvjTkNHIGmXMu
         NN/A==
X-Gm-Message-State: AOJu0YwbPwfaDrtSMi8lVTzuBmJll1cO2EWkI8f1qufHr/rkTPmYFasQ
	Ga/TwuTAtx/7NHcYqt2wYyBvenDkcnqt3J6M8AV/wmPYTq0lXSQ+Cwj6wgxRuw==
X-Google-Smtp-Source: AGHT+IFrVkgBsPjX1Dr5Cja5KOAsFZ70SEzEpDyfmgzi8CVC22VmpwKQ9J2ZR2shglyLPQ2FjICvJw==
X-Received: by 2002:a05:6e02:5ce:b0:360:73de:be5e with SMTP id l14-20020a056e0205ce00b0036073debe5emr1026139ils.14.1706282704233;
        Fri, 26 Jan 2024 07:25:04 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id p5-20020a02b385000000b0046ebddc03fbsm321799jan.33.2024.01.26.07.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:25:03 -0800 (PST)
Message-ID: <71634002-42b3-4341-b42b-a6356d358284@ieee.org>
Date: Fri, 26 Jan 2024 09:25:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <vireshk@kernel.org>,
 Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
References: <2e7bbdaf8a495bb1273396395b5c779363287581.1705350141.git.christophe.jaillet@wanadoo.fr>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <2e7bbdaf8a495bb1273396395b5c779363287581.1705350141.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/24 2:22 PM, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of

Fix whatever it is you meant to say here.                     ^^^^^^^^

> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
> needed.

Otherwise this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/staging/greybus/audio_manager.c  |  8 ++++----
>   drivers/staging/greybus/authentication.c |  6 +++---
>   drivers/staging/greybus/fw-download.c    |  7 +++----
>   drivers/staging/greybus/fw-management.c  | 20 +++++++++-----------
>   drivers/staging/greybus/gbphy.c          |  6 +++---
>   drivers/staging/greybus/loopback.c       |  6 +++---
>   drivers/staging/greybus/raw.c            |  6 +++---
>   drivers/staging/greybus/vibrator.c       |  6 +++---
>   8 files changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index 9a3f7c034ab4..fa43d35bbcec 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -44,14 +44,14 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
>   	int id;
>   	int err;
>   
> -	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&module_id, GFP_KERNEL);
>   	if (id < 0)
>   		return id;
>   
>   	err = gb_audio_manager_module_create(&module, manager_kset,
>   					     id, desc);
>   	if (err) {
> -		ida_simple_remove(&module_id, id);
> +		ida_free(&module_id, id);
>   		return err;
>   	}
>   
> @@ -78,7 +78,7 @@ int gb_audio_manager_remove(int id)
>   	list_del(&module->list);
>   	kobject_put(&module->kobj);
>   	up_write(&modules_rwsem);
> -	ida_simple_remove(&module_id, id);
> +	ida_free(&module_id, id);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
> @@ -92,7 +92,7 @@ void gb_audio_manager_remove_all(void)
>   
>   	list_for_each_entry_safe(module, next, &modules_list, list) {
>   		list_del(&module->list);
> -		ida_simple_remove(&module_id, module->id);
> +		ida_free(&module_id, module->id);
>   		kobject_put(&module->kobj);
>   	}
>   
> diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
> index b67315641d18..d53e58f92e81 100644
> --- a/drivers/staging/greybus/authentication.c
> +++ b/drivers/staging/greybus/authentication.c
> @@ -324,7 +324,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
>   	if (ret)
>   		goto err_list_del;
>   
> -	minor = ida_simple_get(&cap_minors_map, 0, NUM_MINORS, GFP_KERNEL);
> +	minor = ida_alloc_max(&cap_minors_map, NUM_MINORS - 1, GFP_KERNEL);
>   	if (minor < 0) {
>   		ret = minor;
>   		goto err_connection_disable;
> @@ -351,7 +351,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
>   err_del_cdev:
>   	cdev_del(&cap->cdev);
>   err_remove_ida:
> -	ida_simple_remove(&cap_minors_map, minor);
> +	ida_free(&cap_minors_map, minor);
>   err_connection_disable:
>   	gb_connection_disable(connection);
>   err_list_del:
> @@ -375,7 +375,7 @@ void gb_cap_connection_exit(struct gb_connection *connection)
>   
>   	device_destroy(&cap_class, cap->dev_num);
>   	cdev_del(&cap->cdev);
> -	ida_simple_remove(&cap_minors_map, MINOR(cap->dev_num));
> +	ida_free(&cap_minors_map, MINOR(cap->dev_num));
>   
>   	/*
>   	 * Disallow any new ioctl operations on the char device and wait for
> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> index 543692c567f9..2a5c6d1b049c 100644
> --- a/drivers/staging/greybus/fw-download.c
> +++ b/drivers/staging/greybus/fw-download.c
> @@ -63,8 +63,7 @@ static void fw_req_release(struct kref *kref)
>   	 * just hope that it never happens.
>   	 */
>   	if (!fw_req->timedout)
> -		ida_simple_remove(&fw_req->fw_download->id_map,
> -				  fw_req->firmware_id);
> +		ida_free(&fw_req->fw_download->id_map, fw_req->firmware_id);
>   
>   	kfree(fw_req);
>   }
> @@ -171,7 +170,7 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>   		return ERR_PTR(-ENOMEM);
>   
>   	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
> -	ret = ida_simple_get(&fw_download->id_map, 1, 256, GFP_KERNEL);
> +	ret = ida_alloc_range(&fw_download->id_map, 1, 255, GFP_KERNEL);
>   	if (ret < 0) {
>   		dev_err(fw_download->parent,
>   			"failed to allocate firmware id (%d)\n", ret);
> @@ -212,7 +211,7 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>   	return fw_req;
>   
>   err_free_id:
> -	ida_simple_remove(&fw_download->id_map, fw_req->firmware_id);
> +	ida_free(&fw_download->id_map, fw_req->firmware_id);
>   err_free_req:
>   	kfree(fw_req);
>   
> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> index 93137a3c4907..3054f084d777 100644
> --- a/drivers/staging/greybus/fw-management.c
> +++ b/drivers/staging/greybus/fw-management.c
> @@ -165,7 +165,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
>   	}
>   
>   	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
> -	ret = ida_simple_get(&fw_mgmt->id_map, 1, 256, GFP_KERNEL);
> +	ret = ida_alloc_range(&fw_mgmt->id_map, 1, 255, GFP_KERNEL);
>   	if (ret < 0) {
>   		dev_err(fw_mgmt->parent, "failed to allocate request id (%d)\n",
>   			ret);
> @@ -180,8 +180,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
>   				GB_FW_MGMT_TYPE_LOAD_AND_VALIDATE_FW, &request,
>   				sizeof(request), NULL, 0);
>   	if (ret) {
> -		ida_simple_remove(&fw_mgmt->id_map,
> -				  fw_mgmt->intf_fw_request_id);
> +		ida_free(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
>   		fw_mgmt->intf_fw_request_id = 0;
>   		dev_err(fw_mgmt->parent,
>   			"load and validate firmware request failed (%d)\n",
> @@ -220,7 +219,7 @@ static int fw_mgmt_interface_fw_loaded_operation(struct gb_operation *op)
>   		return -ENODEV;
>   	}
>   
> -	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
> +	ida_free(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
>   	fw_mgmt->intf_fw_request_id = 0;
>   	fw_mgmt->intf_fw_status = request->status;
>   	fw_mgmt->intf_fw_major = le16_to_cpu(request->major);
> @@ -316,7 +315,7 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
>   	}
>   
>   	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
> -	ret = ida_simple_get(&fw_mgmt->id_map, 1, 256, GFP_KERNEL);
> +	ret = ida_alloc_range(&fw_mgmt->id_map, 1, 255, GFP_KERNEL);
>   	if (ret < 0) {
>   		dev_err(fw_mgmt->parent, "failed to allocate request id (%d)\n",
>   			ret);
> @@ -330,8 +329,7 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
>   				GB_FW_MGMT_TYPE_BACKEND_FW_UPDATE, &request,
>   				sizeof(request), NULL, 0);
>   	if (ret) {
> -		ida_simple_remove(&fw_mgmt->id_map,
> -				  fw_mgmt->backend_fw_request_id);
> +		ida_free(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
>   		fw_mgmt->backend_fw_request_id = 0;
>   		dev_err(fw_mgmt->parent,
>   			"backend %s firmware update request failed (%d)\n", tag,
> @@ -369,7 +367,7 @@ static int fw_mgmt_backend_fw_updated_operation(struct gb_operation *op)
>   		return -ENODEV;
>   	}
>   
> -	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
> +	ida_free(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
>   	fw_mgmt->backend_fw_request_id = 0;
>   	fw_mgmt->backend_fw_status = request->status;
>   
> @@ -617,7 +615,7 @@ int gb_fw_mgmt_connection_init(struct gb_connection *connection)
>   	if (ret)
>   		goto err_list_del;
>   
> -	minor = ida_simple_get(&fw_mgmt_minors_map, 0, NUM_MINORS, GFP_KERNEL);
> +	minor = ida_alloc_max(&fw_mgmt_minors_map, NUM_MINORS - 1, GFP_KERNEL);
>   	if (minor < 0) {
>   		ret = minor;
>   		goto err_connection_disable;
> @@ -645,7 +643,7 @@ int gb_fw_mgmt_connection_init(struct gb_connection *connection)
>   err_del_cdev:
>   	cdev_del(&fw_mgmt->cdev);
>   err_remove_ida:
> -	ida_simple_remove(&fw_mgmt_minors_map, minor);
> +	ida_free(&fw_mgmt_minors_map, minor);
>   err_connection_disable:
>   	gb_connection_disable(connection);
>   err_list_del:
> @@ -669,7 +667,7 @@ void gb_fw_mgmt_connection_exit(struct gb_connection *connection)
>   
>   	device_destroy(&fw_mgmt_class, fw_mgmt->dev_num);
>   	cdev_del(&fw_mgmt->cdev);
> -	ida_simple_remove(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
> +	ida_free(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
>   
>   	/*
>   	 * Disallow any new ioctl operations on the char device and wait for
> diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
> index 6a7d8cf2a1eb..93b74a236ab1 100644
> --- a/drivers/staging/greybus/gbphy.c
> +++ b/drivers/staging/greybus/gbphy.c
> @@ -46,7 +46,7 @@ static void gbphy_dev_release(struct device *dev)
>   {
>   	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
>   
> -	ida_simple_remove(&gbphy_id, gbphy_dev->id);
> +	ida_free(&gbphy_id, gbphy_dev->id);
>   	kfree(gbphy_dev);
>   }
>   
> @@ -225,13 +225,13 @@ static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
>   	int retval;
>   	int id;
>   
> -	id = ida_simple_get(&gbphy_id, 1, 0, GFP_KERNEL);
> +	id = ida_alloc_min(&gbphy_id, 1, GFP_KERNEL);
>   	if (id < 0)
>   		return ERR_PTR(id);
>   
>   	gbphy_dev = kzalloc(sizeof(*gbphy_dev), GFP_KERNEL);
>   	if (!gbphy_dev) {
> -		ida_simple_remove(&gbphy_id, id);
> +		ida_free(&gbphy_id, id);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index d7b39f3bb652..bb33379b5297 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -1028,7 +1028,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
>   	gb->file = debugfs_create_file(name, S_IFREG | 0444, gb_dev.root, gb,
>   				       &gb_loopback_dbgfs_latency_fops);
>   
> -	gb->id = ida_simple_get(&loopback_ida, 0, 0, GFP_KERNEL);
> +	gb->id = ida_alloc(&loopback_ida, GFP_KERNEL);
>   	if (gb->id < 0) {
>   		retval = gb->id;
>   		goto out_debugfs_remove;
> @@ -1079,7 +1079,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
>   out_connection_disable:
>   	gb_connection_disable(connection);
>   out_ida_remove:
> -	ida_simple_remove(&loopback_ida, gb->id);
> +	ida_free(&loopback_ida, gb->id);
>   out_debugfs_remove:
>   	debugfs_remove(gb->file);
>   out_connection_destroy:
> @@ -1121,7 +1121,7 @@ static void gb_loopback_disconnect(struct gb_bundle *bundle)
>   	spin_unlock_irqrestore(&gb_dev.lock, flags);
>   
>   	device_unregister(gb->dev);
> -	ida_simple_remove(&loopback_ida, gb->id);
> +	ida_free(&loopback_ida, gb->id);
>   
>   	gb_connection_destroy(gb->connection);
>   	kfree(gb);
> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
> index b9c6eff7cdc1..836d35e5fa85 100644
> --- a/drivers/staging/greybus/raw.c
> +++ b/drivers/staging/greybus/raw.c
> @@ -181,7 +181,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
>   	raw->connection = connection;
>   	greybus_set_drvdata(bundle, raw);
>   
> -	minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
> +	minor = ida_alloc(&minors, GFP_KERNEL);
>   	if (minor < 0) {
>   		retval = minor;
>   		goto error_connection_destroy;
> @@ -214,7 +214,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
>   	gb_connection_disable(connection);
>   
>   error_remove_ida:
> -	ida_simple_remove(&minors, minor);
> +	ida_free(&minors, minor);
>   
>   error_connection_destroy:
>   	gb_connection_destroy(connection);
> @@ -235,7 +235,7 @@ static void gb_raw_disconnect(struct gb_bundle *bundle)
>   	device_destroy(&raw_class, raw->dev);
>   	cdev_del(&raw->cdev);
>   	gb_connection_disable(connection);
> -	ida_simple_remove(&minors, MINOR(raw->dev));
> +	ida_free(&minors, MINOR(raw->dev));
>   	gb_connection_destroy(connection);
>   
>   	mutex_lock(&raw->list_lock);
> diff --git a/drivers/staging/greybus/vibrator.c b/drivers/staging/greybus/vibrator.c
> index 227e18d92a95..89bef8045549 100644
> --- a/drivers/staging/greybus/vibrator.c
> +++ b/drivers/staging/greybus/vibrator.c
> @@ -153,7 +153,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
>   	 * there is a "real" device somewhere in the kernel for this, but I
>   	 * can't find it at the moment...
>   	 */
> -	vib->minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
> +	vib->minor = ida_alloc(&minors, GFP_KERNEL);
>   	if (vib->minor < 0) {
>   		retval = vib->minor;
>   		goto err_connection_disable;
> @@ -173,7 +173,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
>   	return 0;
>   
>   err_ida_remove:
> -	ida_simple_remove(&minors, vib->minor);
> +	ida_free(&minors, vib->minor);
>   err_connection_disable:
>   	gb_connection_disable(connection);
>   err_connection_destroy:
> @@ -197,7 +197,7 @@ static void gb_vibrator_disconnect(struct gb_bundle *bundle)
>   		turn_off(vib);
>   
>   	device_unregister(vib->dev);
> -	ida_simple_remove(&minors, vib->minor);
> +	ida_free(&minors, vib->minor);
>   	gb_connection_disable(vib->connection);
>   	gb_connection_destroy(vib->connection);
>   	kfree(vib);


