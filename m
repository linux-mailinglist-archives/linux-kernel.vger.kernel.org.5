Return-Path: <linux-kernel+bounces-77417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E908D8604F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2634D1C23599
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334F13BAEA;
	Thu, 22 Feb 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DchUr+ws"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44813BAC8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637855; cv=none; b=OoOSD+szXZAKHewRne7G49ri2drVBcV8SLznhl/E/azaqzDHUmKoDj0KB2W1zr+sVo62ExXdlD9Uxyl2SL/wh+U7P6a9RMUreTNgNwPOhhWoeCPWjwDqGtn3MAkSSq7VdyWLLfstXGCfO7ItPsMZu98WA+GVR+8ObBxbexc7F5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637855; c=relaxed/simple;
	bh=eTl3BaSXL1EOcleF8Llz7TJCP6iZbj2tst9XjTceF1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjkGYIhLGeO5Xr0jwxAh6T9bo8dJl86839qqE+ZdkcHrWV8qPCFuL0RJ633KCvXjLQd1S2WdO0ugA98AB1IAkS2cVmsWpv/W8PnVJy429GRgtkv9yHt5HkHiHy7EkECSekDO/iBRh0eXafQSKudB2i5ObEIoXqFBVgUtPcl1raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DchUr+ws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708637852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtxCaMm2553SkupuI9XJeFwENX6MIeYRxtADotfCGT4=;
	b=DchUr+ws7T1euXx7Dly/bs4sFyxfsm14leurL3SjjYPO0luTyJ2ZvAqlNFdi+1v83AXFrp
	Gn//u+7sZOCKpnmiTXB/PyItjzveasfgfgowoJvquhSZ6qVhu5uf7ukUo1UNn7y9oRCHdN
	dSXC/gw0znGImhWHimuzIIEobBVPSDI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-_Ov9caJoNZGK6h5npaDTjQ-1; Thu, 22 Feb 2024 16:37:30 -0500
X-MC-Unique: _Ov9caJoNZGK6h5npaDTjQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7857e6d5dso13523839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637849; x=1709242649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtxCaMm2553SkupuI9XJeFwENX6MIeYRxtADotfCGT4=;
        b=rXiKHyxRhPb8J4NpaBvUtF0BifB7ftWWjBiabyWVg4dpsKIW7HNU9PPAyLlo2z///m
         I80pX1pl32Eh55eqBx/bukLYNmMjbgmYM8uhXt/DiSfzDqM8AR+XQxTqu5UzT1/bBk4L
         JKTtpCegL2d1Lzy8GOrre3l6rJNmIWjwpmg6QxbjhJh3Uhd0Cas0uGF4k/4mPXxqCcXk
         /vS+zGr8RUNFVRcTaVLanoO4QLJ+ncsY13Nm94glqxmefpW5boJJ/oCWlQUFj1FkRhFF
         t9XyyscPTZns1S0RnqEEZZS9j3torlP+C5UAcp4zS7x6bb2u8bipYCbaw9fw9dOwVgBZ
         D+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWmahnYVzJC20rUMBkwHrPLKfbYiZjCrs6TgJlT37xbY3GOHOL14r7dFad9iqkWJgEIhwCBy/iRul5jVN7ex6vm3OyW4KOoTkp60b9B
X-Gm-Message-State: AOJu0Yz6rrXm7VBTE9IAo4UBDL6mwkE+NHPSn0WMM6ZaXxtKUxnGqyao
	DZfBaPJ6xDfbkTEilxBU1zpzvgCRN24yIXJx06zo+dvH+Vg60rnnfuDi8df6x/nNZIqMSybiUOu
	JwDgYsR2SWhQ19cdz/0Ub3YyqpUJruaOeDgpIAhRf1pJAL4LnxUHcAv4F0TuO+XkTAi/btA==
X-Received: by 2002:a5e:8a09:0:b0:7c7:4e71:7911 with SMTP id d9-20020a5e8a09000000b007c74e717911mr154283iok.18.1708637849417;
        Thu, 22 Feb 2024 13:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgU0x5ieHj4hzgNeb/0+6xmyweUr+A42rwzQGt3bwPjQRz1SfIuiuqgZPCPDmibh8XqUJ1XQ==
X-Received: by 2002:a5e:8a09:0:b0:7c7:4e71:7911 with SMTP id d9-20020a5e8a09000000b007c74e717911mr154269iok.18.1708637849173;
        Thu, 22 Feb 2024 13:37:29 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id l14-20020a056638220e00b004743021012asm2117827jas.2.2024.02.22.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:37:27 -0800 (PST)
Date: Thu, 22 Feb 2024 14:37:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vfio: mdev: make mdev_bus_type const
Message-ID: <20240222143705.6cede313.alex.williamson@redhat.com>
In-Reply-To: <20240208-bus_cleanup-vfio-v1-1-ed5da3019949@marliere.net>
References: <20240208-bus_cleanup-vfio-v1-1-ed5da3019949@marliere.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Feb 2024 17:02:04 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the mdev_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/vfio/mdev/mdev_driver.c  | 2 +-
>  drivers/vfio/mdev/mdev_private.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
> index 7825d83a55f8..b98322966b3e 100644
> --- a/drivers/vfio/mdev/mdev_driver.c
> +++ b/drivers/vfio/mdev/mdev_driver.c
> @@ -40,7 +40,7 @@ static int mdev_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> -struct bus_type mdev_bus_type = {
> +const struct bus_type mdev_bus_type = {
>  	.name		= "mdev",
>  	.probe		= mdev_probe,
>  	.remove		= mdev_remove,
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index af457b27f607..63a1316b08b7 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -13,7 +13,7 @@
>  int  mdev_bus_register(void);
>  void mdev_bus_unregister(void);
>  
> -extern struct bus_type mdev_bus_type;
> +extern const struct bus_type mdev_bus_type;
>  extern const struct attribute_group *mdev_device_groups[];
>  
>  #define to_mdev_type_attr(_attr)	\
> 
> ---
> base-commit: 78f70c02bdbccb5e9b0b0c728185d4aeb7044ace
> change-id: 20240208-bus_cleanup-vfio-75a6180b5efe
> 
> Best regards,

Applied to vfio next branch for v6.9.  Thanks,

Alex


