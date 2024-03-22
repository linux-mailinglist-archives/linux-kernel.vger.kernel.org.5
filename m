Return-Path: <linux-kernel+bounces-111205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF488691E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730302883D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3F1CA80;
	Fri, 22 Mar 2024 09:23:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553581757D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099432; cv=none; b=cbHRw0FECA6TdUsrP3dZapnOFwDaq86h/37tPD2wH1Q4E6jGI15/mSKN3fVcS/ave1tFImszEzgMPUqSkIGnu0kFA7QxvxJn1VT0oWAHxvKWnW1J2RXcQRmU855TRY1hvmpLIODykimRlRl3cZh9VIWceYMSIj9nB+HFOkKahJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099432; c=relaxed/simple;
	bh=4XqNxjKXQydnEthSSoKu+FxMBbfu+Rri2qsMp7OyuNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw6q3qyZYu5COESAieuGmOkG6Jafj9zkZuIiDNN9bMXa7sYOHMLyQ2K9XKrKJ3dLc/pU5slZAoWQkubQlf/fLZKinZA/BTl8fvccAa7FCZJD3FTfRvT+8MohJY5/5WtIGl2hudLr0homhq5M8Leh0DlUsH9rIs3oiYmpNijZzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976D41007;
	Fri, 22 Mar 2024 02:24:22 -0700 (PDT)
Received: from [10.57.72.175] (unknown [10.57.72.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293943F64C;
	Fri, 22 Mar 2024 02:23:46 -0700 (PDT)
Message-ID: <44b2cf99-7d87-42ac-8446-fe0822c89c97@arm.com>
Date: Fri, 22 Mar 2024 09:23:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-5-ryan.roberts@arm.com>
 <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
 <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
 <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 02:38, Huang, Ying wrote:
> Hi, Paul,
> 
> Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
> For some example kernel code as follows,
> 
> "
> unsigned char x[16];
> 
> void writer(void)
> {
>         memset(x, 1, sizeof(x));
>         /* To make memset() take effect ASAP */
>         barrier();
> }
> 
> unsigned char reader(int n)
> {
>         return READ_ONCE(x[n]);
> }
> "
> 
> where, writer() and reader() may be called on 2 CPUs without any lock.

For the situation we are discussing, writer() is always called with a spin lock
held. So spin_unlock() will act as the barrier in this case; that's my argument
for not needing the explicit barrier(), anyway. Happy to be told I'm wrong.

> It's acceptable for reader() to read the written value a little later.
> Our questions are,
> 
> 1. because it's impossible for accessing "unsigned char" to cause
> tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
> correctness, right?
> 
> 2. we use barrier() and READ_ONCE() in writer() and reader(), because we
> want to make writing take effect ASAP.  Is it a good practice?  Or it's
> a micro-optimization that should be avoided?
> 
> --
> Best Regards,
> Huang, Ying


