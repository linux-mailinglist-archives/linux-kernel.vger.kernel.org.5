Return-Path: <linux-kernel+bounces-83689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDCF869D55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA9828300D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC288487A5;
	Tue, 27 Feb 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n47AI41l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4071DA37
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054289; cv=none; b=s6BoKtXXPthEL6dF8VGsmd1m3fFsUrKig27/36c26yWCe68PTXtChxhUIu83g9hF4MxwTZZUruz3RT05Q3b+dP/HJtXGemJZLBuE0LEnN/aHvjkgKJyMn+ulhqw7YEdEwV6tcrE6zcVz7N5DvirVFU7uMVdOOu/jH6DuTpyFyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054289; c=relaxed/simple;
	bh=PNcverg+Hnzn6bxfuKU8MPQAP1RyaRFBgEEPtrpOxP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au4opaG3N6oEGHjZf7Xshr2ocSnTekF1YlpkIehBEq55ObpbMR98xE3Vw+9KiZJBLZQkCmK+UELIwsgGHgb7+MzO8dAX7et/RM0jW2trlJHCXhrFY1nM+9o9Pw12UI+vPKDwd04nNACQpRqVvtD2y1Go69xr8G/VBKidZHqQPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n47AI41l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F4C433F1;
	Tue, 27 Feb 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054288;
	bh=PNcverg+Hnzn6bxfuKU8MPQAP1RyaRFBgEEPtrpOxP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n47AI41lyDiASUiQ+7+Ka7jnVNx44uAlZIIiw/2vtr+Jh1NlNMdvyZu2cIZbfctPA
	 03ag85vrwI2a2OZiN6aaKGwzrqsOkNPGhMm2q8kAIoyJn4/TNGMs7KwsUitolkke+v
	 Y2R546VXGEQFb3I6PChiSisk0ar++TD8RlD20s93dcmWl1Qtz847EpiDqqTCSZqLgO
	 iJ/Qn5K3DjZMwuuuzoVc3/IPfE2Bt5RwRkc8QMGmcC1xZppCvrW/cQFo4sHw6nNEN8
	 8utuSTBYgQ+DAYIh97kCLxnJTCWJn8LidcaQHx6HTbcwjT86XtcwYHSwHbRbgxmvJn
	 R1gsKer9Jz6yA==
Date: Tue, 27 Feb 2024 09:18:06 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	hongyu.jin@unisoc.com
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Message-ID: <Zd4ZTokbVPkj5gy4@google.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
 <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
 <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
 <Zd03RHMKBqv1f6GF@google.com>
 <CAHJ8P3Lj_1pa=npkAsMfeStEY3nWgf591tFndKTT_skFYLv+GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3Lj_1pa=npkAsMfeStEY3nWgf591tFndKTT_skFYLv+GQ@mail.gmail.com>

