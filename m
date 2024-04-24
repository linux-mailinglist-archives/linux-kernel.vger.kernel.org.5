Return-Path: <linux-kernel+bounces-157344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180018B101B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFE11F247FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3F16C437;
	Wed, 24 Apr 2024 16:44:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D7393
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977043; cv=none; b=bZlntTXVnvcEdGVTtZzxih5+e8e197FZJsB6nCF6pGVPD9OrVwLunPMWfy9NJ1NktTf7vKe99NVgrllxa03I8oAFFFLPXnK+w/RLI9z6WXtH/pUtoOX63bnynllL1gf8wMXblBh1sWmfhMnFBg/I/TdSO31aQHtFeqndz+IBhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977043; c=relaxed/simple;
	bh=XOkoRAeOLBBwWfiy9asZrl+BJVwihqjiTP8qVEuUoZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy1kvckFrD9agciYKDY9h0WmcynEPEBHvJtEprJP5MW/9gddWCWx00JYxg2YvAfm8GrLusDlzwYT/a+9gbOEIutjQOsjc5RceIea+PqzScXvIn3FbmM9y54TNraFukX/W2TWKB8d8kawaM6QRPYpzQ+nsWyXJcS8oqlvk0ae8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F013C113CD;
	Wed, 24 Apr 2024 16:44:00 +0000 (UTC)
Date: Wed, 24 Apr 2024 17:43:58 +0100
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
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
Message-ID: <Zik2zs0cBeJ_AzED@arm.com>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424111017.3160195-2-ryan.roberts@arm.com>

On Wed, Apr 24, 2024 at 12:10:16PM +0100, Ryan Roberts wrote:
> Previously PTE_PROT_NONE was occupying bit 58, one of the bits reserved
> for SW use when the PTE is valid. This is a waste of those precious SW
> bits since PTE_PROT_NONE can only ever be set when valid is clear.
> Instead let's overlay it on what would be a HW bit if valid was set.
> 
> We need to be careful about which HW bit to choose since some of them
> must be preserved; when pte_present() is true (as it is for a
> PTE_PROT_NONE pte), it is legitimate for the core to call various
> accessors, e.g. pte_dirty(), pte_write() etc. There are also some
> accessors that are private to the arch which must continue to be
> honoured, e.g. pte_user(), pte_user_exec() etc.
> 
> So we choose to overlay PTE_UXN; This effectively means that whenever a
> pte has PTE_PROT_NONE set, it will always report pte_user_exec() ==
> false, which is obviously always correct.
> 
> As a result of this change, we must shuffle the layout of the
> arch-specific swap pte so that PTE_PROT_NONE is always zero and not
> overlapping with any other field. As a result of this, there is no way
> to keep the `type` field contiguous without conflicting with
> PMD_PRESENT_INVALID (bit 59), which must also be 0 for a swap pte. So
> let's move PMD_PRESENT_INVALID to bit 60.

I think we discussed but forgot the details. What was the reason for not
using, say, bit 60 for PTE_PROT_NONE to avoid all the swap bits
reshuffling? Clearing or setting of the PTE_PROT_NONE bit is done via
pte_modify() and this gets all the new permission bits anyway. With POE
support (on the list for now), PTE_PROT_NONE would overlap with
POIndex[0] but I don't think we ever plan to read this field (other than
maybe ptdump). The POIndex field is set from the vma->vm_page_prot (Joey
may need to adjust vm_get_page_prot() in his patches to avoid setting a
pkey on a PROT_NONE mapping).

-- 
Catalin

