Return-Path: <linux-kernel+bounces-27477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E182F0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3F51F22489
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68301BF30;
	Tue, 16 Jan 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVC3b0ok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43TBKCHg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5101BF22
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Jan 2024 15:46:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705416394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLGkeF3QQbjCQ+UVYNssoPlXROoQCdjE1WB9zExwudg=;
	b=iVC3b0ok3unOQso05GJlZuVtZblbvHX3UH38rC56qCQKQ0pGsTTzKQwe8SULqrn0HFv8bU
	XhvmpxrH0PG2dXcubnW+gOq+2dzMR4BnUVAE4LmXw0I54By0w8XUW8ktOLM3U2NbtdNsop
	CZVR5iZfFs9lzOZqKuN3ipu45RJzXH87XYkSzrWdjkuFLHqIgE1cWMxKCeGc/+vmL3oeAe
	XkpcUqyDqeA9d39ZRcCzFuFWugjQl+qje9a9t4lgr/3M5w/z7YWjHlUkDIbS73KMULiO70
	pz+Gp+iI5qz1kWJ/R5BkGpk6YPFpkh7awHtFUP5lOGFWIoYv8YWP9BlgLsiLBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705416394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLGkeF3QQbjCQ+UVYNssoPlXROoQCdjE1WB9zExwudg=;
	b=43TBKCHgLs8d6duRUpMSoXM9pWSP+peN7Mg6ht4Ik+uUipJU0wGm+3dNFUETJAW4qMoqrh
	0An4ROxlL5iQsfCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
	bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
	juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
	mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH] futex: Avoid reusing outdated pi_state.
Message-ID: <20240116144632.cDj3SolO@linutronix.de>
References: <20240116130810.ji1YCxpg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240116130810.ji1YCxpg@linutronix.de>

On 2024-01-16 14:08:12 [+0100], To Jiri Slaby wrote:
> --- a/kernel/futex/requeue.c
> +++ b/kernel/futex/requeue.c
> @@ -873,7 +873,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned=
 int flags,
>  		if (res)
>  			ret =3D (res < 0) ? res : 0;
> =20
> -		futex_unqueue_pi(&q);
> +		futex_unqueue_pi(&q, true);

This obviously needs the same change as futex_lock_pi() unless it is
okay to avoid the argument and remove it if it hasn't been removed. I
forgot that the requeue path has also signals & timeouts and so is
subject to the same problem.

Assuming we go that direction=E2=80=A6

>  		spin_unlock(q.lock_ptr);
> =20
>  		if (ret =3D=3D -EINTR) {

Sebastian

