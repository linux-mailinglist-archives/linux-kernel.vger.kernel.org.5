Return-Path: <linux-kernel+bounces-57699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969AC84DC7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30301C238EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116AA6BFA7;
	Thu,  8 Feb 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n59bghUE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893B6BB36
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383479; cv=none; b=STrRH4lDMBbhpd567Kb4OEutZSssX8VuyqIoMdPnNZOvI4601MG70qeY11nDd5IRP6hwe3zb4ZDqQtIwZiHGLX7HXE+3mwlGiY5DTpputO1QYbMg/yfhc73Xe/+8qjX3FxkHunRrmY7BSbhZh59SHyrntr8FzbHnnGLzqIBb1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383479; c=relaxed/simple;
	bh=p7M5LRY2IIR3JbhYpi12gul04UVDehtCNBndvFQhT4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ3L9V2W938+hlCW39cYraDDIaHUr+Z0O9RvrQkrucmUg2AtDaczWLLaca0MD11BQ1f1oEGxhevFPheDR24ekcu/5hQp/4xxbUs13vZHaO7IUEfz5Dq8D+B7aXOIHJHJsvXptGbaPxdE1OdlT+cotzYpgtal6egZUAlFg6zSkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n59bghUE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so105696e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707383475; x=1707988275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o6hMNIZUaBRVM7gi8uDMiowpTMxtF27cC2fdkjBJWH8=;
        b=n59bghUEZpcupbyWHTOfn5fjBy3lHpyanCd3+vpbeNeQygNyJzf9U8bchu+ymVMBH2
         ZiUZappNAzxSGHH+j1QJVV0jz8Jrw3v0dEZ45dRaIbjFO3FAU364yjybdpblnOhU/5kE
         PsyNirQDRDYX25xf7uABvAVnw9DroPZ2kARfGAoH8uov7LZOTafBYSzpcewav9N+fBBR
         fPzYrZQ+a3EzMjbFr7Rh2lpFU9jOxqXSJ1e0B8AJH3ZEfRX2WXdClLtb7PsGxFL2eFW5
         9wQZpIdTG5U87HUq5uNLTjPxvQR58YV7QeekO9VOlba+GUQd40AiHTolEf+Gpd9wa/Zk
         kPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383475; x=1707988275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6hMNIZUaBRVM7gi8uDMiowpTMxtF27cC2fdkjBJWH8=;
        b=qjNoyr3tUepP9EftJL/DfB3GkvFRf2ZDMxrYMRXlD24kNiNEWSqSZl1akYStAZ8ImO
         O7NCsutylKDLU9TpofAkt59wbvljkfBjWSnjR2eeuTU+cbwyGmPyM67YmnF5gqcHJlIt
         pMsNQayzgN0iFGZQHrY8yFDUr3fqhN89BqftkjMEvKAfSbk09OVraFo0i7VsVZDTUtco
         ItslGGlcnxgxJpTeHyyPbSaQPXysLR5+KbzI8LiprCR44PfKYXy6MFHj1kiPYFnRTGdS
         3wAAR53afIs+5qCrt3Lm62EbcqvBng1wUNz5h9rhZDjsKkz9asEDYC+hC7lWetHH2owd
         oXBg==
X-Forwarded-Encrypted: i=1; AJvYcCUcPDINXgBETxVY+F0xBXtc13Cqq0fznEOqtxz5BkwtbAeGUwgFEzzSWC/OavHYQEvTCbnbsZTrheB2gJ5MqwwlPSntvyj5GDI4Yd4U
X-Gm-Message-State: AOJu0YxtSNizBJ5y/aDQWvmBXBVxGVwgrfhlwGyZBOVxijLrljqI/mDD
	aGKP1yB8LllxdMIMXvmaedWZY+zsJ15cRj2DSdrE1UUlpF/MCw4bCKzgqeQmpavKfRNM0OmMIeO
	XfDRK2CpMwNELilHCzcPNYeW5lF3d8dIx243smQ==
X-Google-Smtp-Source: AGHT+IEdMMmX0qUysZ36JNG6vjjPDWbDnwCkmT8i09RQZO80h9rQ9AXsc+CoHbdB4Czk7n8tQfMWuFQWC0VHbAenhUk=
X-Received: by 2002:ac2:4107:0:b0:511:6d76:4a6 with SMTP id
 b7-20020ac24107000000b005116d7604a6mr980330lfi.49.1707383475362; Thu, 08 Feb
 2024 01:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207013325.95182-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240207013325.95182-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 8 Feb 2024 17:11:04 +0800
Message-ID: <CABQgh9G_KCNjj4TvKzG04cQVPsWn2OCSEd_vK10fBtJtWX4E0Q@mail.gmail.com>
Subject: Re: [PATCH v12 00/16] iommu: Prepare to deliver page faults to user space
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Longfang Liu <liulongfang@huawei.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 09:39, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> When a user-managed page table is attached to an IOMMU, it is necessary
> to deliver IO page faults to user space so that they can be handled
> appropriately. One use case for this is nested translation, which is
> currently being discussed in the mailing list.
>
> I have posted a RFC series [1] that describes the implementation of
> delivering page faults to user space through IOMMUFD. This series has
> received several comments on the IOMMU refactoring, which I am trying to
> address in this series.
>
> The major refactoring includes:
>
> - [PATCH 01 ~ 04] Move include/uapi/linux/iommu.h to
>   include/linux/iommu.h. Remove the unrecoverable fault data definition.
> - [PATCH 05 ~ 06] Remove iommu_[un]register_device_fault_handler().
> - [PATCH 07 ~ 10] Separate SVA and IOPF. Make IOPF a generic page fault
>   handling framework.
> - [PATCH 11 ~ 16] Improve iopf framework.
>
> This is also available at github [2].
>
> [1] https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/
> [2] https://github.com/LuBaolu/intel-iommu/commits/preparatory-io-pgfault-delivery-v12
>

Wandering are these patches dropped now,

[PATCH v2 2/6] iommufd: Add iommu page fault uapi data
https://lore.kernel.org/lkml/20231026024930.382898-3-baolu.lu@linux.intel.com/raw

[PATCH v2 4/6] iommufd: Deliver fault messages to user space
https://lore.kernel.org/lkml/20231026024930.382898-5-baolu.lu@linux.intel.com/

And does iouring still be used in user space?

Thanks

