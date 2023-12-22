Return-Path: <linux-kernel+bounces-9556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D804C81C77A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EF02877EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D618031;
	Fri, 22 Dec 2023 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qx1lMB+o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jt2xIxUh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B418035
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703238171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Hqka5/XeRCziVLv9/ClXGIkKphpoNKzRFwTvx7g4hc=;
	b=Qx1lMB+oCRUynMajzNhHP5UsjvZ3BtFH8XtzXQzMHpb2YSy06ROsCpB6BFbfxNifJiBK3y
	748srbaVn+QWiLTwnp5jy1OGNIMr0YKyVYbVDxZb+y75VNwNfFpiZrsHnqwvEOeG6VvlZn
	B5XUlQ/BmHBu8q5xn4cqvecyIST26zivMPA25bbbUz0PwT0/J5m6y8SxYQ0mVq04/qz1VY
	HTBrgW7tecxvKcDDR1h89N9MH8f86y65rrGVV6K5qDR0wAO+bHCg9+7//Xjfx4evKCWcTd
	z5DRarfC/g1i1fm1KrrDNd5Yi+oNzgb+1m9dxMuuEOyKXGBGSzY0G2AGRSFfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703238171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Hqka5/XeRCziVLv9/ClXGIkKphpoNKzRFwTvx7g4hc=;
	b=Jt2xIxUhmRcgCfnNHSqsRDXAK+0AMaFSJwHjbDc+jrnaCQc7Mwt3cy22kMRbGyafYno9px
	wX+rmh5Xv6JtYfDg==
To: Douglas Anderson <dianders@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Li Zhe <lizhe.67@bytedance.com>, Pingfan
 Liu <kernelfans@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog/hardlockup: Use
 printk_cpu_sync_get_irqsave() to serialize reporting
In-Reply-To: <20231220131534.3.I6ff691b3b40f0379bc860f80c6e729a0485b5247@changeid>
References: <20231220211640.2023645-1-dianders@chromium.org>
 <20231220131534.3.I6ff691b3b40f0379bc860f80c6e729a0485b5247@changeid>
Date: Fri, 22 Dec 2023 10:48:49 +0106
Message-ID: <87h6kak1ye.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2023-12-20, Douglas Anderson <dianders@chromium.org> wrote:
> The interleaving problem was less bad with the "buddy" hardlockup
> detector. With "buddy" we always end up calling
> `trigger_single_cpu_backtrace(cpu)` on some CPU other than the running
> one. trigger_single_cpu_backtrace() always at least serializes the
> individual stack crawls because it eventually uses
> printk_cpu_sync_get_irqsave(). Unfortunately the fact that
> trigger_single_cpu_backtrace() eventually calls
> printk_cpu_sync_get_irqsave() (on a different CPU) means that we have
> to drop the "lock" before calling it and we can't fully serialize all
> printouts associated with a given hardlockup.

I think that is good enough. Otherwise there would need to be some kind
of CPU handshaking to ensure things are synchronized correctly in case
multiple CPUs have triggered the situation.

> However, we still do get
> the advantage of serializing the output of print_modules() and
> print_irqtrace_events().
>
> Aside from serializing hardlockups from each other, this change also
> has the advantage of serializing hardlockups and softlockups from each
> other if they happen to happen at the same time since they are both
> using the same "lock".
>
> Even though nobody is expected to hang while holding the lock
> associated with printk_cpu_sync_get_irqsave(), out of an abundance of
> caution, we don't call printk_cpu_sync_get_irqsave() until after we
> print out about the hardlockup. This makes extra sure that, even if
> printk_cpu_sync_get_irqsave() somehow never runs we at least print
> that we saw the hardlockup.

I agree with calling printk() before trying to acquire ownership of the
cpu_sync.

> This is different than the choice made for
> softlockup because hardlockup is really our last resort.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

