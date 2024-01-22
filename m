Return-Path: <linux-kernel+bounces-34060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110A8372E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AC8B28CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145133F8D4;
	Mon, 22 Jan 2024 19:36:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382F3E49E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952173; cv=none; b=al7xlBXu0vd5yQymMywvI2TS77OJl5n+n/k5zm/Zzj2ASQDWdLSXxq43feya5ACNJMFgWLeQ+Uq0EmFYDEmGB3CHdnprz63uG2q/Y/87eiR0g3oXiBNWdc2gEJpM6xSd7XifJ5rqRboHWHPmHNRomsW1Lf+gJDLi5VtxOJyutLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952173; c=relaxed/simple;
	bh=hd4hERnKUHLp2M7ISNYou1fZosK6qgnVMXcDV3L4S5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXoI6vHmASwRsdfFjtn9ymViCCv/oavtavncR/4CvX/qclyxc4thUS2SBXy6xaDK2D/vFeLEgku52MhxhaAq5/R5PyZ23/vezzbSKdWKfPoqfGCSyJw4oxKhTjyU+aWtZqdyiYo0Ii5O1ajjPWJTDOhAycvG1+0ZJcctE1lVnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DFBC433F1;
	Mon, 22 Jan 2024 19:36:11 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:37:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240122143740.6a889e36@gandalf.local.home>
In-Reply-To: <bb90c70d-85fa-4228-a333-ab91eea945b2@efficios.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
	<20240122114743.7e46b7cb@gandalf.local.home>
	<CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
	<CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
	<CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
	<bb90c70d-85fa-4228-a333-ab91eea945b2@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 13:27:25 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > IOW, this trivial patch seems to be much safer than worrying about
> > some pointer exposure.  
> 
> My only concern about the simple ino_counter static increment is what
> happens in the unlikely scenario of a 32-bit overflow. This is why
> I suggested using a bitmap to track inode allocation. It's compact, and
> we don't care that much about the linear bitmap scan overhead because
> it's far from being a fast path.

The original code use to get its inode via "get_next_ino()" I don't think
there's any reason not to just go back and do that again.

It can still overflow, but it's not anything new that couldn't have happen
to debugfs and tracefs over the last decade.

-- Steve

