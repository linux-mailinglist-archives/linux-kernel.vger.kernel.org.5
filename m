Return-Path: <linux-kernel+bounces-167616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700958BAC08
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251421F21EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFE152DF0;
	Fri,  3 May 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsFvvHtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AD848A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737671; cv=none; b=AAp1L2K0SW/JaTBxZD39Pv8EVvvy5w8bTIyHsk5IU5DMz2I/UxwYf4hGAh3AFMgYBeWXQ0u8D9eXxhBUe2ssATMA/YXfMHEXXyglEIDPVlVvtVc754VnT+fltXS90lrlXfqTfO3eMBbG6YSll+R8vUDP2ViKV2nvdOLSZDVYse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737671; c=relaxed/simple;
	bh=pNn1ZnLdIoZXn4anJCmUHd8hHC79ijS4d9Te7tMQCJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMHhl2yskyFkays+/Fev2rbcGCnSkv+/6O/aALYU7IIDpLOOjwvgW8wp3vCQDSHWkzK5IEH4m/7Ma3UEF4YtJhznkjlMM5QDqrn4GZEAtiWsclfJfRWRdd9GONMRxtdJ+PHquKQvYKUfGI50rGKRtnCb/mC2Ip0Y1fNFi9qjzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsFvvHtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A536C116B1;
	Fri,  3 May 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714737670;
	bh=pNn1ZnLdIoZXn4anJCmUHd8hHC79ijS4d9Te7tMQCJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsFvvHtEUW5DG32HjK8HOFltIOrd92pmxTXaeeFgHY4lZeYYJSbcntq+xi3/idJ9l
	 YF99wi72KOQzRE78xIjSOAdZuDeNegWHiKgeXr03IWzpAapcvCM+wEkbEzabclvsoI
	 oHMO5YdcUSk9FT+Qweh1OW79pONs3H5oven9l61eUELwB9799ROx+fUqJZChjnHGWR
	 Uhr1OA7WQaRcyrgZOP7BVfPGK7TOKtaMQVR3hkF0J9vRXsPi+jMgzNG48aUp1TZoFZ
	 rZEUxWqGRAC/68Rz3oKtCxF1eEmzkG9um8UGYo1a4iHjmfz2JEsUNkp5prNxGv02x5
	 HtkeRgUNFhiKw==
Date: Fri, 3 May 2024 13:01:04 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64/mm: Enable userfaultfd write-protect
Message-ID: <20240503120104.GA18156@willie-the-truck>
References: <20240501145419.1390363-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501145419.1390363-1-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Ryan,

On Wed, May 01, 2024 at 03:54:16PM +0100, Ryan Roberts wrote:
> This series adds uffd write-protect support for arm64.
> 
> Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
> perceived lack of available PTE SW bits. However it actually turns out that
> there are 2 available but they are hidden. PTE_PROT_NONE was previously
> occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
> "IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
> use" like it does for the other SW bits. I've confirmed with the spec owner that
> this is an oversight; the bit is intended to be reserved for SW use and the spec
> will clarify this in a future update.
> 
> So now we have two spare bits; patch 3 enables uffd-wp on arm64, using the SW
> bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
> (e.g. soft-dirty - see RFC at [3] - or some other usage).

Thanks, I think this series looks really good now.

From your discussion with Anshuman, it sounds like you're going to post
a new version with the first patch split up so I'll wait for that.

Will

