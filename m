Return-Path: <linux-kernel+bounces-94815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB8874587
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9032288407
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075B4C8B;
	Thu,  7 Mar 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrCNbtB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935141391
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773625; cv=none; b=q5vDzzbQ6aRzzsm65nLRUZ5hfypzHZND+jUAObury+1T6faG5SJj/R7RW36Oefgk7q3DIM+qNNYxQeY4yd+osPlp8QQGSBuQPQxzrmK5RgMi08qmO5VY9SxMuFhnG2cM+fEEnftZW+ZPuK5J/gbl1grq5HOH+6/3TAffRsmQdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773625; c=relaxed/simple;
	bh=4bqWptoKbnRgrpqaRERXOF58F2B3DTRxO8EnLm4nMi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWzQ4DDSkePy8Pg2CBZHVTP/kvue6smp+WgkwWfAtmbMZ/Y4jfE21NTG6xwxxdVijigJwwkpoVdaoKaPpITP5kJwA7td3/CgE6K/En4dLb4zMbcdM+wJFZVpFksT9AtJza59RxAzdNJGjmyV/fM60qJZO19WloLVXrcr/cEuc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrCNbtB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A7C433F1;
	Thu,  7 Mar 2024 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709773625;
	bh=4bqWptoKbnRgrpqaRERXOF58F2B3DTRxO8EnLm4nMi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jrCNbtB5YcSuEDMNq1BjhKJby+ulYRhhfEgvyaD6HS83j6LLzr4zGgEum1aMRBPuI
	 bV3ZqX/QGlLYpzAuXjV2syAfOSsMspXu+++FJ6AddCtrWXg1vgtknrlRHyt1MuptGl
	 DiNEnMUvG54BNfY8Z0CYT2qahjhlM7IcISZHkepKoPMjXPt1M9F4vI9MLCOg/gRbMW
	 YT3oeSDCQ4AFaUyKpuxJVN1MJib+7weIJLayFbKDCst0gaO6YBVOZup3advBOCUzQo
	 oOuIsyhSAGkmt8LB4v3bfbDR1rWzpcAEW/kNBL3XcMyxQ8YzzTEbYuZH5Jpm2vb/Fn
	 wDjmX6zgF4g/A==
Message-ID: <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
Date: Thu, 7 Mar 2024 09:07:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
 <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/6 14:51, Gao Xiang wrote:
> 
> 
> On 2024/3/6 13:31, Gao Xiang wrote:
>> There are mainly two reasons that thp_get_unmapped_area() should be
>> used for EROFS as other filesystems:
>>
>>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>>     mappings");
>>
>>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>>     THPs for read-only mmapped files (e.g. shared libraries) even without
>>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>>     for non-DAX").
> 
> Refine this part as
> 
>   - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
>     which enable THPs for mmapped files (e.g. shared libraries) even without
>     ...
> 
>>
>> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
> 
> Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
> Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
> 
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

