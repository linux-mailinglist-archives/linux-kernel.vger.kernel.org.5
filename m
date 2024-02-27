Return-Path: <linux-kernel+bounces-82499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5C868564
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DD1F22B53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7984A0A;
	Tue, 27 Feb 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRpQawtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB61FA6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995639; cv=none; b=aJPdSGuMzvn8FVMB1f3mJI0SErTLuQCiPvtgi8OI/iBn9z4bdE+8j5M/8uZkcFfMisJQE+c4Bk4z1L9QMDu+5fVBiWRt/nEasFFWFLlmSbK7FJ8hNL4HNu6H6jwL62QpGIQSoz6cOvBqZg1xoNFQI/byr8tGkbMfUORuR8QH/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995639; c=relaxed/simple;
	bh=rns9tbOCnQ17z7ThR0yXP5WAZXibD6njSBg/+AoGdPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFN/WLmcipRS7+gQ5DJ9m0geBzmbRhUHCn9fZi7gYL/jhz+4SsPHmG1zWaINhHTbM0qHtzO320EJrdMccXX9vG8/1eXTESQwDlnVS4hq8PrzB3NlclcIeCLbL2eHMr2my8BTKmtUUOZs+GZ1z3eHMzWalF/ZAqjRvZPf3kEBEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRpQawtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C750CC433C7;
	Tue, 27 Feb 2024 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995638;
	bh=rns9tbOCnQ17z7ThR0yXP5WAZXibD6njSBg/+AoGdPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRpQawtR6DPv/3KJNMTcCRb3IeSI+I+G5VAD7KM+HG2ylj5YIJR3nb+1De2dsfT5E
	 FilDgb2KF0FDmdjQGcmuA3HUkv1NtSoRw5GZJJi48hZq4GvyrFDXxulwGPTzI7pYyW
	 09ClKZVEoIJZGtgT5HNNGlq8oaoGOcLJo6TPTi+AF+j0jxZgoDnpcxGucauPbOMOjC
	 koxfYHatvKTixDwO2Y7mUeM9Ipl6EyoW6nU4F95+xj4i/iQ0HCTC8oaIgOQQL1IeLi
	 54PScHjs366BJUdOuSNBnaHKeJlWSDLbBRvjjmzfX/woBFp8gO8mVcfT8luxKbUgTp
	 J9OndJDidkCMg==
Date: Mon, 26 Feb 2024 17:00:37 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: fix write pointers all the time
Message-ID: <Zd00NbIAbs99vn4j@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org>
 <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>

On 02/26, Chao Yu wrote:
> On 2024/2/24 4:55, Jaegeuk Kim wrote:
> > Even if the roll forward recovery stopped due to any error, we have to fix
> > the write pointers in order to mount the disk from the previous checkpoint.
> 
> Jaegeuk,
> 
> IIUC, we may lost warm node chain once we allocate new section for all logs,
> should we give some notification in log to indicate such condition that
> filesystem doesn't process a full recovery flow?

How about v2 to preserve the error which gives a warnings on roll-forward
recovery?

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/recovery.c | 2 +-
> >   fs/f2fs/super.c    | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index b3baec666afe..8bbecb5f9323 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >   	 * and the f2fs is not read only, check and fix zoned block devices'
> >   	 * write pointer consistency.
> >   	 */
> > -	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> > +	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> >   			f2fs_sb_has_blkzoned(sbi)) {
> >   		err = f2fs_fix_curseg_write_pointer(sbi);
> >   		if (!err)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2e41142d07c0..4d03ce1109ad 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >   	 * If the f2fs is not readonly and fsync data recovery succeeds,
> >   	 * check zoned block devices' write pointer consistency.
> >   	 */
> > -	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> > +	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> >   		err = f2fs_check_write_pointer(sbi);
> >   		if (err)
> >   			goto free_meta;

