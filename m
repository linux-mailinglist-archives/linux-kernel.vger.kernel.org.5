Return-Path: <linux-kernel+bounces-41471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510A83F25F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84351C2153A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55B63D;
	Sun, 28 Jan 2024 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Luwn49zT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B787182
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706400162; cv=none; b=lw6JbFltThYbEYUnQ1BHvunFrRAYA31MecTXmgBynOrX6oSGT3AXzZrtgzODH+UqoN4nGMOl3anxpd6wNPZhA2tXOQkJFKrUTY1RlRI7q71gm5XuAHsxKCMeyjPf2Lzbfj4WKj1mJyF+TQMmZbhCwgS8wNyZhDwlQ4+MlgcBvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706400162; c=relaxed/simple;
	bh=7i60AQVcNwjxPAh7wJDI3XQaAANFbd4/TNGBjnSdNDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm4zOYJX4ttJYhZk+Bllkob4tVqHQ4uRcZYWOUfoglk9YmY271XnIZpa5qGDGsY/+fl0H3AQHkonzI5mNa895cO/sSy/4h0sg1ps5KnYyg3LvnrEENlxT8s/CE7HJAg1viSEUFu3PoLp8RhzYtSnCeYqY5/uwvSfxXMV+8sXGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Luwn49zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ABDC433F1;
	Sun, 28 Jan 2024 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706400161;
	bh=7i60AQVcNwjxPAh7wJDI3XQaAANFbd4/TNGBjnSdNDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Luwn49zTla1BfneDo5Tomn3VbrJO0STwInNMR9SkISa70MXGcs7H2U7kaDleMhK9V
	 PsLI8BlnvbW9/Vs0lP+RpdOyJ6n8cKEtIYKy6olmZJUSvw2wM1vgI230gQOIZlydoh
	 baeDilpjareAhJXtgqNNfGNcXIhZsTQDftWk+pE8=
Date: Sat, 27 Jan 2024 16:02:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Neel Natu <neelnatu@google.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix false-positive WARN(nr_mmapped) in
 kernfs_drain_open_files
Message-ID: <2024012727-petition-flip-917c@gregkh>
References: <20240127234636.609265-1-neelnatu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127234636.609265-1-neelnatu@google.com>

On Sat, Jan 27, 2024 at 03:46:36PM -0800, Neel Natu wrote:
> Prior to this change 'on->nr_mmapped' tracked the total number of
> mmaps across all of its associated open files via kernfs_fop_mmap().
> Thus if the file descriptor associated with a kernfs_open_file was
> mmapped 10 times then we would have: 'of->mmapped = true' and
> 'of_on(of)->nr_mmapped = 10'.
> 
> The problem is that closing or draining a 'of->mmapped' file would
> only decrement one from the 'of_on(of)->nr_mmapped' counter.
> 
> For e.g. we have this from kernfs_unlink_open_file():
>         if (of->mmapped)
>                 on->nr_mmapped--;
> 
> The WARN_ON_ONCE(on->nr_mmapped) in kernfs_drain_open_files() is
> easy to reproduce by:
> 1. opening a (mmap-able) kernfs file.
> 2. mmap-ing that file more than once (mapping just once masks the issue).
> 3. trigger a drain of that kernfs file.
> 
> Modulo out-of-tree patches I was able to trigger this reliably by
> identifying pci device nodes in sysfs that have resource regions
> that are mmap-able and that don't have any driver attached to them
> (steps 1 and 2). For step 3 we can "echo 1 > remove" to trigger a
> kernfs_drain.
> 
> Signed-off-by: Neel Natu <neelnatu@google.com>
> ---
>  fs/kernfs/file.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index ffa4565c275a..e9df2f87072c 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -483,9 +483,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  		goto out_put;
>  
>  	rc = 0;
> -	of->mmapped = true;
> -	of_on(of)->nr_mmapped++;
> -	of->vm_ops = vma->vm_ops;
> +	if (!of->mmapped) {
> +		of->mmapped = true;
> +		of_on(of)->nr_mmapped++;
> +		of->vm_ops = vma->vm_ops;
> +	}
>  	vma->vm_ops = &kernfs_vm_ops;
>  out_put:
>  	kernfs_put_active(of->kn);

What commit id does this fix?

thanks,

greg k-h

