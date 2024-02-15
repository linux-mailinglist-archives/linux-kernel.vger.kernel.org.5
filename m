Return-Path: <linux-kernel+bounces-66278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E08559A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFC1F2242E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F5E748D;
	Thu, 15 Feb 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CT1TWM3W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A43BA2D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970138; cv=none; b=MSpRlEvz7eYzE3YsARp5CgcsDH+nuC6EC/VXtD2L0EjOyMHTBrRMjLf4dmsg7Dr0yeNDsKOccCAztxZU9oNyiHBA4ztJdrtN2CO67NLnNMvFfa95inKCdo/1PDotB76ec2uYvnunWKxtEhZoeISn09Qmy3++WIzcKw25/lE3h1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970138; c=relaxed/simple;
	bh=nkKzVlC4uhur07A57q8tmU+Tg8XPjDGLzdXhB+c6Pdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar0ipn4PbcmUjIP0I1s0m+q1qmc8xBuwmefmyR3YIVZo59eLROrb5HjYxHJ1j07knAUWY5YszmWsHm5PRrotOQdFSBXjjkukznRDI+tEOujA7B2PWWa31LprzfiRRtJIPDjKgGaaqm0u0LQGspdvSoPBs1q/H2WpkdvtDGCSuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CT1TWM3W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9fuIbytQEg5hPlOrjPD0SvR4AYugFV4t14iROBoJ0LM=; b=CT1TWM3WnH7FRz+110NSMbcst2
	Pf3j/6YqOCJCnOH5qJN0aGDB2OtG7mqxNISlngQydxm6AKdLui6yL2SlCml3FuLzbXUQe680L1SyH
	RF+wUGjNDzED7pykZgrd5JlkZxHdkoO+zpJMjB3OYxxF5LTdh77jw7UmO2pb6GMPTX3m8W38SHhBs
	gFb/RlqdeV3j/Yu8n0aWop3e6q1mfyi0EdE1VdOnHzdG9x8ekm40RPiS43Ebn9BrGNgZKKqqgRtGK
	T30J9/FndGQZZOruQS+u0ZhlJ8gH7sMFFR1mCHbsJHvKaEE6Gxq+WK1sieqZR590aYzmawOopU6MW
	6pBnz9bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raT3N-00000000rgW-05AJ;
	Thu, 15 Feb 2024 04:08:53 +0000
Date: Thu, 15 Feb 2024 04:08:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] mm/migrate_device: further convert
 migrate_device_unmap() to folios
Message-ID: <Zc2OVIEVe87WCruV@casper.infradead.org>
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
 <877cj67jn3.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cj67jn3.fsf@nvdebian.thelocal>

On Thu, Feb 15, 2024 at 09:38:42AM +1100, Alistair Popple wrote:
> > +++ b/mm/migrate_device.c
> > @@ -377,33 +377,33 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
> >  			continue;
> >  		}
> >  
> > +		folio = page_folio(page);
> 
> Instead of open coding the migrate pfn to folio conversion I think we
> should define a migrate_pfn_to_folio() and get rid of the intermediate
> local variable. This would also allow a minor clean up to the final for
> loop in migrate_device_unmap().

I think we should stop passing pfns into migrate_device_unmap().
Passing an array of folios would make more sense to every function
involved, afaict.  Maybe I overlooked something ...

Also, have you had any thoughts on whether device memory is a type of
folio like anon/file memory, or is it its own type?

