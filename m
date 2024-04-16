Return-Path: <linux-kernel+bounces-146547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B708A66E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F161C218C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831D84FBF;
	Tue, 16 Apr 2024 09:18:32 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C084A5F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259112; cv=none; b=Hd7OsM3nonXyqmSg7qFwbIgOAhHdkRiehYFfWFYoU21iKBhsdDuf3qFo89yMnnFTGqic1/lrKi2HlSQs/jplSa13H4reoRL2KrQblELACSHqG7CDMkF1P/3OisRrLRZ/CVnvppflSVULbJ61f8WdXTp+v7cmmmxfv2ZUx4HIFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259112; c=relaxed/simple;
	bh=6ltKxsUhCgXtSH/Nbj5y13LLbIa+X5H+TfQMw2M0eKM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=po9qZDoAPA6XD4FCjZWDUHTlHzeyEKByNG7zYPcpVRl9ZwT3gGQg/1etMDk9Rmxjrt+3RI0XsaVo0BBjPDpu3RNW+vu++F37SdOnZqNxCbpRaJMqEjSqZ2XLLkKi5d4+yur9voiuE2L2UU/u7UWWylpvWeXOD5Tn7iT/5Cn1XpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VJdg62BMVztQWF;
	Tue, 16 Apr 2024 17:15:30 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 74C9718006D;
	Tue, 16 Apr 2024 17:18:21 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 17:18:20 +0800
Subject: Re: [PATCH v2 1/2] mm/hugetlb: convert dissolve_free_huge_pages() to
 folios
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>, <jane.chu@oracle.com>,
	<muchun.song@linux.dev>, <nao.horiguchi@gmail.com>, <osalvador@suse.de>
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <767479f0-d2bb-d9f1-c835-93ad08111033@huawei.com>
Date: Tue, 16 Apr 2024 17:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/13 2:21, Sidhartha Kumar wrote:
> Allows us to rename dissolve_free_huge_pages() to
> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
> directly and use page_folio() to convert the caller in mm/memory-failure.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
> 
> v1 -> v2:
> 	- Change additional comments which reference hugepages to
> 	  hugetlb folios per Miaohe Lin. 
> 	- introduce patch 2
> 
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 17 ++++++++---------
>  mm/memory-failure.c     |  8 ++++----
>  3 files changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

