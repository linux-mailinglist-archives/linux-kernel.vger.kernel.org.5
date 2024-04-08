Return-Path: <linux-kernel+bounces-135907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489D89CCF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4691C2129C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F54146A94;
	Mon,  8 Apr 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lNCBDe4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956D140E2B;
	Mon,  8 Apr 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608197; cv=none; b=eshPq4E31cE0gkLJe9mg+fvB2aJFch/M8OGAZ30b8N+z/QpL2l0u62XRbdTfGA8eoRLBp0wp5JQ7DKJGrsYhuPP0PRszQT66RH3S77COGDetgn+gkvR5azfIOVDYyoMTRo16+Guog2q4QjUtzH3m36yD0KzwHwzizjdDPduKOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608197; c=relaxed/simple;
	bh=bOOcY1a8hc61A1P59kdD85Nt8/pNDslGOFAv6yD/KGs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m/zUbhGzj9jiKUQ5KPp3YcIjMsbkzSUh+/bb0yKP6hcqn4k19zegJ/yfN3vIJSZB5v/phyH1yQTWIAosz5jVlN3zYfys0rnWVy4HbNw6Cfb9CUUPQR51+GjHdqRYITIXMxrlDszk9Vd695+mI54Ao11La2OQNAqzs/txj8r8XWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lNCBDe4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB7C433F1;
	Mon,  8 Apr 2024 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712608196;
	bh=bOOcY1a8hc61A1P59kdD85Nt8/pNDslGOFAv6yD/KGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lNCBDe4EMHQ8aPMQRps4rLqu6wveaKyvcbKvi7qSpuxklpcDi7bkF9eSzb603nAfC
	 sBuSPnCWUVq0ulEMLkktbxQ3dp3iWXlmy7avZnNAif4LVCc0VC/Un0iH08rJ+Ik6uI
	 ydzF063ys+yJYWG+9hMzWNAgo8hHcKjnzKaNfAuc=
Date: Mon, 8 Apr 2024 13:29:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, Tycho
 Andersen <tandersen@netflix.com>, Jens Axboe <axboe@kernel.dk>, Aleksa
 Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-Id: <20240408132955.70d10145d2ea1b0b12b7a5d0@linux-foundation.org>
In-Reply-To: <20240408145819.8787-3-mkoutny@suse.com>
References: <20240408145819.8787-1-mkoutny@suse.com>
	<20240408145819.8787-3-mkoutny@suse.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon,  8 Apr 2024 16:58:18 +0200 Michal Koutn=FD <mkoutny@suse.com> wrote:

> The kernel provides mechanisms, while it should not imply policies --
> default pid_max seems to be an example of the policy that does not fit
> all. At the same time pid_max must have some value assigned, so use the
> end of the allowed range -- pid_max_max.
>=20
> This change thus increases initial pid_max from 32k to 4M (x86_64
> defconfig).

That seems like a large change.

It isn't clear why we'd want to merge this patchset.  Does it improve
anyone's life and if so, how?


