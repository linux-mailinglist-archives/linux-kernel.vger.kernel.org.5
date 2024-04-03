Return-Path: <linux-kernel+bounces-130675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E17897B86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2241288560
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C215697C;
	Wed,  3 Apr 2024 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kSChGikx"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE968156966
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182862; cv=none; b=PkXzkoHLSoXyzBhCcSAjbJRc7mrKLPZxTAl11r52nshjqeIXHsfqf+O5nHuBFMgY+drowWWWTqMrkOr1+NV/tTdUP+ilAiXe4F439HTdAhmFdBTkmU80aozmxeHv5iygTDiR3xUBqrJLEj+4mENjrLAgMA9lW076D4wAn6ecTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182862; c=relaxed/simple;
	bh=Z5FBHN101mZpUyh29wRD9MBxgloAJzxok9M9TawjyKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvFvjhzLkz2S9n3E/UU+mZBaaEqwy86ojRtVoW3fESZB2OD1WKKrtvpc8VLxaTBAxUqSR6pJRo5dMZXV7sSeUep2nAcqD1TDhJuHbL1mvXdDv7O9Udn5Bekr18ujvq3k/wJhGfxRfbYo3/Tf8PeqZS/ER0gocEta0SVmyGF9tuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kSChGikx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uRZPrdzzc8LLfV7AgfZFvQAae8d6ee9G2qb7w/6eEAo=; b=kSChGikxfiSQhRkSmgUxM2Ugkt
	ljYwQ3yvkax7xjcvdKtMyyd6K+kT833EwpfDvzyx/Z+nVxghYtRZ9lCHWOLh1KKRkRQHNK1vOMe9Z
	cHqHTZlnXym1xh0loGAYcAhFtwIDABNMLZxQLIMSq9qOu7udlOoeGneWzAFA98Cg/LlEzgJ2pPDEr
	zNeyZJy5kfcZsBsi5pllg5AFayEeHqQ1yYtHUUkh5TrVu6FmY7FAVHmVAapO6yhbbagXPXcCNHh/V
	ly6dAWYgLztPVciJSTIsRenMcYGW/SBXyeekHnnTIwLM5PuuXtWxBzJpMWQVOA/G9inFRDcHZ71ts
	VebarYSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rs8yT-005AvB-39;
	Wed, 03 Apr 2024 22:20:54 +0000
Date: Wed, 3 Apr 2024 23:20:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/8] sparc32: make __cmpxchg_u32() return u32
Message-ID: <20240403222053.GK538574@ZenIV>
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
 <85837f16-903c-44cd-8277-377e0228eb61@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85837f16-903c-44cd-8277-377e0228eb61@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 02, 2024 at 01:03:13PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 02, 2024 at 12:28:28AM -0400, Al Viro wrote:
> > Conversion between u32 and unsigned long is tautological there,
> > and the only use of return value is to return it from
> > __cmpxchg() (which return unsigned long).
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I have pulled these in as replacements for my patches in the meantime.
> 
> Thank you!

FWIW, updated branch force-pushed; the difference is that __cmpxchg()
on sparc32 went
-       switch (size) {
-       case 1:
-               return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
-       case 2:
-               return __cmpxchg_u16((u16 *)ptr, (u16)old, (u16)new_);
-       case 4:
-               return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
-       default:
-               __cmpxchg_called_with_bad_pointer();
-               break;
-       }
-       return old;
+       return
+               size == 1 ? __cmpxchg_u8(ptr, old, new_) :
+               size == 2 ? __cmpxchg_u16(ptr, old, new_) :
+               size == 4 ? __cmpxchg_u32(ptr, old, new_) :
+                       (__cmpxchg_called_with_bad_pointer(), old);

(and similar for parisc).  Rationale: sparse does generate constant
truncation warnings in unreachable statements, but not in never-evaluated
subexpressions.  Alternative would be what parisc used to do in mainline:
	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
and we'd need the same in 16bit case (both on parisc and sparc32).
Explicit (and rather mysterious) & 0xff for passing unsigned long to
a function that takes u8 was there to tell sparse that e.g.
cmpxchg(&int_var, 0, 0x12345678) was *not* trying to feed
0x12345678 to a __cmpxchg_u8(), which would quietly truncate it had
it ever been reached.  Use of conditional expression avoids that
without having to play with explicit (and utterly pointless from
C point of view) masking.  IMO it's better that way, not to mention
being more concise than use of switch.

