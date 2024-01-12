Return-Path: <linux-kernel+bounces-24999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160482C5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D67286835
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2D15E94;
	Fri, 12 Jan 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hv2Wyt/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38614F6D;
	Fri, 12 Jan 2024 19:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C207C433F1;
	Fri, 12 Jan 2024 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705087893;
	bh=FvQJcr9tDVeV5tst8ttPoAR1yrrsKUrGxfwyN8pTbuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv2Wyt/S8vaNTb/tchv5D88XUyCfkJBo6JFVkePkT93GwR2Rl9JY2ky40Ld7UulEi
	 9bivVJUyX7QGDVhUNOqNyzPFkK26QvLlYJFb3UAsENrWVme9bzr+JJyBISw+cTlcft
	 VLwK0VeqxJfHiuSpYUOgL4R2qWQFwxJ5lkc7ljIg=
Date: Fri, 12 Jan 2024 20:31:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: Dave Kleikamp <shaggy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	jfs-discussion@lists.sourceforge.net, stable@vger.kernel.org,
	lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
	Mikhail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH 5.10/5.15] jfs: add check if log->bdev is NULL in
 lbmStartIO()
Message-ID: <2024011216-rubdown-buddhist-6d1e@gregkh>
References: <20240112165007.4764-1-mish.uxin2012@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112165007.4764-1-mish.uxin2012@yandex.ru>

On Fri, Jan 12, 2024 at 07:50:07PM +0300, Mikhail Ukhin wrote:
> Fuzzing of 5.10 stable branch shows NULL pointer dereference happens in 
> lbmStartIO() on log->bdev pointer. The reason for bdev being NULL is the 
> JFS_NOINTEGRITY flag is set on mount of this fs. When this flag is enabled,
> it results in the open_dummy_log function being called, which initializes a
> new dummy_log, but does not assign a value to bdev.
> 
> The error is fixed in 5.18 by commit
> 07888c665b405b1cd3577ddebfeb74f4717a84c4.
> Backport of this commit is too intrusive, so it is more reasonable to apply
> a small patch to fix this issue.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
> Signed-off-by: Pavel Koshutin <koshutin.pavel@yandex.ru>
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> ---
>  fs/jfs/jfs_logmgr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Who is using jfs in 5.10 and 5.15?  Why not just mark the filesystem as
BROKEN there instead?  If you need to access your ancient filesystem
image just use a newer kernel.

For filesystems that are not used in older kernels, work like this feels
odd, especially for something just like a NULL dereference which doesn't
do much, right?

thanks,

greg k-h

