Return-Path: <linux-kernel+bounces-86629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0020C86C809
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290BE1C21AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C357BAEA;
	Thu, 29 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFKX78E9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594457AE4D;
	Thu, 29 Feb 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206100; cv=none; b=mM26/TDO4+QTg3z5GytkDwPu5EvWHXiKgj8p0taNz61GVy+84EFFuv930Cm/IHQKd29FKCis9QLOLI6SJWivxpwhHKpfeWXJKk87BTWQm9JmD02lr5o+Kq6m4IbKLv74iyMBafhLzkT7sr0L6eGHf2EQQedxkFN7eP3XuxiD3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206100; c=relaxed/simple;
	bh=K/dQdNCw8tgzoiIBAXZRdigwTtDv7ZgnD6yJd6kn6T4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Og96IFKyIzngZ5mg5uBdFSvdaaCYCCXjsDrvRKpwgkyF4Al0mWw6YwkyujJg+O39Ue8K+JKrM/hDFkWPlfXuMnyj3zpv1yK7bFa7HKzB21Qvvd/Ei/Z84JvBeQBQgE5of5I3MTCucQ9IpqQxBvBb23msyxr8OP1mGpfn5pOsU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFKX78E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89AC433C7;
	Thu, 29 Feb 2024 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709206099;
	bh=K/dQdNCw8tgzoiIBAXZRdigwTtDv7ZgnD6yJd6kn6T4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HFKX78E9g6n8aiCYYQIDDPOkPvPHYoHF4Txx/dZH+ekO5Xo856L7IGX3WdzNHMpcf
	 /D9nRnPSfXrFrs1vJ/m6J/BpIHCgW9zlHZWawfRjwv9OsV9hi5NfSlPtSTnIBQI7+s
	 U7tE+iIVKOwpD8u4MtBBduz3qOLicukz3UzXDyP+X1wX/ZNexJ4P7Huxj+GMMrsfBG
	 eRV4LwSkahPc4Ixsq+if6l2g8XOlfNRiVBhUvmp3Fp9FqrJf4W8BVXLV4xF0eTdQst
	 R/AbZmq1ukNIwRB/kftsxka+F6uSGyTiGK2JdzGLhrDoMmE/pm41wvmaYRgsBYofTu
	 rOf25IE35/o5Q==
Date: Thu, 29 Feb 2024 20:28:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Fix to allocate entry_data_size buffer with
 rethook instances
Message-Id: <20240229202814.3ee3568bda16099e41c94569@kernel.org>
In-Reply-To: <170920576727.107552.638161246679734051.stgit@devnote2>
References: <170920576727.107552.638161246679734051.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 20:22:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to allocate fprobe::entry_data_size buffer with rethook instances.
> If fprobe doesn't allocate entry_data_size buffer for each rethook instance,
> fprobe entry handler can cause a buffer overrun when storing entry data in
> entry handler.
> 

Oops, missed a URL.

> Reported-by: Jiri Olsa <olsajiri@gmail.com>

Closes: https://lore.kernel.org/all/Zd9eBn2FTQzYyg7L@krava/

Thanks,

> Fixes: 4bbd93455659 ("kprobes: kretprobe scalability improvement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 6cd2a4e3afb8..9ff018245840 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  {
>  	int size;
>  
> -	if (num <= 0)
> -		return -EINVAL;
> -
>  	if (!fp->exit_handler) {
>  		fp->rethook = NULL;
>  		return 0;
> @@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  
>  	/* Initialize rethook if needed */
>  	if (fp->nr_maxactive)
> -		size = fp->nr_maxactive;
> +		num = fp->nr_maxactive;
>  	else
> -		size = num * num_possible_cpus() * 2;
> -	if (size <= 0)
> +		num *= num_possible_cpus() * 2;
> +	if (num <= 0)
>  		return -EINVAL;
>  
> +	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
> +
>  	/* Initialize rethook */
> -	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
> -				sizeof(struct fprobe_rethook_node), size);
> +	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
>  	if (IS_ERR(fp->rethook))
>  		return PTR_ERR(fp->rethook);
>  
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

