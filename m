Return-Path: <linux-kernel+bounces-132065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D497A898F47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1252A1C25133
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A02134733;
	Thu,  4 Apr 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr/AKpWw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E41130A77
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260544; cv=none; b=mDcEukZjRDL6CifKSryf+cWt5EAkt2J8DWOWwOF1n0v8zLxnWpNqC99yAO4iRdlcNdr+nXHj73qe2YFOX20tNG2MRziQdwPv8pSRmhx20Rc9ExMy2/rFsWpRi+ZrY/snP3q9lzr5D7DmKgbWZUgi5H7ds3qXHd9T27uSvo5wPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260544; c=relaxed/simple;
	bh=EpILh+wb4KCEI3yEhXzuXtGDiLSGEDMU1ojOng1rrks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhguYJmcmy49ZTabovBg3i+kp5GTARQ+gWrNOxqiwimYqhTDT5VwJqcYDNv19ovZ+zebjCL9IcUaTEZh6m38P3gaYd5uRZTfVh3w5hvSySUZ/HtgJLu/FMwB/r9fqpoN2DQBzOYskQr1/pbQtI6wwmAPyq9UBrZKuFGJnglGZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr/AKpWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0600BC433F1;
	Thu,  4 Apr 2024 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712260544;
	bh=EpILh+wb4KCEI3yEhXzuXtGDiLSGEDMU1ojOng1rrks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr/AKpWwpMNMG2eBSfzUc5T11uNTSkOUuUP7xwsV78y4+DgBKF+Or8iPbyYWJAGSt
	 9y75mzD3jPQTGeWgX88sHDcfifz66ixCQC0JgpBc7CZ2fB4VD4Z4HcMR3fYQVofABl
	 28wNvA1B0vMrbNQJyGxQCJ6RStbZCjskxxOPrUwza+V62wnqsj1hel8tI/GjdKQ1rQ
	 5+i93e1HCqXFFf+9MHONUqkYlVWotmypVZonEO+B5+I9KRtfxYilne/Z3ilAD7k7hD
	 xtsfXowoxPfdM739dGjnUfpzkL7z2bLkmgGDSZqga05yFdped1aCeQTLNENrGkpJh6
	 hbBxtgiyBrBvw==
Date: Thu, 4 Apr 2024 19:55:42 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Hillf Danton <hdanton@sina.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H=5D?= f2fs:
 avoid the deadlock case when stopping discard thread
Message-ID: <Zg8Fvu1X_4uqQl9A@google.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com>
 <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zf4FIAkI83GbQYLB@google.com>
 <ZgL9NLLiSdDeIMg_@google.com>
 <SI2PR03MB526041E42B6BD9C9DA9FBAC184352@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <SI2PR03MB5260819B5B1719063EFF458A843D2@SI2PR03MB5260.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR03MB5260819B5B1719063EFF458A843D2@SI2PR03MB5260.apcprd03.prod.outlook.com>

On 04/03, Light Hsieh (謝明燈) wrote:
> Our log shows that thaw_super_locked() find that sb is readonly, so sb_freeze_unlock() is not invoked.
> 
> static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
> {
>       ...
>       if (sb_rdonly(sb)) {
>             sb->s_writers.freeze_holders &= ~who;
>             sb->s_writers.frozen = SB_UNFROZEN;
>             wake_up_var(&sb->s_writers.frozen);
>             goto out;
>       }
>                ...
>       sb_freeze_unlock(sb, SB_FREEZE_FS);
> out:
>       deactivate_locked_super(sb);
>       return 0;
> }

Thank you. Could you please take a look at this patch?

https://lore.kernel.org/linux-f2fs-devel/20240404195254.556896-1-jaegeuk@kernel.org/T/#u

> 
> 寄件者: Jaegeuk Kim <jaegeuk@kernel.org>
> 寄件日期: 2024年3月27日 上午 12:52
> 收件者: Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>
> 副本: Hillf Danton <hdanton@sina.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-f2fs-devel@lists.sourceforge.net <linux-f2fs-devel@lists.sourceforge.net>
> 主旨: Re: 回覆: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
>  
> 
> External email : Please do not click links or open attachments until you have verified the sender or the content.
> On 03/22, Jaegeuk Kim wrote:
> > On 03/22, Light Hsieh (謝明燈) wrote:
> > > I don't see my added log in sb_free_unlock() which will invoke percpu_up_write to release the write semaphore.
> > 
> > May I ask more details whether thaw_super() was called or not?
> 
> Ping?
> 
> > 
> > > 
> > > 
> > > ________________________________
> > > 寄件者: Jaegeuk Kim <jaegeuk@kernel.org>
> > > 寄件日期: 2024年3月22日 上午 08:29
> > > 收件者: Hillf Danton <hdanton@sina.com>
> > > 副本: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>; linux-f2fs-devel@lists.sourceforge.net <linux-f2fs-devel@lists.sourceforge.net>
> > > 主旨: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
> > > 
> > > 
> > > External email : Please do not click links or open attachments until you have verified the sender or the content.
> > > 
> > > On 03/22, Hillf Danton wrote:
> > > > On Tue, 19 Mar 2024 17:14:42 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> > > > >  - mnt_want_write_file()
> > > > >    - sb_start_write(SB_FREEZE_WRITE)
> > > >  __sb_start_write()
> > > >    percpu_down_read()
> > > > >                                              - sb_start_intwrite(SB_FREEZE_FS);
> > > >    __sb_start_write()
> > > >      percpu_down_read()
> > > >
> > > > Given lock acquirers for read on both sides, wtf deadlock are you fixing?
> > > 
> > > Damn. I couldn't think _write uses _read sem.
> > > 
> > > >
> > > > >  - f2fs_stop_checkpoint(sbi, false,            : waiting
> > > > >     STOP_CP_REASON_SHUTDOWN);
> > > > >  - f2fs_stop_discard_thread(sbi);
> > > > >    - kthread_stop()
> > > > >      : waiting
> > > > >
> > > > >  - mnt_drop_write_file(filp);
> > > >
> > > > More important, feel free to add in spin.
> > > 
> > > I posted this patch before Light reported.
> > > 
> > > And, in the report, I didn't get this:
> > > 
> > > f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().
> > > 
> > > because f2fs_ioc_shutdown() calls f2fs_stop_discard_thread() after thaw_bdev()
> > > like this order.
> > > 
> > >  -> freeze_bdev()
> > >  -> thaw_bdev()
> > >  -> f2fs_stop_discard_thread()
> > > 
> > > Am I missing something?
> > > 
> > > >
> > > > Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> > > 

