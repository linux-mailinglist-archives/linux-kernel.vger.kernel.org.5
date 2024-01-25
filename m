Return-Path: <linux-kernel+bounces-39046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D664D83CA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DD5B22407
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647313174E;
	Thu, 25 Jan 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeMsgi/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7863407
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204437; cv=none; b=SYE98bEpyZAx+6VAWs5sIUbSyojBfOkBOafOWRpCuRCalNeMKg9+4vtKB4SpFAGOR+59GPOFiovQI9RMFXZhx78nvHaqBYLFGwuK/HDL3AJOe0oruz3TpMY2qHmZqBYXhkZd9khIQXHAnI2Kf7XMMjG3JS48XowXRkCCMtZH5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204437; c=relaxed/simple;
	bh=MNsS8xhfLazNPkpX0xDXLMjg/ydZvJAqYMw5ftV2uSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8sDqih58w7Z1wLXay6XAKRl4HfExVT9Cl972JCsL/wrikAubqMKexbaijtLlgrvXsN3NMkdq37i9BkDCxSdB2MYYWDjwDDaXa1RRDdhz7V38HEZ6Mi2sXhegTzF0my9i4T3SeE7eU7lMp3pzuupb6L2xEx07OrKJLyZqnRSY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeMsgi/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A11FC433F1;
	Thu, 25 Jan 2024 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204437;
	bh=MNsS8xhfLazNPkpX0xDXLMjg/ydZvJAqYMw5ftV2uSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeMsgi/fsn+w9Ztk5dm9VbbHMnLx9G3J+Ld5oYHV0F67UqoiS1wKZAATmkd6ayspb
	 lJyJs0G6+0VNjAWJjmXx5J2nkSLdTnVJmQqAfbu3RYINzqmp0QielOsF46KuJx5DiT
	 fBEKvPXmX10NkOHUNvNNTpCcpsw1eTqvIXzfx/79Rczz2DszK38CI9U3v5e8kw0xMp
	 1/ciGqxZKKNLXfdReP4mCeWNtplEniMDBI1wQXaIBBjsUhkQ/FjvYP5OkrLHF7Or7i
	 BsiD9k2CBDneKbFEzgXLj7xq4OGzg02soYRVLWI9grIEbZ6rbixGun/BEnZbxSiqXv
	 0WAgS5tL4Bzlg==
Date: Thu, 25 Jan 2024 18:40:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240125-deportation-sogenannten-2d57a7ce8f81@brauner>
References: <20240117143548.595884070@goodmis.org>
 <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home>
 <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home>
 <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
 <20240122144443.0f9cf5b9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122144443.0f9cf5b9@gandalf.local.home>

On Mon, Jan 22, 2024 at 02:44:43PM -0500, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 10:19:12 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Actually, why not juist add an inode number to your data structures,
> > > at least for directories? And just do a static increment on it as they
> > > get registered?
> > >
> > > That avoids the whole issue with possibly leaking kernel address data.  
> > 
> > The 'nlink = 1' thing doesn't seem to make 'find' any happier for this
> > case, sadly.
> > 
> > But the inode number in the 'struct eventfs_inode' looks trivial. And
> > doesn't even grow that structure on 64-bit architectures at least,
> > because the struct is already 64-bit aligned, and had only one 32-bit
> > entry at the end.
> > 
> > On 32-bit architectures the structure size grows, but I'm not sure the
> > allocation size grows. Our kmalloc() is quantized at odd numbers.
> > 
> > IOW, this trivial patch seems to be much safer than worrying about
> > some pointer exposure.
> 
> I originally wanted to avoid the addition of the 4 bytes, but your comment
> about it not making a difference on 64bit due to alignment makes sense.

Non-unique inode numbers aren't exactly great for userspace and there
are a surprisingly small yet large enough number of tools that trip over
this in various ways. So if that can be avoided then great.

But luckily no one is probably going to tar up tracefs. ;)

