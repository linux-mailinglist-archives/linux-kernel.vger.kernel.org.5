Return-Path: <linux-kernel+bounces-46925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24084466C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F59BB27A22
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772B133997;
	Wed, 31 Jan 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihs7wZ8T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90812130E2A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723057; cv=none; b=McJKnhg5mWXOLJ1rafPbh0WcyFtuiYPMk5KoKqaR4ckuzBpVltpXV+FXQOo4zHpl3bm6Ro6zlPQ4965wTlchxlHLForfwTUYPiuxEGmge9vdQEjdI/+FrDg4UUl22x370B7p6eqTL2m4Q7LxCVox40ehJV8YQkgAIF5TnY/+Fcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723057; c=relaxed/simple;
	bh=iHNGCe7fgTP2mBEo4B+ASlltFbA+RsqIEiR4+KPxYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeYhQZXVo/gSFpYNBF91sDffQhpYe2SPsl4YG0L5SOijozkppeJdVLpL64JA7aSZ0ZJxans5393NRJIjgUsPrY8hT8LnXMhb8FohJVn+U+mGsuCFNrDi8TyvJbqtmFkbHqqCn7WRPPxL2nLtprMkzgUVn6ez1Ji+gW5gU6zJozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihs7wZ8T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706723054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5781lePBe66jW2WvriRyvO/9mZi/+pJ8MQFthSgYBM=;
	b=ihs7wZ8T62AFJksTDAvYmOFNCPCwuq/7JFZ6qPjWI6i03OzeDHQBdokYQcY3MwQSfWcWpd
	uhLf0igXAcT1GFyRMoccvQUe9hCeerDdjy+YMn8XNnB2ArO+ymzE7E0aDpN0a8V8uO+v1G
	Bo7mY6dhe7JcXjbJzwokCSLT3Y4NLew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-I8rSRwEWN2KNXykaDoKx0g-1; Wed, 31 Jan 2024 12:44:10 -0500
X-MC-Unique: I8rSRwEWN2KNXykaDoKx0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F07CF185A783;
	Wed, 31 Jan 2024 17:44:09 +0000 (UTC)
Received: from localhost (unknown [10.22.32.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32A26C259E7;
	Wed, 31 Jan 2024 17:44:09 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:44:03 -0300
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
Subject: Re: [ANNOUNCE] 5.10.204-rt100
Message-ID: <ZbqG45ZeWgd01CGb@uudg.org>
References: <ZYX0Y_lbe8hNUNnj@uudg.org>
 <ZblPl7XCGo648oeU@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rJHHQZj6yDWjMtof"
Content-Disposition: inline
In-Reply-To: <ZblPl7XCGo648oeU@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--rJHHQZj6yDWjMtof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:35:51PM +0100, Pavel Machek wrote:
> Hi!
>=20
> We (as in cip project), are trying to do -cip-rt releases
> once a month. Are there any plans for 5.10-rt release any time soon?
> That would help us ;-).

Hi Pavel!

I already pushed v5.10-rt-next (containing v5.10.209-rt101-rc1) to
kernel.org and kernelci should pick that up for comprehensive testing
within the next hour. As soon as the testing is done I will perform the
release dance.

My vacations started (abruptly) a few days before I planned and that lead
to some delays. People volunteered to run the builds if anything critical
popped up, but that was not the case.

Sorry for the inconvenience, I do hope a release tomorrow or Friday does
not disrupt your workflow too much.

Luis

> Best regards,
> 								Pavel
> --=20
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


---end quoted text---

--rJHHQZj6yDWjMtof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmW6huMACgkQ85SkI/jm
fCZwHQ/+ICFUdngQSSQwCAgYRVz21CDgqM1MX8Q/ARYk/4cxGOLPNij3Xvl7GfrX
BBhhD0R58dXDPukwYSfroI8VbXJmSNcXnAQdv5lQEXN80bH3VImquGBUPoB/GTge
igYFm0Iiz6HD9p83vudgISscEEwDULCAikaTI6mR8oYxA+MkjrDBoXFyXKUTW5jO
um4K8mW7Ge+U35LKaK8yUiby6k8I/nVJp3Zrtkq1YV5phFH1Cuixe1Iy6xjpQyG0
yrfw4/IG1wXRGh2VzG/z7rdln5+AlcVHg1F0lU2zo2g0jAe/rxoLBWJa52+HygqD
hP+6O+t7pDrNHnIn/wE8L6jMkUXOHi84lUTvxsjJ/pgm7uRgx5qs9xwcgR80OzfX
FssMHw07YhM8eT7Z1ArKl33DnYZS5SnCUEfs3FNsxH/9daN7eDX/z99SLG4UB1WU
f5+6MCKOr6dQybxH2ZTS6wfWaRn3u5TBV7NpEmumOKYhytH/4WSq457LEzSg0fUB
TTE5ndtJLTxI5oxAI2Ibb5Tef+y1+oOlzsm2FEl+S3mtjmJ26mtoF+ai3IBMzj0h
YLOd3D9WcuYtDLpmY9G2uC9xpz7SykaiKjNztQmZWksNVtrwsymh+VSQEf2Zuq8s
G6BmNuhM+nbbdZcnZUl5tit5C9PM8N1nVvpmptf8gwqgLp5f1Dc=
=NHGD
-----END PGP SIGNATURE-----

--rJHHQZj6yDWjMtof--


