Return-Path: <linux-kernel+bounces-1211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FD814BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20060B20E74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760C39FEA;
	Fri, 15 Dec 2023 15:25:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B536AEA;
	Fri, 15 Dec 2023 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d9f7af8918so673341a34.0;
        Fri, 15 Dec 2023 07:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653898; x=1703258698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1KxO6deZnelp4zRShdYeXlRDuUBsn1JgcYXM2Knxlg=;
        b=PwSl3Iunve/zkU7EPNhxvQyDkFA4RlutWQmk0FaV1xZNWoWRjJiDqyd7nwx9fTI5kk
         RblVqCFBL64ogERGeARPBpWnINPU4vPRvZ9pjlI3NT2i6MoqLxtfFpflxqGia3ogBZpO
         UWW5S6U790HOrUDchqwBaGXvJYieJj24mLRjp1OLpnTJ2a98tKdeLyBwd8ReR9kyx9cd
         wK4r17mhUn2NJYaqrme4/9G13IhNV1ttbqJiFBkeaEzWWijXFVQyqCyUZhMlQOVI3KbB
         YOOQ4SDEavjtfK/OytwKPgsgSo9XV00txciqf3lS9jXqHpVNcXzBoZuIQYCrWAj2jQV0
         GAOw==
X-Gm-Message-State: AOJu0YyXZAUzwytwHBov68jUq+cQjDiPfh3RSR/cJBfPX5keQ5toR8yr
	9gFs2P4bxQk89VlV7C0BTg==
X-Google-Smtp-Source: AGHT+IF3DdJW74bPK38SUphJlKZ+n/hKitiokKcgMWBUN3B1WSrWQktRoS8P3zNv/uR0dgu1UFGlXA==
X-Received: by 2002:a05:6830:1107:b0:6d9:f66e:f557 with SMTP id w7-20020a056830110700b006d9f66ef557mr11375830otq.8.1702653898434;
        Fri, 15 Dec 2023 07:24:58 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m18-20020a9d6ad2000000b006d7e23c58b6sm3614287otq.38.2023.12.15.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:24:57 -0800 (PST)
Received: (nullmailer pid 3989129 invoked by uid 1000);
	Fri, 15 Dec 2023 15:24:56 -0000
Date: Fri, 15 Dec 2023 09:24:56 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Frank Rowand <frowand.list@gmail.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Dexuan Cui <decui@microsoft.com>, Vineet Gupta <vgupta@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Wei Liu <wei.liu@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v2 4/7] dma-mapping: Add helpers for dma_range_map bounds
Message-ID: <170265389548.3988948.144759236279201432.robh@kernel.org>
References: <cover.1702486837.git.robin.murphy@arm.com>
 <16d3e9100cd4a4a397641df963f416cc7f70cc4c.1702486837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d3e9100cd4a4a397641df963f416cc7f70cc4c.1702486837.git.robin.murphy@arm.com>


On Wed, 13 Dec 2023 17:17:57 +0000, Robin Murphy wrote:
> Several places want to compute the lower and/or upper bounds of a
> dma_range_map, so let's factor that out into reusable helpers.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: fix warning for 32-bit builds
> ---
>  arch/loongarch/kernel/dma.c |  9 ++-------
>  drivers/acpi/arm64/dma.c    |  8 +-------
>  drivers/of/device.c         | 11 ++---------
>  include/linux/dma-direct.h  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 23 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


