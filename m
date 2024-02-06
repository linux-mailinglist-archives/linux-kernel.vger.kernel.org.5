Return-Path: <linux-kernel+bounces-54484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A665784AFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AB8B24224
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92F12BF14;
	Tue,  6 Feb 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="as48I4e6"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9A12B169
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207515; cv=none; b=L0jqPW+4hZnP4Eb4aKQ0jO/7UD618zoP8suqKhAS/9hmVYYS6J7KqC1Gbo8AdrZzz6yYlje4lYxHnMl7qBpbjdu/ukIjU9m86x4w/YDMsB9AhTQYovtNM7pNEXqY7NUkufxf3CB8kpzTgrl05PtTyFupvRkpCbi9LK0dJp70/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207515; c=relaxed/simple;
	bh=V+or0CGYqI/j+yVcolyQTN6SWKGZbzOrLpDMheqhgoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx6KOZ0cHrLB0bt+zGHWn+k3L/KTxWI58xCGoG1qZm/AGSTTLu25suRCYUB13rgbc2Ex0MDXlUUq4/iManJL1kmmqRVGVGUrXAgRDDLVq9PBBTf9dq3Q9oWr+8Q1ashB5ojyS2BS4RvyzauNujD2MhiP1m3zpJ5+bgdS+HyfjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=as48I4e6; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707207504; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n4L712Wu1atDoWRSzGANCoeLDJJJ+/sOVHYz/0n8058=;
	b=as48I4e6lOZVB1c5zIx1hULRCIt2645ZSkGQc/pFnXDI7YiwVbCuRG+UK+NCJkl1T0eTo2X+V1fEBacMzgzTZpMz2wDLPt6ifsTLPu85zT7zlh3lHQHk+kRprs/EqMoF9C8miuLdjJ2MMM1RstPCL7JkpnOfWOZ9RrvXJQd89nE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0CysvU_1707207502;
Received: from 30.97.56.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0CysvU_1707207502)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 16:18:23 +0800
Message-ID: <67e0d81f-7125-455c-b02f-a9e675d55c6c@linux.alibaba.com>
Date: Tue, 6 Feb 2024 16:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
 <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
 <ZcCnNPkNpE7KTHZu@tiehlicka>
 <2613b670-84f8-4f97-ab4e-0d480fc1a3f8@linux.alibaba.com>
 <ZcDvVA84s9-Azr33@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZcDvVA84s9-Azr33@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/5 22:23, Michal Hocko wrote:
> On Mon 05-02-24 21:06:17, Baolin Wang wrote:
> [...]
>>> It is quite possible that traditional users (like large DBs) do not use
>>> CMA heavily so such a problem was not observed so far. That doesn't mean
>>> those problems do not really matter.
>>
>> CMA is just one case, as I mentioned before, other situations can also break
>> the per-node hugetlb pool now.
> 
> Is there any other case than memory hotplug which is arguably different
> as it is a disruptive operation already.

Yes, like I said before the longterm pinning, memory failure and the 
users of alloc_contig_pages() may also break the per-node hugetlb pool.

>> Let's focus on the main point, why we should still keep inconsistency
>> behavior to handle free and in-use hugetlb for alloc_contig_range()? That's
>> really confused.
> 
> yes, this should behave consistently. And the least surprising way to
> handle that from the user configuration POV is to not move outside of
> the original NUMA node.

So you mean we should also add __GFP_THISNODE flag in 
alloc_migration_target() when allocating a new hugetlb as the target for 
migration, that can unify the behavior and avoid breaking the per-node pool?

