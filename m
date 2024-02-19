Return-Path: <linux-kernel+bounces-71805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09785AAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E161C20FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C872E481DB;
	Mon, 19 Feb 2024 18:21:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC2446A1;
	Mon, 19 Feb 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366872; cv=none; b=C1aIdnI5P2e5QnlkKyVAgdqtFHykN1kmz4AjqwL6XyPGkusZrfj8DZrH4zzW0SJcN7DGOUbh7JpNdHjS2G2Vl1QvIMxsCXZstVZO91JbMURwUcmr8+YqfXYfXqMwDIp2YpfGsg4u/pVR7gsN5J8IGrP4rvZj3RoUV1nvfiIlFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366872; c=relaxed/simple;
	bh=FBbXL1bn1jLAvsJAzBCrpdaDZITQl0cdtip8OZUnO4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nC3a6nsKnHNDr2OV1Scfamxti8lgEF7Xje3l20XUqufu43g5piCOlEcoWtZOCJjmJ2KrbhykSJah/aif9aZiViUOVc0Rp+saOx454Er9hJrog1gyIOb4gmC05ELXMXEP266OKvo1LmVRSII9FrJq8B6iZBJRHtITwSJDw977IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B9C433C7;
	Mon, 19 Feb 2024 18:21:11 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:22:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v17 3/6] tracing: Add snapshot refcount
Message-ID: <20240219132254.484fde37@gandalf.local.home>
In-Reply-To: <20240219131754.5d26f4e6@gandalf.local.home>
References: <20240213114945.3528801-1-vdonnefort@google.com>
	<20240213114945.3528801-4-vdonnefort@google.com>
	<20240219131754.5d26f4e6@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 13:17:54 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 Feb 2024 11:49:42 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
>=20
> > @@ -9678,7 +9739,9 @@ trace_array_create_systems(const char *name, cons=
t char *systems)
> >  	raw_spin_lock_init(&tr->start_lock);
> > =20
> >  	tr->max_lock =3D (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> > -
> > +#ifdef CONFIG_TRCER_MAX_TRACE =20
>=20
> Oops!
>=20
> I'll fix this too.
>=20
>=20
> > +	spinlock_init(&tr->snapshot_trigger_lock);

And this too:

kernel/trace/trace.c:9245:9: error: implicit declaration of function =E2=80=
=98spinlock_init=E2=80=99; did you mean =E2=80=98spin_lock_init=E2=80=99? [=
-Werror=3Dimplicit-function-declaration]
 9245 |         spinlock_init(&tr->snapshot_trigger_lock);
      |         ^~~~~~~~~~~~~

-- Steve

> > +#endif
> >  	tr->current_trace =3D &nop_trace;
> > =20
> >  	INIT_LIST_HEAD(&tr->systems); =20


