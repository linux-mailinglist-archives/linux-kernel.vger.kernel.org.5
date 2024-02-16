Return-Path: <linux-kernel+bounces-69376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08F85883A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36B7284AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416E14600A;
	Fri, 16 Feb 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IUmM3Oul"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68491D69A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120207; cv=none; b=Vb6PXkv2uBRXZMol6WnmNRexCZa2OaaCO20BBMVHHmRaABAx6g8tIy+6Cz1cFPpSHpTLVj3Wh4TAvauk7ESrgwvu2g++aQUezisE0nZVn0/alYavrdEChLzqTkdv9Lg2NChYSAD0+20xcJJTP9FnTSG5wpoiTv6Np3X2ZVQQ96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120207; c=relaxed/simple;
	bh=v7qFsL5MrbSJkyhmHUaQIZpBDuVCQNP5lE4kotGMMHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZQJkQgLpDLmV0mN6RNbxKszfTuJZMA8/v40Qn1WTGsky5zrhei2ekaSHF2nCJenG50etP0SGs/7YJprjVo34o9/Yitb9eQdQRYeLN8Nt5cVioBhCmbBA7+63O2qi37TIeZq9XrcyG36QfVtPb6BUM3uDguKStzGp1uz8M1tWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IUmM3Oul; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ImZiREhBrMq4AWnxqY5yboGSGsxPSUPiaLAI0+rRZ4=; b=IUmM3OulO6dKlT1g/3V5IkgGUE
	OegQwcNeGt+ZwWOg5bUgzPREhD/4t6JHicocHj7dGDXK++NKAuYVviF4+nUQUI//1FJfzrhQ6dJk8
	cU/yU8Ju9mALmHZFFixRvRuF2c45t7t0Yr9hgdlOAQ6BWXMwV+AlbOURTG0uySseoQ58P/9uGoV6r
	jVOdw2ERDbNe3Jz8zKW6RXZFpPavpfHX8/xzSfaWwuYbJS+7nEMQnXbRF3IgKhRiRY1VdGsjbWtxo
	GQ7JJlkutKfNUwCA+54iwhhYlaVSu/n9GJ01SAzU9Zk3GOdHAENpJ0LN51jMz4gugTm4k7l7D8xwh
	pkniriAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb65p-00000005kPR-1ZGg;
	Fri, 16 Feb 2024 21:50:01 +0000
Date: Fri, 16 Feb 2024 21:50:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com
Subject: Re: [PATCH v2 1/6] mm/migrate: introduce migrate_pfn_to_folio()
Message-ID: <Zc_YiSDsmdv-2Rcm@casper.infradead.org>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>

On Fri, Feb 16, 2024 at 01:13:15PM -0800, Sidhartha Kumar wrote:
> +static inline struct folio *migrate_pfn_to_folio(unsigned long mpfn)
> +{
> +	return page_folio(migrate_pfn_to_page(mpfn));

umm, no.

	struct page *page = migrate_pfn_to_page(mpfn);
	if (page)
		return page_folio(page);
	return NULL;

