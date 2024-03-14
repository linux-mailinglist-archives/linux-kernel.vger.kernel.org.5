Return-Path: <linux-kernel+bounces-103111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47887BB28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAB9B23371
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151106EB49;
	Thu, 14 Mar 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hn8Ssc0k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTlw/6Zs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BD6BFAC;
	Thu, 14 Mar 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411639; cv=none; b=IMrmVV1ngbVvrlRtaaU96mfK8VDHLxcc8IxXsve3a9wZYGQ1QO85InBIo1q2d1VdLYUU+CsmcWWIg/FHsmOx9OtO0PlW7sgH1wq/J8D8cl7e5UTlf8Z6dJ/mRcF065U4IJHn7Z9Urx6neMpVHCQtYJlxCVuCyYW/afA7dqs2MN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411639; c=relaxed/simple;
	bh=82h2+iV8XEivGIcdU7fx2Zr3EONorrMCWp43nILiMs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gD25wOnjPFGrEjxTJZ6ojdZMJ0X7gVWVeVxlavLKIO9u/BKT/GR3RyqIaeW2lUJLcLmB7TBk/DuCCJBt3cHEfqkrh8jvB9yum16Y5Cwj1QqugeXVb4s11V/w2sfm/b1HDghqjwXpoy7j05OgAO8taQPHLPlCE2H/B+4C0TTztOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hn8Ssc0k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTlw/6Zs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710411635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BXmd1smb+1tQUSUN5Krj3Ey1bflfCa1N+wP3Jumbn2E=;
	b=hn8Ssc0k+eh0KolOc/wmr+q4lV5wTdlJ3Xek93r4teQW7VWYCY04nA2sj2/8BSfzfrS391
	6XQrINZsiAquijkpKCMCbVTK42BRrPyL2u0bJqdmU3eI5cIHwPs38j1CIutv05SMQkLHJz
	LDcA2PqoabQ6Xv7FHdIQWJYhT4sllcybadTMDonOYZ/83mlNgPrpLzGV2V05oUtzMW79MX
	jtXjo8CzqlEfloPxf4Hq3RJKxU8vFlkq+oQ+k3OncQESvs8x7+xmWeawQZzZcpllr5r0Qo
	tkwQ74pfDYur7XU6pc56Aor87NSrdY2ajm3ApmZyeeMYApjHO5iu8jLWiv5c+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710411635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BXmd1smb+1tQUSUN5Krj3Ey1bflfCa1N+wP3Jumbn2E=;
	b=dTlw/6ZsGM11mKS4bdM5Tgz3NTKNWgJRaOm82bPrYO/VhsDz2Z0LQ8Gc2GMo+aRcYswG3t
	SZsDEn15Txp3APCw==
To: Z qiang <qiang.zhang1211@gmail.com>, =?utf-8?B?5p+z6I+B5bOw?=
 <liujingfeng@qianxin.com>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "secalert@redhat.com" <secalert@redhat.com>
Subject: Re: memory leak in posix_clock_open
In-Reply-To: <CALm+0cW8HutqzcrfxysLWoOVyzh70RT3G0gaALRbnS=8Lw2f=g@mail.gmail.com>
References: <ef6a91ac20d8441bad9956c15caaafef@qianxin.com>
 <CALm+0cW8HutqzcrfxysLWoOVyzh70RT3G0gaALRbnS=8Lw2f=g@mail.gmail.com>
Date: Thu, 14 Mar 2024 11:20:35 +0100
Message-ID: <87frwtm7ws.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 17:46, Z qiang wrote:
>
> diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
> index 9de66bbbb3d1..71d9d8c394fa 100644
> --- a/kernel/time/posix-clock.c
> +++ b/kernel/time/posix-clock.c
> @@ -137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,
> struct file *fp)
>
>         if (!err) {
>                 get_device(clk->dev);
> +       } else {
> +               kfree(pccontext);
>         }
>  out:
>         up_read(&clk->rwsem);

Looks about right. Can you please send a proper patch?

