Return-Path: <linux-kernel+bounces-112450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F88879FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5381F216A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940756B78;
	Sat, 23 Mar 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcjKT2AY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD023BF;
	Sat, 23 Mar 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219503; cv=none; b=dolh6F/Af/ZX29vsVPtxhwmFjQ4Dv21ZuUdvQrJz4jReNaZ324dQgumRz3ll+/VDgShmwPTD/UltXw+HNdz59zKTFaUZt4qs7rLN4efULEZBWA+UWL5Jc9a/J3UFeMtfopsVZW3wTlzKYyFnq6vRSia4es3bEvVJzoNzNF+lFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219503; c=relaxed/simple;
	bh=+mtJ5IE4P/cFRPbERUs8Q4/5lmsBJRrG3EaPz0KmKmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEInWABlgwhE2/+U742UN0c2NVKX2H3qD4y357/9uWLSsZ7ZQTPdV50I8zpl/0dOiQisTeD3ttJQ7zbRrZnqK6FwWHMTnX2N1qi5JJol82V7t1bvADzHq26COCR1Unl727eMPGA2kHS1Br8N51k6EEBjrXB4NboSbuu7459sgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcjKT2AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DA8C433C7;
	Sat, 23 Mar 2024 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711219502;
	bh=+mtJ5IE4P/cFRPbERUs8Q4/5lmsBJRrG3EaPz0KmKmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcjKT2AYphRdGHtYvag4o9ENC0t1Qd6LDvTyNc6dB2w+tLbnyoTB6LZlNEnwpgcvf
	 UrwOPvlIOoQ5H3MtBKkl5N6uk4LGSYAdQ5afm690OuwLqEkz4+v8SVNB9XJDVtphEQ
	 6kNt4YmUUtPtqsiPsT+ZQfjSSRGvgNKWLyfMcfFdSzYzDODfJScgIcnY1xoLjDJCR+
	 rY2+WWsCQQr7QLn9EhlBuDwR4EVBFagiyA7oExyGkIqq/gMR96xAsZWbw0HH/dvr4x
	 bZyBIn5UfbWHh7ZyILbI0ei0AbK1dAPa0yfnhAsS7AMM3jHfyG5xG8FsxIkxDQetRs
	 Gfb99Ede3DUHw==
Date: Sat, 23 Mar 2024 11:45:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	lvc-project@linuxtesting.org, khoroshilov@ispras.ru,
	ykarpov@ispras.ru, vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: Re: [PATCH 2/2] xfs_refcount: Preventing integer overflow
Message-ID: <20240323184502.GA6390@frogsfrogsfrogs>
References: <20240323062603.665572-1-shum.sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323062603.665572-1-shum.sdl@nppct.ru>

On Sat, Mar 23, 2024 at 09:26:03AM +0300, Andrey Shumilin wrote:
> Multiplying variables can overflow the "overhead" variable.
> To fix this, the variable type has been increased.
> Next, a subtraction operation occurs with it,
> but before that it is checked.

Under what circumstances will pre-multiplication @overhead have a large
enough value to overflow?  The blocksize cannot be larger than 2^16, and
full splits of three btrees should never require anywhere close to 2^16
blocks, right?  Did your analysis tool find a scenario where this
actually happens?

--D

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  fs/xfs/libxfs/xfs_refcount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
> index 511c912d515c..cbf07552eaff 100644
> --- a/fs/xfs/libxfs/xfs_refcount.c
> +++ b/fs/xfs/libxfs/xfs_refcount.c
> @@ -1070,7 +1070,7 @@ static bool
>  xfs_refcount_still_have_space(
>  	struct xfs_btree_cur		*cur)
>  {
> -	unsigned long			overhead;
> +	unsigned long long		overhead;
>  
>  	/*
>  	 * Worst case estimate: full splits of the free space and rmap btrees
> -- 
> 2.30.2
> 
> 

