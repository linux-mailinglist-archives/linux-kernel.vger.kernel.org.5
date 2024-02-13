Return-Path: <linux-kernel+bounces-63037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5185299F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49EA1F24CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9817562;
	Tue, 13 Feb 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCtJFE6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C806AD6;
	Tue, 13 Feb 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808856; cv=none; b=dJSgXvm3VdJemJ33Kxsh66D/0kKerRKKDOm2iz7o064TxG1eifD7GVzisiIorSoiHbv8tBH1nn/BDSW5UPyXs1zqoTsZvtWKyDwuCU5oW8aSvMmLUYcactLzl5C8kaHEG1spxbVu3O7PjBp9rv+WJwkXsdv/twuxGeAbV4zcMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808856; c=relaxed/simple;
	bh=I5/rXdcTUUyXEyrSQOUtTC1H1Xv29zk2GLcUmcp5FbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmEzf/SLuT/3y3M6/qGH2vN8imTlDq6LCBpUV7mq/4zRI5cAaP1xu6cZtNoiKCqjE45A7rAhHtKLOGTDG0NCzQHI9U6xR3A6jM10Q12nZ+ibuKviE8EMlsyQumFX0gF1TcQoHzV2vmC5VwakPBuPdaOm3DhEkEgc3UhlFHUslrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCtJFE6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F94C433F1;
	Tue, 13 Feb 2024 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707808856;
	bh=I5/rXdcTUUyXEyrSQOUtTC1H1Xv29zk2GLcUmcp5FbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCtJFE6lQWGjAn9TWrFAy0reZmo13YUQeRBm5+3hg7yNB6oIqBcRdHcJhbA9QDgVw
	 /dBMV+CWTTPflBx4a9JkWaT7pCWX5LBtCGaNcthD1dL6ddFIeQGSHavHgRYgdq+GVE
	 T+wL1D21OlJ3/gPOLEkiOIE25vBDtMGtUV3FvK5E=
Date: Tue, 13 Feb 2024 08:20:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Message-ID: <2024021316-nuclei-botany-5446@gregkh>
References: <2024020836-flypaper-relapse-5c97@gregkh>
 <tencent_DDCFB377C3642974A3A3A44D176B776DA605@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_DDCFB377C3642974A3A3A44D176B776DA605@qq.com>

On Tue, Feb 13, 2024 at 08:43:26AM +0800, Edward Adam Davis wrote:
> On Thu, 8 Feb 2024 12:25:10 +0000, Greg KH wrote:
> > On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > > members of env.
> > > >
> > > > What is "env"?  And can you wrap your lines at 72 columns please?
> > > env is an instance of struct kobj_uevent_env.
> > 
> > Ok, be specific please in your changelog text, otherwise we can't really
> > understand what is happening.
> > 
> > > > > Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > ---
> > > > >  include/linux/kobject.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > > > > index c30affcc43b4..74b37b6459cd 100644
> > > > > --- a/include/linux/kobject.h
> > > > > +++ b/include/linux/kobject.h
> > > > > @@ -30,7 +30,7 @@
> > > > >
> > > > >  #define UEVENT_HELPER_PATH_LEN		256
> > > > >  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> > > > > -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> > > > > +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
> > > >
> > > > That's an odd number, why that?  Why not just a page?  What happens if
> > > > some other path wants more?
> > > An increase of 512 bytes is sufficient for the current issue. Do not consider
> > > the problem of hypothetical existence.
> > 
> > Why is this 512 bytes sufficient now?  What changed to cause this?
> There is the following code in input_print_modalias():
> 
> drivers/input/input.c
>    1         len += input_print_modalias_bits(buf + len, size - len,
> 1403                                 'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
> This code will add up to 2608 bytes of data to env at most.
> (KEY_MAX - KEY_MIN_INTERESTING) * 4 = (256 * 3 - 1 - 113 ) * 4 = (765 - 113) * 4 = 652 * 4 = 2608 bytes。
> Note: In the expression, 4 represents 3 bytes of hexadecimal data and 1 byte of comma.

So your change above is wrong and will not work for the max size?

Why not restrict the modalias here to fit instead of overflowing?  Odds
are we should be checking this properly no matter what the value is
changed to, right?

> include/uapi/linux/input-event-codes.h
> 188 #define KEY_MUTE                113
> 807 #define KEY_MIN_INTERESTING     KEY_MUTE
> 808 #define KEY_MAX                 0x2ff
> During my actual testing process, I found that a total of 1684 bytes were
> contributed in input_print_modalias().
> > 
> > And how can we detect this automatically in the future?  Shouldn't we
> > just be truncating the buffer instead of having an overflow?
> > 
> > > > And what's causing the input stack to have so many variables all of a
> > > > sudden, what changed to cause this?  Is this a bugfix for a specific
> > > > commit that needs to be backported to older kernels?  Why did this
> > > > buffer size all of a sudden be too small?
> > > The result of my analysis is that several members of struct input_dev are too
> > > large, such as its member keybit.
> > 
> > And when did that change?  What commit id?  What prevents it from
> > growing again and us needing to change this again?
> The code that caused this issue has been introduced for a long time, and it is
> speculated that it was due to the fact that the warning in add_uevent_var() was
> returned directly to ENOMEM without being taken seriously.
> 
> lib/kobject_uevent.c
>   2         if (len >= (sizeof(env->buf) - env->buflen)) { 
>   1                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
> 672                 return -ENOMEM;                                                                                                                                                                        

Odd line numbers?

Anyway, we should get rid of the WARN() as that will cause crashes, and
just handle it properly there.


>   1         }
> 
> I believe that this issue was introduced by:
> 7eff2e7a8b65 - Driver core: change add_ueventvar to use a struct.

In 2007?  And never been actually hit since then?  So is this a real
issue? :)

thanks,

greg k-h

