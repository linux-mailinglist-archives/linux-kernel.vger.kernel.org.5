Return-Path: <linux-kernel+bounces-33716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6B836D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267A91F2887A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783777F1B;
	Mon, 22 Jan 2024 16:46:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462A3FB3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941977; cv=none; b=qv2hzwpEf5XKXlsSZMPbo/dcw45NFJpkq4NoF1JPqnFdTjuEdWEWDVp/kvPAgrsNa1aQGtuCgjPoGAQHn33Qq0AX3i88peDoujvHdgY4vEG7ju/PSMmcWEB+Xq71Dd+XNkBFyBzug703ZPpaQjRg3v9zfYP1WMV7SGKlrA0tDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941977; c=relaxed/simple;
	bh=Ky6TuzpBuK8teEOWfhPPInB3LvoxxinV7RLy7GUKkC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNhvCF97AVlSyBsR1Z8lnyWzax2JDVFf70j5jwtnwbCRhqxmgskbD1RWtLxyEcfQDYZfZZC0+kEVCCCZ3ds1hNOkwR0tpCGCZciVH25sbxqCdIqdRP29WIqlrcmvh+mBwUPMOWWdPT+xjcC7qbvKJHaBjczYaDa/Z6xqPrV6h9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA35C43390;
	Mon, 22 Jan 2024 16:46:15 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:47:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240122114743.7e46b7cb@gandalf.local.home>
In-Reply-To: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 17:23:29 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +/* Just try to make something consistent and unique */
> > +static int eventfs_dir_ino(struct event_inode *ei, const char *name)  
> 
> eventfs_inode

Heh, I fixed that, but must have created the patch before catching it. :-/

> 
> > +{
> > +       unsigned long sip = (unsigned long)ei;
> > +
> > +       sip += strhash(name) + EVENTFS_DIR_INODE_INO;
> > +       sip = siphash_1u32((int)sip, &inode_key);
> > +
> > +       /* keep it positive */
> > +       return sip & ((1U << 31) - 1);
> > +}
> > +
> >  /*
> >   * The eventfs_inode (ei) itself is protected by SRCU. It is released from
> >   * its parent's list and will have is_freed set (under eventfs_mutex).  
> 
> Thanks, find is happy now the directories have different inode numbers.
> The files still have identical inodes numbers, I hope that doesn't cause
> any issues...

Well, I guess I should ask Linus.

Linus,

I can add this patch to make sure directory inodes are unique, as it causes
a regression in find, but keep the file inodes the same. I can see how the
issue is with directories, as find (and probably other applications) check
for invalid directory loops. But with files, there should be no issue. It
could just think it's another hard link.

The question I have is, should this just make dir inodes unique and keep
files the same, as this patch does? Or make all inodes unique?

This is assuming that my algorithm is good enough to not leak kernel
addresses. I could also chop it down to 28 bits, as that's probably still
"good enough" to keep things unique.

	return sip & ((1U << 28) - 1);

That would make it even harder to unhash to get an address.

-- Steve

