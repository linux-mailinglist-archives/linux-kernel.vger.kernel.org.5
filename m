Return-Path: <linux-kernel+bounces-98405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BB8779A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA77B212CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048B10E5;
	Mon, 11 Mar 2024 01:52:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961BEBE;
	Mon, 11 Mar 2024 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121922; cv=none; b=d8txKkYz78ItyEQfxfTvMqYOvE6B/1U8Ao6qzscHxVNTUlHj7FaJDzzoTE3S6+gibZTllXA0PrmHPSKxuMC1Kc/8jC7gTlsfF7QUNsJqXvTcFCZOhq8mAyseD6jkmLK1WMzViFV94WJPTYVxpctonW/XU5rH9wj5OJXy03LInZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121922; c=relaxed/simple;
	bh=lcvb6GVZVmZ7eBM8aE5/I0RYqZqgLNHqdjhd/cKtC90=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c2nrjNFhPaKiPVyVLNj7A4Hhpu2JfdbPbhDQU94W+951FEHXD9iK7c4jlbOFLSiVw1O1rXQY0+wEzolRcCtXE/fS9dhgZAJLUx4F2zLvSkMsv+UL0GeUr6NteXIwlQUOiE6AV6HoJD03tDcZ5roV7zEWg+lU4y7IaGOhesnSM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TtKT80PTJz2BfpM;
	Mon, 11 Mar 2024 09:49:32 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 4177A1A0172;
	Mon, 11 Mar 2024 09:51:57 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 11 Mar 2024 09:51:56 +0800
Subject: Re: [PATCH stable-5.10] mm/memory-failure: fix an incorrect use of
 tail pages
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240307124841.2838010-1-liushixin2@huawei.com>
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <cb1cba51-69a9-846f-250c-4740938eb10e@huawei.com>
Date: Mon, 11 Mar 2024 09:51:56 +0800
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200004.china.huawei.com (7.185.36.141)

Hi, Greg,

There is a bugfix for 5.10-stable, 5.4-stable, 4.19-stable. Introduced when backport

commit c79c5a0a00a9 ("mm/memory-failure: check the mapcount of the precise page").

[1]: https://lore.kernel.org/stable/20240307124841.2838010-1-liushixin2@huawei.com/

[2]: https://lore.kernel.org/stable/20240307125053.2847205-1-liushixin2@huawei.com/

[3]: https://lore.kernel.org/stable/20240307125150.2849068-1-liushixin2@huawei.com/


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


