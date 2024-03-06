Return-Path: <linux-kernel+bounces-93588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C386873243
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A75EB279CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13815D8F1;
	Wed,  6 Mar 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZCSHeNOm"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B453717C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715512; cv=none; b=AkOGKMp3qvNs4nmJU8N2RcsQ79aTrYvZvjhH4vtSt2VaiuT9lpqna/nHv7nVtFvovjxWuSBZPrfAgM175oV1JUQEJK26hL+QtF80wxVxkTaJ6R2KIX34i1aNABzyHCObGUbWw1J00lrjJ26bn3qwNs3jM1yAsaStUyAaGAGraMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715512; c=relaxed/simple;
	bh=me5Ntro2kYOqnhKhbjphMxZIL2wbGHBbxsGTR12xtlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nooy6R4wui7oygc/vBmFzdLvWyLO+uyklZHi/7XukSRXgheHY+MRUm7UlhP52X5gRGdPkjUPRLqk14N7Iosc3cdUJIAfReInYXyDlC/JUBl/1NOthvB9kFgMYOUYcsqHEqOfGSVgjmeud6/1/gfxUyByALgNhho8stk+UqMlO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZCSHeNOm; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709715506; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8sqL5oufDdJey+dd6E71N6P0bC3HDZLL4i4IRfJyaUM=;
	b=ZCSHeNOm73OmUcFeb3pc59FQ/9hAsgNsmY0dVrhekLRBUO78p08aDPdM3fzovGB7vlC9LB83nr3Lrpr1mZigBdUwXheFIh1/Tuh5EFaYj+cx4fJ7/gJHN5lEzvFssLrGO+NyNFvCikl4/D1oAompjvaOqG18jwJDYC8qi+AG/Qc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1wuDqC_1709715505;
Received: from 30.97.56.47(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1wuDqC_1709715505)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 16:58:26 +0800
Message-ID: <d45de441-ff6f-463b-97d1-49341852dd14@linux.alibaba.com>
Date: Wed, 6 Mar 2024 16:58:23 +0800
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
 <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
 <Zd7xnrzGb_8QiqcE@localhost.localdomain>
 <3eda72bd-25ad-4518-b38e-b63f75e5e94d@linux.alibaba.com>
 <Zegta2FEb8pkV4vz@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zegta2FEb8pkV4vz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/6 16:46, Oscar Salvador wrote:
> On Wed, Mar 06, 2024 at 04:35:26PM +0800, Baolin Wang wrote:
>> On 2024/2/28 16:41, Oscar Salvador wrote:
> 
>>>    	if (folio_test_hugetlb(src)) {
>>>    		struct hstate *h = folio_hstate(src);
>>> +		bool allow_fallback = false;
>>> +
>>> +		if ((1UL << reason) & HTLB_ALLOW_FALLBACK)
>>> +			allow_fallback = true;
>>
>> IMHO, users also should not be aware of these hugetlb logics.
> 
> Note that what I wrote there was ugly, because it was just a PoC.
> 
> It could be a helper e.g:
> 
>   if (hugetlb_reason_allow_alloc_fallback(reason)) (or whatever)
>       allow_fallback_alloc = true
> 
>>>
>>>    		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>>>    		return alloc_hugetlb_folio_nodemask(h, nid,
>>> -						mtc->nmask, gfp_mask);
>>> +						mtc->nmask, gfp_mask,
>>> +						allow_fallback);
>>
>> 'allow_fallback' can be confusing, that means it is 'allow_fallback' for a
>> new temporary hugetlb allocation, but not 'allow_fallback' for an available
>> hugetlb allocation in alloc_hugetlb_folio_nodemask().
> 
> Well, you can pick "alloc_fallback_on_alloc" which is more descriptive I
> guess.

Seems better.

> 
> Bottomline line is that I do not think that choosing to allow
> fallbacking or not here is spreading more logic than having the
> htlb_modify_alloc_mask() here and not directly in
> alloc_hugetlb_folio_nodemask().
> 
> As I said, code-wise looks fine, it is just that having to pass
> the 'reason' all the way down and making the decision there makes
> me go "meh..".

Well, fair enough:) let me respin it. Thanks.

