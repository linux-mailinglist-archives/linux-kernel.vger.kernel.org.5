Return-Path: <linux-kernel+bounces-77415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB428604EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567531F21C16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3873F38;
	Thu, 22 Feb 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrkfhrKM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3251E496
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637848; cv=none; b=fWaS1oXobsPXKRE/OEEjEu4h/77l2zqCBwR2XvZ4FgKH/xOQkQm71WGHKMf3PYpCUZlhpvVtiNO1/38joIVpm7MOWxrDrEx12G12XbeAZDw3lMVEpFHiR06kc8d2L04XonSITYR41cEvugPn89Bb/dNnylthan7xUlY79PtMSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637848; c=relaxed/simple;
	bh=CRQLcQZZCyWq7iQgWSpsPFZZBjaRvd9wTMW8gMdChFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUfD5KovQFvH3PejwEafzW4oFGE/ArpsAjqNXWPMDyscJYcYlG5cn8tPHRr7wYXsnhCRvN8gnQPuxZJsW8F1DEnHztGhBYPKX3AmGkXHHYSCmnJNmy+EbEL7nNHSw5R+PDQilr9HnXWoCN/hcdkF76GwDrWeyt3wnsee4pStuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrkfhrKM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708637845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7l+9clzjVKQA+xkkzwU5JxUEh+E5T8G22Hnvhg7ds4=;
	b=BrkfhrKMhfgYXKEfPneO+ntVZPhTAGCYUwPN7Kk/4snlsIXshROTUwRunP5/48hDeoHQYQ
	4NMJaQS8/w0pAlF4npu5Bkk5K9ML6QX3yyfqa7IfnxlRZ0hEZId7uT6hS24jFp1+v9R2+y
	e+ig1zxZQHFtiZFuXwzaW2DmoXSldvs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-flzu64GWNcqPZs5Jca1Tzg-1; Thu, 22 Feb 2024 16:37:24 -0500
X-MC-Unique: flzu64GWNcqPZs5Jca1Tzg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c76a65a4aaso22502239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637843; x=1709242643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7l+9clzjVKQA+xkkzwU5JxUEh+E5T8G22Hnvhg7ds4=;
        b=uL4C44nTdD5kHivdMC5fxd1hORdrKbpbUaVGor0BeVP0Gj9SaqokzAh1NPfPTWYSf3
         CS8Wu++CJFEwRs9y/9DVg3VJJpyXdDNpBvGplzcLjneVyDXgObjcilkA9dEhAn4m7DrA
         FIitqGeNpvI4YclxPEzAqo3zggMB9klewOdOPRjm3DCCi3gg7CuI5eJnyKJwRPUk/kSA
         8sbYu+RsuXCHX498NycAfwpv8WRDYqcnwBLIfuI07Bhu0dv1mzPBdl0TD5Wzp1oNGHqu
         7dK/FA01C66f1l90HEd8Kf2aRyUNawCFnKaX/Td2C8c6sagEjRO6fmnIW6Hjmvvextra
         w9dA==
X-Forwarded-Encrypted: i=1; AJvYcCXSG73492Pb6xTYOVhEuGRGATvWmdPam2lZMXlX1GUgr+ErPVsWptKNgHUu6HG7Iq78hxczczTkfxRTfiyluMDbXZ4ZuTc+VYxGohaC
X-Gm-Message-State: AOJu0YysEpNw0NvpDnYpZkkpnJ6lLSt0MUcovAfBSldqNR8fFMtS8Nva
	AEIYQqgT1UdrXKql8SBqRsuNT6QUE3qb968T0DygQv4+4R4x/iplXiquf3zUo1k6RRosi0HnrWq
	MFECHIYqf6hQGN3ytZPg4v4OEYHb4G6QvdlQRCJoI0omI23fP5lYRnvICWfBopg==
X-Received: by 2002:a6b:e00e:0:b0:7c0:3d0f:b7cf with SMTP id z14-20020a6be00e000000b007c03d0fb7cfmr2831139iog.8.1708637843593;
        Thu, 22 Feb 2024 13:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/m5G6udUIqgOLIq2GJ6IMPYm7AvkII6Jm6SmNbDfsGtL4njJ2KwbwX+3lenHBYb+iEfCSAA==
X-Received: by 2002:a6b:e00e:0:b0:7c0:3d0f:b7cf with SMTP id z14-20020a6be00e000000b007c03d0fb7cfmr2831128iog.8.1708637843367;
        Thu, 22 Feb 2024 13:37:23 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id l14-20020a056638220e00b004743021012asm2117827jas.2.2024.02.22.13.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:37:22 -0800 (PST)
Date: Thu, 22 Feb 2024 14:37:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio: Use WARN_ON for low-probability allocation
 failure issue in vfio_pci_bus_notifier
Message-ID: <20240222143717.5e6bd5d8.alex.williamson@redhat.com>
In-Reply-To: <20240115063434.20278-1-chentao@kylinos.cn>
References: <20240115063434.20278-1-chentao@kylinos.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 14:34:34 +0800
Kunwu Chan <chentao@kylinos.cn> wrote:

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> This is a blocking notifier callback, so errno isn't a proper return
> value. Use WARN_ON to small allocation failures.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
> v2: Use WARN_ON instead of return errno
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1cbc990d42e0..61aa19666050 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2047,6 +2047,7 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
>  			 pci_name(pdev));
>  		pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
>  						  vdev->vdev.ops->name);
> +		WARN_ON(!pdev->driver_override);
>  	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
>  		   pdev->is_virtfn && physfn == vdev->pdev) {
>  		struct pci_driver *drv = pci_dev_driver(pdev);

Applied to vfio next branch for v6.9.  Thanks,

Alex


