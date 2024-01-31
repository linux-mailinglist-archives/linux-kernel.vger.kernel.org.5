Return-Path: <linux-kernel+bounces-46734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E2844352
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4761F221FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD112A148;
	Wed, 31 Jan 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxZxh5pV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60961128388
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716004; cv=none; b=MVJJN4Fy9s48xXeBoLfx2wp/MWZZ5Mp4AhunNCQgA4v/5E+JGswn+Ob3J7sLrfriKR+i6r1JGPf9bz89Vv9PaHMz9NgQQ7uXSfo5gL6Psb9SvRVOPkS3OW9mxnPQHLgAsm1c1ib4EJekd9rrrjINFgN7WVUAY7SF6aL8zwh7P8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716004; c=relaxed/simple;
	bh=TIYEjhEm+Q9THJNQ+RQRVyVZX4DEQNHZSWYzF0LI+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuwXNRgMW7bf0DtXDPqD18+COXPH+Bu2qiRfmuUCMcZeKUCAHWsD1mJzyLw9OByhuBKVaoBz4wDSDIhhbNIrTN9s+s35FXRNkrsM5pIpbb9sPC7St+0qejCNixQ0QmL7Tcyx7Yx7MTmo7eE0HK7Bn/02eqDgySvW3wreuYRhyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxZxh5pV; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706716003; x=1738252003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIYEjhEm+Q9THJNQ+RQRVyVZX4DEQNHZSWYzF0LI+Ak=;
  b=YxZxh5pVPqosFLAAD7MphbDqPojQeWmV3P0TSZGqGs+JLwJ9C0b549mD
   AJoAnXY2kGm7L+7YptHQSvbF/LB3VNkaNTtlfOrrKnnuaVScJGE4zKiRu
   70TliT2+w6BpfoUaPGZx+VXZ58G3av602SwdJLmu3hk1r4n+Fs/7RnfFY
   NgiE6ifIjvvG70exoRxq0eET+Vc037Lkladx6gTHJVKP5ofegXYNzG/6b
   yoGjYptSRowVK99byy5J575tygDCcAnjmugiWQZsP2Q0qJNeuBFCA3Uxe
   JoWqAPtq5OhDr3Ci5NcdK/xtkX9zDNkEnmOB19GjqCjRX322uqNhX3Gtj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394068820"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="394068820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822605488"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822605488"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2024 07:46:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 07C7B772; Wed, 31 Jan 2024 17:36:46 +0200 (EET)
Date: Wed, 31 Jan 2024 17:36:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 2/2] x86/head64: Replace pointer fixups with
 RIP_RELATIVE_ADDR()
Message-ID: <yie3eza6ak7eqlsvb2fjj6t7k43qtupscmv6cvu2eoqv5ikaoz@h5drniall723>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-3-kevinloughlin@google.com>
 <733302e0-e8c2-458e-a4b2-dfd10e065036@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733302e0-e8c2-458e-a4b2-dfd10e065036@amd.com>

On Wed, Jan 31, 2024 at 09:30:10AM -0600, Tom Lendacky wrote:
> On 1/30/24 16:08, Kevin Loughlin wrote:
> > Now that we have RIP_RELATIVE_ADDR(), we can replace the "fixup_*()"
> > family of functions in head64.c with the new macro for cleaner code.
> 
> If this series is purely for backporting, this specific patch isn't needed,
> right? Since this all works today with clang?

That's true. However, temporary things often end up becoming permanent :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