On 02/27, Zhiguo Niu wrote:
> On Tue, Feb 27, 2024 at 9:13 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 02/26, Zhiguo Niu wrote:
> > > Dear Chao,
> > >
> > > On Fri, Feb 23, 2024 at 10:38 AM Chao Yu <chao@kernel.org> wrote:
> > > >
> > > > On 2024/2/23 10:01, Zhiguo Niu wrote:
> > > > >
> > > > >
> > > > > On Thu, Feb 22, 2024 at 8:30 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
> > > > >
> > > > >     On 2024/2/7 10:01, Zhiguo Niu wrote:
> > > > >      > A panic issue happened in a reboot test in small capacity device
> > > > >      > as following:
> > > > >      > 1.The device size is 64MB, and main area has 24 segments, and
> > > > >      > CONFIG_F2FS_CHECK_FS is not enabled.
> > > > >      > 2.There is no any free segments left shown in free_segmap_info,
> > > > >      > then another write request cause get_new_segment get a out-of-bound
> > > > >      > segment with segno 24.
> > > > >      > 3.panic happen in update_sit_entry because access invalid bitmap
> > > > >      > pointer.
> > > > >
> > > > >     Zhiguo,
> > > > >
> > > > >     Can you please try below patch to see whether it can fix your problem?
> > > > >
> > > > >     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org>
> > > > >
> > > > >     Thanks,
> > > > >
> > > > >
> > > > > Dear Chao,
> > > > > I need to coordinate the testing resources. The previous testing has been stopped because it was fixed with the current patch. In addition, this requires stability testing to reproduce, so it will take a certain amount of time. If there is any situation, I will tell you in time.
> > > >
> > > > Zhiguo, thank you!
> > >
> > > We tested this patch  this weekend on the previous version with
> > > problem, and it can not reproduce panic issues,
> > > so this patch should fix the original issue.
> > > thanks！
> >
> Dear Jaegeuk,
> > Hey, do you guys please point out which patches were tested without what?
> This problem occurred during our platform stability testing.
> it can be fixed by my  this patch set, mainly be fixed by:
> f2fs: fix panic issue in update_sit_entry & f2fs: enhance judgment
> conditions of GET_SEGNO
> and Chao's patch can also fix this problems testing without my patch
> > IOWs, which patches should I remove and keep Chao's patch?
> I think chao's patch is more reasonable, it does error handling more complete.
> but my patch just do some sanity check for return value of GET_SEGNO
> Same as other codes(update_segment_mtime)
> and i think it also needed except this part:

Thanks for confirmation. It seems it'd be better to revert yours and apply
Chao's patch first. If you think there's something to improve on top of it,
could you please send another patch afterwards?

> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 3bf2ce46fa0907..bb22feeae1cfcb 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -96,7 +96,8 @@ static inline void sanity_check_seg_type(struct
> f2fs_sb_info *sbi,
> (GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
> #define GET_SEGNO(sbi, blk_addr) \
> - ((!__is_valid_data_blkaddr(blk_addr)) ? \
> + ((!__is_valid_data_blkaddr(blk_addr) || \
> + !f2fs_is_valid_blkaddr(sbi, blk_addr, DATA_GENERIC)) ? \
> NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi), \
> GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
> #define CAP_BLKS_PER_SEC(sbi)
> because Chao's patch let new_addr=null_addr when  get_new_segment
> returns NOSPACE,
> so I think this can be reverted and it also saves code running time.
> How about Chao's opinions?
> thanks!
> >
> > >
> > > >
> > > > BTW, I've tested this patch for a while, and it looks there is no issue w/
> > > > FAULT_NO_SEGMENT fault injection is on.
> > > >
> > > > > btw, Why can’t I see this patch on your branch^^?
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test>
> > > >
> > > > Too lazy to push patches in time, will do it in this weekend. :P
> > > >
> > > > > thanks！
> > > > >
> > > > >
> > > > >      >
> > > > >      > More detail shown in following patch sets.
> > > > >      > The three patches are splited here because the modifications are
> > > > >      > relatively independent and more readable.
> > > > >      >
> > > > >      > ---
> > > > >      > Changes of v2: stop checkpoint when get a out-of-bound segment
> > > > >      > ---
> > > > >      >
> > > > >      > Zhiguo Niu (4):
> > > > >      >    f2fs: correct counting methods of free_segments in __set_inuse
> > > > >      >    f2fs: fix panic issue in update_sit_entry
> > > > >      >    f2fs: enhance judgment conditions of GET_SEGNO
> > > > >      >    f2fs: stop checkpoint when get a out-of-bounds segment
> > > > >      >
> > > > >      >   fs/f2fs/file.c          |  7 ++++++-
> > > > >      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
> > > > >      >   fs/f2fs/segment.h       |  7 ++++---
> > > > >      >   include/linux/f2fs_fs.h |  1 +
> > > > >      >   4 files changed, 27 insertions(+), 9 deletions(-)
> > > > >      >
> > > > >

