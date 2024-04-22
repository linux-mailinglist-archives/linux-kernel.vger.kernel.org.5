Return-Path: <linux-kernel+bounces-153898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADED8AD4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D998DB20F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBA7155314;
	Mon, 22 Apr 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+TAVYd5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D5154432
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813125; cv=none; b=VopC71v4HSo2EBN7uqJFlYDzMSoAad3RLEvF2x4rLwLegqdNzgECx28j0PXlr8Zd3r53QhUYC2qBPOFAyW3F31LkATXefhADwjW1PAgBpilUdRN50FHHFE0igVwgnRFylZ83JzC2Sn6YPZRXAMflZgxnxsRU7YPdy2Ea2exp+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813125; c=relaxed/simple;
	bh=1a92759FjtnELPC2MqSXqE89WWJoExSAA6yt/yYun7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/mE5brzJnpj7xxkSIwqWKy+y7vY794RgIoLjeDobw/sqtms/l0DB0C0aBzsUXD63UylLrRt+TNgZKI92nIF1AQB6eAJGpLtc870dchxWCTm8G7n0pPDGU8W0njRCD3AbC4qOIFThlLDDaLP6gGCmy8rrYlQyMEGmFPTzT/GHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N+TAVYd5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lvwto3yehD40Bt0byCkThGy+w+BpMURn1Z2lSHOmbVw=; b=N+TAVYd5w9IVNa3GMJnn30VXie
	VSO+0vL53tVLzJT8RQf2Fpri3uH4udAiQlloJryYgSG25HZAC3hm4Df+kyyWBcDrqzYNOnr0bk4d/
	HHn+XFc1VljWh8xDEclpEGpKCgR6i5ty95vh+p1neVki7O5VQhnNYZxyqhSihopbHL9E6abaZZcfe
	XvzRcbjfr51GEjjHH1Mma203Gu/M8yTBkhba0c51WQiwjYu+uz/XqrvYF9AUa4HQ5czKodBkuE2JJ
	2ymRqIRjOBeoMyrJwYcPxy6monmSfjXFe20ptd4FciXsBReNBx+WvbJm0emeuEnwcx+fN7uBpANoH
	WKBlXnJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryz55-0000000EneE-1Jwh;
	Mon, 22 Apr 2024 19:11:59 +0000
Date: Mon, 22 Apr 2024 20:11:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm: huge_memory: convert __do_huge_pmd_anonymous_page()
 to use folios
Message-ID: <Zia2f2EI8LWFE2XA@casper.infradead.org>
References: <20240422181216.91938-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422181216.91938-1-jianfeng.w.wang@oracle.com>

On Mon, Apr 22, 2024 at 11:12:16AM -0700, Jianfeng Wang wrote:
> Change __do_huge_pmd_anonymous_page() to take folio as input, as its
> caller has used folio. Save one unnecessary call to compound_head().

I don't like this patch.  It makes the assumption that folios will never
be larger than PMD size, and I don't think that's an assumption that's
going to last another five years.  Look where you had to
do &folio->page:

> +	clear_huge_page(&folio->page, vmf->address, HPAGE_PMD_NR);

> +		entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);

For mk_huge_pmd() in particular, you need to know the precise page, and
not just use the first page of the folio.

