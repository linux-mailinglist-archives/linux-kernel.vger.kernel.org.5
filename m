Return-Path: <linux-kernel+bounces-91762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36332871637
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE15D1F21F85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90157D3F8;
	Tue,  5 Mar 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVlHhubE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BD7B3E7;
	Tue,  5 Mar 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622410; cv=none; b=Mil0psBYgwsSP7cQ/0/Tbjxy2NtXBRNHuPAdVOby1OdIyg3IzjwuQs4MeSsrNrGHw4+SmhlrqaJmV54/eNHW19IsmV8qMac5jPKUGksj16ombC3+k0lhoA/eBdkKBHjCtbTT6fvEqdh4equmL29kjxRnIctuIBpuISQqbpywYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622410; c=relaxed/simple;
	bh=RIZdtkpm4Ekv09ZANlxpUUyxGm+RWP9Hdn8uJuss4yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+fDGSwzeUk11B5+pBGEhUtBsBRHqQDdRnS8PNsAlyssDLcYfd2yjwBfV+RX1OesIZnM6ZQ0bqXmG2s8msqac8Iaw59n55VIH56Vuh5YFUj5F5V6h685kqS0pbAKFPDV2HI/7EhQetIntglTOosSn8Yl8/W62Vgnxp5CRvP0tSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVlHhubE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC9C433F1;
	Tue,  5 Mar 2024 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709622409;
	bh=RIZdtkpm4Ekv09ZANlxpUUyxGm+RWP9Hdn8uJuss4yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dVlHhubE+DL2GE9Wp85pdrTqtHazfjqAkZwDoCg9r46t/R6zk6Y9FyLopnJAXgd1e
	 XJv2XwQsRw0fnyGZDFcsqqGLBXDddTT/md4FFLSalyCPFfVXgvHyMZEV+zsOW3qYJe
	 UADxQ3gs2+pwi+eGtjhqYJAJNSQboqi63MTXQ/HP7WULLlJbAjmpcjIKZwPmRhE5k1
	 D/pPeqJpUMJwnNiv423r1EDnb2ByupUcKLeMPPzspRwm/TYTIRfk0GJ/WzPpk2YIcZ
	 pSSsNIRWC5bkai5muZXo92NJnaluRkBimin+8rdHodAYBYIKwdvcF1IMZh1DgRiQOy
	 +jI7PJIlo4FJA==
Message-ID: <1d3dbc08-654c-46f6-a53d-43deeda5c14f@kernel.org>
Date: Tue, 5 Mar 2024 16:06:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: move capacity validation to blkpg_do_ioctl()
Content-Language: en-US
To: Li Lingfeng <lilingfeng@huaweicloud.com>, axboe@kernel.dk,
 min15.li@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com
References: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 12:21, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 6d4e80db4ebe ("block: add capacity validation in
> bdev_add_partition()") add check of partition's start and end sectors to
> prevent exceeding the size of the disk when adding partitions. However,
> there is still no check for resizing partitions now.
> Move the check to blkpg_do_ioctl() to cover resizing partitions.
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

But I wonder if this needs a Fixes: 6d4e80db4ebe ("block: add capacity
validation in bdev_add_partition()") tag and Cc-stable...

-- 
Damien Le Moal
Western Digital Research


