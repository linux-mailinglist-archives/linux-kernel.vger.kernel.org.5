Return-Path: <linux-kernel+bounces-141390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCF8A1D99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A835B1F25E56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEC1EB1CC;
	Thu, 11 Apr 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rlF82H7m"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E11EB1C5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855650; cv=none; b=A/VEu8U0bJPN3yNopcH1x12pV6IZycmHsrFBdon0I+yPEKtTC48o1jwdUzfo4gICIQSabytUPplkAaV2FdnnCuXcE/ytLMRyQUkVodTqQsKfiCtnhTAOqU+rGGbP7VMzbEsEmvTyGNZV7nC5rS1rzUTQqTwKGHnTUeXVjrWJasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855650; c=relaxed/simple;
	bh=KzIfpkxGQTLR8rP92KQ0/zyb38KE4fX0idfEoIGOEOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay2U4xiFwsDF1WjaVl1f5MIdZOYcIH1ZP0AzsaG/ID24m0nEJiT/MarNjOvAtpSQY63zIZSsEQ2p7GlOODIKcsNuej3l9pyEQaN2LI0owiPv3Gh7FJQMrBLvAZFoKbGs+IfDuSE5we52ZURnkqF64EvWPJl4x9WhDjMhhx1xYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rlF82H7m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u8ONCHTbMYw+HuP94f+vXbsWbQuW9Wq6kjOeo/Gca+s=; b=rlF82H7mQVf0gyU9vHbCQeLy+R
	ICyYbl8rX/dFBAPo/kHuxDPKszAWGqlBlZ2Hm5+3APUcwetl6wU2z8RMJwDlvi5OkHR9oaxVgUh8r
	4X1Oa4OeNlSG8ePk1FKUQHemNeosZ7pb9zja6CaSAllt5dDsPmd8V4Ad5X9ROzcTDLJwW+/7O71bs
	iseLu34oOV95rzZjQTBbDzqcPDa/Gz6aLKnXa8xSut7ETTsKiBmWB5D9TM+9Y5XyfDCRQtphz3oKl
	5I3E8XxZ0Mj6BH2jWhGnX76QEY6IVkl1e3euxZq5nLPxt9/gOW+a/QeQJXcbCS7A63kXWoXgWnFaU
	kSqaG35A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruxzx-00000007OPo-1YYl;
	Thu, 11 Apr 2024 17:14:05 +0000
Date: Thu, 11 Apr 2024 18:14:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhgaXWprPHnh5LTt@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
 <ZhcDRmyYkMGPgs4F@x1n>
 <ZhcnzS1S6zOMJwSL@casper.infradead.org>
 <ZhcstFcjOuOmr0wx@x1n>
 <Zhf4zqsfkz1XCwBN@casper.infradead.org>
 <ZhgDFJGsFsTjWokU@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhgDFJGsFsTjWokU@x1n>

On Thu, Apr 11, 2024 at 11:34:44AM -0400, Peter Xu wrote:
>    If the answer is yes, I'd say please provide some document patch to
>    support such behavior, you can stop my patch from getting merged now,
>    but it's never clear whether someone else will see this and post it
>    again.  If it wasn't obviously to Suren who introduced per-vma lock [1],
>    then I won't be surprised it's unknown to most developers on the list.

Anyone touching this path should have a good idea about what is and is
not the common case.  Your confidence greatly exceeded your ability
here.  I will not be submitting such a patch.

