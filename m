Return-Path: <linux-kernel+bounces-98259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3487778E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85731C20C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BB38394;
	Sun, 10 Mar 2024 16:19:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357616FF43;
	Sun, 10 Mar 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710087586; cv=none; b=fRip43gibgqZhbTyDfexkIWXk+DiTBrL7Ufat9SUs6won269Tzmb95657KldudZ1uFgjhEnHqBjAeCPysR0t05q20R/BDa7NiPh5j8n9hUHtHR5F0Mn9vSi7et0hK5UO8029vDZ8Zs+0R3UQBn/uAY/553BRj+sZKtXCZgfzwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710087586; c=relaxed/simple;
	bh=Aoj3fQ5Mo7+PDxevHRm5b91B4gzPe0g9i2jn5l53Yck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbppgark9Qmld1VMjt8mOQlcF3RYAMDmNgSCVOkQUV0eSt/S16rBq9rZtNnW3q3MQ8mLKv8rtqp7J8web/7ofvKPxeOCi9RxS3nfNlYW3xVD9jpAOZagrNmpOlqC0UWcjL4AFXTBMkHRQjawTlIpMfIaN0Ay2DTD48Gpe/N4Gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D3BC433F1;
	Sun, 10 Mar 2024 16:19:44 +0000 (UTC)
Date: Sun, 10 Mar 2024 12:19:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, joel@joelfernandes.org, linke li
 <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer
 waiters
Message-ID: <20240310121942.7c0a613b@rorschach.local.home>
In-Reply-To: <CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
References: <20240308183816.676883229@goodmis.org>
	<CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
	<20240308163528.3980c639@gandalf.local.home>
	<CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
	<CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 13:41:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 8 Mar 2024 at 13:39, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So the above "complexity" is *literally* just changing the
> >
> >                   (new = atomic_read_acquire(&my->seq)) != old
> >
> > condition to
> >
> >                   should_exit ||
> >                   (new = atomic_read_acquire(&my->seq)) != old  
> 
> .. and obviously you'll need to add the exit condition to the actual
> "deal with events" loop too.

I haven't had a chance to rework this part of the patches, but I have
some other fixes to push to you from earlier this week, and I think the
first three patches of this series are also fine. As the loop in
ring_buffer_wait() isn't needed, and patch 2 and 3 are trivial bugs.

I'll send you a pull request for that work and I'll work on this code
later.

-- Steve


