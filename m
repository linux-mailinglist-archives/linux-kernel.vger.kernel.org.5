Return-Path: <linux-kernel+bounces-119075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1488C3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D2D304621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC012A146;
	Tue, 26 Mar 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFdXl7/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF680636;
	Tue, 26 Mar 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460439; cv=none; b=LSRfATpwMBVaBr/+NLqUPIt0gnZK+nUiru7aVh1EZ9R0rb2UrgoFGwRq8zAzsqpnVdJ3R303sA9ecLAysP6JM2TgwZ3BSHvP0Rg2q8WK1VkNuzIh8OkU4nl038T8tDTYTme3f0doM+LrZ8fvYJ5GL+yzjt11pIKgtHTIZO8ccTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460439; c=relaxed/simple;
	bh=frbkNVRzMBWKQzm1ZJzR0crhcSQzWA8fXQBKk2O2Bos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeaPcZ4eAv3t2xSa/FyUqELxwYzityyxJRCVk5Id5WamiaAhY3ClmcXTtZ0FVDjIFr38FuKHZM0qptW0cHBEdCk6myRoQgKEhYM4cr0f55QokBed6PTqfJ0tqOlQ7AAleYm8ypIJj63ftW8ols3LsbMtcAo4nF3AqIm8CkM0myc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFdXl7/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A1EC433C7;
	Tue, 26 Mar 2024 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711460438;
	bh=frbkNVRzMBWKQzm1ZJzR0crhcSQzWA8fXQBKk2O2Bos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vFdXl7/9Q0TpEWbs8wJZQyjamY2ppsqiY3SDqD6pkgxF6M9U1DlwWOXTNu9UKXQdg
	 3fQ2HFTtOEm4q4wYvPKq0kBEAcEb18bn4D+n+HcZrP2J9GY4h+zTydu/E0fEIvslU4
	 cx56agXhkNYpRAHqqtbJXv3QrA7+rBR3S5ITIBVK5huT42MdvHhgK/6uhl9bOBPukr
	 b4ZoSSNEFQwEsU9fp8wQElawku0gj819Uzj1WbL70qXdbopXY0QZthZGsixee8QIhO
	 qhhFdSvD45teyEK8mAyWSacoK8t9Al2asK6FE3m5yL7M+kstnZng0+Yn5NTehf1ck+
	 gp6QH6gGAaNWA==
Message-ID: <79bca118-5027-4153-9fea-bda4c5ad6edb@kernel.org>
Date: Tue, 26 Mar 2024 22:40:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, Yihang Li <liyihang9@huawei.com>,
 yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 22:32, John Garry wrote:
>> John,
>>
>> Unrelated to this patch, but I wonder if the GFP_KERNEL used here shouldn't be
>> GFP_NOIO... Is this ever called in the IO path or error recovery ?
>>
> 
> These should not be called in the IO path - as they are management 
> functions. But I am quite confident that they can be called in SCSI 
> error handling (for libsas).

So it sounds like GFP_NOIO would be a lot safer...

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research


