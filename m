Return-Path: <linux-kernel+bounces-146548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D28A66E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AD281776
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139184FBF;
	Tue, 16 Apr 2024 09:19:00 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1F84DE4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259140; cv=none; b=loJF9hmY9MbzNfGdnNYmSpJ9oiRc3s1/pXQV4j0OIS7vpFb2RM/vNxGHAryFJDWcOzU855oVVCdc7P4DLJJiZTOcG3rJBJ9PMvucNGd/mmGu8wJnt/2fe0+Yb6gnDnndlWLiOpfgfmNmL2+YsIlhBfsWhi2b+8swrA1/guBKR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259140; c=relaxed/simple;
	bh=ESZpiJGjF6gmJ6oujrwxfz0d5l+Ta7ADcVYrGLAfulM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PRIyYXcKxXQAnH5jWkkcKXELppra6p8s+pe83Cwr0/E4GqZplW/0rpL79a1+4OvJarKBYUZ3+Vs3IJ2nOM0Unc4+KDVZDIPQ1pICc5HDBhDUywdSbXgup7b0uCRm35o7/GstualRwRIIRhgj2oRa6fiDOaYl/1DIMVr7uHky3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJdjr1Wd9z1wsP4;
	Tue, 16 Apr 2024 17:17:52 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 468841A0190;
	Tue, 16 Apr 2024 17:18:50 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 17:18:49 +0800
Subject: Re: [PATCH v2 2/2] mm/hugetlb: rename dissolve_free_huge_pages() to
 dissolve_free_hugetlb_folios()
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>, <jane.chu@oracle.com>,
	<muchun.song@linux.dev>, <nao.horiguchi@gmail.com>, <osalvador@suse.de>
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
 <20240412182139.120871-2-sidhartha.kumar@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <893a6dda-d9a1-65c4-60b1-12ea5f652466@huawei.com>
Date: Tue, 16 Apr 2024 17:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240412182139.120871-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/13 2:21, Sidhartha Kumar wrote:
> dissolve_free_huge_pages() only uses folios internally, rename it to
> dissolve_free_hugetlb_folios() and change the comments which reference it.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 4 ++--
>  mm/hugetlb.c            | 2 +-
>  mm/memory_hotplug.c     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

