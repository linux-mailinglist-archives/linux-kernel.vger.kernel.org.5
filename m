Return-Path: <linux-kernel+bounces-139648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D283B8A05C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D251282747
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7D64CD0;
	Thu, 11 Apr 2024 02:19:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE3634E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801945; cv=none; b=hxL5cr/EP6WdSBmnXj5XgYf1I8MgB3/q7HGwYWGto++bDuzWQtgG1lk+UceYw24+2Bn8i89J/E8qSWYI/eB9qQz0VM41euxq3aUdFdfDp5VQmc54E89ZH00MChH6lYb2qXIo8wevn/nxPB7NBzHoTc+c73BYZpFrDcdsUo2a7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801945; c=relaxed/simple;
	bh=lKcqCBKrjxlHSJoaV287CW1HfG7T/scL2q276VSe/4Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e51Fy2y6qqkf+rD9go3hyQ18cQDIpxoPJ/NdTYqYLXjCKFIYzl9JQry5D86EfiihLEiAtHNcl8y/H0YyOGIPo415bu3AXcRsoV7lZF1+1O1ft2hBDHe+plgXJsUuThVzTuDUNtSahPBxvA4mNwLXoNF4TTn9VM4p3GR0U4FJo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFNdx2Np7z1GGNn;
	Thu, 11 Apr 2024 10:18:13 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 2073618002F;
	Thu, 11 Apr 2024 10:19:00 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:18:59 +0800
Subject: Re: [PATCH] fork: defer linking file vma until vma is fully
 initialized
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<brauner@kernel.org>, <oleg@redhat.com>, <tandersen@netflix.com>,
	<mjguzik@gmail.com>, <willy@infradead.org>, <kent.overstreet@linux.dev>,
	<zhangpeng.00@bytedance.com>, <hca@linux.ibm.com>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <thorvald@google.com>, <Liam.Howlett@Oracle.com>,
	<jane.chu@oracle.com>
References: <20240410091441.3539905-1-linmiaohe@huawei.com>
 <20240410132157.b0e54f59b066f2c1d322d425@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bc472a86-5a5d-9551-5680-8519b8682169@huawei.com>
Date: Thu, 11 Apr 2024 10:18:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240410132157.b0e54f59b066f2c1d322d425@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/11 4:21, Andrew Morton wrote:
> On Wed, 10 Apr 2024 17:14:41 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Thorvald reported a WARNING [1]. And the root cause is below race:
>>
>>  CPU 1					CPU 2
>>  fork					hugetlbfs_fallocate
>>   dup_mmap				 hugetlbfs_punch_hole
>>    i_mmap_lock_write(mapping);
>>    vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
>>    i_mmap_unlock_write(mapping);
>>    hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
>> 					 i_mmap_lock_write(mapping);
>>    					 hugetlb_vmdelete_list
>> 					  vma_interval_tree_foreach
>> 					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
>>    tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
>> 					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
>> 					 i_mmap_unlock_write(mapping);
>>
>> hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
>> i_mmap_rwsem lock while vma lock can be used in the same time. Fix this
>> by deferring linking file vma until vma is fully initialized. Those vmas
>> should be initialized first before they can be used.
> 
> Cool.  I queued this in mm-hotfixes (for 6.8-rcX) and I added a cc:stable.

Thanks for doing this. And any comment or thought would be really welcome and appreciated.
.

> .
> 


