Return-Path: <linux-kernel+bounces-137310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1A89E03C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447861C2241A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D313E05D;
	Tue,  9 Apr 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx/6Um3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B613137C2A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679721; cv=none; b=sjvPIYty492or4TLT0inupCIeEUynX5eJmcXBe6OEWLrK8K5T921ti46ksb8tGD7A2ks8cjrZYr3HeGbfv1G5Ey5gAITW1Tvug1x5JMJMANgbU1/AgYCFG8kD9SVI11dDREVvOOTegj7ccfsE/JkVEmtC3yQHo15U8TiHz9jgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679721; c=relaxed/simple;
	bh=j25mVSV7JaOAYPymcWENzF72xWe8UKWzEPPYmINrrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpPKBUj9zMNbr8JUno1ONSW0eCjTiH0GVZb/bVjCYR/srhWWMBqAkVahodmADb/6X1j47kp4puRzcbNge0Fc93RhpoWaS1aX+0CRHRkUZ2scA/9Ynu71QQ5jRGZ5XEMvb83Z/5BHBjkH0R8xUZx4R5jWs0nXZzfG6HnuvxAKdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx/6Um3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850D5C433F1;
	Tue,  9 Apr 2024 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679720;
	bh=j25mVSV7JaOAYPymcWENzF72xWe8UKWzEPPYmINrrTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx/6Um3GCGFEJdmkNmAM/2vbAgjap7/1jyuTvs2ybQfzvNzcP1cbp1FYKlGohexhA
	 jLypVhSW1clknwS0KoF/IoOboJEuL3xKLqvN0XLZuEJQSk8d1p4GRGE73iGBYTD555
	 l82nSAcpJYVI+QVIlQzGkEE2vXbKHdyLG+LfO1kEdm+LfbQdupLWktkiJsrqzE0VFO
	 sOGIcQeBbP3KaOjpyJ8IQSbBJ5peFVieuXS8FurIOfNkUV8EGm82yqfmwYyiYoz3VT
	 6WZwEIZlL6+JHqfC7ruGoHVkPA0mus8C/Wa9IQ7iOF84uz7LHmyW0e2JH2n7C/7eNd
	 IiT7mahfgIgLg==
Date: Tue, 9 Apr 2024 16:21:58 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't set RO when shutting down f2fs
Message-ID: <ZhVrJh3rackEiIfL@google.com>
References: <20240404195254.556896-1-jaegeuk@kernel.org>
 <2c195fee-c71c-4e44-b24f-9880b3c1b6c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c195fee-c71c-4e44-b24f-9880b3c1b6c4@kernel.org>

On 04/09, Chao Yu wrote:
> On 2024/4/5 3:52, Jaegeuk Kim wrote:
> > Shutdown does not check the error of thaw_super due to readonly, which
> > causes a deadlock like below.
> > 
> > f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
> >   - bdev_freeze
> >    - freeze_super
> >   - f2fs_stop_checkpoint()
> >    - f2fs_handle_critical_error                     - sb_start_write
> >      - set RO                                         - waiting
> >   - bdev_thaw
> >    - thaw_super_locked
> >      - return -EINVAL, if sb_rdonly()
> >   - f2fs_stop_discard_thread
> >    -> wait for kthread_stop(discard_thread);
> > 
> > Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/super.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index df9765b41dac..ba6288e870c5 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4135,9 +4135,16 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
> >   	if (shutdown)
> >   		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> > -	/* continue filesystem operators if errors=continue */
> > -	if (continue_fs || f2fs_readonly(sb))
> > +	/*
> > +	 * Continue filesystem operators if errors=continue. Should not set
> > +	 * RO by shutdown, since RO bypasses thaw_super which can hang the
> > +	 * system.
> > +	 */
> > +	if (continue_fs || f2fs_readonly(sb) ||
> > +				reason == STOP_CP_REASON_SHUTDOWN) {
> > +		f2fs_warn(sbi, "Stopped filesystem due to readon: %d", reason);
> >   		return;
> 
> Do we need to set RO after bdev_thaw() in f2fs_do_shutdown()?

IIRC, shutdown doesn't need to set RO as we stopped the checkpoint.
I'm more concerned on any side effect caused by this RO change.

> 
> Thanks,
> 
> > +	}
> >   	f2fs_warn(sbi, "Remounting filesystem read-only");
> >   	/*

