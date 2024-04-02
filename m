Return-Path: <linux-kernel+bounces-127565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B9894DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6261C21D50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B054F217;
	Tue,  2 Apr 2024 08:36:19 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986E57876;
	Tue,  2 Apr 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046978; cv=none; b=cijWfq5iPsLYjwBonJMjTXEuZFoulWKOsW+B3AKcxrah0RseyUT6MCHulCshgmQ95icnOFtbWrpQy5+UF+er1AHgZjHRP8RZ7eUkcts2+3uKEBbPfSRrlv+vzEaKYcpmIO1sCYDQU9MP0qT1iHVKCcTxjpzZ1msziejS3Ryg9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046978; c=relaxed/simple;
	bh=UB/N0cVPnf/gh5VPq0ZazBwt+QqNOI4Qfzr3vqZ49ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qACvkhliKGBtfr2hAsn7Q22mpR/XFw2KfLh4tpWjtmcbb6Z4jR3rjvb+noImnylkMBpZUN+rQHiGDL5E8Xt+dqX2HnVCoJh5LUR/KF86GefZ9BktwdzspYGJViIALb6Xc0W8RDxcyTQw/ZcYEKJnC+6OY8bUBE5zHANgLDy9YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rrZcY-00E0Ns-HN; Tue, 02 Apr 2024 16:35:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Apr 2024 16:36:11 +0800
Date: Tue, 2 Apr 2024 16:36:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: xingwei lee <xrivendell7@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	samsun1006219@gmail.com, Mike Rapoport <rppt@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in crypto_sha3_update
Message-ID: <ZgvDe6fdJzgb8aZZ@gondor.apana.org.au>
References: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>

On Wed, Mar 20, 2024 at 10:57:53AM +0800, xingwei lee wrote:
>
>   syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20000000ul, /*addrlen=*/0x58ul);
>   res = syscall(__NR_accept, /*fd=*/r[0], /*peer=*/0ul, /*peerlen=*/0ul);
>   if (res != -1)
>     r[1] = res;
>   res = syscall(__NR_memfd_secret, /*flags=*/0ul);
>   if (res != -1)
>     r[2] = res;

So this is the key to the issue.  The whole point of memfd_secret is
to make the pages inaccessible to the kernel.  The issue is those
pages are then gifted to the kernel through sendmsg.  Somewhere
along the line someone is supposed to throw up an error about this,
or map the pages properly.  I guess neither happened which is why
we end up with a page fault.

I'll cc the memfd_secret authors to see what should catch this.

>   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xb36000ul,
>           /*prot=*/0x2000003ul, /*flags=*/0x28011ul, /*fd=*/r[2],
>           /*offset=*/0ul);
>   syscall(__NR_ftruncate, /*fd=*/r[2], /*len=*/0xde99ul);
>   *(uint64_t*)0x20000180 = 0;
>   *(uint32_t*)0x20000188 = 0;
>   *(uint64_t*)0x20000190 = 0x20000140;
>   *(uint64_t*)0x20000140 = 0x20000080;
>   *(uint64_t*)0x20000148 = 0xb0;
>   *(uint64_t*)0x20000198 = 1;
>   *(uint64_t*)0x200001a0 = 0;
>   *(uint64_t*)0x200001a8 = 0;
>   *(uint32_t*)0x200001b0 = 0;
>   syscall(__NR_sendmsg, /*fd=*/r[1], /*msg=*/0x20000180ul,
>           /*f=*/0x47933e2b0522cf63ul);

This is the spot where the memfd_secret pages are given to the kernel
for processing through sendmsg.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

