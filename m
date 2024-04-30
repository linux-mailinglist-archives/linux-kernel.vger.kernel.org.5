Return-Path: <linux-kernel+bounces-164003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065328B770B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384491C22156
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE3174EC0;
	Tue, 30 Apr 2024 13:28:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77D172BBF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483727; cv=none; b=aQAu31OAQKrgB+ihdNJv0yu4EU01Um6F9yBUpIxrdiqdgZKdWzteCSKmdES3ZEfmZ4TBZGe4qafBNQkq4F7xif1jQ08iKhzChYhGET/Ye8UUi7XgAVJYaDukjjo6ZL9LK0qsPqZJQmp4nHAjz5Gv2X91mXUC+KlQLLrTIusxVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483727; c=relaxed/simple;
	bh=fqVHp1k5t31Za+YyqmDbWnlbLfQ3U1zUqBIll69kroI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=patK0klC92fX5HW5aCWsR26O9GC0gOQLg2ux2H0JCWmhgC6FEngiBq1uFgielZVFvK4m7557jdAhclRKCNBzcX40VPltd3RAyERxempVWI9lojZzCX6fBJemq7XqPQ8XAzs2RiYK0tghx9y3K42VNc8gceMsXaoS+WJiZ50IMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70386C4AF1C;
	Tue, 30 Apr 2024 13:28:44 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:28:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Message-ID: <ZjDyCg2LkFEXRS6k@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
 <Zi_IzrfIcqWxt7cE@arm.com>
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com>
 <ZjDR0EIjLr9F2dWn@arm.com>
 <8cf74e5f-e6a5-465e-83b4-205233c78005@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf74e5f-e6a5-465e-83b4-205233c78005@arm.com>

On Tue, Apr 30, 2024 at 12:35:49PM +0100, Ryan Roberts wrote:
> There is still one problem I need to resolve; During this work I discovered that
> core-mm can call pmd_mkinvalid() for swap pmds. On arm64 this will turn the swap
> pmd into a present pmd, and BadThings can happen in GUP-fast (and any other
> lockless SW table walkers). My original fix modified core-mm to only call
> pmd_mkinvalid() for present pmds. But discussion over there has shown that arm64
> is the only arch that cannot handle this. So I've been convinced that it's
> probably more robust to make arm64 handle it gracefully and add tests to
> debug_vm_pgtable.c to check for this. Patch incoming shortly, but it will cause
> a conflict with this series. So I'll send a v2 of this once that fix is accepted.

Sounds fine. I can queue the arm64 pmd_mkinvalid() fix for 6.9 and you
can base this series on top. But I have a preference for this patchset
to sit in -next for a bit anyway, so it might be 6.11 material.

-- 
Catalin

