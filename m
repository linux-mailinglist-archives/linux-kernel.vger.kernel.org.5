Return-Path: <linux-kernel+bounces-116459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052A88A413
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957DEBA4D86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916215EFB4;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B55184322;
	Mon, 25 Mar 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337815; cv=none; b=ZeEbhrSB2Of45wZ+qZm7sA6gjMOMiub9UIh0kplosLpg/rEFJqQslPf3KxXV0zqZtZbltQwkkjGTg59p1wz7NxF+u2q2qXlvZIyR9tLBiePi50tgg0/qhBWNiZnl+5I0cvo9MpdfJ5BcfdoiBV95Nrt85K1mnOUsuxjWOIvo4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337815; c=relaxed/simple;
	bh=4lL5XnMf7GNTkV3kYDbLRsz5MXFmRO+PFX0TJ+76mGg=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U+ge3BOIP2afoy0/rd/dw/sF+ReGya2AYNsN5MsCOTvoedJQwM6KWHFyRFXjlPZ+5TDByXOtmdzpiSUHPh/W6hRTZzzweQ2IwENQKmAXtvSjlFZOU242sDjUwmVRbjiD9fvvY9XTKtwJ2vWyluiTd07in+KRIh39ZD7kTZ1ezfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V2z7S5nsKz1h3fw;
	Mon, 25 Mar 2024 11:34:12 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A3421A016C;
	Mon, 25 Mar 2024 11:36:50 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 11:36:49 +0800
Subject: Re: [PATCH stable-5.10] mm/memory-failure: fix an incorrect use of
 tail pages
To: Matthew Wilcox <willy@infradead.org>, <stable@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240307124841.2838010-1-liushixin2@huawei.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Sasha Levin
	<sashal@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Naoya Horiguchi
	<n-horiguchi@ah.jp.nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <026db58d-feea-8191-616a-3e6dca592786@huawei.com>
Date: Mon, 25 Mar 2024 11:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240307124841.2838010-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)

Hi,

After backport commit c79c5a0a00a9 ("mm/memory-failure: check the mapcount of the precise page"),

I got an error message as written on the patch. The problem can be fixed by the patch or just revert.

Now I prefer to revert because I think it is related to folio and no impact in stable, or maybe I'm wrong.


Thanks,


On 2024/3/7 20:48, Liu Shixin wrote:
> When backport commit c79c5a0a00a9 to 5.10-stable, there is a mistake change.
> The head page instead of tail page should be passed to try_to_unmap(),
> otherwise unmap will failed as follows.
>
>  Memory failure: 0x121c10: failed to unmap page (mapcount=1)
>  Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored
>
> Fixes: 70168fdc743b ("mm/memory-failure: check the mapcount of the precise page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f320ff02cc19..dba2936292cf 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1075,7 +1075,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  				unmap_success = false;
>  			}
>  		} else {
> -			unmap_success = try_to_unmap(p, ttu);
> +			unmap_success = try_to_unmap(hpage, ttu);
>  		}
>  	}
>  	if (!unmap_success)


