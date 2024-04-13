Return-Path: <linux-kernel+bounces-143674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010A48A3C36
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A41A1C20B25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D43D547;
	Sat, 13 Apr 2024 10:22:13 +0000 (UTC)
Received: from rockwork.org (rockwork.org [45.32.92.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E024A0D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.92.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003732; cv=none; b=JMxA/+3xYKmcT0yrQFMrA2LIfaRt5nE/S5omh6ZdeH4L5aV2IpN2R76W7/L1MW6huTOWlglDDBi1Sy5E6+t7rGqPry4thq7DwL5EP1faqub6fwRsrVr/2oZpscg8tCCrvGM6CLm4UU9KpjPrqCGb4ZwjWhk0jUpy+nozIu7dZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003732; c=relaxed/simple;
	bh=cKfJqzwn1UM58rtsZxhexJzGwK67MEdN/QUZgx3CAHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC/k2do+hJcXlBLvAOnPKeNOGhkLymf0edGRdlmuw8E6/2Lwi45wA/m+hKs+n3CDcqo63/K47LPdV5YA9wrJsi4c189fbqpnMpriO9tIT3Ty7yrRjKjmq9FOZki4vzuVDGNjXukZzwZbm28JC+EKHJFnONQXVuWxWqMp9G+Js7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org; spf=pass smtp.mailfrom=rockwork.org; arc=none smtp.client-ip=45.32.92.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rockwork.org
Received: from [IPV6:2408:8340:c42:16f0:eb78:1cb0:d0a9:e8e3] (unknown [IPv6:2408:8340:c42:16f0:eb78:1cb0:d0a9:e8e3])
	by rockwork.org (Postfix) with ESMTPSA id 6537B5DD4A;
	Sat, 13 Apr 2024 10:15:11 +0000 (UTC)
Message-ID: <2688421d-37c2-4038-8d03-24ae175f137e@rockwork.org>
Date: Sat, 13 Apr 2024 18:15:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com, linux-kernel@vger.kernel.org,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>,
 linux-riscv@lists.infradead.org
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Xingyou Chen <rockrush@rockwork.org>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/20/23 03:33, Tomasz Jeznach wrote:
> ... > +#endif /* _RISCV_IOMMU_BITS_H_ */
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> new file mode 100644
> index 000000000000..c91f963d7a29
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -0,0 +1,134 @@
> ...
> +
> +static struct pci_driver riscv_iommu_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = riscv_iommu_pci_tbl,
> +	.probe = riscv_iommu_pci_probe,
> +	.remove = riscv_iommu_pci_remove,
> +	.driver = {
> +		   .pm = pm_sleep_ptr(&riscv_iommu_pm_ops),
> +		   .of_match_table = riscv_iommu_of_match,
> +		   },
> +};
> +
> +module_driver(riscv_iommu_pci_driver, pci_register_driver, pci_unregister_driver);

There's helper macro to be considered, and not forced to:
   module_pci_driver(riscv_iommu_pci_driver);

> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> new file mode 100644
> index 000000000000..e4e8ca6711e7
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -0,0 +1,94 @@
> ...
> +
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.driver = {
> +		   .name = "riscv,iommu",
> +		   .of_match_table = riscv_iommu_of_match,
> +		   .suppress_bind_attrs = true,
> +		   },
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,
> +	.shutdown = riscv_iommu_platform_shutdown,
> +};
> +
> +module_driver(riscv_iommu_platform_driver, platform_driver_register,
> +	      platform_driver_unregister);

And also:
   module_platform_driver(riscv_iommu_platform_driver);

