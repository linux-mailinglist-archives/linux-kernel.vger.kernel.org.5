Return-Path: <linux-kernel+bounces-122464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2088F7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279E31C24B90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D612E40D;
	Thu, 28 Mar 2024 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA7ekfYM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1275225A8;
	Thu, 28 Mar 2024 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607651; cv=none; b=B8Np3b1pWLnOSJJEGRx3nMECvov6ZHLKAzvWofeToB60OvTAH5QqnSmmFt8fbZ5x8vCzgPpHkaoP8zNA3G5+3944vgF20XUO2dZj+Qk7Iuhb7jPsawRBAJROMZ/bAK7dd+R+Vh397D/MSy9Tcqj2mtiWJbbzMoU4/wTXfem32wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607651; c=relaxed/simple;
	bh=OSZxUh1fu5GjMOOFW4rXi46zAlT98/Mr1omvAEd18D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhH4sbhnQWt8H8C/abliKnmkQJqMK3kXxyymyHY7ZeLZiZii44JFcrEZ6J9UMDp0hp8gfGkhbmTwAUGcqzTNjS1EVrFzm+SCXgWD9K8RraA1XkuPkc4J+XA8+36JlMMvtWtJ7LJgr0tn+ImA9BP1NZnvRT3YdO8LpEH/nYEez9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA7ekfYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046EFC433C7;
	Thu, 28 Mar 2024 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711607651;
	bh=OSZxUh1fu5GjMOOFW4rXi46zAlT98/Mr1omvAEd18D4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CA7ekfYMrb3MoijNkweqAgV2XtAzjHiMXqM2FdwZ5eP/CnRHuADpIXSy4KXo1Auhm
	 lWGg8FVdyZ520+KXxIr2EZXrfE8nujD2YxrOvi6ci7XG2tAh+rDEJADMxNmF+pGsup
	 lfGYS5GCRVXXXJnZw3HpI7A4HdxbUIABMEfuaGKo3HNkfY+pf4T6T+aWfzfh5P5MPE
	 1/34rJWCHDr8Nc4wKK6zcxSfBuK74ZevRqmNX5Au4GCcue+N9srGVSbbVfJYuNkEkP
	 ebalC39ZVykIlJ4AC0YMM62lGUin5Vmbhm8L5RKe285p+v+E4RPMh6TuT9sTFNkkLs
	 vo38nVEjtH0iw==
Message-ID: <8e0129c9-c9c1-4c50-8c5b-ce902c91c5ad@kernel.org>
Date: Thu, 28 Mar 2024 15:34:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: libsas: Allocation SMP request is aligned to 16B
To: Yihang Li <liyihang9@huawei.com>, john.g.garry@oracle.com,
 yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240328062657.581460-1-liyihang9@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328062657.581460-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 15:26, Yihang Li wrote:
> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
> through kmalloc() allocation. However, for the hisi_sas hardware, all
> commands address must be 16-byte-aligned. Otherwise, the commands fail to
> be executed.
> 
> So use 16B as the alignment for SMP request.
> 
> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
> Signed-off-by: Yihang Li <liyihang9@huawei.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
> Changes since v2:
> - Use 16B as alignment for SMP requests instead of ARCH_DMA_MINALIGN.
> 
> Changes since v1:
> - Directly modify alloc_smp_req() instead of using handler callback.
> ---
>  drivers/scsi/libsas/sas_expander.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..5ddbd00d5c76 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>  
>  static inline void *alloc_smp_req(int size)
>  {
> -	u8 *p = kzalloc(size, GFP_KERNEL);
> +	u8 *p = kzalloc(ALIGN(size, 16), GFP_KERNEL);
>  	if (p)
>  		p[0] = SMP_REQUEST;
>  	return p;

-- 
Damien Le Moal
Western Digital Research


