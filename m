Return-Path: <linux-kernel+bounces-40334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0F983DEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE53528ABF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1D1DDFC;
	Fri, 26 Jan 2024 16:25:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047A1DDF2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286350; cv=none; b=jzOU4U0DQ3gVV4EJatwTgiLZXpkfYUvsLU2me1K4u7px49fkbwBH3KLv6c64ETYaurY7hGO++LmyOHEpIf4ScWHERKrFcLGWgUIganuHGDd5tNDZH2GnzbxGyLsY0l+Og/q7b+CT2x7Mf44hFEJkgyYreX7Q7T6JPvwCYL+92a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286350; c=relaxed/simple;
	bh=usYo1qWpfr98O2uM2CcTxhxgQ9wwoLK07IN3DcRfu0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBQ1lR9mtoSnwM113MEIC029f9/ZgLlguXBWKJu9E+Sp/xfgqlzbRL0SvusCmTPf06L4L4y8JH4vIQM7H7C4qScPEdW8KBrFj8Pvi+4N8biecpkKTj5GaKbh+/HRvZY6tmq6j+KY6PU2dVhX7KtB5hDPGBnPKtptSP3wm1Wfa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7748C433F1;
	Fri, 26 Jan 2024 16:25:48 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:25:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240126112551.6b8c0450@gandalf.local.home>
In-Reply-To: <20240126-wirksam-wenngleich-cd9573d8cb28@brauner>
References: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<20240122144443.0f9cf5b9@gandalf.local.home>
	<20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
	<20240125130731.3b0e2a42@gandalf.local.home>
	<20240125130821.0a1cd3a7@gandalf.local.home>
	<CAMuHMdU-+RmngWJwpHYPjVcaOe3NO37Cu8msLvqePdbyk8qmZA@mail.gmail.com>
	<20240126-wirksam-wenngleich-cd9573d8cb28@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 11:11:39 +0100
Christian Brauner <brauner@kernel.org> wrote:

> The size would be one thing. The other is that tar requires unique inode
> numbers for all files iirc (That's why we have this whole btrfs problem
> - let's not get into this here -  where inode numbers aren't unique and
> are duplicated per subvolume.).

Well, I guess that answers Linus's question about wondering if there's any
user space program that actually cares what the inodes are for files. The
answer is "yes" and the program is "tar".

And because tar cares, I think I should fix it for tracefs even if it
doesn't work because of size. But the size issue is a trivial fix if I just
default it to 1 page.

I currently use get_next_ino(), but I can use my own version of that, and
because each directory has a fixed number of files, I could have it be:

/* Copied from get_next_ino but adds allocation for multiple inodes */
#define LAST_INO_BATCH 1024
#define LAST_INO_MASK (~(LAST_INO_BATCH - 1))
static DEFINE_PER_CPU(unsigned int, last_ino);

unsigned int tracefs_get_next_ino(int files)
{
	unsigned int *p = &get_cpu_var(last_ino);
	unsigned int res = *p;

#ifdef CONFIG_SMP
	/* Check if adding files+1 overflows */
	if (unlikely(!res || (res & LAST_INO_MASK) != ((res + files + 1) & LAST_INO_MASK))) {
		static atomic_t shared_last_ino;
		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);

		res = next - LAST_INO_BATCH;
	}
#endif

	res++;
	/* get_next_ino should not provide a 0 inode number */
	if (unlikely(!res))
		res++;
	*p = res + files;
	put_cpu_var(last_ino);
	return res;
}


This way the eventfs inode would tell tracefs_get_next_ino() how many inode
numbers it needs for its files and then when it creates the file inode, it
can use:

	inode->i_ino = ei->ino + idx;

Where idx is the index into the d_children array of the directory's
eventfs_inode.

-- Steve

