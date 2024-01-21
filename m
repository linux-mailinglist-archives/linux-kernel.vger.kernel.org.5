Return-Path: <linux-kernel+bounces-31964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F570835470
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9E1F21B69
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BE2E40C;
	Sun, 21 Jan 2024 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SlIpCznQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B726AF5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705812378; cv=none; b=D8l2O0ZlkQUTRLfCGM3CwIcjuvyXH1aMNe2TgikyEWN3HnB8PRCd5D3JSMznsGlfCkKEDUBR0mUhw68mg7ACo9mR3v9YP7GK961fkLCg+Wd/QhKamn4CgE3HW2M/q3ag7GcMLBezh0uj3oUL3tbY739C0yQeE5u7ohwHDsv30jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705812378; c=relaxed/simple;
	bh=ik35T/x5yL4zn6sAO0sKXnsdeSg2LD9SzPHvJ/0RNT8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mOHDN/7ZAHuqrXOeiWUKqJV3Cn9Xiu7JJTo4Dcj2f9i7HaqXavMwIi0ZjO3LeysRMPb6EyuqS8h2FAhkl2x659bAwp+n1oanHFCgpjLcsJi/L34Q/JR3TuRAi4Q/aeuIdWQSvbiSLql/ST1v9Iag5EMRkXU5pAuXRrv1oh9FSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SlIpCznQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F55EC433C7;
	Sun, 21 Jan 2024 04:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705812378;
	bh=ik35T/x5yL4zn6sAO0sKXnsdeSg2LD9SzPHvJ/0RNT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlIpCznQNRWUWlmcXdGCIovSY8+l5SbuHVyLXRHORtd6cgidKRGjb8pNEFSGGmY0x
	 vtp9ZHkjW0EdOoFrMKmuQTYdFqbdYUiIQBnh/E7kaH5BGIMEE+2akIMSMwdL/sFvAh
	 rTRhPr+wZP2NFO+4GEqQSW7fCgpGuJ+AcmHHiiIo=
Date: Sat, 20 Jan 2024 20:45:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vincent Whitchurch
 <vincent.whitchurch@axis.com>, Dmitry Vyukov <dvyukov@google.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Mike Christie
 <michael.christie@oracle.com>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Stefan Roesch
 <shr@devkernel.io>, Joey Gouly <joey.gouly@arm.com>, Josh Triplett
 <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>, Ondrej Mosnacek
 <omosnace@redhat.com>, Florent Revest <revest@chromium.org>, Miguel Ojeda
 <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] getrusage: use sig->stats_lock
Message-Id: <20240120204552.c0708fd10fc8e2442c447049@linux-foundation.org>
In-Reply-To: <CADBMgpxC+BP-wfrM-wP1nbZOcRb0LbsmMDQ3LQ8hUKYsF3QECw@mail.gmail.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
	<20240119141501.GA23739@redhat.com>
	<20240119141529.GB23739@redhat.com>
	<CADBMgpxC+BP-wfrM-wP1nbZOcRb0LbsmMDQ3LQ8hUKYsF3QECw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 19:27:49 -0800 Dylan Hatch <dylanbhatch@google.com> wrote:

> 
> I applied these to a 5.10 kernel, and my repro (calling getrusage(RUSAGE_SELF)
> from 200K threads) is no longer triggering a hard lockup.

Thanks, but...

The changelogs don't actually describe any hard lockup.  [1/2] does
mention "the deadlock" but that's all the info we have.

So could we please have a suitable description of the bug which these are
addressing?  And a Reported-by:, a Closes: and a Fixes would be great too.



