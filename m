Return-Path: <linux-kernel+bounces-119513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1788C9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A241F81089
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA251BC41;
	Tue, 26 Mar 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0DTX3Of"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D55611E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471926; cv=none; b=nTsIYQp8VRWmo72hXTW6SpEoYhVZSACA8uwnTASUPG6wS8wBjjJHCsC+/+Tx9W04rhdloSbxETUu86AwTcTkH0Z7BDChqG2xSfo4JdHWElxkooCTx79nhwHcrjHsDeSi8WV5cApBV0cF+hJv0345GobWHc7nF1xs4bjQWk34cfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471926; c=relaxed/simple;
	bh=VGvzPDcwbNrB7wKDzQn4uUId9Ig5vPtwkz+8ZQqrXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjk+vS6vbZAQe4tAAjuIEm3EJ6+ZMaV2X44+FZI9+M3liX05SRJ8yJtDIYPzVxXbMPReEY4vpKjlF60mpaspC4UHJ+G5fPz/6YlHbbV+pLA5mLjYsG1nr00c+aPE6b1RvYgkSmlC9y9yho8D5G9R/DPIHl+ROhvWEtlQ0TX3DjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0DTX3Of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63ACC433C7;
	Tue, 26 Mar 2024 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471925;
	bh=VGvzPDcwbNrB7wKDzQn4uUId9Ig5vPtwkz+8ZQqrXYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0DTX3OfeIm6YD6OdHw6XMb8uCR9Z76AcPa8PWbQnad9qf6RLepfxF5YX3K7SAAdp
	 VKZ2d8+V8DBmfmlItdFCTflf0a8NYFgs3S8RAC5KvB11pQu6aue3IWw9v7pHGUFWgh
	 5ggMKUhHt7sdv1j3FgdmPpfdVqlrtnpFk9egkskBzHkJoaT2zsMkICjzSe0czmW4k5
	 EMGJCFKKg6KeDtAlw6ejWsCyDbLDkML0y0gLc0THsloZKj65kMw8h6DgDyuBo8Fxv3
	 tRbb/xR9unKwIEfyHn8lzHIjvQoexEDLMyTpGY9AILPOz+PHBWqdD0WmxxQKu1KbDN
	 oeu/NE0C0lh9Q==
Date: Tue, 26 Mar 2024 16:52:04 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Hillf Danton <hdanton@sina.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= f2fs: avoid the
 deadlock case when stopping discard thread
Message-ID: <ZgL9NLLiSdDeIMg_@google.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com>
 <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zf4FIAkI83GbQYLB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf4FIAkI83GbQYLB@google.com>

On 03/22, Jaegeuk Kim wrote:
> On 03/22, Light Hsieh (謝明燈) wrote:
> > I don't see my added log in sb_free_unlock() which will invoke percpu_up_write to release the write semaphore.
> 
> May I ask more details whether thaw_super() was called or not?

Ping?

> 
> > 
> > 
> > ________________________________
> > 寄件者: Jaegeuk Kim <jaegeuk@kernel.org>
> > 寄件日期: 2024年3月22日 上午 08:29
> > 收件者: Hillf Danton <hdanton@sina.com>
> > 副本: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>; linux-f2fs-devel@lists.sourceforge.net <linux-f2fs-devel@lists.sourceforge.net>
> > 主旨: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
> > 
> > 
> > External email : Please do not click links or open attachments until you have verified the sender or the content.
> > 
> > On 03/22, Hillf Danton wrote:
> > > On Tue, 19 Mar 2024 17:14:42 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> > > > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> > > >  - mnt_want_write_file()
> > > >    - sb_start_write(SB_FREEZE_WRITE)
> > >  __sb_start_write()
> > >    percpu_down_read()
> > > >                                              - sb_start_intwrite(SB_FREEZE_FS);
> > >    __sb_start_write()
> > >      percpu_down_read()
> > >
> > > Given lock acquirers for read on both sides, wtf deadlock are you fixing?
> > 
> > Damn. I couldn't think _write uses _read sem.
> > 
> > >
> > > >  - f2fs_stop_checkpoint(sbi, false,            : waiting
> > > >     STOP_CP_REASON_SHUTDOWN);
> > > >  - f2fs_stop_discard_thread(sbi);
> > > >    - kthread_stop()
> > > >      : waiting
> > > >
> > > >  - mnt_drop_write_file(filp);
> > >
> > > More important, feel free to add in spin.
> > 
> > I posted this patch before Light reported.
> > 
> > And, in the report, I didn't get this:
> > 
> > f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().
> > 
> > because f2fs_ioc_shutdown() calls f2fs_stop_discard_thread() after thaw_bdev()
> > like this order.
> > 
> >  -> freeze_bdev()
> >  -> thaw_bdev()
> >  -> f2fs_stop_discard_thread()
> > 
> > Am I missing something?
> > 
> > >
> > > Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> > 

