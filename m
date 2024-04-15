Return-Path: <linux-kernel+bounces-145851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0180B8A5BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCE8285226
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E7158873;
	Mon, 15 Apr 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ew97772B"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001215885D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210910; cv=none; b=eP3XOEdDY+bo/lfd6Z5ryUGWGMngnAzBn0P9Sk7L2tYqU7GNKoDJfLf9uUWzuQjtQKIpZ5gKNsOejHeX0Lp2Fs6LgmcZqAISZSE9rcOcUG8PL8yq2BpD2TPfAiLTeiJrALd1YRYaAVyBNYwqVrSvQk96csSi/2axn6+Q1O7wS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210910; c=relaxed/simple;
	bh=8nhccozgYNxEq/0Gqr6wadVOlq4H+k7Sr6gRN4VI98w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0Z2clSxs7gNovUGpGnO4ZZQX/qYgMME9l+daxeEJQ+8IrRARwY6gecA3t1NlCVbaBzFKYV0ChwSMg8D7+wn+sdK6viGzxKZZ1WO2vHXLNz6htmWoU0z/PG7KrSny/v63fSRQonCU84Aua/s+a/IkelUaBX0wEtSm7VBsD4kXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ew97772B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1HLF6zdWK+G6VmVP84eyW7NaYb38ri7n17m7dR09Qc=; b=Ew97772BmDT/aZed+egpCrTuJp
	6kYOsNtvQvc8GNTxQaHSeRqfV1k52pbD06MG5Si1XzgUP2bYT+bBZpAKYvwSwLdv/h66tn0PkA1YV
	ucyeaU9KhnaDLTD9y+yMyN5IsyKztpOdzSeyfUPX6vVHRg1BrdifzD6NvmzO+pvSETSC7u2wedjzT
	f8zT9dd8c8B35zhqM7M38VFAib1mVQUKTbadtI3hs60s7SALNViZrpEBAZ4csxgLc5yhTC+uyDyin
	MN8UXIZpVEzyvPG5NlMKbZj5hitLQnAaNpEg/j5sWZe/h3lLjpH5ijv2Ri3xSP13d80A6cIttV7Rd
	u6XPTqzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwSPw-00CzAg-39;
	Mon, 15 Apr 2024 19:55:05 +0000
Date: Mon, 15 Apr 2024 20:55:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 002/437] fs: add generic read/write iterator helpers
Message-ID: <20240415195504.GU2118490@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411153126.16201-3-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 11, 2024 at 09:12:22AM -0600, Jens Axboe wrote:

> +/* generic read side helper for drivers converting to ->read_iter() */
> +ssize_t vfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
> +		      ssize_t (*read)(struct file *, char __user *,
> +				     size_t, loff_t *))
> +{
> +	return do_loop_readv(iocb->ki_filp, to, &iocb->ki_pos, 0, read);
> +}
> +EXPORT_SYMBOL(vfs_read_iter);
> +
> +/* generic write side helper for drivers converting to ->write_iter() */
> +ssize_t vfs_write_iter(struct kiocb *iocb, struct iov_iter *from,
> +		       ssize_t (*write)(struct file *, const char __user *,
> +				       size_t, loff_t *))
> +{
> +	return do_loop_writev(iocb->ki_filp, from, &iocb->ki_pos, 0, write);
> +}
> +EXPORT_SYMBOL(vfs_write_iter);

Wait a minute; just what do you expect to happen if that ever gets called
for ITER_BVEC or ITER_XARRAY?

