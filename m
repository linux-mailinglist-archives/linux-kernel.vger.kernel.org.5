Return-Path: <linux-kernel+bounces-67518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEED856CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421831F26AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D113A249;
	Thu, 15 Feb 2024 18:34:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A17139597
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022048; cv=none; b=e6dDkmuN0k11ao5fJS32fiyED+uUTBSzprPDIfotx+6jZVXTcKprDO8wh9XF3hlIq+VXeeSs5Gjjld63Lydi7kuEozzzfl1EV4qVKMLgr+owYHw0Qpeg+4rmBDPAQP0qczqihQd/neWNtsfIgoRJya/+94M9SMFiw6Wz0vuEdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022048; c=relaxed/simple;
	bh=no/blXCb0vQawIseQkgHar47hmhAMUTDnXZAbG+6kqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRp2ldSmu0f84NX5AfGs2dnlxmBUtaC3kfy1pOb+JWRhXTylTBSsoF0vqK/cmNmHqWptfPhD0UXGuIuZhH3qrVMqMFJ8u9biV7z7tVCAjKgYggbXs54jRlSyJaDaoD6fLXve688tamMhUVUwS/m2FrUBdtEOO2NV9LXABMdhYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38715C433C7;
	Thu, 15 Feb 2024 18:34:03 +0000 (UTC)
Date: Thu, 15 Feb 2024 18:34:00 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/18] arm64/mm: Convert READ_ONCE(*ptep) to
 ptep_get(ptep)
Message-ID: <Zc5ZGNaYp5dFND1_@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-8-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-8-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:54AM +0000, Ryan Roberts wrote:
> There are a number of places in the arch code that read a pte by using
> the READ_ONCE() macro. Refactor these call sites to instead use the
> ptep_get() helper, which itself is a READ_ONCE(). Generated code should
> be the same.
> 
> This will benefit us when we shortly introduce the transparent contpte
> support. In this case, ptep_get() will become more complex so we now
> have all the code abstracted through it.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

