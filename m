Return-Path: <linux-kernel+bounces-89168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DD86EB87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C451F215B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB659141;
	Fri,  1 Mar 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olnLWCFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5UmcwJId"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8A54273
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330265; cv=none; b=t4Ho8HNuYcz7FMB10FIGYxNZQyW6dhQna0pDnZt5ASR2HzYNnOYJAXHtn2Mi4927bvXLDZ7dzBW1TeJIBuzDWwfhKa1kj1TB2xTrl/I7gvNLQDKhTYjRa7dqhlEO2Uc+V15OlYziU8J23W9UVkaRerR6KwdmQGXCUfnQploXWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330265; c=relaxed/simple;
	bh=wLs58LjYHqDtAtU9huTE5yAnHjoEs4loshkLDz0+nwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6ir7DSLv+QpvRrijxkAtUFtNEqkVFJ1ILnbdZXV1I1r0R63dhbq9HejY/duiOLJFSq/M5WgAYqGdWDtGLQVjrH+iiLM3Hr2RNnCnJjRtAUh6+f9wNjOmXvjJmN6t0FR9vS9iIjRHyS/tYN6ujxO6sf4U6Jnb+lWxQv/iT/pE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olnLWCFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5UmcwJId; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709330262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2ElRbJ+yWzkzMZNxWMo/TKFEfePY+AGrVnb1CXRPlQ=;
	b=olnLWCFvicqLHdfJxhLQ07B5CNKb/MXpfPRhZLaotxh9U+Q8/ZHGu+AfVXXg3wMIRqQZz0
	Q3OzsI2COBvCWupb7L9BFTqN6ecBsOckSXbqvanEnMNRfHYJEoUfa8ZwpXSOjz+EllNYOH
	JBRQEKfw+l55WoZviYsGkrEtzYOnxScVb68K/3Gv45rXHCfU7Cj0z+Uk2MJlMiKBj7idsH
	3EWRd7uF/lGn4AInIP161Q19jSUYiDnhoe/xlVrxYnfmVU19VO4dNQLzsTRH9IRQ6PndQU
	MFdBwH0gHg20yUoCocYSiqWapWQIF9bNwuUDXgme3hzm6HP5jEgh183ARiN65A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709330262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2ElRbJ+yWzkzMZNxWMo/TKFEfePY+AGrVnb1CXRPlQ=;
	b=5UmcwJIdsxDbKZwwJ1DucFoymc/eCb6Y5p1FQZMI7zSKlp/9BOFONi5Bobu0Vap9bP8DjT
	YII6qGcgivUjpFAA==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Arjan van
 de Ven <arjan@linux.intel.com>, x86@kernel.org
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <202403020457.RCJoQ3ts-lkp@intel.com>
References: <202403020457.RCJoQ3ts-lkp@intel.com>
Date: Fri, 01 Mar 2024 22:57:41 +0100
Message-ID: <87edctwr6y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 02 2024 at 04:12, kernel test robot wrote:
> FYI, the error/warning was bisected to this commit, please ignore it
> if it's irrelevant.

I have no idea to which previous thread you are replying to because your
mail lacks any references.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   87adedeba51a822533649b143232418b9e26d08b
> commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
> date:   5 months ago
> config: i386-randconfig-062-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020457.RCJoQ3ts-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>
> vim +698 arch/x86/include/asm/processor.h
>
>    695	
>    696	static inline u16 per_cpu_llc_id(unsigned int cpu)
>    697	{
>  > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
>    699	}
>    700	

This is bogus and I looked at another related bogosity today:

  https://lore.kernel.org/all/202403010704.oGQZPu0P-lkp@intel.com

which has similar complaints.

So I went and downloaded the config and followed the reproduction
instructions except for one detail.

The only difference is the sparse version:

    1) I had the regular debian variant installed.

       Version:  0.6.4 (Debian: 0.6.4-3)

    2) I updated my sparse clone and rebuilt

       Version:  v0.6.4-66-g0196afe16a50

Neither one of them exposed the problem, but you are using:

       sparse version: v0.6.4-66-g0196afe1-dirty

which is obviously based on the latest upstream tree, but seems to have
some extra muck on top which I don't know what it is.

Does this reproduce with an unpatched upstream sparse for you?

If so then I'm really curious why it does not reproduce here.

Thanks,

        tglx

