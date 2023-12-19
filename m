Return-Path: <linux-kernel+bounces-5372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A98189FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A7A1F2276B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14291C692;
	Tue, 19 Dec 2023 14:27:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBEB1B29C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 179AC1FB;
	Tue, 19 Dec 2023 06:28:38 -0800 (PST)
Received: from [10.57.85.119] (unknown [10.57.85.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D88D63F5A1;
	Tue, 19 Dec 2023 06:27:52 -0800 (PST)
Message-ID: <ef4fa484-5925-41b1-ace6-db14820c9c2e@arm.com>
Date: Tue, 19 Dec 2023 14:27:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-debug: make dma_debug_add_bus take a const pointer
Content-Language: en-GB
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@lst.de,
 m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <2023121941-dejected-nugget-681e@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2023121941-dejected-nugget-681e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-19 1:41 pm, Greg Kroah-Hartman wrote:
> The driver core now can handle a const struct bus_type pointer, and the
> dma_debug_add_bus() call just passes on the pointer give to it to the
> driver core, so make this pointer const as well to allow everyone to use
> read-only struct bus_type pointers going forward.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   include/linux/dma-map-ops.h | 4 ++--
>   kernel/dma/debug.c          | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index f2fc203fb8a1..e401f824a007 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -443,10 +443,10 @@ static inline void arch_teardown_dma_ops(struct device *dev)
>   #endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
>   
>   #ifdef CONFIG_DMA_API_DEBUG
> -void dma_debug_add_bus(struct bus_type *bus);
> +void dma_debug_add_bus(const struct bus_type *bus);
>   void debug_dma_dump_mappings(struct device *dev);
>   #else
> -static inline void dma_debug_add_bus(struct bus_type *bus)
> +static inline void dma_debug_add_bus(const struct bus_type *bus)
>   {
>   }
>   static inline void debug_dma_dump_mappings(struct device *dev)
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 3de494375b7b..1a5c86dd87d5 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -876,7 +876,7 @@ static int dma_debug_device_change(struct notifier_block *nb, unsigned long acti
>   	return 0;
>   }
>   
> -void dma_debug_add_bus(struct bus_type *bus)
> +void dma_debug_add_bus(const struct bus_type *bus)
>   {
>   	struct notifier_block *nb;
>   

