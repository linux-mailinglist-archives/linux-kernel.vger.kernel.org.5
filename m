Return-Path: <linux-kernel+bounces-118490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E288BBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A840C2E2E56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7878132816;
	Tue, 26 Mar 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tg/RSc4V"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199F4CB2E;
	Tue, 26 Mar 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439625; cv=none; b=Yz6q7OjcmMjxz78vXELf62o+1wANWcUGOZE9ofUjycKgVuF0YCNorE/J9v9qcK/fIw5b5A35dMtGXSPAq7QGoqIpuYq+CUJ65ToSD3z774Rg5mPB5d5MFMGY56t1lxTvq2J0sIuCyH7BNZNIc1+MYon0kDMYuFjcGUFKccgj5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439625; c=relaxed/simple;
	bh=RSZylZlCpTdbm+Z9o6U3XqmKBS0KpMhd9GAVethT39M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bX7rkRoOUhREL19yf1krFhojPLqTtT6cLzcSiORsF4q7M6VaUlVNuu0+0xeS/PUmhgMjmCl91b4GEL6Bvj+ThekIqPithbgrOenw4urfaP2nIjF8/4zbM+5BTHNbt/lkT4bgrOtS9q2YCK1/j9zVDk1v+Ja7wuWKOKu3Pcja6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tg/RSc4V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ot6b39AXYDAVGwlyEemjJVuPK4U4r83NNhgKBebl2bA=;
	t=1711439623; x=1712649223; b=tg/RSc4VYDSnmfkVKJrEkvfEeqmJfQgxumJcpSsqMuwj11j
	WzojvYa8DYb+0WCXdkOThtdhjx8mRDaYQTlZrh6y2su34DsZc9g9G0vl2v9XogzQTuXfmIEB9Q7iZ
	eiavY8AEVRuPrXh0fzAFBnjWYfusBqHWiUvCpaKroGb5pd3GhXylZFVjg29kqX/Te+tH4DkoeOTnA
	sqDcK7zkbti4bAONOCEZOZyosvCypIL/0nDZ7hUkYp3E1g8xa5UboEASxJS6o5yc0ljwQE4KGstQL
	JfLKiXbm4qF647EBeO7ZhevNZXh4D6I+uxVyFhlLci3IAwYxdJYoKmc41B5yvmnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp1cq-0000000FYHx-0UH6;
	Tue, 26 Mar 2024 08:53:40 +0100
Message-ID: <0659e47eb33c4159168abe392764a1de44e9bc71.camel@sipsolutions.net>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, Josh Triplett
 <josh@joshtriplett.org>, Peter Zijlstra <peterz@infradead.org>
Date: Tue, 26 Mar 2024 08:53:39 +0100
In-Reply-To: <04081c65-f9bf-404c-8557-7af72f6a72de@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
	 <ZgGnuFJiTX5laS7c@boqun-archlinux>
	 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
	 <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
	 <48034addaeb6c33ca8b3e636262b6c043ddc5359.camel@sipsolutions.net>
	 <04081c65-f9bf-404c-8557-7af72f6a72de@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 10:39 +0300, Dan Carpenter wrote:
> On Mon, Mar 25, 2024 at 07:43:18PM +0100, Johannes Berg wrote:
> > On Mon, 2024-03-25 at 21:28 +0300, Dan Carpenter wrote:
> > > On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> > > > Also __acquire()/__release() are just empty macros without __CHECKE=
R__.
> > > > So not sure the indirection really is warranted for this special ca=
se.
> > > >=20
> > > > I can add a comment in there, I guess, something like
> > > >=20
> > > >  /* sparse doesn't actually "call" cleanup functions */
> > > >=20
> > > > perhaps. That reminds me I forgot to CC Dan ...
> > > >=20
> > >=20
> > > These are Sparse warnings, not Smatch warning... Smatch doesn't use a=
ny
> > > of the Sparse locking annotations.
> >=20
> > Sure, of course. I just saw that you added cleanup stuff to sparse to
> > allow using it in smatch.
> >=20
> > > Smatch handles cleanup basically correctly at this point.
> >=20
> > Do you "run" / "emit" the cleanup function calls there?
>=20
> Yes.

I see. I guess that doesn't work for sparse. You write:

   This shouldn't really have been needed if I had written the parse.c
   code correctly to create new scopes for every __cleanup__.

Would that maybe be a way to handle it in sparse? Though not sure how to
return then.

> > I briefly look
> > at doing that in sparse but it felt ... complicated, and then I saw the
> > condition in the cleanup function which I thought sparse could probably
> > not see through anyway.
>=20
> The if (_T->lock) statements are a problem.  For those, I have to
> manually add them to check_locking.c as an unlock function and to
> check_preempt.c as a decrement the preempt count function.

OK, no fun.

I think overall it's still easier to go with this patch :)

And maybe we should think about replacing what we need sparse for...

johannes

