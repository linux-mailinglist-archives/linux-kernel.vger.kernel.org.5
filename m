Return-Path: <linux-kernel+bounces-29545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB13831002
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747C9B268A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73928694;
	Wed, 17 Jan 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nR5jN40d"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342332D634;
	Wed, 17 Jan 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532881; cv=none; b=GEoSWD3OfjVcYTqHsyc7rZ8b5op1wYN/gNaJBDFvWWZVllwkGKYlm2ilUv8yD5ecDXLorFqU/70hxYo07G1hcshfbvy6vqHznVx1O6znRuVetgkgY5KmIvmhlf7pcuUlPRq53zJCnObk9YoncUZL/VEWHwSa2H86riv+mmBhY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532881; c=relaxed/simple;
	bh=RsvBSwKvQ2SL0TwQ0y/xzPi6TaEGjntVaeT7IcC7znE=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=oFeB5fzeuB2viwGhr4GDZHhavs80+GtPxkrBBPZNPYyU+Ha9lI7wBcpItW7pDODVbFNpvT9gUAinMpT1ue38su9KtnsP5/HH644FSicWkfACRMU4p8d+lRpy5SdFbVToOUazEo8HhAIETSX+0X6AHwDJzOUcGUE2ta6++/8HSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nR5jN40d; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fL92iJU4SDKpF36FunOx2bUJ2B7KJrwX+j+sVRk1roE=;
	t=1705532879; x=1706742479; b=nR5jN40ddAm9tVdWN2jq3/J6jPRYiVZecMh9Gfqt+dHVKuk
	c5700PQUse2zvq/ccaJp3M7vfgpqGzNyZp3u+T0FfC9Sc80QLalK8x0U7vIYmwMxS0+KYkWQNeTEa
	xP9gkeiv6u0VlRb7BMvUQDbzTcud3pFcEfPt7NIMee5CrpjfXAYUZ2+9ureXEQdgzO0QAm5eTvvIz
	geW0OZBN8vquo1sQrjLQyXwv76j/VQBPAtdxfoxxu7/mQ/hd+Ow1Hq6oFgAvBVRWdcvuMto90JCfe
	ZMBnkoB8ldB9Br+5H0gt5WJRxybJ69Jf97cZzEGzpL4i+LeUulotVlAPkaIgwarg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQF0f-00000006tEi-3UpA;
	Thu, 18 Jan 2024 00:07:50 +0100
Message-ID: <7719f03304bd525e6b85a8700eb3466acf1cc76b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: tx: Add __must_hold() annotation
From: Johannes Berg <johannes@sipsolutions.net>
To: Brent Pappas <bpappas@pappasbrent.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 18 Jan 2024 00:07:47 +0100
In-Reply-To: <Zagxwx40ja4JRUQ2@pappasbrent.com>
References: <20240113011145.10888-2-bpappas@pappasbrent.com>
	 <87sf31hhfp.fsf@kernel.org>
	 <26d364547d3bbb04800877e899cfebe0e1ec4dc0.camel@sipsolutions.net>
	 <Zagxwx40ja4JRUQ2@pappasbrent.com>
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

Hi Brent,

On Wed, 2024-01-17 at 15:00 -0500, Brent Pappas wrote:
> Thanks for the feedback Johannes. As I mentioned in my original email, I'=
m still
> learning the RCU API, so I appreciate the insight from someone more
> knowledgeable.

Note this isn't really all that RCU related.

> > Much better to put something lockdep_assert_held() or similar into the =
right
> > places.
>=20
> I'm not committed to using __must_hold(); would you be willing to accept =
this
> patch if I change it to use lockdep_assert_held() instead?

I'm actually not sure what you're trying to check here. The
rcu_dereference() inside of it? But that'll already be checked at
runtime by lockdep without any further code.

So ... right now I don't see that there's any point in adding any
further annotations, but I'm also not sure what you're trying to
achieve.

> > The function ieee80211_set_beacon_cntdwn() is called from a number of p=
laces
> > in this file, some of which acquire RCU critical section, and some of w=
hich
> > acquire no locks nor RCU critical section at all.
>=20
> Grepping through tx.c, I see ieee80211_set_beacon_cntdwn() is invoked in =
three
> places:
>=20
> - Line 5285: Inside the definition of ieee80211_beacon_get_ap(), which is=
 only
>   invoked in critical sections (both directly and in another nested call)=
.
> - Line 5439: Directly inside a critical section.
> - Line 5471: Directly inside a critical section (same as previous).

Right.

> > I tried to fix this in sparse many years ago, some code even got merged=
 (and
> > then reverted), and if the experience tells me anything then that it's =
pretty
> > much not fixable.
>=20
> I'm sorry to hear that; a solution to this problem sounds very useful. I'=
m
> currently working on making my own static analyzer for performing more ch=
ecks
> than what sparse currently provides.=C2=A0

Are you aware of smatch?

> Since you've worked on this problem and
> have deeper insight into than I do, what sort of checks would you like to=
 see
> added to a tool like sparse (besides checking whether specific locks are =
held)?

I haven't really thought about that ... some better taint tracking would
be nice but that's _really_ hard ;-)

johannes

