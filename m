Return-Path: <linux-kernel+bounces-107864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3E8802B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE23D285478
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A2107A8;
	Tue, 19 Mar 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJttsfsk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E3208A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866890; cv=none; b=hZaiekfY/WE5Jl3N6uV0F5yYG8aejCGgIMKbmrASDkE2aPSQzidO3+1YE+XJP4il+qj5XrcKo4tS9E9MoyZCmyYIS4dLFIfid2TJDJFZhlRRyAU0dFePg8B+aoETVuc3DpFXGYQ4H6K5BfdkwOmYMWDh/6jusiovUWg4OXw5jGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866890; c=relaxed/simple;
	bh=9pjVQ10M/8aXW/FknymC3twMMiIlNIpq1dAY7tnn1bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIPBhJgRxYyO4jjR1v/c+zdL2AZVOgwZKGbByNOTE2TcapfZYTWCWPGqJbz383j6TDiE4YfOosMxTjHBdqb2VntzxH/bK3n8mYGuUxjJsdDWqzJ/uiC3YfrqhVC5Q4rOAi1Ja5qyuSQBxirLAX/iof7DpFgKPcyJLy9K8xO1f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LJttsfsk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V0SBy7Ck4tFXpJEBaySgBj+pOkXYLCrjbnWaEi08VzU=; b=LJttsfskNs00fcnL0LgG1jB0L7
	iVg5ZWYK6v7D9MxeDFhiNq+xVqA8/QtmSqnqvmJC/e6foEa1JhM0Db6tcmPI/JPkp7jDW+yOTPWMn
	WilAJqWRKvQIZAkq/Q4p8kUlJZ2LmzFoAg3qBpriJ4DTo+kpUbVOD8N10ZVpCfOL8iYtEF7mC1bDj
	9huXxDkp5hlugXLcwrpQtM7b43tZU7AselHCO3weExvnt08EY+hfPzSbgmJqDhoeU0OceGQbDzFFm
	ZYTYMdtbLWWnF8zlY8cKhuL2HH4ceArXYmy5MC6HfDKq8Modl2owyL8MqnMC51LmraH9342/Ypyzx
	E3zTsdOg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmcd9-00000002KxF-0cSH;
	Tue, 19 Mar 2024 16:48:03 +0000
Date: Tue, 19 Mar 2024 16:48:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/filemap: clean up hugetlb exclusion code
Message-ID: <ZfnBw5POGyVZjkjK@casper.infradead.org>
References: <20240319092733.4501-1-ryncsn@gmail.com>
 <20240319092733.4501-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319092733.4501-3-ryncsn@gmail.com>

On Tue, Mar 19, 2024 at 05:27:31PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> __filemap_add_folio only has two callers, one never passes hugetlb
> folio and one always passes in hugetlb folio. So move the hugetlb
> related cgroup charging out of it to make the code cleaner.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Ah; excellent.  I once had a patch along these lines, but it never made
it in.  Happy things got refactored to the point where it's now easy,
and mildly annoyed at myself that I hadn't spotted it yet.

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

(I'm acking these on the assumption that Andrew's just going to take
them; I can collect them myself if that makes anybody else's life
easier)

