Return-Path: <linux-kernel+bounces-23956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1982B476
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32059B217EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C7537E4;
	Thu, 11 Jan 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tkDWBWFF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8753A1BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VqEajgKYUCRG8Rpm6+M9Aezz8/e9dXscDdOmwHGM7AM=; b=tkDWBWFFGAttTj4drcch5XyXvQ
	/vAw9ozrGxZ1GlZ1XZN99Bh4Tlv08VGBISNUZib+O8GUd765lTT7ndy82gdokPwyBZzhxFSCVXSzM
	ipYEsMKh1AuZZ7nZu8vkzCYYCaBWGsT10BubbNozvKPGrgDrNK8IWlj0o1HxzQ0WG2BN/iz37F9Rw
	rAIHbvpn47GKDdQXrbbaWso73/ZrWla9A3ZpjQI2H15g3aUxkCgRYIpi3Mkg9Q+rLwbfdjTU2OwyF
	S0bH+jt0e3k9XcD985AMjhHCU2KLpucYcl+QNPpPKumOGYpdihRnav3Xjx+tUTMW6HRfPgRku+X+7
	SEqHVhYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzPJ-00EVS2-CT; Thu, 11 Jan 2024 18:03:57 +0000
Date: Thu, 11 Jan 2024 18:03:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linmiaohe@huawei.com, mike.kravetz@oracle.com,
	naoya.horiguchi@nec.com, akpm@linux-foundation.org,
	songmuchun@bytedance.com, shy828301@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, jthoughton@google.com,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Message-ID: <ZaAtjVVTETdQDR4B@casper.infradead.org>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
 <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
 <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
 <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
 <6bacbd7c-88cb-1399-8bd0-db98c93a1adf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bacbd7c-88cb-1399-8bd0-db98c93a1adf@oracle.com>

On Thu, Jan 11, 2024 at 09:51:47AM -0800, Sidhartha Kumar wrote:
> On 1/11/24 9:34 AM, Jiaqi Yan wrote:
> > > -                       if (!folio_test_has_hwpoisoned(folio))
> > > +                       if (!folio_test_hwpoison(folio))
> > 
> > Sidhartha, just curious why this change is needed? Does
> > PageHasHWPoisoned change after commit
> > "a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?
> 
> No its not an issue PageHasHWPoisoned(), the original code is testing for
> the wrong flag and I realized that has_hwpoison and hwpoison are two
> different flags. The memory-failure code calls folio_test_set_hwpoison() to
> set the hwpoison flag and does not set the has_hwpoison flag. When
> debugging, I realized this if statement was never true despite the code
> hitting folio_test_set_hwpoison(). Now we are testing the correct flag.
> 
> From page-flags.h
> 
> #ifdef CONFIG_MEMORY_FAILURE
> 	PG_hwpoison,		/* hardware poisoned page. Don't touch */
> #endif
> 
> folio_test_hwpoison() checks this flag ^^^
> 
> /* At least one page in this folio has the hwpoison flag set */
> PG_has_hwpoisoned = PG_error,
> 
> while folio_test_has_hwpoisoned() checks this flag ^^^

So what you're saying is that hugetlb behaves differently from THP
with how memory-failure sets the flags?

