Return-Path: <linux-kernel+bounces-98296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03FC877804
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AEF28138F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468639AFD;
	Sun, 10 Mar 2024 18:36:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006C39AD5
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095803; cv=none; b=pusTRepabVzE2xWHoXn5DDmenF+d4gq1ABA04/t9SgBbtHBGzNBmevqOrrALXKSydFUzFcjrFqcbyv4V01gmn0Rp3J9wcHmbL/y72pub+miBKC7JH7J7CO6ByFIxKTeRpxtbSv9I1/MCHZds1Brjwde+djEhYGQu0jPP5zbPfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095803; c=relaxed/simple;
	bh=BExo0rP+W8uEQed6H6W4rt613GfDykdsivkK43c3Yiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdQA3gkQc38pIAwRJ3jBP97LlPXh6ymErypjfJvxeojOA93XMO8mBTcU8HAKjkUX4B++DsSCvEYqD1g/tmV/PT/Zx77CJOa5ZpzvZJ9pXPbtYVed/9CjkVNNqNNtE0vpoM+NGiE1EIHym29gEiPRMMQFSHYOSM08vifw3R8fReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C853C433F1;
	Sun, 10 Mar 2024 18:36:42 +0000 (UTC)
Date: Sun, 10 Mar 2024 14:36:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 0/3] tracing: Fixes for v6.8
Message-ID: <20240310143640.3feb907b@rorschach.local.home>
In-Reply-To: <550b6c44aa434b5b91e999a8d073527c@AcuMS.aculab.com>
References: <20240306184244.754263547@goodmis.org>
	<550b6c44aa434b5b91e999a8d073527c@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 18:16:06 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> ...
> >   Another issue that was brought up is that the trace_seq buffer is
> >   also based on PAGE_SIZE even though it is not tied to the architecture
> >   limit like the ring buffer sub-buffer is. Having it be 64K * 2 is
> >   simply just too big and wasting memory on systems with 64K page sizes.
> >   It is now hardcoded to 8K which is what all other architectures with
> >   4K PAGE_SIZE has.  
> 
> Does Linux use a 2k PAGE_SIZE on any architectures?
> IIRC m68k hardware has a 2k page, but Linux might always pair them.
> A 2k page might (or might not) cause grief.
> 

The trace_seq is just a buffer to build up the event output string. The
ring buffer sub-buffer is set to page size. For trace_marker, it is
still limited to the size of the ring buffer sub-buffer. If the
sub-buffer is only 2K, the trace_marker write will be broken up by less
than 2K.

The problem that is being fixed here had nothing to do with the limited
size of the resources. The issue was actually the opposite. On PowerPC,
the PAGE_SIZE being 64K allowed the strings to be that big too. And
what broke was that it was passed to a vsprintf(s, "%.*s", len, str);
where the len was greater than 32K and that caused a warning as the
precision of "%.*s" has a max of signed short.

2K PAGE_SIZE will still just "work".

-- Steve

