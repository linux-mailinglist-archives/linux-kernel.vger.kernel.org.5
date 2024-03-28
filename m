Return-Path: <linux-kernel+bounces-123402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7889080C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EB11C2C122
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036561327F0;
	Thu, 28 Mar 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlcDQfqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D27E101;
	Thu, 28 Mar 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649575; cv=none; b=nApEtXLVen+7sfwLuFCONrWjjDsabyb6Xwp91Q9+At+WYpACXEii+skr/BR9G/XffvDsAVeSn82eHgadZ0BdGlDRsNWp/v0/6atD9A7n4ECjDhHMlmdsTLCa+0p2PYKgdrFaJWf9RB2jzkusD7AYqiNEaxTDsroUwACt1WjLfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649575; c=relaxed/simple;
	bh=SS4ILHIMnZROum7pziPlPCiUbOz/qiP5WKjXEHTgiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJUSTaouE+2ZCkDQMpqcp5G9FiNphbi6uPOGQbr5WjoY9Y2w6e/Kg4e7qZIw3VNuXr260/hCkuBIwLfp4n/iD9L8TcxhwxfG6Hfqih0T9Hn1gYW8L8YjlKuuTKmvh5fqGgVL+kGIhERObtK58mzY947ZJ9Pey70svyfmMdlQUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlcDQfqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E010BC433F1;
	Thu, 28 Mar 2024 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649574;
	bh=SS4ILHIMnZROum7pziPlPCiUbOz/qiP5WKjXEHTgiUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlcDQfqZ65A1PqbO9Rpv9NsuDCSwigXBlSLTdMxrCHXi2LF0PfJJjwerjXHVowvrM
	 gmyXsTTIhutyl6amP962E1muMabGdc8AN9P5w6A/9icpY0AxG18rb7p0JvmYJWN4F+
	 JKXVxAQFHh3WPXxyNW9XX+zOeZqv9nxVusOvDj1gfUBu/+IudNJ+3LsHp0mhwBw79T
	 ffFKAipJuWXKzO4wZCxJv6MXEXrOr/kYKlRIFML2xdueUZlq4UDTR5rC2PavGBmZlq
	 Rub2xv3gJlGHASWvYD/kkUH36/17cSeZNDi7PyOkLnkdq6ywLuRLm1N5U6oH+dv01A
	 rSrhI1F390tow==
Date: Thu, 28 Mar 2024 18:12:50 +0000
From: Simon Horman <horms@kernel.org>
To: duoming@zju.edu.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: fix use-after-free bugs caused by
 ax25_ds_del_timer
Message-ID: <20240328181250.GI651713@kernel.org>
References: <20240326142542.118058-1-duoming@zju.edu.cn>
 <20240327191025.GU403975@kernel.org>
 <7192041a.9d52.18e838dbf1b.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7192041a.9d52.18e838dbf1b.Coremail.duoming@zju.edu.cn>

On Thu, Mar 28, 2024 at 01:34:48PM +0800, duoming@zju.edu.cn wrote:
> On Wed, 27 Mar 2024 19:10:25 +0000 Simon Horman wrote:
> > > When the ax25 device is detaching, the ax25_dev_device_down()
> > > calls ax25_ds_del_timer() to cleanup the slave_timer. When
> > > the timer handler is running, the ax25_ds_del_timer() that
> > > calls del_timer() in it will return directly. As a result,
> > > the use-after-free bugs could happen, one of the scenarios
> > > is shown below:
> > > 
> > >       (Thread 1)          |      (Thread 2)
> > >                           | ax25_ds_timeout()
> > > ax25_dev_device_down()    |
> > >   ax25_ds_del_timer()     |
> > >     del_timer()           |
> > >   ax25_dev_put() //FREE   |
> > >                           |  ax25_dev-> //USE
> > > 
> > > In order to mitigate bugs, when the device is detaching, use
> > > timer_shutdown_sync() to stop the timer.
> > 
> > FWIIW, in my reading of things there is another failure mode whereby
> > ax25_ds_timeout may rearm the timer after the call to del_timer() but
> > before the call to ax25_dev_put().
> 
> I think using timer_shutdown_sync() or del_timer_sync() to replace del_timer()
> could prevent the rearm.

I think only timer_shutdown() and timer_shutdown_sync() will prevent a
rearm. But I also think (but am not entirely sure) this is only important
in the ax25_dev_device_down() case (there are others, as you mention
below).

> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > ---
> > >  net/ax25/ax25_ds_timer.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> > > index c4f8adbf814..5624c0d174c 100644
> > > --- a/net/ax25/ax25_ds_timer.c
> > > +++ b/net/ax25/ax25_ds_timer.c
> > > @@ -43,7 +43,12 @@ void ax25_ds_setup_timer(ax25_dev *ax25_dev)
> > >  
> > >  void ax25_ds_del_timer(ax25_dev *ax25_dev)
> > >  {
> > > -	if (ax25_dev)
> > > +	if (!ax25_dev)
> > > +		return;
> > > +
> > > +	if (!ax25_dev->device_up)
> > > +		timer_shutdown_sync(&ax25_dev->dama.slave_timer);
> > > +	else
> > >  		del_timer(&ax25_dev->dama.slave_timer);
> > >  }
> > 
> > I think that a) it is always correct to call timer_shutdown_sync,
> > and b) ax25_dev->device_up is always true. So a call to
> > timer_shutdown_sync can simply replace the call to del_timer.
> 
> I think timer_shutdown*() is used for the code path to clean up the
> driver or detach the device. If timer is shut down by timer_shutdown*(),
> it could not be re-armed again unless we reinitialize the timer. The
> slave_timer should only be shut down when the ax25 device is detaching or
> the driver is removing. And it should not be shut down in other scenarios,
> such as called in ax25_ds_state2_machine() or ax25_ds_state3_machine().
> So I think calling timer_shutdown_sync() is not always correct.
> 
> What's more, the ax25_dev->device_up is not always true. It is set to
> false in ax25_kill_by_device().
> 
> In a word, the timer_shutdown_sync() could not replace the del_timer()
> completely.

Yes, sorry. I missed that ax25_ds_del_timer() is not
only called from ax25_dev_device_down().

> > Also, not strictly related, I think ax25_dev cannot be NULL,
> > so that check could be dropped. But perhaps that is better left alone.
> 
> The ax25_dev cannot not be NULL, because we only use ax25_dev_put() to
> free the ax25_dev instead of setting is to NULL. So I think the check
> could be dropped.
> 
> Do you think the following plan is proper?
> 
> diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> index c4f8adbf8144..f1cab4effa44 100644
> --- a/net/ax25/ax25_ds_timer.c
> +++ b/net/ax25/ax25_ds_timer.c
> @@ -43,8 +43,7 @@ void ax25_ds_setup_timer(ax25_dev *ax25_dev)
> 
>  void ax25_ds_del_timer(ax25_dev *ax25_dev)
>  {
> -       if (ax25_dev)
> -               del_timer(&ax25_dev->dama.slave_timer);
> +       del_timer_sync(&ax25_dev->dama.slave_timer);
>  }
> 
> There is no deadlock will happen.

I'm actually getting to think that your original patch was correct.
But perhaps a different approach would be to simply call
timer_shutdown_sync() in ax25_dev_device_down(). And leave
ax25_ds_del_timer() alone.

> 
> > Zooming out a bit, has removal of ax25 been considered.
> > I didn't check the logs thoroughly, but I'm not convinced it's been
> > maintained - other than clean-ups and by-inspection bug fixes - since git
> > history began.
> 
> Best regards,
> Duoming Zhou

