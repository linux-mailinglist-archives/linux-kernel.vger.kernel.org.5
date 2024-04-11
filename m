Return-Path: <linux-kernel+bounces-140746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DEF8A18D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500C3B2A655
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF43398E;
	Thu, 11 Apr 2024 15:25:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496715E85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849147; cv=none; b=QNztD+kfWflwNY2a71i3dTmM2jagLz8+G6fD1H6yvHzFau9xEGBo//am8txJprGDzE1TMWPbDlCPqvW2aCDnc0/50z18N6k7X0OKD7/ChDMX8PifdevIu3Q1jOFZWwfm2+DdrrZcK8yJs0obGHqns7lCaSafJKDJXxbbogI7TyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849147; c=relaxed/simple;
	bh=dgfr9kddIcMvQMEC+xA9ZzQEu4QL1FEzezLmB3J0a9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0QQzRmUrL2akA8NDguOIhUIh74EpSluJFM8sXhLBvezE1ZWIjIbcHCaN5hoAAJep5gnCItbw6ahoyTdFcxGJe992JMLoZKT+plEkOyh2Kai4fPUJW7TFvZsB/OUkXNii7lQQ6cYvkZk3piJj9p90EdZnvidrp6pxeC/PYjLD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2198A113E;
	Thu, 11 Apr 2024 08:26:12 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7F7E3F6C4;
	Thu, 11 Apr 2024 08:25:40 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:25:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Message-ID: <ZhgA8WDkZDbYIDHg@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
 <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>
 <Zhf4LqNhQFN8ezx1@FVFF77S0Q05N>
 <d9582c0e-af24-46a1-9c3e-b9dc68af20d8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9582c0e-af24-46a1-9c3e-b9dc68af20d8@arm.com>

On Thu, Apr 11, 2024 at 03:57:04PM +0100, Ryan Roberts wrote:
> On 11/04/2024 15:48, Mark Rutland wrote:
> > On Thu, Apr 11, 2024 at 02:37:49PM +0100, Ryan Roberts wrote:
> >> On 11/04/2024 14:02, Mark Rutland wrote:
> >>> but the logic remains fairly simple, and I suspect the overhead for late
> >>> allocations might not matter since the bulk of late changes are non-allocating.
> >>
> >> Its just the fixmap overhead that remains...
> > 
> > True; my thinking there is that almost all of the later changes are for smaller
> > ranges than the linear map (~10s of MB vs GBs in your test data), so I'd expect
> > the overhead of those to be dominated by the cost of mappin the linear map.
> > 
> > The only big exception is arch_add_memory(), but memory hotplug is incredibly
> > rare, and we're not making it massively slower than it already was...
> 
> What about something like coco guest mem (or whatever its called). Isn't that
> scrubbed out of the linear map? So if a coco VM is started with GBs of memory,
> could that be a real case we want to optimize?

I think that's already handled -- the functions we have to carve portions out
of the linear map use apply_to_page_range(), which doesn't use the fixmap. See
set_memory_*() and set_direct_map_*() in arch/arm64/mm/pageattr.c.

Note that apply_to_page_range() does what its name implies and *only* handles
mappings at page granularity. Hence not using that for
mark_linear_text_alias_ro() and mark_rodata_ro() which need to be able to
handle blocks.

Mark.

