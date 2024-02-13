Return-Path: <linux-kernel+bounces-64494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A280E853F26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58A61C22B70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EB62A00;
	Tue, 13 Feb 2024 22:50:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45A626C6;
	Tue, 13 Feb 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864609; cv=none; b=tinTAckYjvql084klJIvdW66gOxYdl7W7wZedp5zHGESKq1urRr22qTaV7h6ZaaZU/TpOYJ5bZhO2MA01D/ldgmFK5nDcBNZ5icbBdj+K90zyVnU3/I4OcicqiMi+QMbNRqH14G8STYHJ9P/TMy/fdx5Ur6IaKX7DnZJiXIvSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864609; c=relaxed/simple;
	bh=MN7Hm+6Ysr7MPqO2FhWpicFrKyMuv7+TpmQv2eMGLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQnIeERa/hQKrTk/nuimP2tXlcoEvu0TwvTfdamqHOejklQL7JQ234zKNRqomnwl/gbpbNXqAbyJgUxqRUy7fCgl1dNhLFWJCjVPi8L+xZC6jJXBRJo3Hx2Gd0B/FMCghoyrmDtTAz5RzSXr1DMRuIPG4FgvPM2hf2S4b5hTjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549CBC433C7;
	Tue, 13 Feb 2024 22:50:08 +0000 (UTC)
Date: Tue, 13 Feb 2024 17:51:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v17 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240213175138.1bc30513@gandalf.local.home>
In-Reply-To: <20240213155309.01c7c2b2@gandalf.local.home>
References: <20240213114945.3528801-1-vdonnefort@google.com>
	<20240213114945.3528801-3-vdonnefort@google.com>
	<20240213155309.01c7c2b2@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 15:53:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 Feb 2024 11:49:41 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
>=20
> Did you test with lockdep?
>=20
> > +static int __rb_inc_dec_mapped(struct trace_buffer *buffer,
> > +			       struct ring_buffer_per_cpu *cpu_buffer,
> > +			       bool inc)
> > +{
> > +	unsigned long flags;
> > +
> > +	lockdep_assert_held(cpu_buffer->mapping_lock); =20
>=20
> /work/git/linux-trace.git/kernel/trace/ring_buffer.c: In function =E2=80=
=98__rb_inc_dec_mapped=E2=80=99:
> /work/git/linux-trace.git/include/linux/lockdep.h:234:61: error: invalid =
type argument of =E2=80=98->=E2=80=99 (have =E2=80=98struct mutex=E2=80=99)
>   234 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep=
_map)
>       |                                                             ^~
> /work/git/linux-trace.git/include/asm-generic/bug.h:123:32: note: in defi=
nition of macro =E2=80=98WARN_ON=E2=80=99
>   123 |         int __ret_warn_on =3D !!(condition);                     =
         \
>       |                                ^~~~~~~~~
> /work/git/linux-trace.git/include/linux/lockdep.h:267:9: note: in expansi=
on of macro =E2=80=98lockdep_assert=E2=80=99
>   267 |         lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HEL=
D)
>       |         ^~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/lockdep.h:267:24: note: in expans=
ion of macro =E2=80=98lockdep_is_held=E2=80=99
>   267 |         lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HEL=
D)
>       |                        ^~~~~~~~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/ring_buffer.c:6167:9: note: in exp=
ansion of macro =E2=80=98lockdep_assert_held=E2=80=99
>  6167 |         lockdep_assert_held(cpu_buffer->mapping_lock);
>       |         ^~~~~~~~~~~~~~~~~~~
>=20
> I believe that is supposed to be:
>=20
> 	lockdep_assert_held(&cpu_buffer->mapping_lock);

If this is the only issue with this series, I may just fix up the patch
myself.

