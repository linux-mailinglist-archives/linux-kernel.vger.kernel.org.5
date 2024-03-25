Return-Path: <linux-kernel+bounces-117488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC988ABE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8830747E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935A5490B;
	Mon, 25 Mar 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ElYf+oVU"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A1823C3;
	Mon, 25 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384888; cv=none; b=ZaKDQtjhAzAgFvCdxXQZ9HjIz3O1IlbaTRzgwfmNtxXve9vWBPFuqcfEWFWcOgD9knTIlPgFtHpwWGLX418i2NEoWAiKU3aj1W7kTIiV5LAvTwDIt/s56DYVHv3xwHyQfskG8EIBvIjMdzNRG5e0r/mHa0x+h/IgrhK88C8/It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384888; c=relaxed/simple;
	bh=J8TFNBjKT8XKA6rSxr767vBkNBvvVSapyx8mZob0aJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=judu6PLFaxLSiGKm2oKGedigszWq97cZk60x9xCT4tWw+wH4n3DshIughMrrwNqA7ks7I252uiWo+LyjN/5J+UWFT29wLB43LcF8VrkF6EBGqrTl7lTes2P4mEaN/ILVVYYNlsIdyPstYkkmPvXNb+2OG9wRGu+ya0JVlcxRrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ElYf+oVU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9Bw7ZOyhcGm63lwlF9HqOuIvk1orl2j1qZi0NNeEQAc=;
	t=1711384887; x=1712594487; b=ElYf+oVUlNHfQN3rtK11O/rg0DajyUvjh+VsnmPLhRVvWXf
	p3ONE3o4x4JfM7fuG+zXh6g5FZL+/uvtHyEOE4qMdd3z67LMQiffVtnNOG36mhKF6wfzbao29/W7e
	QA85s0BhqfTklxzalVEhLW2dpLv7S1anO8YV02wsZg+S3Yl03JIMaufEZJ7aBNSd5ZI8YRIx6O5QO
	XlfclBImzf5DOxefY/i8o4tVP71WiJItK59agHWG6LsaRU4VDv+XzXGnMjnnUO2TEKH/ucaLrBOLk
	EO1ltC9qf3n6CdVHlcKDFJ5OtKLXdLBjffVMSSsrmx3OkINuH7ej8mfwzO/IfHRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ronNz-0000000DxMk-3SHd;
	Mon, 25 Mar 2024 17:41:24 +0100
Message-ID: <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 25 Mar 2024 17:41:22 +0100
In-Reply-To: <ZgGnuFJiTX5laS7c@boqun-archlinux>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
	 <ZgGnuFJiTX5laS7c@boqun-archlinux>
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

On Mon, 2024-03-25 at 09:35 -0700, Boqun Feng wrote:=20
> > -DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
> > +DEFINE_LOCK_GUARD_0(rcu, do { rcu_read_lock(); __release(RCU); } while=
(0), rcu_read_unlock())
> > =20
>=20
> Hmm.. not a big fan of this. __release(RCU) following a rcu_read_lock()
> is really confusing. Maybe we can introduce a _rcu_read_lock():
>=20
> 	void _rcu_read_lock(bool guard) {
> 		__rcu_read_lock();
> 		// Skip sparse annotation in "guard(rcu)()" to work
> 		// around sparse's lack of support of cleanup.
> 		if (!guard)
> 			__acquire(RCU);
> 		rcu_lock_acquire(...);
> 		...
> 	}
>=20
> and normal rcu_read_lock() is just a _rcu_read_lock(false), RCU guard is
> a _rcu_read_lock(true)?

Not sure I see any value in that, that's pretty much equivalent but
seems IMHO less specific, where here we know we really want this only in
this case. I don't see any other case where we'd want to ever "call"
_rcu_read_lock(true).

Also __acquire()/__release() are just empty macros without __CHECKER__.
So not sure the indirection really is warranted for this special case.

I can add a comment in there, I guess, something like

 /* sparse doesn't actually "call" cleanup functions */

perhaps. That reminds me I forgot to CC Dan ...

> But before that how does it looks if we don't fix this entirely? ;-)

Well basically every time you write

void myfunc(void)
{
  guard(rcu)();
  ...
}

sparse will complain about mismatched locks, which is _really_ annoying
for e.g. networking where there's (a) a kind of "no new warnings" rule,
and (b) sparse is actually important for all the endian annotations etc.

Which right now means that we can't use all this new machinery, which is
a shame.

johannes

