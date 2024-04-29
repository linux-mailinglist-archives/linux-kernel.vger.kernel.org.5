Return-Path: <linux-kernel+bounces-162690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B068B5F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25C61C2142D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA28562E;
	Mon, 29 Apr 2024 16:34:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EC1E4BE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408447; cv=none; b=CD75E/ikLs6cEScCy+GnOd7P9nF/oV1xiZxA9K9mO39tEN/uUJ08tttyUphFbAiGLckc5UfQSsPAseEF0KnDYtUkh9E5SUBYD2/YPaUjXL9shLh5D4jpe9v3mzldgHcVlDiLlVP5IVVHq25lCnPhga3KwrGFiQD/MwTiCDwvmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408447; c=relaxed/simple;
	bh=tp4gof1FQFgdvLtEsovWPTK7DBuxtwmZt9bB0FbK/eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX7KvWVLEW9J+PbcWachASGHBidz5762abWqNxQ+CloD6CPXfQe/4bIy1vnN62Mhu5NBnihmoRqAWYtoNZUGjTQgU1o/fzocdUffdHBJMyRl9hA3Q+MsWFOuwRd+Y6hJ399io5MWz6Cv6JgCzqKPofnuo3D1A9cRFzM2ckOhH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D787C113CD;
	Mon, 29 Apr 2024 16:34:04 +0000 (UTC)
Date: Mon, 29 Apr 2024 17:34:01 +0100
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
Subject: Re: [PATCH v2 2/3] arm64/mm: Move PTE_INVALID to overlay PTE_NS
Message-ID: <Zi_L-asPXKDo3IMf@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429140208.238056-3-ryan.roberts@arm.com>

On Mon, Apr 29, 2024 at 03:02:06PM +0100, Ryan Roberts wrote:
> PTE_INVALID was previously occupying bit 59, which when a PTE is valid
> can either be IGNORED, PBHA[0] or AttrIndex[3], depending on the HW
> configuration. In practice this is currently not a problem because
> PTE_INVALID can only be 1 when PTE_VALID=0 and upstream Linux always
> requires the bit set to 0 for a valid pte.
> 
> However, if in future Linux wants to use the field (e.g. AttrIndex[3])
> then we could end up with confusion when PTE_INVALID comes along and
> corrupts the field - we would ideally want to preserve it even for an
> invalid (but present) pte.
> 
> The other problem with bit 59 is that it prevents the offset field of a
> swap entry within a swap pte from growing beyond 51 bits. By moving
> PTE_INVALID to a low bit we can lay the swap pte out so that the
> offset field could grow to 53 bits in future.
> 
> So let's move PTE_INVALID to overlay PTE_NS (bit 5). PTE_NS is res0 for
> SW outside of the secure state so Linux will never need to touch it.
> 
> These are both marginal benefits, but make things a bit tidier in my
> opinion.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(subject to renaming PTE_INVALID to PTE_PRESENT_INVALID)

