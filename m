Return-Path: <linux-kernel+bounces-151343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E944D8AAD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A280A282C53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44A823A9;
	Fri, 19 Apr 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4CnkOV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9C81216
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524592; cv=none; b=CJMhzOW+sbwkoj+MwBfhC77UQGR9cMylIfrxnjCY1jgIcz22TspWbQIID2v/a/yobgAYx7DzY2LgIqPYwYlNZnu9FYdc/AdRzrZhryS7yJVj43K07CiLQkpb8WfVM3iNGdeZT5hiS8cBn0jgTgZ9rfIa8ThN5iDdnjTOnuQ7aEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524592; c=relaxed/simple;
	bh=uWAY6LlF7v6+sqojjMdbCQRzzgR4DjCY8JKq5y18Ehk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCYXOgy7z1bZb5Gd9gS20RA3vNeqkKjoLrP3AOqD7zV6VJbbpowBFslbU5B9uLekD+/8SwQelR0r62P3dP47DXJocqDL7IgqwRCXuVELncB99pPfhvF9pJNeOfJhnnceI8f6XeShthhnwm2d9ppbOzSqV3PXhQAXNkrscwij47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4CnkOV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D71C072AA;
	Fri, 19 Apr 2024 11:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713524592;
	bh=uWAY6LlF7v6+sqojjMdbCQRzzgR4DjCY8JKq5y18Ehk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4CnkOV8TzpWGtuWggKvbOgGgmDnwWfihPiKWDyeKOBgfMQgKbYqAWbV0zNi09unu
	 F6w+nEDNflQn9cwHTby2xXiJ9MTWm/QrSda0u4cpCBYLoa/RqiLmzG8NXqvSfQenri
	 5k8ACsd7zdPRvLqTOV8cnP8JLL9bC+spTsesgIhlB/onl2LiCvS517GIm7uSG5M51A
	 KAD4Q+WYmNz+CpMnYngIUdlMwvyrC1G/Y561SbvIf6XO7FNgFU5AVjNW8K27bBgQ0I
	 uxbd91aRxGTbT0+nw8jptnCTZ00/9p7sog6tB/HmoZtM5pqFNusVV3/ASfza6XMse1
	 41BbtdZO+HI1g==
Date: Fri, 19 Apr 2024 12:03:06 +0100
From: Will Deacon <will@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, ryan.roberts@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
Message-ID: <20240419110306.GA2972@willie-the-truck>
References: <CAHVXubiH64beFuB_GHSq5BKCus=O_+bqYTCwWQ+=2Q-F=T=ctQ@mail.gmail.com>
 <mhng-911ba065-e6c8-4d42-978c-e47897bcb493@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-911ba065-e6c8-4d42-978c-e47897bcb493@palmer-ri-x1c9a>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 18, 2024 at 03:11:56PM -0700, Palmer Dabbelt wrote:
> On Fri, 01 Mar 2024 03:29:18 PST (-0800), alexghiti@rivosinc.com wrote:
> > On Fri, Mar 1, 2024 at 11:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > I confess I haven't looked at the patches yet, but this cover letter raises a
> > > few quesions for me. I'll aim to look at the actual patches in due course.
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> in case someone wants to pick them up via a generic tree.  I'm happy to take
> them via the RISC-V tree if folk want, no rush on my end I'm just scrubbing
> through old stuff.

I'd definitely like to take the arm64 parts via the arm64 tree (on a
shared branch), as it's a non-trivial amount of mm code which may end up
conflicting. I'd also like to see Ryan's Ack on the changes before these
end up in -next.

Will

