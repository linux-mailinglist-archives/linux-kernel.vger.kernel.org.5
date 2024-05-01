Return-Path: <linux-kernel+bounces-165211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B48B8991
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EB6285D23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1BB84D0B;
	Wed,  1 May 2024 12:07:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240C83CB0;
	Wed,  1 May 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565261; cv=none; b=VU+t1W1CKAqeNeoI1vdQEqxCXJYnyzI/Qh0fKMh5jIh2A6+y0CsO5qsAoY4w+W0x2xwWdG9oNyfX4i3tqbWSqkL4bEGLxdw7TVTvWQZety56A6sCXv0WlhcaquR/dVILEyUfBivMDZ5a5mbco7pIXM5X45ngav42rTbxernGQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565261; c=relaxed/simple;
	bh=KRSiba1Wfe1AyV1Ikzz7ypfhE6bSK4FEWZ0s092Z/9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBFZIYCjRuh+mgYefTgCBbRVoujcIDALXF6ys3ieXIhWSd7uTNzB3JMJe8ThMEe6ZU4SEGwW+q80VUNNUJ8DRRcjsKMuBx28+nMqlLLz4SNomlg/kz6y4fsue5/RETtTWHB3yor09uDOgPIJtBwlglWk8BbFyCpVgT6xZSmgDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE03C113CC;
	Wed,  1 May 2024 12:07:38 +0000 (UTC)
Date: Wed, 1 May 2024 13:07:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <ZjIwiFa3CMxxtAZ1@arm.com>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>

On Tue, Apr 30, 2024 at 11:05:01AM -0500, Maxwell Bland wrote:
> Add an optional note_non_leaf parameter to ptdump, causing note_page to
> be called on non-leaf descriptors. Implement this functionality on arm64
> by printing table descriptors along with table-specific permission sets.
> 
> For arm64, break (1) the uniform number of columns for each descriptor,
> and (2) the coalescing of large PTE regions, which are now split up by
> PMD. This is a "good" thing since it makes the behavior and protection
> bits set on page tables, such as PXNTable, more explicit.
> 
> Before:
> 0xffff008440210000-0xffff008440400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff008440400000-0xffff008441c00000 24M PMD ro NX SHD AF NG BLK UXN...
> 0xffff008441c00000-0xffff008441dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff008441dc0000-0xffff00844317b000 20204K PTE RW NX SHD AF NG UXN ...
> 
> After (tabulation omitted and spaces condensed):
> 0xffff0fb640200000-0xffff0fb640400000 2M PMD TBL RW x NXTbl UXNTbl ME...
> 0xffff0fb640200000-0xffff0fb640210000 64K PTE RW NX SHD AF NG UXN MEM...
> 0xffff0fb640210000-0xffff0fb640400000 1984K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb640400000-0xffff0fb641c00000 24M PMD BLK ro SHD AF NG NX UXN...
> 0xffff0fb641c00000-0xffff0fb641e00000 2M PMD TBL RW x NXTbl UXNTbl ME...
> 0xffff0fb641c00000-0xffff0fb641dc0000 1792K PTE ro NX SHD AF NG UXN M...
> 0xffff0fb641dc0000-0xffff0fb641e00000 256K PTE RW NX SHD AF NG UXN ME...
> 
> v3:
>   - Added tabulation to delineate entries
>   - Fixed formatting issues with mailer and rebased to mm/linus
> 
> v2:
>   - Rebased onto linux-next/akpm (the incorrect branch)
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
> Thank you again to the maintainers for your review of this patch.
> 
> To Andrew Morton, I apologize for the malformatted patches last week.It
> will hopefully never happen again. I have tested mailing this patch to
> myself and have confirmed it cleanly merges to mm/linus.
> 
>  Documentation/arch/arm64/ptdump.rst | 184 +++++++++++++---------
>  arch/arm64/mm/ptdump.c              | 230 +++++++++++++++++++++++++---
>  include/linux/ptdump.h              |   1 +
>  mm/ptdump.c                         |  13 ++
>  4 files changed, 332 insertions(+), 96 deletions(-)

Is this v3 replacing v2 here:

https://lore.kernel.org/r/20240423142307.495726312-1-mbland@motorola.com

or it goes on top? The patch versioning and subject change confuses me.

-- 
Catalin

