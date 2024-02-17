Return-Path: <linux-kernel+bounces-69955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E58590C3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EDD1C20D5D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49237CF26;
	Sat, 17 Feb 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMR++vwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8017CF0C;
	Sat, 17 Feb 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185840; cv=none; b=Ghou7+at6vXgfdwcyq534stna8cpv/oD6LmHktCV1VF7PauqHyLAGB652UswFJg2Yxy0QxMrcG7a4VrSS+AJ+8f9vltaVZ2X1oSyvnzKRSRsrj8MusBEvIiy/ma6q1oHKJEEvabjp9DiLKp8hxh0R2cTG0CAZQkLdtJ+NiC4B98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185840; c=relaxed/simple;
	bh=idhzi+lvLrvt3lT5g616HW/iowk9PphKg3c1Aoged8A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfkjB/ugwdnnUZRGcnxj4alhhxMG8kAosGuwrc+L7IH9n7KCckMABJtFV5F/upeoz6oPz+esXrRYzV2usekBzLWSg9RjRbhLmALIWkDaUezzXk6tbmWFjxKZ7PrEgFtKsc794z9+ONCV9RhUq/9VYOyLa1RChX4OhmgMydp1r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMR++vwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0F2C433F1;
	Sat, 17 Feb 2024 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708185839;
	bh=idhzi+lvLrvt3lT5g616HW/iowk9PphKg3c1Aoged8A=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=FMR++vwpuRjhvzYouPZTQJ5KJWYM0TwTC0nb755B+G+bwYdxWlLbaHIQV7JBpg2YR
	 0a0zzXDV1+lxeYkN2o0N3gH0PValQXED+2/3OgWugYQ1hNbj9ECvghpQOL7Tp3yWzP
	 QURJGJM+rh62m29co0urevEKR1ZiCd0qboOUSQiA=
Date: Sat, 17 Feb 2024 17:03:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-usb@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into
 unattached state after try role"
Message-ID: <2024021724-festivity-divisible-0b32@gregkh>
References: <20240215193352.1026707-1-megi@xff.cz>
 <2024021739-self-pencil-b932@gregkh>
 <ratkc4fo3mqwuzsbxsiwq54jclnarnjl3x7ts64elx6hguvbay@ihelujsnzd6i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ratkc4fo3mqwuzsbxsiwq54jclnarnjl3x7ts64elx6hguvbay@ihelujsnzd6i>

On Sat, Feb 17, 2024 at 04:40:21PM +0100, Ondřej Jirman wrote:
> On Sat, Feb 17, 2024 at 04:32:54PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 15, 2024 at 08:33:50PM +0100, Ondřej Jirman wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > > 
> > > The reverted commit makes the state machine only ever go from SRC_ATTACH_WAIT
> > > to SNK_TRY in endless loop when toggling. After revert it goes to SRC_ATTACHED
> > > after initially trying SNK_TRY earlier, as it should for toggling to ever detect
> > > the power source mode and the port is again able to provide power to attached
> > > power sinks.
> > > 
> > > This reverts commit 2d6d80127006ae3da26b1f21a65eccf957f2d1e5.
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > See https://lore.kernel.org/all/odggrbbgjpardze76qiv57mw6tllisyu5sbrta37iadjzwamcv@qr3ubwnlzqqt/
> > > for more.
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index f7d7daa60c8d..295ae7eb912c 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -3743,9 +3743,6 @@ static void tcpm_detach(struct tcpm_port *port)
> > >  	if (tcpm_port_is_disconnected(port))
> > >  		port->hard_reset_count = 0;
> > >  
> > > -	port->try_src_count = 0;
> > > -	port->try_snk_count = 0;
> > > -
> > >  	if (!port->attached)
> > >  		return;
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - Your patch does not have a Signed-off-by: line.  Please read the
> >   kernel file, Documentation/process/submitting-patches.rst and resend
> >   it after adding that line.  Note, the line needs to be in the body of
> >   the email, before the patch, not at the bottom of the patch or in the
> >   email signature.
> > 
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> 
> It's a mechanically generated revert of upstream patch. It has no authorship.
> I did not write it, machine did. :)
> 
> But I can add a sign off for the commit message I made:
> 
> Signed-of-by: Ondrej Jirman <megi@xff.cz>

You have to do so.

And you need a Fixes: and cc: stable tag too, right?

Please fix up and send a v2 properly.

thanks,

greg k-h

