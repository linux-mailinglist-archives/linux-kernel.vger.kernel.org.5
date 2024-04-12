Return-Path: <linux-kernel+bounces-143336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABF8A375B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83591282E06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A0482C1;
	Fri, 12 Apr 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCVda51f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5544C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955364; cv=none; b=TQjvcwKj1+bA/Psj5uhwHOTdUkWcJLWzUMo5jYvop5Fkv7Lm+dNqNZmqh3ksx76d7xl4KnSQgpU97iMgFjDkC59y/cCH18dmFJqSsz0s32bIpkuT1wgZbdisqVggmYmwROJglITGh2akWvtrVE1POZNKg8pY6d33TzbixkB1A6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955364; c=relaxed/simple;
	bh=EqCqyiam+TyOhBuv0Ql8sinMo9ZD/uH+9B8oI0QJNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2GfPvdFQMs5VaQ6mRj34YTCycWMBPcnT6SiiQZOr9AQg5FIBpRL08Q/roHfc6VmGGOXZPbw6R2u4+HIjNI4xGZycym2TdpBBEYSy3Wc4zXe/40hAs+Pu0Pt6dc/wv1kbNz9Uq880deYVnugqVe0rNpLVDdA/5AqrLDZjAuhJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCVda51f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E969C113CC;
	Fri, 12 Apr 2024 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955364;
	bh=EqCqyiam+TyOhBuv0Ql8sinMo9ZD/uH+9B8oI0QJNeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCVda51fezwFmGWgStTpm1VbFuIAunct53zJGSzKB7TykRR5SUga4mgtvZdrtf1rs
	 F7ckHwjUoypk6vvQ+HMzPtgVPvpdQnmqcQAugckVVn9ZdMQtQhmPh2VAGN9/6D7DO8
	 QYXewx3M4LaTSKOG+q8UQ7NN/cSn+Q9+YFYAcsBpUEKY5caiAhOUgJRgC6HXgtfVl9
	 WqtwamsUuyBDbutywDq7MNAwiPJa18ZDwIXYePG9T1C7D5B5DAzgaLAKAfyy+YoafD
	 QVJYg3YRHj+lZYG42FNHAqa5IbHOWxVEQ/FqbdFKHPzVWzdfTLkF/+2loXZIUknqEo
	 0Tu4xVvkCra1g==
Date: Fri, 12 Apr 2024 20:56:02 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block
 address
Message-ID: <Zhmf4klcOr4eplin@google.com>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-3-jaegeuk@kernel.org>
 <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>

On 04/11, Chao Yu wrote:
> On 2024/4/10 4:34, Jaegeuk Kim wrote:
> > f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> > not the corruption case.
> 
> In which case we will read ahead invalid meta pages? recovery w/ META_POR?

I was trying to debug another issue, but found the root cause. Let me drop this
patch.

> 
> Thanks,
> 
> > 
> > Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index eac698b8dd38..b01320502624 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >   		break;
> >   	case META_SIT:
> >   		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_SSA:
> >   		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
> >   			blkaddr < SM_I(sbi)->ssa_blkaddr))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_CP:
> >   		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
> >   			blkaddr < __start_cp_addr(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_POR:
> >   		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> >   			blkaddr < MAIN_BLKADDR(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case DATA_GENERIC:
> >   	case DATA_GENERIC_ENHANCE:
> > @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >   	return true;
> >   err:
> >   	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +check_only:
> >   	return false;
> >   }

