Return-Path: <linux-kernel+bounces-87808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559D86D949
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CA51C227A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924739AC9;
	Fri,  1 Mar 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyL1pMip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F03984A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258329; cv=none; b=dSKFZk0sLP3R/B8Ypy2QxUhGRrE4wzZ6pG+5GVzvMTxmT4Gr4xMKFaibgTbkIY3ANFd9qOkGefsereIvdT7XH1slG1GEI+ZdHAqC+iMzCRxZ/wEDoGgU8YK6VhfGebYWXDA3PPE6TfHDMrN42IMz+xFUN6M6m/fjBdzNoe9/qUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258329; c=relaxed/simple;
	bh=OcuenNbFeoaYEW2LlBjOx0+q6bI5pkE/MIMURp6AGlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkW81avOSBSpJ6rktV+xzmlOiw+dz0x8E7J/5qoaWcrq16WBgJ9rsSjIQsguOXd3IW70geItHLo6xREXI8n8V29F3CIgpvQYRdsSGY8LBM0paloS2Z9g4xwKBUSHT1FHVxhEcZP4+5VZ4mMjTrbSKTOH2DuP4NL6jrOtNmiGAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyL1pMip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B5EC433F1;
	Fri,  1 Mar 2024 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709258329;
	bh=OcuenNbFeoaYEW2LlBjOx0+q6bI5pkE/MIMURp6AGlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyL1pMipG955O6PPN5Kni6DnbhUe/1VDEcnhsjoLLm3TkFiWB1XkDRBA/13CDX9IS
	 5d4KUrMoCq5ocfanOzjVbSjKRR12DOylJV8o9+4lX2KG1pUlQhRn2I3Mtevdpfr5w3
	 r+C79pi+2BRxVRNJXsro8EeZmI6dX/rloNCJjURPEdaHHQ+Zr7LTzWFv1jkz4nKaSI
	 VQvlzEZ66YXcws3vj4gyqg1MTfFJjKeiUWdvb3jCBGBKmfbUYDBOzWccGGU0dnfzKR
	 jU1FpyjEDLTpVMZLYC0xXhAKNLf80zb2P4ptm1JqTvSp6HCoWNc2FMWx+4KDxGWhnN
	 VHZaZq+KF0PDQ==
Date: Thu, 29 Feb 2024 17:58:47 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daeho43@gmail.com>, Daeho Jeong <daehojeong@google.com>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix blkofs_end correctly in
 f2fs_migrate_blocks()
Message-ID: <ZeE2VwBmGJxrgKZ2@google.com>
References: <20240226013208.2389246-1-chao@kernel.org>
 <2b81aa6f-db51-4a7c-97ab-2af2c2fea056@kernel.org>
 <CACOAw_yn4m+nEGMEX8RL1xFEaZpzXvjUhUdSoo9d2EeGfzPrAA@mail.gmail.com>
 <3325fdb0-1f21-4ba9-919a-09fa0206f7c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3325fdb0-1f21-4ba9-919a-09fa0206f7c5@kernel.org>

On 03/01, Chao Yu wrote:
> On 2024/3/1 1:41, Daeho Jeong wrote:
> > On Thu, Feb 29, 2024 at 2:11 AM Chao Yu <chao@kernel.org> wrote:
> > > 
> > > Jaegeuk, Daeho,
> > > 
> > > Any comments on this serials?
> > > 
> > > Thanks,
> > 
> > No functional difference here, since start_blk is always aligned with
> > the section address.
> 
> You're right.
> 
> > However, this is more clear in itself.
> 
> Thanks for the review!
> 
> One more thing is, I found that fallocate() on pinned file will preallocate
> aligned w/ section-size which is about several hundred megabyte for ZUFS case,
> since commit e1175f022911 ("f2fs: fix to align to section for fallocate() on
> pinned file").
> 
> It looks not make sense, especially for logcat case which actually want to
> preallocate 2MB space, so, what about reverting commit e1175f022911 and
> looking for other solution to avoid GCing on fragmented pinned file.

I remember we removed the logcat case.

> 
> What do you think?
> 
> Thanks,
> 
> > 
> > Reviewed-by: Daeho Jeong <daehojeong@google.com>
> > 
> > Thanks,
> > 
> > > 
> > > On 2024/2/26 9:32, Chao Yu wrote:
> > > > In f2fs_migrate_blocks(), when traversing blocks in last section,
> > > > blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > >    fs/f2fs/data.c | 5 +++--
> > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > index c21b92f18463..0c728e82d936 100644
> > > > --- a/fs/f2fs/data.c
> > > > +++ b/fs/f2fs/data.c
> > > > @@ -3841,13 +3841,14 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
> > > >        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > >        unsigned int blkofs;
> > > >        unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
> > > > +     unsigned int end_blk = start_blk + blkcnt - 1;
> > > >        unsigned int secidx = start_blk / blk_per_sec;
> > > >        unsigned int end_sec;
> > > >        int ret = 0;
> > > > 
> > > >        if (!blkcnt)
> > > >                return 0;
> > > > -     end_sec = secidx + (blkcnt - 1) / blk_per_sec;
> > > > +     end_sec = end_blk / blk_per_sec;
> > > > 
> > > >        f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > >        filemap_invalidate_lock(inode->i_mapping);
> > > > @@ -3857,7 +3858,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
> > > > 
> > > >        for (; secidx <= end_sec; secidx++) {
> > > >                unsigned int blkofs_end = secidx == end_sec ?
> > > > -                     (blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
> > > > +                             end_blk % blk_per_sec : blk_per_sec - 1;
> > > > 
> > > >                f2fs_down_write(&sbi->pin_sem);
> > > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

