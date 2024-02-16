Return-Path: <linux-kernel+bounces-68576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141B857CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B481BB20DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D312881C;
	Fri, 16 Feb 2024 12:34:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B0339A1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086870; cv=none; b=HyzC5RRzg5NsXXMLON2hNKxFEvEX91CyGZ8ynPpjOcpMin71NTzWPErY0k2Yw33XkCTAP7ENpObriKEspqFaSgXYt4b99op09r1N0LqJqT4dW6IzjdeuaXNwtJmYc2gSSiYa14gRuX7QlwnmtnHr//nuuELcxLozu6Oit/NFAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086870; c=relaxed/simple;
	bh=x4PKLZP4+EHRWnPbPhu64B7Lq3y21gG0G8Z1bOVklRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8gwh4RvlmpDsenA2r1Wud6CPtNqm00ANZlCdmGdxqjFU5+eLFGM50ASKqcktfunoh5rvyssE6Pung49fXR0tMJN/mPpPgyTavlk6GHGpj+9G2Vcszp++JyyXVX+kRn3YxWi7n+Jo87CSpiK4Lea6gzYGY7c5OK1ooL/Vg7HiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9663DC433C7;
	Fri, 16 Feb 2024 12:34:25 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:34:23 +0000
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
Subject: Re: [PATCH v6 17/18] arm64/mm: __always_inline to improve fork() perf
Message-ID: <Zc9WT8Wit4HkIsD2@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-18-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-18-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:04AM +0000, Ryan Roberts wrote:
> As set_ptes() and wrprotect_ptes() become a bit more complex, the
> compiler may choose not to inline them. But this is critical for fork()
> performance. So mark the functions, along with contpte_try_unfold()
> which is called by them, as __always_inline. This is worth ~1% on the
> fork() microbenchmark with order-0 folios (the common case).
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

