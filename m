Return-Path: <linux-kernel+bounces-58050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6F84E0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5671C255A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010E74E26;
	Thu,  8 Feb 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RL5gV+Yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA171B4F;
	Thu,  8 Feb 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395114; cv=none; b=YhxItJFm0ZHl1s1sDkJQPQb4ngbaYB5jDW3DI8WIjM1G56O9kantCrUlqsJSRadobsRhI2m7Z5XkvTIcFqfuOzj4QNlEbLwj6y9Jlf1hzcxk3Xt4zJcXAW9dbWNlZCjZqYkJfdZbOKakK8dKVNyb2jBhQ01qU6AVsRVMmNtwyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395114; c=relaxed/simple;
	bh=k0auTRrxBqZyp0A1ddKh0do79j+T/zneuMFgZdMwvVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpnzVtmSiNNLxFZIR+Gr8BYdm01eA5ADmKr3C/DhzjlnD3cGJs1+tAVcDHFVz2hHrTZcKmBYeHM6uo+YusVgQSV2yrL4Uon/ToqaohdLTTba+kHKOhbBjX2BxflT7eYdz+p4I2D35XJKmBMi+LNHr8vowdCnU4SrKT7AT3W9CEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RL5gV+Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412FDC433C7;
	Thu,  8 Feb 2024 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707395113;
	bh=k0auTRrxBqZyp0A1ddKh0do79j+T/zneuMFgZdMwvVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL5gV+YkRThlSRODvgJVELiYk6P+fURNUfUXeKax0edLquUYHWFAC/8XEFYni8lJ0
	 LR+dJ3LET8EX5yHinlzGvDJco6eHlcWgiavza82b3H+gID777V/nYklMUhh3p89JYA
	 7tl4oCc60fYREMRxzx9hk6EOu3OPL2yA4WtyD600=
Date: Thu, 8 Feb 2024 12:25:10 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Message-ID: <2024020836-flypaper-relapse-5c97@gregkh>
References: <2024020812-snowbound-version-6bfa@gregkh>
 <tencent_6C6ACF8878B26D482FE56F649498E90EEF0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6C6ACF8878B26D482FE56F649498E90EEF0A@qq.com>

On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > of data to env, which will result in insufficient memory allocated to the buf
> > > members of env.
> > 
> > What is "env"?  And can you wrap your lines at 72 columns please?
> env is an instance of struct kobj_uevent_env.

Ok, be specific please in your changelog text, otherwise we can't really
understand what is happening.

> > > Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  include/linux/kobject.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > > index c30affcc43b4..74b37b6459cd 100644
> > > --- a/include/linux/kobject.h
> > > +++ b/include/linux/kobject.h
> > > @@ -30,7 +30,7 @@
> > >
> > >  #define UEVENT_HELPER_PATH_LEN		256
> > >  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> > > -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> > > +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
> > 
> > That's an odd number, why that?  Why not just a page?  What happens if
> > some other path wants more?
> An increase of 512 bytes is sufficient for the current issue. Do not consider
> the problem of hypothetical existence.

Why is this 512 bytes sufficient now?  What changed to cause this?

And how can we detect this automatically in the future?  Shouldn't we
just be truncating the buffer instead of having an overflow?

> > And what's causing the input stack to have so many variables all of a
> > sudden, what changed to cause this?  Is this a bugfix for a specific
> > commit that needs to be backported to older kernels?  Why did this
> > buffer size all of a sudden be too small?
> The result of my analysis is that several members of struct input_dev are too
> large, such as its member keybit.

And when did that change?  What commit id?  What prevents it from
growing again and us needing to change this again?

thanks,

greg k-h

