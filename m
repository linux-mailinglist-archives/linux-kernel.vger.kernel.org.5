Return-Path: <linux-kernel+bounces-107675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69587FFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3067A1C218A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21C56776;
	Tue, 19 Mar 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+kczf6W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DF208B0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859819; cv=none; b=mnff6Ac99yzlYTghZ6jmF2689BH6+7KdiI8qWvIMzpf80jRY3AH2TRfYL9L77CSurDDYrcTCeKnRAMzuP3J9B7KrvxbDmF8JuhGqvMklNJw7ilpruvBIf8vYbMyzX50cat8V7QBFhi6cxfIX3DjzCxMlcWqJkZeBqSzjjUd0zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859819; c=relaxed/simple;
	bh=9Or02ADRX8u+teHk/fSbctDIgcqOyiCVTsoWY9rQI2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpyUHHfRq6ztOBgSwZPUeuKgoZ1G6Wc9VsDa7FPcfzCsViChuuztuloL5UbAxUnrSddoXdqINGg9PjP9INDpGzrh7o5cyBPPg0q2bWanhtphzlIOAnVyjnF7eyhYzfbdqNAqLUgZ/HhEU0dwm7w22b0HPeqwkdf3smqN0UWRfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+kczf6W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710859817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQVEbtTOwcCbdEEQDCGW8gxi2FS5l5Frw2gE9pER4XY=;
	b=K+kczf6WxjRNyGBWfs0EuukM3dRbY698RRwq+Iai0dUExPy/MUC5o2s00EnNZhpE6wxJf9
	LLud0nvPQ5+fh+JWMpCFJzOidB6sotyoTIHBoMKFCg+csMvagzEFHEaCqY3BH0yg+DjQjf
	/dN5jW/YU06VHLfS7fzurPw+gH7blh0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-ZUVGYaOnNxyczbvUAVODsQ-1; Tue, 19 Mar 2024 10:50:16 -0400
X-MC-Unique: ZUVGYaOnNxyczbvUAVODsQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-221bd0d2bf6so7232712fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859815; x=1711464615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQVEbtTOwcCbdEEQDCGW8gxi2FS5l5Frw2gE9pER4XY=;
        b=ISsQ+d5W0izugcZYOUmMNfi+05KO+/9AfN33fTfpcrmeqOrXJ7A5NSmfKPrVFXw1Vk
         32jLIvJxWa1V6iCwLdWxV3zaYulZ5BvX1MmNnl+3mW+Cgq4t6y126F8mPguzB5b9idp0
         YOecDqgPIe+o2ZCUW8uE5LdGr5nAWRry3xQKYCL5pZB1C0gkwdzaudy54qnKnJDgPj8x
         AASoKWL50OYlNvkoJRGp3C/JNZxPD0fIy4t8Xs/Uk7pAw6FuWKvr7yO0kJ8YfsZ6w9Go
         7wixE7V2XvtZ4LN+PDTRlf7MMPeElBhTkULTsk3vd0/1xc+dCE6t7+IAHRejNeJRxIkt
         u5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2i8EmYp75FcwwwaWRwZ6dD4E/py1/VGqJbewR+56XDLwDUA3SacQYLX75Ow1YzwEVuTjxt0ZOAJsetJDdDVFmVmU5Va5KkiMo+fQr
X-Gm-Message-State: AOJu0Yz852gYPgWwvRu4x948BlwUo/y3AP9+D6OL1jz8Pg+ex7u69xZk
	o1dsbb2HD7EzU7gcJkufDHb17Cwypt4Ny7p1YDPTal4MlyU2XA6Jztq1kJqkfG0g83NUXJKImc+
	VrQraJN1pfKqbGeWI/tvO4o1P7W8oei1qoN1NYXFF/xGCJ0BnEMY79nJmVMff4g==
X-Received: by 2002:a05:6870:4345:b0:221:c9ef:3e with SMTP id x5-20020a056870434500b00221c9ef003emr16362033oah.13.1710859815381;
        Tue, 19 Mar 2024 07:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG95zfhgakQbD+IW3Q6yfYsnzRgRRliSdgUB3UoL9l6r9IzAM8N4q69arDelFugd9JQVbllDA==
X-Received: by 2002:a05:6870:4345:b0:221:c9ef:3e with SMTP id x5-20020a056870434500b00221c9ef003emr16362019oah.13.1710859815111;
        Tue, 19 Mar 2024 07:50:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id g18-20020a02c552000000b00474fd401b8fsm2885461jaj.34.2024.03.19.07.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:50:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 08:50:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mikhail Malyshev <mike.malyshev@gmail.com>
Cc: jgg@ziepe.ca, yi.l.liu@intel.com, kevin.tian@intel.com,
 tglx@linutronix.de, reinette.chatre@intel.com, stefanha@redhat.com,
 abhsahu@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Reenable runtime PM for dynamically unbound devices
Message-ID: <20240319085011.2da113ae.alex.williamson@redhat.com>
In-Reply-To: <20240319120410.1477713-1-mike.malyshev@gmail.com>
References: <20240319120410.1477713-1-mike.malyshev@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 12:04:09 +0000
Mikhail Malyshev <mike.malyshev@gmail.com> wrote:

> When trying to run a VM with PCI passthrough of intel-eth-pci ETH device
> QEMU fails with "Permission denied" error. This happens only if
> intel-eth-pci driver is dynamically unbound from the device using
> "echo -n $DEV > /sys/bus/pci/drivers/stmmac/unbind" command. If
> "vfio-pci.ids=..." is used to bind the device to vfio-pci driver and the
> device is never probed by intel-eth-pci driver the problem does not occur.
> 
> When intel-eth-pci driver is dynamically unbound from the device
> .remove()
>   intel_eth_pci_remove()
>     stmmac_dvr_remove()
>       pm_runtime_disable();

Why isn't the issue in intel-eth-pci?

For example stmmac_dvr_remove() does indeed call pm_runtime_disable()
unconditionally, but stmmac_dvr_probe() only conditionally calls
pm_runtime_enable() with logic like proposed here for vfio-pci.  Isn't
it this conditional enabling which causes an unbalanced disable depth
that's the core of the problem?

It doesn't seem like it should be the responsibility of the next driver
to correct the state from the previous driver.  You've indicated that
the device works with vfio-pci if there's no previous driver, so
clearly intel-eth-pci isn't leaving the device in the same runtime pm
state that it found it.  Thanks,

Alex

> Later when QEMU tries to get the device file descriptor by calling
> VFIO_GROUP_GET_DEVICE_FD ioctl pm_runtime_resume_and_get returns -EACCES.
> It happens because dev->power.disable_depth == 1 .
> 
> vfio_group_fops_unl_ioctl(VFIO_GROUP_GET_DEVICE_FD)
>   vfio_group_ioctl_get_device_fd()
>     vfio_device_open()
>       ret = device->ops->open_device()
>         vfio_pci_open_device()
>           vfio_pci_core_enable()
>               ret = pm_runtime_resume_and_get();
> 
> This behavior was introduced by
> commit 7ab5e10eda02 ("vfio/pci: Move the unused device into low power state with runtime PM")
> 
> This may be the case for any driver calling pm_runtime_disable() in its
> .remove() callback.
> 
> The case when a runtime PM may be disable for a device is not handled so we
> call pm_runtime_enable() in vfio_pci_core_register_device to re-enable it.
> 
> Mikhail Malyshev (1):
>   vfio/pci: Reenable runtime PM for dynamically unbound devices
> 
>  drivers/vfio/pci/vfio_pci_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --
> 2.34.1
> 


