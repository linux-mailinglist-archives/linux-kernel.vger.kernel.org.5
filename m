Return-Path: <linux-kernel+bounces-87654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F086D704
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FC8283535
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DFD4595C;
	Thu, 29 Feb 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEVfPUel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019944362;
	Thu, 29 Feb 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247014; cv=none; b=hZcwhClC14mEe0kcEPs3IX5aAbEXFloMNRbOQZZwbZYRjEXc+PS2/vHZoer2wH2tR2YTOWCZcK7kkDf9xq8FB+9BEPSwSgnvJhmNTueT3+9/O5/QFy4/HEGO2yBaEmBPAaAxN8orbUl2u2L+1Z9vxx475T7Xb2JacB/IZmt4Hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247014; c=relaxed/simple;
	bh=ekfbDf15yCY6P//fpG4nQw5ky8qNnNsLRyFC6XWeW24=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WANn5RsC+UeA74Pxc3o2Zwz4Tti7WdG9FGL9bqJ58oaYpYru2wdPVdbzhjrIFZyu2g/bCK2gqFYLySsL0yX+Hkuz86VAR+YlHsACFTu7QdNGlH+5Lx1No5TDaf+dCXDKDSo6QRNGmPP/wANRfEBhFnKAsbViQ8j5Bfy3cSm4+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEVfPUel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EECC433F1;
	Thu, 29 Feb 2024 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709247014;
	bh=ekfbDf15yCY6P//fpG4nQw5ky8qNnNsLRyFC6XWeW24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEVfPUeldaXF3E1IEwQP9f527BXlLSYs5cR6lTWBiFCOLJbEjt6TinoMDEmiXxaBg
	 tyoUxDnjI1fydNJM7j2Jq1RxNgjxX0joSdYDA0OXih74XKzIQ5kQy1XLwhTH9MUJFI
	 AtHjZM8cLiuwVBnIjgEi+FsS8vA8UyQb9y2SYS/f/eabUTqL5Qb2tlR6+DapGsrDmX
	 nQpMs0rzXUElKE1OxLrJPPMx/21vuW0ItcybFxJD2+7LeKJ4SQUSReWo/4WsGJ+tDW
	 bYpaEFh8QpfUXX2eUVRKq+wrhGcGlkc0XJLBTeWvEwEvTkLZIXtZ1Nw9qXjcJMu9X2
	 FYzEluqaAoYdw==
Date: Fri, 1 Mar 2024 07:50:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Fix to allocate entry_data_size buffer with
 rethook instances
Message-Id: <20240301075010.6125d953f6e109fe71cf9ffe@kernel.org>
In-Reply-To: <ZeD-HkC7bsAn_YgK@krava>
References: <170920576727.107552.638161246679734051.stgit@devnote2>
	<ZeD-HkC7bsAn_YgK@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 22:58:54 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Feb 29, 2024 at 08:22:47PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to allocate fprobe::entry_data_size buffer with rethook instances.
> > If fprobe doesn't allocate entry_data_size buffer for each rethook instance,
> > fprobe entry handler can cause a buffer overrun when storing entry data in
> > entry handler.
> > 
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> 
> Tested-by: Jiri Olsa <olsajiri@gmail.com>

Thanks for testing!
Let me pick this to probe/fixes.

Thank you,

> 
> thanks,
> jirka
> 
> > Fixes: 4bbd93455659 ("kprobes: kretprobe scalability improvement")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |   14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 6cd2a4e3afb8..9ff018245840 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
> >  {
> >  	int size;
> >  
> > -	if (num <= 0)
> > -		return -EINVAL;
> > -
> >  	if (!fp->exit_handler) {
> >  		fp->rethook = NULL;
> >  		return 0;
> > @@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
> >  
> >  	/* Initialize rethook if needed */
> >  	if (fp->nr_maxactive)
> > -		size = fp->nr_maxactive;
> > +		num = fp->nr_maxactive;
> >  	else
> > -		size = num * num_possible_cpus() * 2;
> > -	if (size <= 0)
> > +		num *= num_possible_cpus() * 2;
> > +	if (num <= 0)
> >  		return -EINVAL;
> >  
> > +	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
> > +
> >  	/* Initialize rethook */
> > -	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
> > -				sizeof(struct fprobe_rethook_node), size);
> > +	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
> >  	if (IS_ERR(fp->rethook))
> >  		return PTR_ERR(fp->rethook);
> >  
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

