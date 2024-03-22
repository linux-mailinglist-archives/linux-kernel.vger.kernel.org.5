Return-Path: <linux-kernel+bounces-112066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700918874CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19CC1C22873
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615881740;
	Fri, 22 Mar 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGcJ4Yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C37627FC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146275; cv=none; b=fqM0aweNW8dcKc69t1vjqKYRL7L1t09bP1IaeGuJ2hXD44XawXryQO/CNKyXXMQG3lA6+wj1p//6HdWRrtYuHg5Py2pm2hvPb5UOtdyKqfBGOJ+PSi9Sk7KWKWKoUdmIna9y3WHAwUflG7H0AaB5SnmwsLMkuHv+euyASPwlLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146275; c=relaxed/simple;
	bh=u9hLQq6AbccTuvOfTFuQN65uvQDoNtfDPvG6xM7TeA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3TjC6+iX4I6nQSAj+lx8cZ77GnoIRILA07HmfZ9AcUKjA2rnZ0/kj0LzGgcKGW54J92yu6EOM3yPneM+Y7qwnanaItnA2QfA3hSszhFC2vnNs5pOPsL3a5gZuqgUynBUy5j2Tt1/NJSPtnO3imrgFacOywI9OattGb4nkf1Kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THGcJ4Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C51C433F1;
	Fri, 22 Mar 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711146274;
	bh=u9hLQq6AbccTuvOfTFuQN65uvQDoNtfDPvG6xM7TeA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THGcJ4YzFy+bIbZ5yw6EferzhNPNLNAFaPtsewBMPNNW+5dyCef7pSpzLtVSH1KFQ
	 NxIkOcDhIhDOck+jrsDOzlf0tO1vDyN1grFlvCVLZo5gaNR6U1F7YRF51w/1CQL9BC
	 TYhaFcARm1WIhHQp1XgJEkdR/MwaQp/I++cR6O895VhE8YVxViT/bK0IOIX8ThpMVU
	 LEwinwAeVZerafNzdxgTCP49aJca7dmC5vqNULFc3p5eI9IonrJh/WzVHckBvPsqrV
	 TZlfvZRTornG7hn3WTCbEyRYjhlZZNxg0ePBqY8hd1wNMAyG/sKqUDClekThul1Q5k
	 lw3revJJdR8KQ==
Date: Fri, 22 Mar 2024 22:24:32 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Hillf Danton <hdanton@sina.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= f2fs: avoid the
 deadlock case when stopping discard thread
Message-ID: <Zf4FIAkI83GbQYLB@google.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com>
 <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>

On 03/22, Light Hsieh (謝明燈) wrote:
> I don't see my added log in sb_free_unlock() which will invoke percpu_up_write to release the write semaphore.

May I ask more details whether thaw_super() was called or not?

> 
> 
> ________________________________
> 寄件者: Jaegeuk Kim <jaegeuk@kernel.org>
> 寄件日期: 2024年3月22日 上午 08:29
> 收件者: Hillf Danton <hdanton@sina.com>
> 副本: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>; linux-f2fs-devel@lists.sourceforge.net <linux-f2fs-devel@lists.sourceforge.net>
> 主旨: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
> 
> 
> External email : Please do not click links or open attachments until you have verified the sender or the content.
> 
> On 03/22, Hillf Danton wrote:
> > On Tue, 19 Mar 2024 17:14:42 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> > > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> > >  - mnt_want_write_file()
> > >    - sb_start_write(SB_FREEZE_WRITE)
> >  __sb_start_write()
> >    percpu_down_read()
> > >                                              - sb_start_intwrite(SB_FREEZE_FS);
> >    __sb_start_write()
> >      percpu_down_read()
> >
> > Given lock acquirers for read on both sides, wtf deadlock are you fixing?
> 
> Damn. I couldn't think _write uses _read sem.
> 
> >
> > >  - f2fs_stop_checkpoint(sbi, false,            : waiting
> > >     STOP_CP_REASON_SHUTDOWN);
> > >  - f2fs_stop_discard_thread(sbi);
> > >    - kthread_stop()
> > >      : waiting
> > >
> > >  - mnt_drop_write_file(filp);
> >
> > More important, feel free to add in spin.
> 
> I posted this patch before Light reported.
> 
> And, in the report, I didn't get this:
> 
> f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().
> 
> because f2fs_ioc_shutdown() calls f2fs_stop_discard_thread() after thaw_bdev()
> like this order.
> 
>  -> freeze_bdev()
>  -> thaw_bdev()
>  -> f2fs_stop_discard_thread()
> 
> Am I missing something?
> 
> >
> > Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> 

