Return-Path: <linux-kernel+bounces-128400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2590895A59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301CE28171A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064415A48F;
	Tue,  2 Apr 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGQNPioM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CC15990A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077575; cv=none; b=PtOY8DoLy685iBvzN8jfbD/CTYznRKfHhGcLXVi/0M2chFWIiLxTEkho3a37QYJYAmMl9gH1oNij3eAqYqA1dG5JPOo2ZKupxGWpzc1ouKMVDgZrmhUd4Ny1ZYXFphEHQ5iFfDpFc1hAnj9qHM5WH6+ULw8PTiM//ok6GOJBXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077575; c=relaxed/simple;
	bh=zFVBrG14Q/wJvXNT4v5XkuPZUX6MI4x7Nq2iclshyPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt3XzmZ5QXufZo+IiEi0g23Zo5V9pVCxNnd/6vLx5K1cHKcxaEFS9RVfqLyA+D9S7RsgiJA2NIHt+3xEtJ4+0jd/qlIEZRow77xpTZVhh6y+vHzXysKgHpD6ZMzzV/jd6wdlEnbtTW7btLqXY0asM0/55A+jy4dWN/LytC3t3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGQNPioM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF84C433F1;
	Tue,  2 Apr 2024 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712077575;
	bh=zFVBrG14Q/wJvXNT4v5XkuPZUX6MI4x7Nq2iclshyPw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WGQNPioMRAvaQD6P4YA1VnBM++mI2Bs82fWBDiidC5A7FPrNjh+hAjseKra3dTwzE
	 xtw2ih4KQ88FG7/2TH3uhlxhepBxT4bDqUImlkKNpReXE3faEKXXJbpNK9QbueFjb6
	 araZa9DYTqDsmudYQOynHFvnUORnA6XA61yXJt2AgB1KquHVYAo1dRvKNi8wiQhlFO
	 IvZlFIfUWSAK35otXOafw02K86eNXS/4vt3XvPOpAiqjV3ck68AQEThH3dxCK+rpI9
	 WZ6NmbsV/eXmtorx/XBvG/IuWg37ElrdiY3Lb4mLOBjZfrORh/HmP8cyAq1VvlnXx5
	 uJthdqdW/COqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED0E6CE0FF2; Tue,  2 Apr 2024 10:06:14 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:06:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Vineet Gupta <vgupta@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 3/8] ARC: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <32936b57-f451-460b-a2df-e74293e44f5c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-3-paulmck@kernel.org>
 <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>

On Tue, Apr 02, 2024 at 10:14:08AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 1, 2024, at 23:39, Paul E. McKenney wrote:
> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > and two-byte cmpxchg() on arc.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I'm missing the context here, is it now mandatory to have 16-bit
> cmpxchg() everywhere? I think we've historically tried hard to
> keep this out of common code since it's expensive on architectures
> that don't have native 16-bit load/store instructions (alpha, armv3)
> and or sub-word atomics (armv5, riscv, mips).

I need 8-bit, and just added 16-bit because it was easy to do so.
I would be OK dropping the 16-bit portions of this series, assuming
that no-one needs it.  And assuming that it is easier to drop it than
to explain why it is not available.  ;-)

> Does the code that uses this rely on working concurrently with
> non-atomic stores to part of the 32-bit word? If we want to
> allow that, we need to merge my alpha ev4/45/5 removal series
> first.

For 8-but cmpxchg(), yes.  There are potentially concurrent
smp_load_acquire() and smp_store_release() operations to this same byte.

Or is your question specific to the 16-bit primitives?  (Full disclosure:
I have no objection to removing Alpha ev4/45/5, having several times
suggested removing Alpha entirely.  And having the scars to prove it.)

> For the cmpxchg() interface, I would prefer to handle the
> 8-bit and 16-bit versions the same way as cmpxchg64() and
> provide separate cmpxchg8()/cmpxchg16()/cmpxchg32() functions
> by architectures that operate on fixed-size integer values
> but not compounds or pointers, and a generic cmpxchg() wrapper
> in common code that can handle the abtraction for pointers,
> long and (if absolutely necessary) compounds by multiplexing
> between cmpxchg32() and cmpxchg64() where needed.

So as to support _acquire(), _relaxed(), and _release()?

If so, I don't have any use cases for other than full ordering.

> I did a prototype a few years ago and found that there is
> probably under a dozen users of the sub-word atomics in
> the tree, so this mostly requires changes to architecture
> code and less to drivers and core code.

Given this approach, the predominance of changes to architecture code
seems quite likely to me.

But do we really wish to invest that much work into architectures that
might not be all that long for the world?  (Quickly donning my old
asbestos suit, the one with the tungsten pinstripes...)

							Thanx, Paul

