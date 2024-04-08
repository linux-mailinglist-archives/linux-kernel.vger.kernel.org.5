Return-Path: <linux-kernel+bounces-135318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA489BEF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4828A2859C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239886AFB9;
	Mon,  8 Apr 2024 12:27:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263372D057;
	Mon,  8 Apr 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579239; cv=none; b=M1L5JRakw+EMV16CM7bhGvpIkvUh1fElFasjv4HosDhe3ghKH4LUEpdLrUsK16b9KxaVpG3xWgr3lkwUfvKL3LWmXiCNR2oZhyPua2JkXuIasaL/avn2FIRyaqEqA0wgmSzYsuLWVudArNqflO2wp79OzGYF6K++WFK6MIqC898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579239; c=relaxed/simple;
	bh=6wgT8FIhKnWbuRXBiRVHGkeD1dvaZerj7s+LagQqc4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM5OmIjpOsjthT2bIs9k40PywPVys7912i1XlvKFqcVSAtQSkhNQNHNQxjbbo1gsxP/7bSqZ++Q1QPXIQ+4WnDrPGfdCUVxCVn5Ktfl5b1f+wZcxcBmIeSVpMyroLceD4OV4O5ktKwggp9SH/hV6a69duPJ6+GpOOC1pG35Z9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E09BEDA7;
	Mon,  8 Apr 2024 05:27:47 -0700 (PDT)
Received: from [10.57.73.196] (unknown [10.57.73.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8923F64C;
	Mon,  8 Apr 2024 05:27:15 -0700 (PDT)
Message-ID: <effb8ca8-9d45-45d1-afab-467d0ac20fbd@arm.com>
Date: Mon, 8 Apr 2024 13:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: clean up some types in
 panthor_sched_suspend()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <85356b15-4840-4e64-8c75-922cdd6a5fef@moroto.mountain>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <85356b15-4840-4e64-8c75-922cdd6a5fef@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 08:36, Dan Carpenter wrote:
> These variables should be u32 instead of u64 because they're only
> storing u32 values.  Also static checkers complain when we do:
> 
> 	suspended_slots &= ~upd_ctx.timedout_mask;
> 
> In this code "suspended_slots" is a u64 and "upd_ctx.timedout_mask".  The
> mask clears out the top 32 bits which would likely be a bug if anything
> were stored there.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Steven Price <steven.price@arm.com>

If you fancy a bit more clean-up then I think faulty_slots is completely
redundant as a separate variable. In particular in the "if
(suspended_slots)" section it's updated but that updated value is never
used... otherwise I'll put it on my list for cleaning up later.

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index d4bc652b34d5..b3a51a6de523 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2546,7 +2546,7 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
>  {
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  	struct panthor_csg_slots_upd_ctx upd_ctx;
> -	u64 suspended_slots, faulty_slots;
> +	u32 suspended_slots, faulty_slots;
>  	struct panthor_group *group;
>  	u32 i;
>  


