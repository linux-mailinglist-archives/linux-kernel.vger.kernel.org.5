Return-Path: <linux-kernel+bounces-71803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EB85AAB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC29B24B91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDA481B2;
	Mon, 19 Feb 2024 18:16:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B74779C;
	Mon, 19 Feb 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366572; cv=none; b=Ro/d708vKqE1EPG21ZiEbUCgpBUWRlsq1E1ks4HuvwbwGD/6/lEOnsrwYcE8dIpOAQR9+HplYSsYdSPR8ZdTPO+Ol1l8qcDnsmHaxiwT7p0nof2XodMgi3QTsGrisWYfi5waROh6IY6HptTUjai+lkik9HkVP8ixFVoJs5NkSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366572; c=relaxed/simple;
	bh=EpljsEzrG9dama9fboFOPoy9uxObmu3qwV9wBqAh3M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V51AhBjjoEzddL4JTwmUk3LmIxZR4f0+cnqwCSC6tRxgIm63EOVHUzC5s1Cf3e5OMGjHfwFPmN5CaiqTf8Pod6OZrMNZROSX/Pg88LgxRx79e71ACZEphQn1u/bs7aD9R2Wvxm3QB5ydzSl9+CWKcB8rxB3NUSj514eFUTMj08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8301C43390;
	Mon, 19 Feb 2024 18:16:10 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:17:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v17 3/6] tracing: Add snapshot refcount
Message-ID: <20240219131754.5d26f4e6@gandalf.local.home>
In-Reply-To: <20240213114945.3528801-4-vdonnefort@google.com>
References: <20240213114945.3528801-1-vdonnefort@google.com>
	<20240213114945.3528801-4-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 11:49:42 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> @@ -9678,7 +9739,9 @@ trace_array_create_systems(const char *name, const char *systems)
>  	raw_spin_lock_init(&tr->start_lock);
>  
>  	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> -
> +#ifdef CONFIG_TRCER_MAX_TRACE

Oops!

I'll fix this too.

-- Steve

> +	spinlock_init(&tr->snapshot_trigger_lock);
> +#endif
>  	tr->current_trace = &nop_trace;
>  
>  	INIT_LIST_HEAD(&tr->systems);

