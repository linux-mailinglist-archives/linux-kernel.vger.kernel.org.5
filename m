Return-Path: <linux-kernel+bounces-127364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C997894A58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AA283AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805617991;
	Tue,  2 Apr 2024 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj2/etcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02149175A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031443; cv=none; b=GIr+PX9VyIln8cY5kFPTobosuvDrce8Wm25I9tGd3oVrm9hO4memawl9dgoHI7Vdd2pNOXCDLICMAHNzkFIUW2NBk/jAI6p3UNHzyH8Obga18cHHt1bQpUlcql1BCuEiib8RxZoQO18XC1dLWO1MXe98zS8z8ggbGtI0OMRYUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031443; c=relaxed/simple;
	bh=zikIRY2LADiHW5H6P0zhROk8X9vd5W4L+25Lpd005h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhnmlx+gcYADclILB979u9bZ+5rmBjwE7g+5K1BBz/ghsPOTjpHhrScHbGsKXn6BOkwlBIKHXgfhmJU8d6NmMi9IY9HEdOZAooTdfRCMtURs0puNHYDewfqrt+ntCQTd8Sj3EPnSDSDtlkxoZFQJU16odqephmutqdVkTDI37i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj2/etcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E4C433F1;
	Tue,  2 Apr 2024 04:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031442;
	bh=zikIRY2LADiHW5H6P0zhROk8X9vd5W4L+25Lpd005h4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jj2/etcDaDV9TohgThB0sd3IZddvUH176n8Kq6Vl+8kPi7DChO0SkDAG3xffXuvBW
	 5yIX6QFHc5VRgxo8YvTU2Krtu+pS0Uk5EwGZhD1e5kkEjSCXLakfS9suA1beXQtu+G
	 xF5vsLgBRb+4nQjj6H8O9xyEb2aLRIOWqeS7yB3LbMVPMND4wEfrA/AnDdGk/LavO7
	 iwN+B7N/6cX6XMV2ypeILfHU7ZtaIXNrBqB6fqpWhBq2XcZRcTj45ThHs2qgeABzBX
	 JC4fUxqLyq3KlutUiMOpvyQXLVHQ/wej9/U1BnRpFSATNnnWNjcwed181uwQ1/xbno
	 tqfm7sn4SYGeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 28E91CE074C; Mon,  1 Apr 2024 21:17:22 -0700 (PDT)
Date: Mon, 1 Apr 2024 21:17:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <1d1bc9d7-ff7d-4554-9c07-90d4e210a91d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
 <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
 <20240402000758.GC538574@ZenIV>
 <20240402033753.GE538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402033753.GE538574@ZenIV>

On Tue, Apr 02, 2024 at 04:37:53AM +0100, Al Viro wrote:
> On Tue, Apr 02, 2024 at 01:07:58AM +0100, Al Viro wrote:
> 
> > It does, IIRC.
> > 
> > > Would you like to do that patch?  If so, I would be happy to drop mine
> > > in favor of yours.  If not, could I please have your Signed-off-by so
> > > I can do the Co-developed-by dance?
> > 
> > Will do once I dig my way from under the pile of mail (sick for a week
> > and subscribed to l-k, among other lists)...
> 
> FWIW, parisc is in the same situation - atomics-by-cached-spinlocks.
> 've a candidate branch, will post if it survives build...

I am sure that it seemed like a good idea at the time.  ;-)

> Re parisc: why does it bother with arch_cmpxchg_local()?  Default is
> 	* save and disable local interrupts
> 	* read the current value, compare to old
> 	* if equal, store new there
> 	* restore local interrupts
> For 32bit case parisc goes for __cmpxchg_u32(), which is
> 	* if (SMP) choose the spinlock (indexed by hash of address)
> 	* save and disable local interrupes
> 	* if (SMP) arch_spin_lock(spinlock)
> 	* read the current value, compare to old
> 	* if equal, store new there
> 	* if (SMP) arch_spin_unlock(spinlock)
> 	* restore local interrupts
> In UP case it's identical to generic; on SMP it's strictly more work.
> Unless I'm very confused about cmpxchg_local() semantics, the
> callers do not expect atomicity wrt other CPUs, so why do we bother?

;-) ;-) ;-)

In any case, happy to replace my patches with yours whenever you have
them ready.

							Thanx, Paul

