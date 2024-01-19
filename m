Return-Path: <linux-kernel+bounces-31509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5E832F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BDC1F2412D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B056455;
	Fri, 19 Jan 2024 19:10:49 +0000 (UTC)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA91DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691449; cv=none; b=GRHn5QTTJBTQd9jy+rGCWvs0txVFqmGgDOhyD9oV8TmrH9r2gFTM6fKS520EqP2ILEstDrV4NErGSsc2jgNzfS50sVILoov9L2OFCu6rlMjJC/A8dYwbPN3JkxgkbSHSMtB8m5zCiIzmYDiiB+q+Ok6+eKuZ8k1AA3Y0ACik7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691449; c=relaxed/simple;
	bh=8PECGMhwm3BopdpqET6OaIAick528GtTNtZM1lUUtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN27PohP6SpJZkm9MgEJ23ZBxN+cN0jOBbZcQ96qYronyF0G1iNpU0iNZOWhhU9aXDyp3R2ExaIei8huuTlt2njE2lsorNOX81c2+S0dHrga+kf29RqEQjqn2w2LiQns+CmnLhG12OeR9YAVTeXHjRF0Y5y+1HMVcLCB+V5BRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Fri, 19 Jan 2024 14:10:54 -0500
From: Rich Felker <dalias@libc.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20240119191053.GT22081@brightrain.aerifal.cx>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
 <20240119-neuverfilmung-aufregend-54a5bd5929dd@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-neuverfilmung-aufregend-54a5bd5929dd@brauner>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 19, 2024 at 03:33:32PM +0100, Christian Brauner wrote:
> On Mon, 31 Aug 2020 11:32:08 -0400, Rich Felker wrote:
> > The pwrite function, originally defined by POSIX (thus the "p"), is
> > defined to ignore O_APPEND and write at the offset passed as its
> > argument. However, historically Linux honored O_APPEND if set and
> > ignored the offset. This cannot be changed due to stability policy,
> > but is documented in the man page as a bug.
> > 
> > Now that there's a pwritev2 syscall providing a superset of the pwrite
> > functionality that has a flags argument, the conforming behavior can
> > be offered to userspace via a new flag. Since pwritev2 checks flag
> > validity (in kiocb_set_rw_flags) and reports unknown ones with
> > EOPNOTSUPP, callers will not get wrong behavior on old kernels that
> > don't support the new flag; the error is reported and the caller can
> > decide how to handle it.
> > 
> > [...]
> 
> The RWF_* and IOCB_* flags were
> aligned so they could be set in one operation. So there was a merge
> conflict when applying. I've resolved it. Please take a look and make
> sure that it's all correct.
> 
> ---
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] vfs: add RWF_NOAPPEND flag for pwritev2
>       https://git.kernel.org/vfs/vfs/c/31081ab305a1

LGTM. Thanks!

