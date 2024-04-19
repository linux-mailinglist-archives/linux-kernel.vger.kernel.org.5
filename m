Return-Path: <linux-kernel+bounces-151326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900518AACF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23951C21132
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C947EEEC;
	Fri, 19 Apr 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9rNHwre"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89C7E771
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523075; cv=none; b=M3eDbAbn1FQzvNsSKxMSE7W6ZdX8mTy1EFVOPf9kqw3BvAg6V5m6wh9Cb+9iC1cjdcA5q/n1ut2spETuY8K+5XqC1kFrqhKQLvLSzeDILxo7601zDVlpRbQ8nLh2v7awybX5mr6rMMYZFaG/nlIJ8QNNlMFWmk/OC39Ce6BCI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523075; c=relaxed/simple;
	bh=q6S5k2AYRf3VHkAogHkDqnUN5dbXK84Dvl8FFElNO6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAMZ+rPRva8zb39wu2oAJ8b+gz9do4s12f0N8idZMh+5V4C1Li6jzHHIxPfBNCWjjtyaDiAwo3U1Dnejhf/V8jlukJC0jxGIt570rhpquyKCwrb2TYWb96B4FXGPVZYHmMQOo7+Kq2CRRt3LHpRp1YIzA2pu7lwI3eqsar9nF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9rNHwre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713523073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2JSSVZQsCxpolLVY1oFfy3+Jt4qlV9RE+KjhK5Nlq4=;
	b=N9rNHwrekAVGktQzugVtoOj8EMiukDHu7diYDOM/FCGiDPzoz8HVaIB1dwfPvsXzr0/K06
	cUUoPk6l5AP78yWJ40lHJlVRv0JnJ9c0yioZbQDZlnJYSlMB3g0E3NCwOXCYvDE9ph+LTq
	FOfDs5LUIHy+AfKSFipukGQgjQnfzvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-0jMjH9ZgOF6bdiUQRMDSQg-1; Fri, 19 Apr 2024 06:37:49 -0400
X-MC-Unique: 0jMjH9ZgOF6bdiUQRMDSQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A991B802E4D;
	Fri, 19 Apr 2024 10:37:48 +0000 (UTC)
Received: from localhost (unknown [10.22.32.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59959581CF;
	Fri, 19 Apr 2024 10:37:47 +0000 (UTC)
Date: Fri, 19 Apr 2024 07:37:46 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Pavel Machek <pavel@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.214-rt106
Message-ID: <ZiJJeiAjLAk3YMZz@uudg.org>
References: <ZiF_h-W4jgLiRag5@uudg.org>
 <ZiI4Hq5yfrOUdbHk@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqjY3vdOpGcvkOgo"
Content-Disposition: inline
In-Reply-To: <ZiI4Hq5yfrOUdbHk@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


--SqjY3vdOpGcvkOgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:23:42AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > I'm pleased to announce the 5.10.214-rt106 stable release.
> >=20
> > This release is simply an update to the new stable 5.10.214 version and=
 no
> > RT-specific changes have been performed.
> >=20
> > You can get this release via the git tree at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >=20
> >   branch: v5.10-rt
> >   Head SHA1: 3d208061796d4addeb543c78e0a4ec769b6ce6b2
>=20
> Thank you.
>=20
> Could you also push v5.10.214-rt106-rebase tag to the repository for
> consistency?

Hi Pavel!

The tag is there in the repository:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?h=3Dv5.10.214-rt106-rebase

When I released 5.10.215-rt107 (and its -rebase counterpart), 5.10.214-rt10=
6-rebase
was no longer pointing to a commit inside that  branch, probably why your g=
it
update didn't get the tag. You could try a

    git fetch --tags <rt-stable-remote-name>

Best regards,
Luis

> Best regards,
> 								Pavel
> --=20
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


---end quoted text---

--SqjY3vdOpGcvkOgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmYiSXoACgkQ85SkI/jm
fCbe/BAAkpQGjzY4WxJrumVywMmMlpq7ZImnMhcB2PHG/GMxz8N3U9heXTkcUp5k
Uj8eN/uYNK5Pp6S6Mr0ewsqoZbxpQ3n5MZn4pu979Lfe6HYJXfg07jFu6KiKgo9H
1if3rirze63Ryae0bNrCoc5F3z8fiOl2tL4p7i0Tfd8uHL1Fwva6qrkWuU4Np0IY
5XCW3O3bAGTpMgvpWXRtQb2WwxB+WGOQVaeofyZ7391xy10aonji7hN50U3CIJI3
RjiIo+D1massyqGoF1+j36oA/VJfQDlSkBzX0hNlxiQB0DphIyRJT8fnRISS7h9H
jdMcBeCNjsKsfxmbA1Bdcw0lcqDKH5g3ufaO/TzsNvoRLQ+64Kzlk/UBD8VMarb2
i6kLp8livYJ2JdQu2wEzJoZj0kNSRYmiFmQv4S8R5ljiEyo1IexiXOWbZEZq7Rrn
tD3unR1120OpJD/aMWj+W33gzcnWNiiLbTir1TQOBQN9jqrOeY+MkrvQ+f6f5Kk3
98tKHR9CJKtEibQYrNKQP+Hn2FCZtp2LxV+1bP6r45BNrtVey+/MaaNgd9DnAl7m
JbYFLw5C0A1Eumd7E6gSHADlRhPzGUgVDXmjEWIarvZtaeKxOzGyawNO5dbOge5A
hXh2oNgTwJGA32lf5cxTJfI72wpctdNu5ilLHZ6pg1hwuenX+q8=
=Zy6t
-----END PGP SIGNATURE-----

--SqjY3vdOpGcvkOgo--


