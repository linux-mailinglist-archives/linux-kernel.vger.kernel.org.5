Return-Path: <linux-kernel+bounces-39785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780483D60B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E923728A44D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721241C68F;
	Fri, 26 Jan 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfOyWlGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983614276
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258575; cv=none; b=BRfM3f9PI7QRqmUPySSUJ63FfJOBQZFzCD2zhiMH66pfLDQBVtKzNq2KN5V6zLPdZBTTFz2aFOmBdaiW1IM4aTDDKVUSg8EpQcijQn6xbET3qu6/1iBURSkI9GOC/UQuWFpoKVqmXQkuwqMxxe0TsXT57T97pbGINnxoxp3B3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258575; c=relaxed/simple;
	bh=EJ8HNBNPvrJzALg5dpS/zcxB8MUSRkw2iTKEPWWRH5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwb6oWsPFjCJJbXsDbp4zoRP4kZO8b92v2YtwGurA9fqkZSlDBs9tEdjWormeZt4yMdzl4lwKG1GfGk2sPpEUV0l+/CW8ZGW7hSJEJ+/zjvLMYCVRhif5pqKwFCyqWlKd6Q+xbfxAmounWpZOZJqDuYvfZIFPpnRVuDAyJrr/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfOyWlGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C2C433C7;
	Fri, 26 Jan 2024 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706258575;
	bh=EJ8HNBNPvrJzALg5dpS/zcxB8MUSRkw2iTKEPWWRH5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfOyWlGCDHTixxfui7jZbFLFYkMp0yZuTFnthDrhlU+NdHkfbyU4LACmYVuc7FDZA
	 nfczveWp2HFWQ4LYJJpUhsWFjY8FFf+Dal8IzQa+rPNuR/5NsaZ0gtzFjhkOfphEAx
	 w0Kia+Ez0LHfo2oxKSfVATg9iiciNWdsSoRNRmbysR/Lp24/JQOLwsKJAffGDeAXKr
	 FLuYxms+w+epimv/lxCMRFMjGPPuiP39ieO6MecoaoCah4wxxXGH3pbl/tjEafwvkj
	 CeMFNnl/QrELg2Nvl14+l5Qe556/Q/EV9HLEOHz2WXW650iSOIDDd8gX4DjGXKnjAV
	 asOQZg5tVdGQA==
Date: Fri, 26 Jan 2024 00:42:53 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: use printk_ratelimited to avoid redundant logs
Message-ID: <ZbNwjbXyue2-HIr_@google.com>
References: <20240124144506.15052-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124144506.15052-1-chao@kernel.org>

On 01/24, Chao Yu wrote:
> Use printk_ratelimited() instead of f2fs_err() in f2fs_record_stop_reason(),
> and f2fs_record_errors() to avoid redundant logs.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e2c066fbc0fa..7e437aea268e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4091,7 +4091,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>  
>  	f2fs_up_write(&sbi->sb_lock);
>  	if (err)
> -		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);

Needing f2fs_err_ratelimited()?

> +		printk_ratelimited(
> +			"%sF2FS-fs (%s): f2fs_commit_super fails to record stop_reason, err:%d\n",
> +			KERN_ERR, sbi->sb->s_id, err);
>  }
>  
>  void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
> @@ -4134,8 +4136,9 @@ static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
>  
>  	err = f2fs_commit_super(sbi, false);
>  	if (err)
> -		f2fs_err(sbi, "f2fs_commit_super fails to record errors:%u, err:%d",
> -								error, err);
> +		printk_ratelimited(
> +			"%sF2FS-fs (%s): f2fs_commit_super fails to record errors:%u, err:%d\n",
> +			KERN_ERR, sbi->sb->s_id, error, err);
>  out_unlock:
>  	f2fs_up_write(&sbi->sb_lock);
>  }
> -- 
> 2.40.1

