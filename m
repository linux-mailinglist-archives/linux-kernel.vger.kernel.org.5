Return-Path: <linux-kernel+bounces-57330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CB84D70E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345741C2275C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2F1D55F;
	Thu,  8 Feb 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j21ZKIjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34D1947E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351519; cv=none; b=q1C3DSnODGZghpmHLoieoJQo1oet7zp9tmh9Nb4IpufuYFss9H8qjrWfVlBvjzhmrAWZjVEIR3A4oHnhcBH3eGw8w/gFJKl8Vqll52Ywz1/TWVWu3H4SNEiEUgQueQQ8P4SAj7aihrRs/4hdWlOTEALv1Ks58onAQB1qtYHeEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351519; c=relaxed/simple;
	bh=sPGBKRP7Mk3ojRHbadujeGjzZuRfVVNuZG0fT9/kT78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/NeyPqeqEukOzzPSKTNOwIJHm5ohytCFzOLXLLdwIES/va4ehLtScfP5egqWVN+6IATsqA4hjGDAYqXh2yzHzh4JoAn8YPM+00x4sUOzSAwGizRy4cYlqmMI7naAnUV0FzW+tVFqw19cyIzulUyvaRnZr1WTGDXZdHzSrzKJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j21ZKIjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB04C433F1;
	Thu,  8 Feb 2024 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351518;
	bh=sPGBKRP7Mk3ojRHbadujeGjzZuRfVVNuZG0fT9/kT78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j21ZKIjvUsZYb4RtuvAKxGHmF9VW9J792YECBE6SzlLXoD7k4vIgAK59865lInoIg
	 f/LEzyyIJcOC1YdMSnZi6Oiv4QpM5wGh+dVR5MEDSXr6J+976X4aJW2CxGMTEXrvlw
	 1CcE4F8qHPzU2m7vBQsHPDHwIiMGcZQmgB/ui5fPHIOVn0XUToYQCn2oJevV5g/GQ5
	 f3lo9Q9xGORmGd25iQaEi7e7lPsn8FNOpOelgtkg2Gf1AOskQYAUZMcXzm4VEhM7/1
	 lZzqJkBkO/yqP6Q/iqRN3ayVNhhsEebIZ3L2h89geM0VunkI8Czc9l57nNzKuGRyGC
	 /EAxAYOCZvYQw==
Date: Wed, 7 Feb 2024 16:18:36 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to return EIO when reading after device removal
Message-ID: <ZcQd3DtIpiA5P9DQ@google.com>
References: <20240206032513.2495025-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206032513.2495025-1-chao@kernel.org>

On 02/06, Chao Yu wrote:
> generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
>     --- tests/generic/730.out	2023-08-07 01:39:51.055568499 +0000
>     +++ /media/fstests/results//generic/730.out.bad	2024-02-06 02:26:43.000000000 +0000
>     @@ -1,2 +1 @@
>      QA output created by 730
>     -cat: -: Input/output error
>     ...
>     (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
> Ran: generic/730
> Failures: generic/730
> Failed 1 of 1 tests
> 
> This patch adds a check condition in f2fs_file_read_iter() to
> detect cp_error status after device removal, and retrurn -EIO
> for such case.

Can we check device removal?

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 45b7e3610b0f..9e4386d4144c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	const loff_t pos = iocb->ki_pos;
>  	ssize_t ret;
>  
> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> +		return -EIO;
> +
>  	if (!f2fs_is_compress_backend_ready(inode))
>  		return -EOPNOTSUPP;
>  
> -- 
> 2.40.1

