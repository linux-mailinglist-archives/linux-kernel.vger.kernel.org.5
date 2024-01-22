Return-Path: <linux-kernel+bounces-33865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015A836FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7442D1C23012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CB495F6;
	Mon, 22 Jan 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HH+dQZ32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6164C609;
	Mon, 22 Jan 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945802; cv=none; b=QVa/+ZBANW/zLhAlV9swElggbIHIydG0FDd8S3TpKqp9Tht45bl7+DOFSg5mo8lYC0Uvj013RmzYnNq/uYWpt87/b0NPoXd/N9dHFD3xjJmGjSblM3Bu10szSxlmaMDcwm76MjPm/n2aBGZbGLRzn6ekSIslkI+uMY+huhBZf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945802; c=relaxed/simple;
	bh=pgKN2vv5aFY3btJxTALCeAZ5ln5MmVsdnMseQghfUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlsTIImLBLi+co/S8CQuJsfYXxMVgkHNbfrfI1azc/SeaGPBwo79FctLxdKgjEDD/aLTfAQI4eYQH4Tk7/NbAZA6CSKQtvk0A6fN9dPqW+YmB+MkrzjwH736yXu9jicjJOiO1pAqUM+MWmGDuRj5Mll4s0DyW5PMjk8ytEeMhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HH+dQZ32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A6C43390;
	Mon, 22 Jan 2024 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945801;
	bh=pgKN2vv5aFY3btJxTALCeAZ5ln5MmVsdnMseQghfUgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH+dQZ32/Fwo22hkYcnlnDzXAieLU75LlWJRVNwLLnS3/YiSKLI4G/SjA1Y+JJMTm
	 +Z6oqS6ZdmhsStTDWksVOSgIGqfCACw3y9vPRgUkHEZW/2Sdnfmq4elH06fMCO1ja3
	 LmvPPRkYdOcqqDiyCC6qsg5we3UuQRuNXXuvmyFo=
Date: Mon, 22 Jan 2024 09:50:00 -0800
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
Message-ID: <2024012246-passable-delegate-5528@gregkh>
References: <20240112165007.4764-1-mish.uxin2012@yandex.ru>
 <2024011216-rubdown-buddhist-6d1e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011216-rubdown-buddhist-6d1e@gregkh>

On Fri, Jan 12, 2024 at 08:31:30PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 12, 2024 at 07:50:07PM +0300, Mikhail Ukhin wrote:
> > Fuzzing of 5.10 stable branch shows NULL pointer dereference happens in 
> > lbmStartIO() on log->bdev pointer. The reason for bdev being NULL is the 
> > JFS_NOINTEGRITY flag is set on mount of this fs. When this flag is enabled,
> > it results in the open_dummy_log function being called, which initializes a
> > new dummy_log, but does not assign a value to bdev.
> > 
> > The error is fixed in 5.18 by commit
> > 07888c665b405b1cd3577ddebfeb74f4717a84c4.
> > Backport of this commit is too intrusive, so it is more reasonable to apply
> > a small patch to fix this issue.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> > 
> > Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
> > Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
> > Signed-off-by: Pavel Koshutin <koshutin.pavel@yandex.ru>
> > Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> > ---
> >  fs/jfs/jfs_logmgr.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Who is using jfs in 5.10 and 5.15?  Why not just mark the filesystem as
> BROKEN there instead?  If you need to access your ancient filesystem
> image just use a newer kernel.
> 
> For filesystems that are not used in older kernels, work like this feels
> odd, especially for something just like a NULL dereference which doesn't
> do much, right?

Now dropped from my review queue due to lack of response...

