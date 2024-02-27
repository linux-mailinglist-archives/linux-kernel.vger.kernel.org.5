Return-Path: <linux-kernel+bounces-83544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F4869B38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8232328A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33A14601E;
	Tue, 27 Feb 2024 15:53:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0213DBA4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049190; cv=none; b=ArtmjHRNWUuMSSOGMnM5dP23++SGB3hUJuXV1KBxgO56aqUnyC323PL4ElQyHxqtUtEWjPd21q9h2HNiV+i/iPeM8G/dauvV3/y+7IZHFWS99vmxPVkIJ4sCV3pET1WCkHhj2TaO1wv9XH6PdcFmP0dJKZWX9A9X8PLqiaNK9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049190; c=relaxed/simple;
	bh=20LAPwHAALBc7f1xxFAOBHsiasE4WVaDzQaiCUGjsmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljcxiphRlWLxnk8n9y/GZG8vAACtpO0GKBA7ZRAzqERYLQ6ikge4loH8UNg2nOZqXUCFwwLhrj4x7gQMMvgUl3+vSvIYK0xG7L7vPGXYAt8pj8LMXoLpmQqNDcW4sv4IH85REqya7NX41eAhX3K1sRlL8mVkiuqS8jCy7AiGP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133C8DA7;
	Tue, 27 Feb 2024 07:53:46 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3503F762;
	Tue, 27 Feb 2024 07:53:06 -0800 (PST)
Message-ID: <57c928e6-14a4-4724-8c07-e985a2bce522@arm.com>
Date: Tue, 27 Feb 2024 15:53:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org> <Zd4CcL3Nnvybw2xF@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Zd4CcL3Nnvybw2xF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2024 3:40 pm, Christoph Hellwig wrote:
> On Wed, Feb 21, 2024 at 11:35:04AM +0000, Will Deacon wrote:
>> +static size_t iommu_dma_max_mapping_size(struct device *dev)
>> +{
>> +	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
>> +		return swiotlb_max_mapping_size(dev);
> 
> Curious: do we really need both checks here?  If swiotlb is active
> for a device (for whatever reason), aren't we then always bound
> by the max size?  If not please add a comment explaining it.
> 

Oh, good point - if we have an untrusted device but SWIOTLB isn't 
initialised for whatever reason, then it doesn't matter what 
max_mapping_size returns because iommu_dma_map_page() is going to bail 
out regardless.

Thanks,
Robin.

