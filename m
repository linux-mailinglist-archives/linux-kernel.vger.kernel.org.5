Return-Path: <linux-kernel+bounces-119446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B306F88C8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5312B1F67A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EA13C9D5;
	Tue, 26 Mar 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UwQd4PB1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1213C9B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470075; cv=none; b=Y23fv2JAS669e6WhISusTVoub/YXObGui7V5xUGmg2yVrWqtBSfKJej0tXBj1DZzTFO1Fiqxh3scjMGgTj5B5S8oaz7jprp95jwx7iBexBU+wAuCtC9xXE8VklkZTCgImziUpbnR0n4w4ziEh0I08kq5N42iwOSK6JPBwHWLJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470075; c=relaxed/simple;
	bh=qEt8XWA5kwdd1L+VuUKcVMN/aXLxa/Lf4+F4asHjhx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4+x3nrtF2HpF0FsJmhNwCi5BQ6sqmdJnI1XlzlLZJtkQ3de1pBjTPPToPGDSgCKGv7SQ+S6patETlvspOU/U+mecHDjYUV7Qf2zCAJH/ElLwAE30iplZ1lR7OGog1DGIyzfXi+afNdRXU6He5mL3X7o2lb+g7zjLNRcWb5gylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UwQd4PB1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oC7GMMoc4TX7QJB9CFxd5TJEBoqTJwxJZ30aIl5Tde4=; b=UwQd4PB1/rRfPc76QXBGtisIBt
	BpL8Uk7DpRbeB51yNcvOMzGP8jWTSKd6o6JTUOsXA+qFoVmd9QDx+QZ1fz1ESihL/+oCVk09yhW4g
	sS7SDCc0kQz6yowlHTWTFUraGMqwVt88Bty9LBcM/Q+XNPZDLB3GfQrVZ9uN3Bj27kpd++M19QA8J
	patktrpCFQVzxwJeDSTk/Pc1y8A6xYJbDRTkOVwwy3eNo++fIV1tkFckWRgYeIahMy5pD58hRGgzT
	zkHKxp3h5DIFUQSYxcwKaSwx9SlnPBdkXDwIgpYyHZVsUY+3qa03id+qyu7bKDFBrrgM8WAZq+y1X
	gYSLQR4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp9Xp-00000001dxi-1max;
	Tue, 26 Mar 2024 16:21:01 +0000
Date: Tue, 26 Mar 2024 16:21:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org,
	david@redhat.com, hanchuanhua@oppo.com, hughd@google.com,
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
	shy828301@gmail.com, v-songbaohua@oppo.com,
	wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
	yuzhao@google.com
Subject: Re: [PATCH v2] mm: hold PTL from the first PTE while reclaiming a
 large folio
Message-ID: <ZgL17TSjiUtrmzk8@casper.infradead.org>
References: <20240306095219.71086-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306095219.71086-1-21cnbao@gmail.com>

On Wed, Mar 06, 2024 at 10:52:19PM +1300, Barry Song wrote:
>  			if (folio_test_pmd_mappable(folio))
>  				flags |= TTU_SPLIT_HUGE_PMD;
> +			/*
> +			 * Without TTU_SYNC, try_to_unmap will only begin to hold PTL
> +			 * from the first present PTE within a large folio. Some initial
> +			 * PTEs might be skipped due to races with parallel PTE writes
> +			 * in which PTEs can be cleared temporarily before being written
> +			 * new present values. This will lead to a large folio is still
> +			 * mapped while some subpages have been partially unmapped after
> +			 * try_to_unmap; TTU_SYNC helps try_to_unmap acquire PTL from the
> +			 * first PTE, eliminating the influence of temporary PTE values.
> +			 */

Please wrap comments at <80 columns.  The easiest way to do this is just
to pipe the block of text through "fmt -p \*" (need to quote the * to
prevent it from being a glob/regex)


