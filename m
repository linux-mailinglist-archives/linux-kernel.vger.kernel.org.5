Return-Path: <linux-kernel+bounces-132514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759B899618
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEF1F24C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273E288D7;
	Fri,  5 Apr 2024 07:00:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F732557A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300419; cv=none; b=jYtV+rkCuMee1Yzs5CUXkcT0pgjpmy6TQ3KYd1Mmj5Uc5jT9qbsgc/b0ck5PAuuulsv5UjoxXQRm6gf5Hr+06+guaxiDHVaDJhi7gI+D3BVXsaJAtihAKUoGSBnIU/mgn218FX4N0Ky+4QuR/RPtxhNEejtA9DRylQGssocU0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300419; c=relaxed/simple;
	bh=CigG1iSnJRA6e+51aa8I9PgDt8HrJ4ZvNxwm/aLJAp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkNZbiNVEwu2UdR6Rf9VdnBN5I77L+wJ3AMXF9FP3T5Fx7smcTBsb67LjW4Lc4dEktpkWEynXKe6KLk+3XDA1FFOVIxdXwSUZgeNJTCyuCAbjstrBGblWmHos9pvTKXQOMJGc4+pfWIjtUBuvIQuHxfcljFkPPKHDhKLL8JAOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2865768D08; Fri,  5 Apr 2024 09:00:07 +0200 (CEST)
Date: Fri, 5 Apr 2024 09:00:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Fei Li <fei1.li@intel.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-ID: <20240405070005.GA4176@lst.de>
References: <20240403212131.929421-1-david@redhat.com> <20240403150958.713734a1dfbf6cd99d8e7b02@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150958.713734a1dfbf6cd99d8e7b02@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 03, 2024 at 03:09:58PM -0700, Andrew Morton wrote:
> On Wed,  3 Apr 2024 23:21:28 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > Rebased on latest mm-unstable. As we have a conflict now with a cleanup
> > from Chrostoph, temporarily revert that one, so we can apply the fix,
> > and reapply the adjusted cleanup on top. I squashed the fixups
> > sitting in Andrew's tree for that patch.
> > 
> > The fix should likely go in first via the hotfix route, that's why I'm
> > moving it to the front.
> 
> Well that was easy, thanks ;)  Perhaps hch can double-check [3/3] here.

Still looks good.

