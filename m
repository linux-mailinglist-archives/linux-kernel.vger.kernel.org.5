Return-Path: <linux-kernel+bounces-64232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6382853C70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A8C1C222F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA53612FC;
	Tue, 13 Feb 2024 20:51:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570D3D988;
	Tue, 13 Feb 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857501; cv=none; b=K3wZmcQrJEsvj+o+Yil6oQ0SG/HARI6apr4y/Gl5Ow7dcMDa/W6krt5Zw49Ji98e2hxpUq3ph8Zb/KhxGDcDwo1QCw1f7jKbwIda84Qf/Z8KU8ehdhQXKk4OmLKd7Je1cjaqeX95FN0wGbmemDWegovRWK8lo5Sxpi7EG18EBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857501; c=relaxed/simple;
	bh=M9O07Jm/SQoYeOcQw7VLNbboHFFM9jagKb4A0aHLZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buvb4++cIan8m2SyGbdt+bFxPBSKDjlSKvAmJgE083gZy4QE6FTuXjhVAXR6wDkJ1HrgOkmDAJiNyB117ggRXXZZJwbl538F1Dn+CPmh3GQbov4KfS47uC0GOQsL9/6Su01vIkC24fXXO64r7ou+35+7MlREeg1D9tSeqyyOox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ADFC433F1;
	Tue, 13 Feb 2024 20:51:39 +0000 (UTC)
Date: Tue, 13 Feb 2024 15:53:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v17 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240213155309.01c7c2b2@gandalf.local.home>
In-Reply-To: <20240213114945.3528801-3-vdonnefort@google.com>
References: <20240213114945.3528801-1-vdonnefort@google.com>
	<20240213114945.3528801-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 11:49:41 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

Did you test with lockdep?

> +static int __rb_inc_dec_mapped(struct trace_buffer *buffer,
> +			       struct ring_buffer_per_cpu *cpu_buffer,
> +			       bool inc)
> +{
> +	unsigned long flags;
> +
> +	lockdep_assert_held(cpu_buffer->mapping_lock);

/work/git/linux-trace.git/kernel/trace/ring_buffer.c: In function =E2=80=98=
__rb_inc_dec_mapped=E2=80=99:
/work/git/linux-trace.git/include/linux/lockdep.h:234:61: error: invalid ty=
pe argument of =E2=80=98->=E2=80=99 (have =E2=80=98struct mutex=E2=80=99)
  234 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_m=
ap)
      |                                                             ^~
/work/git/linux-trace.git/include/asm-generic/bug.h:123:32: note: in defini=
tion of macro =E2=80=98WARN_ON=E2=80=99
  123 |         int __ret_warn_on =3D !!(condition);                       =
       \
      |                                ^~~~~~~~~
/work/git/linux-trace.git/include/linux/lockdep.h:267:9: note: in expansion=
 of macro =E2=80=98lockdep_assert=E2=80=99
  267 |         lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HELD)
      |         ^~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/lockdep.h:267:24: note: in expansio=
n of macro =E2=80=98lockdep_is_held=E2=80=99
  267 |         lockdep_assert(lockdep_is_held(l) !=3D LOCK_STATE_NOT_HELD)
      |                        ^~~~~~~~~~~~~~~
/work/git/linux-trace.git/kernel/trace/ring_buffer.c:6167:9: note: in expan=
sion of macro =E2=80=98lockdep_assert_held=E2=80=99
 6167 |         lockdep_assert_held(cpu_buffer->mapping_lock);
      |         ^~~~~~~~~~~~~~~~~~~

I believe that is supposed to be:

	lockdep_assert_held(&cpu_buffer->mapping_lock);

-- Steve

> +
> +	if (inc && cpu_buffer->mapped =3D=3D UINT_MAX)
> +		return -EBUSY;
> +
> +	if (WARN_ON(!inc && cpu_buffer->mapped =3D=3D 0))
> +		return -EINVAL;
> +
> +	mutex_lock(&buffer->mutex);
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	if (inc)
> +		cpu_buffer->mapped++;
> +	else
> +		cpu_buffer->mapped--;
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	mutex_unlock(&buffer->mutex);
> +
> +	return 0;
> +}

