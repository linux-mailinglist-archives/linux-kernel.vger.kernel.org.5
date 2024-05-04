Return-Path: <linux-kernel+bounces-168485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F28BB917
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC431F237EA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1217F8;
	Sat,  4 May 2024 01:22:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1D139B
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714785757; cv=none; b=dx0qhoZGZ755trQskUdXCLfg8qZNMB9nhtxyrQ0YDL1P/AS7tBWLILo+LW0S0921C+owu0Ovhej8yBQ7WIoRvZ3G/ctOy1k+PKF9SYkoZuUL8fgE1IYCT/QUB8fDffoW9qe5uk4TTdClBL71GgGyf7ITLyeobnV7nidR0aINkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714785757; c=relaxed/simple;
	bh=kuGh6aznpLxtXdlUqjSZ0mkqxHtQEkq19jVvpN66jIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Me2udNvflJU98rdNoKDnJzKcw0FqJ32QiFsOvnW5L+wAWKCYsKOPcuHju2QtgaVPrW0ys0O/ll8B0/2rj9VUckD7xgxjCIkxR0wg2YitwIf20kPmvpWXkiobF5W6F8GE8U5KITRGr/OXHAfk7ZXPFOfbTxRdoQfRr0/bHlLhqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E0BC116B1;
	Sat,  4 May 2024 01:22:35 +0000 (UTC)
Date: Fri, 3 May 2024 21:22:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [GIT PULL] tracing/tracefs: Fixes for v6.9
Message-ID: <20240503212234.71c1cad2@rorschach.local.home>
In-Reply-To: <CAHk-=wgMSaivGRNk55fd8F3yODqOYUtY=d+vnXmY2buUKewd8Q@mail.gmail.com>
References: <20240503190728.7510af9a@gandalf.local.home>
	<CAHk-=wgMSaivGRNk55fd8F3yODqOYUtY=d+vnXmY2buUKewd8Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 May 2024 17:01:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 3 May 2024 at 16:07, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Minor fix for user_events interface
> >   The ABI of creating a user event states that the fields
> >   are separated by semicolons, and spaces should be ignored.
> >   But the parsing expected at least one space to be there (which was in=
correct).
> >   Fix the reading of the string to handle fields separated by
> >   semicolons but no space between them. =20
>=20
> This is the opposite of a fix.
>=20
> A fix would have fixed the documentation to match reality.
>=20
> Instead, this relaxes our existing parsing. Are there any old kernels
> that had that relaxed parsing? Is there any actual reason to not just
> fix documentation to match reality?
>=20
> Because when reality and documentation do not match, it is not
> *REALITY* that is buggy.

=46rom what Beau and his team told me was that they had tests that were
failing, and when they looked into it, it was because the tests didn't
include a space after the semicolon.

=46rom what I understand (Beau can correct me) but the semicolon was
supposed to be the delimiter and not a "semicolon followed by one or more
spaces".

-- Steve


