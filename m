Return-Path: <linux-kernel+bounces-26011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7D82D9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2404B1F22647
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062F179A1;
	Mon, 15 Jan 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qd5dpkiS"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E81798C;
	Mon, 15 Jan 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z3BzOmqIUzMO6UAJIUQ8GAcKK4W9P4/Fhk70+J3UgU0=;
	t=1705324423; x=1706534023; b=qd5dpkiSzAphXJFZXmns78MO5/1IaI6mRTWuzzw/sjPLt/t
	G2HGM0iw9v3bfHHZ3DUVNVVLCKuEbOK/JpUUA05fGBw3LyKMhOXiLolTg/tiDhBYIEqhVW6tpeI4Y
	CDE3l/toHQFh7KEIQO5+/vFjzRrON0QrmT8K3P5qZ8pgduMzvCVMq81e4OT7Kx6G+2UFVfPLBnAUz
	waF/1zLQhtY8ZpdyHNS9ts8pd7JCQywXVfl6ABsLJau5PUBFjfwH2CTE7WReuVBJgZzpa2d5iDVgw
	V1S9BRaDlGjOFEnDe/YxQXj5nT0XtDjqjlEvqQR1OIY+RBwos6wCGsrBUhUqAJPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPMmT-00000003V7V-1PaZ;
	Mon, 15 Jan 2024 14:13:33 +0100
Message-ID: <26d364547d3bbb04800877e899cfebe0e1ec4dc0.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: tx: Add __must_hold() annotation
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, Brent Pappas <bpappas@pappasbrent.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2024 14:13:31 +0100
In-Reply-To: <87sf31hhfp.fsf@kernel.org>
References: <20240113011145.10888-2-bpappas@pappasbrent.com>
	 <87sf31hhfp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-01-13 at 08:32 +0200, Kalle Valo wrote:
>=20
> >  static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *=
sdata,
> >  					struct beacon_data *beacon,
> >  					struct ieee80211_link_data *link)
> > +	__must_hold(link)
>=20
> Oh, never seen __must_hold() before and looks very useful. So does this
> work with RCU, mutexes and spinlocks?
>=20
> In case others are interested, here's the documentation I was able to fin=
d:
>=20
> https://docs.kernel.org/dev-tools/sparse.html#using-sparse-for-lock-check=
ing
>=20

Except it's not actually useful, and looks more useful than it is. IMHO
it's actually more harmful than anything else.

One might even consider this patch a good example! The function
ieee80211_set_beacon_cntdwn() is called from a number of places in this
file, some of which acquire RCU critical section, and some of which
acquire no locks nor RCU critical section at all. Most of them nest and
are called in RCU.

However, there's basically no way to get sparse to warn on this. Even
inserting a function

void test(void);
void test(void)
{
        ieee80211_set_beacon_cntdwn(NULL, NULL, NULL);
}

will not cause sparse to complain, where this *clearly* doesn't hold an
locks.


Also, as we (should) all know, the argument to __acquires(),
__releases() and __must_check() is pretty much ignored. I tried to fix
this in sparse many years ago, some code even got merged (and then
reverted), and if the experience tells me anything then that it's pretty
much not fixable.

__acquires() and __releases() at least are useful for tracking that you
don't have a mismatch, e.g. a function that __acquires() but then takes
a lock in most paths but forgot one, for example. With __must_hold(),
this really isn't the case.

And then we could argue that at least it has a documentation effect, but
.. what does it even mean to "hold 'link'"? There isn't even a lock,
mutex or otherwise, in the link. You can't "own" a reference to it, or
anything like that. The closest thing in current kernels would be to
maybe see if you have the wiphy mutex, but that's likely not the case in
these paths and RCU was used to get to the link struct ...


IOW, I find this lacking from an implementation/validation point of
view, and lacking if not outright confusing from a documentation point
of view. Much better to put something lockdep_assert_held() or similar
into the right places.

As for your comment about RCU in ath11k (which points back to this
thread): I don't find

	RCU_LOCKDEP_WARN(!rcu_read_lock_held());
or
	WARN_ON_ONCE(!rcu_read_lock_held());

very persuasive, it's much better to have it checked with
rcu_dereference_protected(), rcu_dereference_check(), the condition
argument to list_for_each_rcu(), or (in the case of wiphy) our wrappers
around these like wiphy_dereference(). I cannot think of any case where
you'd want to ensure that some code is in an RCU critical section
without it actually using RCU - and if it does you have
rcu_dereference() and all those things that (a) check anyway, and also
(b) serve as their own documentation.


Anyway, long story short: I don't see value in this patch and won't be
applying it unless somebody here can convince me otherwise, ideally
addressing the concerns stated above.

johannes

