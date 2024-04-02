Return-Path: <linux-kernel+bounces-128408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D6895A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857751C229DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE415A48B;
	Tue,  2 Apr 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SZK7JqIY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCF132C38;
	Tue,  2 Apr 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077825; cv=none; b=oSPygG61mUXoQARU8YHLTtCuMHKku+yScE6hbD7n8xJAPCzHCrEynkpJasGOJwpflZuaVB9OFkB0MsDMv8cw4cCKWShdMpNdfdnRySus6TdAyJwg1Grnwhq1LBaaEUOoMNmQyVB8s3ZLndEXMcaF+hvmkdpt+I/Y+n0aRwe8eoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077825; c=relaxed/simple;
	bh=HF/7wros3imLgQh1dI6bjYbQnodA/QtlZyCB0sW0qgA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nvGfTTbJX9Lotd8NsW3yZJqh5IqUYtk9pwzWp5V+yd4FvBLM++iEP8m++9qV+UzBxMFNb/xulOUWsFAD1g0SkC2DS7x35cZJUE6wHO7UJau6RDR8ht6KfDXNmu/QgibsJyV4PcZQmk97H/dSWZ+jXQFy66K7jfptw+BRWWX0R0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SZK7JqIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E26C433C7;
	Tue,  2 Apr 2024 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712077824;
	bh=HF/7wros3imLgQh1dI6bjYbQnodA/QtlZyCB0sW0qgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZK7JqIY4+EnQ8cqKq3vtIyq4RVVkQj77PcnyPW4AJ0+1nbGD+dj2SIwpyVLycUsS
	 +JRFJLVwCpJcA+zybd/6s/BFuyfhZog57mZR6CSJYuBNxd3d/3KdcMh7b8DghjHRuD
	 oez+HfA0aq+TRD0f3LpXnnoNvVjd1YwXGPhIVTO8=
Date: Tue, 2 Apr 2024 10:10:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, xingwei lee
 <xrivendell7@gmail.com>, davem@davemloft.net, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 samsun1006219@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in
 crypto_sha3_update
Message-Id: <20240402101023.aea0f8ed981903077dcd9e6b@linux-foundation.org>
In-Reply-To: <ZgwfoSj7GqFiOOsc@linux.ibm.com>
References: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>
	<ZgvDe6fdJzgb8aZZ@gondor.apana.org.au>
	<ZgwfoSj7GqFiOOsc@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 18:09:21 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:

> On Tue, Apr 02, 2024 at 04:36:11PM +0800, Herbert Xu wrote:
> > On Wed, Mar 20, 2024 at 10:57:53AM +0800, xingwei lee wrote:
> > >
> > >   syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20000000ul, /*addrlen=*/0x58ul);
> > >   res = syscall(__NR_accept, /*fd=*/r[0], /*peer=*/0ul, /*peerlen=*/0ul);
> > >   if (res != -1)
> > >     r[1] = res;
> > >   res = syscall(__NR_memfd_secret, /*flags=*/0ul);
> > >   if (res != -1)
> > >     r[2] = res;
> > 
> > So this is the key to the issue.  The whole point of memfd_secret is
> > to make the pages inaccessible to the kernel.  The issue is those
> > pages are then gifted to the kernel through sendmsg.  Somewhere
> > along the line someone is supposed to throw up an error about this,
> > or map the pages properly.  I guess neither happened which is why
> > we end up with a page fault.
> 
> Yeah, there was a bug in folio_is_secretmem() that should have throw an
> error about this.
> 
> David Hildenbrand sent a fix, it's in Andrew's tree
> 
> https://lore.kernel.org/all/20240326143210.291116-1-david@redhat.com

I'll send "mm/secretmem: fix GUP-fast succeeding on secretmem folios"
upstream this week.


