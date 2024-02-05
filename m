Return-Path: <linux-kernel+bounces-52207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74FF84955C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742C71F21B72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B011701;
	Mon,  5 Feb 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="buWZpWz5"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E511197
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121737; cv=none; b=gEzgUuICtkJqXbj+T7hg8H9fEOy5O+XIfSMc0wlY7EzeFqZR12To/+/25kg11lnGRl4JDYsdDsgYJJlHaVxCjyfdnGtHTIe+jAtF/ViRwQD5OuWLuC6Hhu1T5qeNN59piScRBA63rBhk25laWNn8z6UHBkOHgG/6AMZycP0EFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121737; c=relaxed/simple;
	bh=jOd5U/bcfwo5nJJLVTP/vq+7/o/XA1zDFdQO4EvAeJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1gOs4nyOlLKMqYsfW7Tzk/gy6r6qrz8MZ56MRoZ/0M7uVqu+6Ll/PnwShRzNwW7rFmN6iaB3sfgpWcUhhp9+X8TNEpFKpqKue/FFAAr6ZpHa6NIGCW4px+tCSC1+HHUqOZx4pDnmvNkhLpIYx/PigvX2xL84fEoWcOJCQK4Lbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=buWZpWz5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707121727; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YKZXLXscoo6WspId5ZWXzvGxFuSp7LUnE6//QnlzEM4=;
	b=buWZpWz5AxbROfZXnzFTU6PLCC9OSwSXa3eoOxYbV8O95Jvs8/JIbSqqzKpXGZ44Pm4MZvopiyYly83r5AusGTofmvT/5cjwgw+C+lXrBxq4Yp2M5OVc3ClZ81xsL3Jl2f50ByXQ9ZF2W+7aV1xKvsxmvYOSUdHOMqhJTJnZITE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W064Cfa_1707121409;
Received: from 30.97.56.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W064Cfa_1707121409)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 16:23:30 +0800
Message-ID: <2d6fa6b6-db90-4ba8-9205-437593bc2f9b@linux.alibaba.com>
Date: Mon, 5 Feb 2024 16:23:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb allocation failure when handling
 freed or in-use hugetlb
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
 <E549C993-A900-40AF-9D0E-F14109237487@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <E549C993-A900-40AF-9D0E-F14109237487@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/2024 2:56 PM, Muchun Song wrote:
> 
> 
>> On Feb 5, 2024, at 11:54, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>> When handling the freed hugetlb or in-use hugetlb, we should ignore the
>> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
>> since we did not use the new allocated hugetlb in this 2 cases.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> OK. It is not a fix (I see a fix keyword in subject) but an
> optimization for unnecessary-allocation cases. Thanks.

Yes, better to change the subject to 'mm: hugetlb: improve the handling 
of hugetlb allocation failure for freed or in-use hugetlb'

Andrew, could you help to change the subject line when you apply it? (or 
you want a new version, please let me know) Thanks.

> Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks for reviewing.

