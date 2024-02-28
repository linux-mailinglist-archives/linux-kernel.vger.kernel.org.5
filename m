Return-Path: <linux-kernel+bounces-85538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51A86B73A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BF81C25A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5471EA8;
	Wed, 28 Feb 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qlty9SIZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01FD40870;
	Wed, 28 Feb 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145170; cv=none; b=Yw7wWKtmOG2xz6SenbfZMI1aicyB2HYkXgext+uzLIizgRNApGfYTKoDkN4FqeQwBe73eZCW7/F/O1ZZx0SzVTnyK/wBp5m+p+36380ui9RxBIRHUKZNMAsAB6vXT1pMz1dN7D0EomKgSVhQezu+8WWSaj9y0whn6J2G/aKnKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145170; c=relaxed/simple;
	bh=CxtHM2+ifmqjyDHFXrz3Up2ARI/1W7ba/SFCOaOgjQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn6lnnr6OCYlLr2uuM3IAGK1F7KELOC37WuBmICxdFul2Tguz4vQogX++TULS2ySGq1k1Oa84Khc5aY6dl3cp6sf7+HHbEfYGJSLaKYvbXN9qp0fc7Bx+gekXtjvKJI0aufoh1PIIB+JZdOb+ZGvvFpLoA/rwkKj3GPuS2yqgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qlty9SIZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C7D340E019B;
	Wed, 28 Feb 2024 18:32:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2J3gT-n2s5B8; Wed, 28 Feb 2024 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709145155; bh=6pILoD7GK3GHs+nxCL00x2OzFQfjgERMsC8V26O4mzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qlty9SIZBohDm/u1rnFR4iIlAoDg9IdGAdodWVGP7xQs3tySAuQo2F8qdbZ0XUxk3
	 CtCkBT2IRyrU8MSIVZXc8v2wZBOp+odwyuafumabGhq2OrnOUpabi7E6t6xxKkslqm
	 1toTUE04pckz1ZTPqNF28sZwtlvsGNuYseFlIa2wqlHf/P8W8eR6KJ3RkdZYz+zslV
	 xP8XfOmkfbiusstHPkS84yPRAeAH3d2INmoA2LM/7v+pY0ca0CoWBLFUA2jdyb/HmW
	 1lOmFVT9r+Ug8pnYZ516491LQIKxanyVXJSp7QI2M9gvO14jUe2OUa8pcwzCVG23IN
	 iM+rrDAf/X5NVLEgp0LnMtTWpyXwYq/4sWQvcoOYG5lmTlNhPML9M3vsHlP2DgkOgQ
	 g9Y3QQj9aVvytSwqPwKrXe2kjPv8MybPM0P5e9fgqeBGr1Y1QR7PHEV5QTib3T2Kq1
	 Tj4eTw5XKtAAAM3SqbyOriuSrzCytk4JezEjvXkRICIQOqHbTcSXXxngruu2CpQf+e
	 1S5UlKUhId6C9OfEyYnoy7D2KUCvQBt2yOOM6eM15BaBO7FWRrFOOZ4+aJ7UYMzRj1
	 Q+32gwgApd39xyG3tn3rntB/qp/2f+DYWX8jKwHH/p/ICZNPIBBN9IZ8A4Eb25JLXe
	 WrW2S7rsW3xSu04m0/BlYU4Y=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB88E40E0185;
	Wed, 28 Feb 2024 18:32:27 +0000 (UTC)
Date: Wed, 28 Feb 2024 19:32:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracepoints: Use WARN() and not WARN_ON() for warnings
Message-ID: <20240228183220.GDZd98NEDTrzZBGdgi@fat_crate.local>
References: <20240228133112.0d64fb1b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228133112.0d64fb1b@gandalf.local.home>

On Wed, Feb 28, 2024 at 01:31:12PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There are two WARN_ON*() warnings in tracepoint.h that deal with RCU
> usage. But when they trigger, especially from using a TRACE_EVENT()
> macro, the information is not very helpful and is confusing:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 0 at include/trace/events/lock.h:24 lock_acquire+0x2b2/0x2d0
> 
> Where the above warning takes you to:
> 
>  TRACE_EVENT(lock_acquire,  <<<--- line 24 in lock.h
> 
> 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
> 		int trylock, int read, int check,
> 		struct lockdep_map *next_lock, unsigned long ip),
> 	[..]
> 
> Change the WARN_ON_ONCE() to WARN_ONCE() and add a string that allows
> someone to search for exactly where the bug happened.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/tracepoint.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

meaning: tested that it really fires:

[    1.196008] Running RCU Tasks wait API self tests
[    1.200227] ------------[ cut here ]------------
[    1.203899] RCU not watching for tracepoint
[    1.203899] WARNING: CPU: 0 PID: 0 at include/trace/events/lock.h:24 lock_acquire+0x2d3/0x300
..

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

