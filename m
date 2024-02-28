Return-Path: <linux-kernel+bounces-84619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DA86A913
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC60C1F2535F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B43250ED;
	Wed, 28 Feb 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sToOitBS"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEA24B2C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106015; cv=none; b=H3VdN0PFQq2iaShmC+pZ27jC/T+zIjsiSWLfl0blBci/7f9c4FF2umD9N8xGGmCCeXkZ5xmNN1045jFZZp06in3P0CNeUjqrzZATx+KjnoK1Po3UwZJTZDJorkTEZsniHX7EiC4t6I+zZe+rzwT80TjVgpiBV0y+Y6GzmmPmgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106015; c=relaxed/simple;
	bh=/ZcikVKrKa47NsNBkq0WwBavuImevglQcR7J8WjNGnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+XOrj4vLUYXyxzbsCSIfvy7Apd1jyKMUjIs78W0By0IqZEpUt0dh3sfq23fz1vVmsD8AZ6E38w6TVRwuDQ+PgHuzXTHWQOqeaV2uvjqkCfVme1XYiYXfxVPg8LpgvBHTF8Jm+MkkSOgStonScPCryRjSA4BJyOINCFoy2sobaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sToOitBS; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709106010; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NVlJ77mhRzQ/mcmS2t+ED1kMM0vLY+HiiLyI/tdXrLI=;
	b=sToOitBS4JvBIbA+OMvG1iicswb2Eyd/Opy6ozhgZyOzvqi7PfKOKpj7OqB6PYyRdIaP34lXm2kKsaRN3ryl5X5r2NX2pg++m7GHKnqCBsYBJQFnJARs3eVwu4OqBnWe8YltnMdLvrx6EJcYYBDSIDq1yAb+go5gxarHzMIfULg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1P0G-v_1709106008;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1P0G-v_1709106008)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 15:40:09 +0800
Message-ID: <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
Date: Wed, 28 Feb 2024 15:40:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
 <Zd38_AYtr9QKp-F6@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zd38_AYtr9QKp-F6@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/27 23:17, Oscar Salvador wrote:
> On Tue, Feb 27, 2024 at 09:52:26PM +0800, Baolin Wang wrote:
> 
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2567,13 +2567,38 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>>   }
>>   
>>   static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
>> -				     int nid, nodemask_t *nmask)
>> +				     int nid, nodemask_t *nmask, int reason)
> 
> I still dislike taking the reason argument this far, and I'd rather have
> this as a boolean specifing whether we allow fallback on other nodes.
> That would mean parsing the reason in alloc_migration_target().
> If we don't add a new helper e.g: gfp_allow_fallback(), we can just do
> it right there an opencode it with a e.g: macro etc.
> 
> Although doing it in an inline helper might help hiding these details.
> 
> That's my take on this, but let's see what others have to say.

Sure. I also expressed my preference for hiding these details within the 
hugetlb core as much as possible.

Muchun, what do you think? Thanks.

