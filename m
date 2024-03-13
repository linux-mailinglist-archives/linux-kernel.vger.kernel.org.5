Return-Path: <linux-kernel+bounces-101025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B787A0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917FF1F21801
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE1B652;
	Wed, 13 Mar 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEBvRbzj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3F947A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293572; cv=none; b=jG+M4uPuHmKw1GptmggrD0qZiXfDXES+p9aj7DIAH+QEbLqU6AEyxvgaTOdebl4BxQj6scHNwn8gGaiMP+32dS0w6kGO9ACWPet4qTAcRp6OcVR+gg9V4wFlNIy8UnFxRgI/E9B8njA+KnVH/XUob+iQ+KtpY4RWGTdiOaqHmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293572; c=relaxed/simple;
	bh=EAz1/6jNZeGT0Jk5yAvRhXaOHjMPAnEwzSGhMuY4HW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd+HBbzmFqg9l9YZaeqydxWA1c/5eX4fFxFLK+cWZDW5TGpcPI1TxfluxTGoCXdmWHXbe4i1QxkErIPrcQ8pQXemvhkrvCde2LOjG8BHBn3gYOhgyCg/tUhbMKCsEGDTRkD0uFO8/BeimVcBRvbTZ3xuNgQlwDucxUSd5sXWk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEBvRbzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3151C433C7;
	Wed, 13 Mar 2024 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293571;
	bh=EAz1/6jNZeGT0Jk5yAvRhXaOHjMPAnEwzSGhMuY4HW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEBvRbzjRtPWBJ1/1vZKlBVP8tancA/wCkjhjid3RO+JtETbJY2mnhNzzOMFyDxG9
	 JmTDIttjOjYjUPfEii4N+4sPj2MN3E9Wy+Ti/JkxjmDDDYdmNmIjE1HPWYvoRPXGCk
	 C9FmY3kbpTWhMhB37rFijCqXBsLA+XpcseoDvnLMyU4DTnwFxLVaQbxDqOYvSxkh7T
	 1/oyh6kqaQ0pyNfefSvV9auzWPAx26mLSoPSOsaQi7pfjxjCksGZ9EjgDhbdQ3cGIx
	 Tt4tycSSLe35h0Ug5ti7eOLBxpSICaDnvJlpM66RZFmuM/jzjE2JSvPRJ+YrfDbK1d
	 nM6XILA5Nrd7A==
Date: Tue, 12 Mar 2024 18:32:50 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return EIO when reading after
 device removal
Message-ID: <ZfECQpk3QliirSlb@google.com>
References: <20240206032513.2495025-1-chao@kernel.org>
 <ZcQd3DtIpiA5P9DQ@google.com>
 <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
 <23aa8351-e002-4185-89c7-ccde6b5b0549@kernel.org>
 <5f335b3b-7edc-458f-819d-40012b61672a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f335b3b-7edc-458f-819d-40012b61672a@kernel.org>

So, I was wondering we can give data even in cp_error case.

On 03/12, Chao Yu wrote:
> Ping,
> 
> Jaegeuk, do you have any comments on this patch?
> 
> Thanks,
> 
> On 2024/2/26 16:00, Chao Yu wrote:
> > Any comments?
> > 
> > Thanks,
> > 
> > On 2024/2/19 11:13, Chao Yu wrote:
> > > On 2024/2/8 8:18, Jaegeuk Kim wrote:
> > > > On 02/06, Chao Yu wrote:
> > > > > generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
> > > > >      --- tests/generic/730.out    2023-08-07 01:39:51.055568499 +0000
> > > > >      +++ /media/fstests/results//generic/730.out.bad    2024-02-06 02:26:43.000000000 +0000
> > > > >      @@ -1,2 +1 @@
> > > > >       QA output created by 730
> > > > >      -cat: -: Input/output error
> > > > >      ...
> > > > >      (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
> > > > > Ran: generic/730
> > > > > Failures: generic/730
> > > > > Failed 1 of 1 tests
> > > > > 
> > > > > This patch adds a check condition in f2fs_file_read_iter() to
> > > > > detect cp_error status after device removal, and retrurn -EIO
> > > > > for such case.
> > > > 
> > > > Can we check device removal?
> > > 
> > > We can use blk_queue_dying() to detect device removal, but, IMO, device
> > > removal can almost not happen in Android, not sure for distros or server,
> > > do you want to add this check condition into f2fs_cp_error()?
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >   fs/f2fs/file.c | 3 +++
> > > > >   1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > index 45b7e3610b0f..9e4386d4144c 100644
> > > > > --- a/fs/f2fs/file.c
> > > > > +++ b/fs/f2fs/file.c
> > > > > @@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > > >       const loff_t pos = iocb->ki_pos;
> > > > >       ssize_t ret;
> > > > > +    if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> > > > > +        return -EIO;
> > > > > +
> > > > >       if (!f2fs_is_compress_backend_ready(inode))
> > > > >           return -EOPNOTSUPP;
> > > > > -- 
> > > > > 2.40.1
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

