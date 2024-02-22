Return-Path: <linux-kernel+bounces-76671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F5E85FAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7477C1C25A84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2114F9FD;
	Thu, 22 Feb 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tnh1/pa0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB3146010
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610744; cv=none; b=UHsCXQCwraL9OuqqRe2KJegpUxDnM0D9wL0EkS+lVY1g7PO53kh38Z0AJwrBh3e44pZXdFNt5O4AYpGHeeo3/CjQlXDLzb7Y4876d0o5HtuE02M04iNVtHfm6cSD9H54S3tf+PjUVuqwLoeNKfeH2NkR31BvLXyWtK+vdZxuDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610744; c=relaxed/simple;
	bh=Q/xurY/WqspoySgD42YQGC+030O+/0qfcS9IGxnhL58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCo6Ibccz53m5HcPaoWSK8vv/hgWq8Iy3qhbn3EfHYTmYA77VKDPvS/1GVAxRtU6VrECSPfnVyx8vXOvualVAvvhigQSYS2TneRspWI4bXTLF749/jdj6WBlKojgONVhhEgRnRmzPyPI4JXA8gUx8thv+776wu+h0QdcIqxIAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tnh1/pa0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AFeYNRFIfcJikzrVy0rC22gQ2tTDpuWFx/vVmZWeO04=; b=Tnh1/pa011xn9yvUG4PrQnNJs0
	OuiFUSDIBiEMTfVDbyz6cEZfk0X+mEJNzWjeextngK+i3jdaCaRf/tN8Eg2Rhe7WySwgQLyMtl9xF
	aOJdi8l8u58GeTQV5UyjfRUEf5uuJfBNJp8zgF1GKiGapruKDqVGmU1tt0z2VGuXoBtSaLyOVaOZa
	3XanYICkXONVb0B4eOeeR47Mby4i+f9xpOn9UPTWr0NA+ncQBe2+BbpWTpMYUyY+8leqkEoPk9WA4
	WPr6/xdk88sheuffb1iEk91fqD8EcKk7qvE2WebL1jPuQbiedIX0LoE94h+MMJR2jPulqz+mw/Imo
	JlXtECaw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd9hc-00000003kn7-12l1;
	Thu, 22 Feb 2024 14:05:32 +0000
Date: Thu, 22 Feb 2024 14:05:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, yanaijie@huawei.com,
	zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com, linux@armlinux.org.uk, rppt@linux.ibm.com,
	linux-kernel@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
	m.szyprowski@samsung.com
Subject: Re: [PATCH] arm: flush: check if the folio is reserved for IMO
 addresses
Message-ID: <ZddUrO7i5KZn57FY@casper.infradead.org>
References: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140147.1880357-1-liuyongqiang13@huawei.com>

On Thu, Feb 22, 2024 at 10:01:47PM +0800, Yongqiang Liu wrote:
> @@ -296,6 +297,9 @@ void __sync_icache_dcache(pte_t pteval)
>  		return;
>  
>  	folio = page_folio(pfn_to_page(pfn));
> +	if (test_bit(PG_reserved, &folio->flags))
> +		return;

Why are you using PG_foo directly instead of the helpers?

	if (folio_test_reserved(folio))

