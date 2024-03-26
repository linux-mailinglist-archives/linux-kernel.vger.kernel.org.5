Return-Path: <linux-kernel+bounces-119849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14888CDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A941C3C0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1913D287;
	Tue, 26 Mar 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwYvkPx/"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBF13D279
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483122; cv=none; b=G5NUPUZ9/NFilbZSJhcF5uKV6HzFl9ep6oZLkEFj5HeXawMk/0287jPkogN/NmJv5kDGZyWTtOMBG9Hdlo9gLLDsnq75JPrgb+zbaV8ssm8dPUx37FF4S+X/alrvjIqS+y41Q0Sba8zW9YB3reRWQJGnjSnKriK/y8XK3TXy5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483122; c=relaxed/simple;
	bh=4bbx/0DROSkMt/Yb7A3sC9L2/Uu13cLTx4FbFsJkgEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/PsrBf0IYLJpthEQWsHgU8EZYBhMR39pNnlRqms+3Tw36UqAuiSymmOx1UAcbA+BEBJSoLQMOn5l7m/aZCm77SDBOjxNHF0X7v3dRe+hjVW3lm/Pl10tvCpvbENW0XvhVFsHYkMkxnwr8+KmMJJd1O+QTmZDXYE4vP2Dm8fwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwYvkPx/; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Mar 2024 15:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711483117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZYB/y6k8bcQC7rHm6ARDNEfjZZ2NSOcHr4vMV4p3tE=;
	b=CwYvkPx/oTDcqRTbPkwL79nQUG3HmjA4D3ZFwejiNPyG7ADnojOjqlx5iJL/IHDphjceqZ
	jIGF+NU6WBHyrecbgGmC4b5Ebgto7nSVP8zvIx95g8VcDAIoL+oXNoTr/CVghUzSf9fde6
	HvD0RRdiPwhFaUckUvTQj/XE7xBmJ1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: zhuxiaohui <zhuxiaohui400@gmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhuxiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH] bcachefs: add REQ_SYNC and REQ_IDLE in write dio
Message-ID: <wor6mzq6nxhochp2bi42ece3hh6pywnt5lz2jacto4ns6lysj7@bc6crgl44rdu>
References: <20240326120345.68786-1-zhuxiaohui.400@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326120345.68786-1-zhuxiaohui.400@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 26, 2024 at 08:03:45PM +0800, zhuxiaohui wrote:
> when writing file with direct_IO on bcachefs, then performance is
> much lower than other fs due to write back throttle in block layer:
> 
>         wbt_wait+1
>         __rq_qos_throttle+32
>         blk_mq_submit_bio+394
>         submit_bio_noacct_nocheck+649
>         bch2_submit_wbio_replicas+538
>         __bch2_write+2539
>         bch2_direct_write+1663
>         bch2_write_iter+318
>         aio_write+355
>         io_submit_one+1224
>         __x64_sys_io_submit+169
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+110
> 
> add set REQ_SYNC and REQ_IDLE in bio->bi_opf as standard dirct-io
> 
> Signed-off-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>

Can I get you interested in a bigger project?

The writeback throttling code is a problem; it really shouldn't be
specific to writeback, it really ought to be a general purpose
backpressure mechanism.

Unfortunately, I've found the code to be opaque, practically to the
point of obfuscation, so it's going to be a difficult nut to crack.

But the lack of higher level, more workable backpressure is a problem,
it leads to queueing delays and priority inversions in filesystem code
and below.

> ---
>  fs/bcachefs/fs-io-direct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/fs-io-direct.c b/fs/bcachefs/fs-io-direct.c
> index 33cb6da3a5ad..f49e6c0f0f68 100644
> --- a/fs/bcachefs/fs-io-direct.c
> +++ b/fs/bcachefs/fs-io-direct.c
> @@ -536,7 +536,7 @@ static __always_inline long bch2_dio_write_loop(struct dio_write *dio)
>  		if (likely(!dio->iter.count) || dio->op.error)
>  			break;
>  
> -		bio_reset(bio, NULL, REQ_OP_WRITE);
> +		bio_reset(bio, NULL, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	}
>  out:
>  	return bch2_dio_write_done(dio);
> @@ -618,7 +618,7 @@ ssize_t bch2_direct_write(struct kiocb *req, struct iov_iter *iter)
>  
>  	bio = bio_alloc_bioset(NULL,
>  			       bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS),
> -			       REQ_OP_WRITE,
> +			       REQ_OP_WRITE | REQ_SYNC | REQ_IDLE,
>  			       GFP_KERNEL,
>  			       &c->dio_write_bioset);
>  	dio = container_of(bio, struct dio_write, op.wbio.bio);
> -- 
> 2.41.0
> 

