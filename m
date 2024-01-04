Return-Path: <linux-kernel+bounces-16298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83028823C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE01F25DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30831DDE7;
	Thu,  4 Jan 2024 06:57:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC41F94D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 61C6930000D09;
	Thu,  4 Jan 2024 07:57:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4131E24ADCF; Thu,  4 Jan 2024 07:57:44 +0100 (CET)
Date: Thu, 4 Jan 2024 07:57:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm/slab: Add __free() support for kvfree
Message-ID: <20240104065744.GA6055@wunner.de>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901230.1782217.9803098171993981037.stgit@dwillia2-xfh.jf.intel.com>
 <2023081449-blurry-bath-248e@gregkh>
 <20230814161731.GN776869@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814161731.GN776869@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 14, 2023 at 06:17:31PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 14, 2023 at 05:31:27PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 14, 2023 at 12:43:32AM -0700, Dan Williams wrote:
> > > Allow for the declaration of variables that trigger kvfree() when they
> > > go out of scope.
> > > 
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  include/linux/slab.h |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 848c7c82ad5a..241025367943 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -746,6 +746,8 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
> > >  extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
> > >  		      __realloc_size(3);
> > >  extern void kvfree(const void *addr);
> > > +DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
> > 
> > No need to check _T before calling this, right (as was also pointed out
> > earlier).
> 
> Well, that does mean you get an unconditional call to kvfree() in the
> success case. Linus argued against this.
> 
> This way the compiler sees:
> 
> 	buf = NULL;
> 	if (buf)
> 		kvfree(buf);
> 
> and goes: 'let me clean that up for you'. And all is well.

Have you actually verified that assumption in the generated Assembler code?

The kernel is compiled with -fno-delete-null-pointer-checks since commit
a3ca86aea507 ("Add '-fno-delete-null-pointer-checks' to gcc CFLAGS").

So NULL pointer checks are *not* optimized away even if the compiler
knows that a pointer is NULL.

Background story:
https://lwn.net/Articles/342330/

Thanks,

Lukas

