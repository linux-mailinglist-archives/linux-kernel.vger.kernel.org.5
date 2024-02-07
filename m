Return-Path: <linux-kernel+bounces-55853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D7184C281
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E505828B0A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7210798;
	Wed,  7 Feb 2024 02:29:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D602FBE9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272970; cv=none; b=mtrWCdGzoRJOJQ/f8BcicBAkSSOxc9NtBCPXwmdNhmDBqmRqbI+h2nv/ki4OafvH9XOiXgppw/wBjQhjUNvcr4xufErR0m7ENvUVy8xWOoBA4uPlkrOlw5BoWXyoSJWkbe2GwEMTaVrVR1S6E0t/xOHz6yDo5TsyhpkPm2g8q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272970; c=relaxed/simple;
	bh=rOi8zvoB9tOUzmjdFJPwR62NPAPMifWU7iPDsk7Dt10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exRe94DJh5S/G9reVEaxAvy+A3R1M+C7m6hxuscsqY5q6aNclegbB++TnaghEJ1kZEHl2TERDdafJtc44ljOAWu79PNeN67Wq7KpnwCvm0K2sv+CyCbAD/gSJhUGVH48QYCSK8hAi/J74l5A+fSwqD5uvCelU3V9r7i9+wCa6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68BD1FB;
	Tue,  6 Feb 2024 18:30:08 -0800 (PST)
Received: from [10.162.40.23] (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709133F762;
	Tue,  6 Feb 2024 18:29:24 -0800 (PST)
Message-ID: <8fff4340-368f-4e66-8839-1d54eea301f9@arm.com>
Date: Wed, 7 Feb 2024 07:59:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: Drop cma_get_name()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Sumit Semwal <sumit.semwal@linaro.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20240206041518.438801-1-anshuman.khandual@arm.com>
 <20240206142550.62bed7715692ddc0071da7d0@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240206142550.62bed7715692ddc0071da7d0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 03:55, Andrew Morton wrote:
> On Tue,  6 Feb 2024 09:45:18 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> cma_get_name() just returns cma->name without any additional transformation
>> unlike other helpers such as cma_get_base() and cma_get_size(). This helper
>> is not worth the additional indirection, and can be dropped after replacing
>> directly with cma->name in the sole caller __add_cma_heap().
> 
> drivers/dma-buf/heaps/cma_heap.c: In function '__add_cma_heap':
> drivers/dma-buf/heaps/cma_heap.c:379:28: error: invalid use of undefined type 'struct cma'
>   379 |         exp_info.name = cma->name;
>       |                            ^~
> 
> Fixing this would require moving the `struct cma' definition into
> cma.h.  I don't think that's worthwhile.

Existing forward declaration e.g 'struct cma' inside include/linux/cma.h does
not seem to sufficient for cma->name to be de-referenced. Agreed - moving the
definition for 'struct cma' into include/linux/cma.h is not worthwhile. Hence
please drop this patch.

