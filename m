Return-Path: <linux-kernel+bounces-43362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3658412B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E7628453B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781015AACB;
	Mon, 29 Jan 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVUXvJb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A461D687;
	Mon, 29 Jan 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553781; cv=none; b=ZtjerE+lVMMAGAA5EWb1nzKv4KWSjPCxf19UlrmD8ZHVDWWYbCA1JZVWoTmuAB0jbMnfBqTaaRnSUvuRfcu1F43pgvHWeSrTjAgsmR9c1wa0JYHFcIwuxKmpfcCTwVIBRT3epq4XfTm0YSKGhPaMU9U+K1IxqybaHMtAYb1rpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553781; c=relaxed/simple;
	bh=z7dp0Qp1EQQ9w5NACKTKcarqslU07mgnpi1r9oGaWNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2agmi7ayDhVSfZvz4WuvSjcCTpTX20FJwaFiGYI0EqLsFjqB+yS7kqvuzz5WQTZcwWX9r6cGNToNZWWbAvgtdNSkEICet0P2GMz4lywQR0oICYzjfOfdYmSaJy0J+OvWFjY6eKrLSErjUOFHSdltZ1afjePPyTgwsnfRrIjaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVUXvJb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDAFC433F1;
	Mon, 29 Jan 2024 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553781;
	bh=z7dp0Qp1EQQ9w5NACKTKcarqslU07mgnpi1r9oGaWNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVUXvJb6ySWYAAxbqDKL6OJ/BobhrZ8237AfXIQgG8zeN5Ctj/2pizHrxxIB32HwZ
	 F8JEPBRwcnAQumtPxB33p2Ve8tSmT4iDMeCQ5M557UA4JnQoJyc3oI0kagNUvSmpDn
	 iEtWRnUyElx0m+iKjzFdrMk2399ddHsNYfWx2qbbU2KzLzFdfQDD4j+UcrBni4Pgu6
	 z3zBM9WCb8kMHtONTIIVEWh1tm/toZa6sKSE51TuzivTdjpbKGWN6kkQGVpgohmuVM
	 ooCV/N0mgJgtMZ+4nYY37NinsGLgi6NjErWZJ/BMgmkrGEbXzqs2TMrU/oU66CXygF
	 z1A5/Wmvsospw==
Date: Mon, 29 Jan 2024 18:42:55 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 0/2] Fix double allocation in swiotlb_alloc()
Message-ID: <20240129184255.GA12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126172059.48ad7b9f@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126172059.48ad7b9f@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 26, 2024 at 05:20:59PM +0100, Petr Tesařík wrote:
> On Fri, 26 Jan 2024 15:19:54 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > Hi folks,
> > 
> > These two patches fix a nasty double allocation problem in swiotlb_alloc()
> > and add a diagnostic to help catch any similar issues in future. This was
> > a royal pain to track down and I've had to make a bit of a leap at the
> > correct alignment semantics (i.e. iotlb_align_mask vs alloc_align_mask).
> 
> Welcome to the club. I believe you had to re-discover what I described here:
> 
>   https://lore.kernel.org/linux-iommu/20231108101347.77cab795@meshulam.tesarici.cz/

Lucky me...

> The relevant part would be this:
> 
>   To sum it up, there are two types of alignment:
> 
>   1. specified by a device's min_align_mask; this says how many low
>      bits of a buffer's physical address must be preserved,
> 
>   2. specified by allocation size and/or the alignment parameter;
>      this says how many low bits in the first IO TLB slot's physical
>      address must be zero.  
> 
> Fix for that has been sitting on my TODO list for too long. :-(

FWIW, it did _used_ to work (or appear to work), so it would be good to
at least get it back to the old behaviour if nothing else.

Anyway, cheers for reviewing the patches. I'll go through your comments
now...

Will

