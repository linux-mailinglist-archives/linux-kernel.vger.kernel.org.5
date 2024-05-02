Return-Path: <linux-kernel+bounces-166744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960A8B9ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9BFB20FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AD16C875;
	Thu,  2 May 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uCpQJWYC"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF980664DB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668344; cv=none; b=meuxFn24T635de66nujumhKB5ZSoOxEtsqKGSS6usdL1c/M8NCUWoqiE8u2OFBd2z98MDM0Xx2FsEgsDfcDLoVpmjqjAMDcZMO/66U5UBmkc+bmIYXF8qoudnsVTeKwqAVtjXfyv9Umx1YxevCGSr9I6aN9M0AX1926o/PSgfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668344; c=relaxed/simple;
	bh=RQfRNvxpFwoyx3yE+JDdi4r+Fa2rw7zgjS/2IOwzmlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ3gZMZns4ZC7BlNta2N4qbjbTbcRnts0bbZCUq0FN+V7thQ34HgzQ2Fs353P6r4f6uNLXHZCzNv3xQoCPwVMPtPpKvTdD/QsZxvbYLoU6QdYdZINhbGMnjyRbjWiqBW3u4+gnij46YzD3BwqUdo/0oe4OP0FRpjawkBdpxS+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uCpQJWYC; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 2 May 2024 09:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714668338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IrbZFE5o5PMbnzhgpEPHbh7quo4OsFw3oMGrAAHN3fI=;
	b=uCpQJWYCUE9wb0HAiul07mm9TH86igqjZ66uQf2c3cHUvzQbAj8dXu3SNbZCESEpQG8Kmz
	PtwqMaWm14eFvCI7p9S1B0IWDltOTxLHJEmeHYD/UWzwAnPuPoAbUzgVaDlUkkmif4Asoo
	pU4v/2cBY7upyp6DlZc8K2v7n2kZU+o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: align cma on allocation order, not demotion
 order
Message-ID: <ZjPDLZZ-raoO2mRy@P9FQF9L96D>
References: <20240430161437.2100295-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430161437.2100295-1-fvdl@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 04:14:37PM +0000, Frank van der Linden wrote:
> Align the CMA area for hugetlb gigantic pages to their size, not the
> size that they can be demoted to. Otherwise there might be misaligned
> sections at the start and end of the CMA area that will never be used
> for hugetlb page allocations.
> 
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Fixes: a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

