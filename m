Return-Path: <linux-kernel+bounces-43737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81CF841882
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790221F28159
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB6364A7;
	Tue, 30 Jan 2024 01:40:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871892E40E;
	Tue, 30 Jan 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578852; cv=none; b=XTVP1Re82e3HKlO+ws3k5BtnqsNIxw7a8I9PBMa6jT3+N4qdglbDfnozs2n3VP6zPrJZix+lax/L4GYz9H/4YasmlERcy5CnpOBQ/jtAG96omgMHUZ0IdnX8fflrjAYOJlDCpQI8mSRLPUS8GLeMYNEzq8HKbD7aA+PyGkunXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578852; c=relaxed/simple;
	bh=VbobI8i12wfdDT/0sDMvAjQ9Fb1PGwZp0fZRrbe0AJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2v1H6XURlUJrMDrVVrMT8jO8qk5yfZ1vUgMBygOk6KBra6S+jcU2xQQvkeV/ju5wzy4TAfmv5pUJsMaAlyHeEHwNKKz4EWGyERsbGpJrOeA89Vwi32XlV7+FLBgjp0Q82ESMXJwAl6H7Xk5sHYU6pcQJLnipqkoWtxkSEStvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TP7BQ19ygzXgty;
	Tue, 30 Jan 2024 09:39:26 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id E29BF140132;
	Tue, 30 Jan 2024 09:40:46 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 30 Jan
 2024 09:40:46 +0800
Date: Tue, 30 Jan 2024 09:40:38 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Changbin Du <changbin.du@huawei.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [RESEND PATCH v2] modules: wait do_free_init correctly
Message-ID: <20240130014038.mawqxwoc34v6hztb@M910t>
References: <20240129020304.1981372-1-changbin.du@huawei.com>
 <ZbfmNiY52KdAet7_@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbfmNiY52KdAet7_@bombadil.infradead.org>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Mon, Jan 29, 2024 at 09:53:58AM -0800, Luis Chamberlain wrote:
> On Mon, Jan 29, 2024 at 10:03:04AM +0800, Changbin Du wrote:
> > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > do_free_init() into a global workqueue instead of call_rcu(). So now
> > rcu_barrier() can not ensure that do_free_init has completed. We should
> > wait it via flush_work().
> > 
> > Without this fix, we still could encounter false positive reports in
> > W+X checking, and rcu synchronization is unnecessary.
> 
> You didn't answer my question, which should be documented in the commit log.
> 
> Does this mean we never freed modules init because of this? If so then
> your commit log should clearly explain that. It should also explain that
> if true (you have to verify) then it means we were no longer saving
> the memory we wished to save, and that is important for distributions
> which do want to save anything on memory. You may want to do a general
> estimate on how much that means these days on any desktop / server.
>
Actually, I have explained it in commit msg. It's not about saving memory. The
synchronization here is just to ensure the module init's been freed before
doing W+X checking. The problem is that the current implementation is wrong,
rcu_barrier() cannot guarantee that. So we can encounter false positive reports.
But anyway, the module init will be freed, and it's just a timing related issue.

>   Luis

-- 
Cheers,
Changbin Du

