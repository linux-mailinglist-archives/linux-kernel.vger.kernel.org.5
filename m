Return-Path: <linux-kernel+bounces-140425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4F8A1446
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347011C220CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E914C5B5;
	Thu, 11 Apr 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRHdTpHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46714C5B8;
	Thu, 11 Apr 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837915; cv=none; b=nvoFCQ+gKP1MuPMRhNAHfjuuW5aoGtKc77dVIfvxehBuGgYp0bWKrfxFn5E33Dkec8UPk35j3cP1SWSgtPewzH4DqvVZWcnLA684VIhc/eUTEs0362fmizlatbwhI3q7N0K21bWxkrD/47yUHF2zg5D8kLsqO9npT+7LIPAgIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837915; c=relaxed/simple;
	bh=GCdZJWo4jZKP70EEzCC60yNA+9vyk9gi0vxFxPwgwVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+wpw6bEKQCERflrBzMU67l3y3FyOwMy8bIuoXK82Q4E4sKx+WxPvVdan68+6y5IgDMS1Hd6YfOhZ8oSgN9+4ybor1MACDXPgCRPImsDyN92QmMOwpsXRl0y1KFkNf2pXJJVyGGp7R5zxf8dBnXgDrECfKBsZE0H9kXo9IiwPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRHdTpHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5CC43390;
	Thu, 11 Apr 2024 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712837915;
	bh=GCdZJWo4jZKP70EEzCC60yNA+9vyk9gi0vxFxPwgwVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRHdTpHgY8TbiBHehtskKT4Nb2Q7ruqrYyiTL12NFQEHePZNAC5AEp75nc7Pvlkbp
	 hbacwfkYsmR5XqTwFPujuKhohSkWsnyKwi6oBknAXWmpW+x8aKOsecbJlw57Y9oHvB
	 qQyuzU/InEXrrj0upRe4l5CPXhe7YdrW25sGk02w=
Date: Thu, 11 Apr 2024 14:18:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>, frieder.schrempf@kontron.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on
 failure
Message-ID: <2024041114-scavenger-overstock-61c1@gregkh>
References: <20240408151700.1761009-1-festevam@gmail.com>
 <2024040940-resume-polygraph-5800@gregkh>
 <CAKZ8rEMg8SamD_R46LpA9LAh4WUhH=6zsqjkXS0ABVdPAK9Czw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKZ8rEMg8SamD_R46LpA9LAh4WUhH=6zsqjkXS0ABVdPAK9Czw@mail.gmail.com>

On Tue, Apr 09, 2024 at 09:42:43AM -0700, Matthias Kaehlcke wrote:
> On Tue, Apr 9, 2024 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 08, 2024 at 12:17:00PM -0300, Fabio Estevam wrote:
> > > From: Fabio Estevam <festevam@denx.de>
> > >
> > > In case regulator_bulk_enable() fails, the previously enabled USB hub
> > > clock should be disabled.
> > >
> > > Fix it accordingly.
> > >
> > > Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock input")
> > > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > > ---
> > >  drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
> >
> > This file is not in the tree for 6.9-rc2, can you please fix this up and
> > resend?
> 
> The driver has been renamed in usb-next. Shouldn't this patch be based
> on usb-next and the backports to stable kernels account for the name
> change?

If you want to wait a few weeks for this fix to get in, sure.  Otherwise
no.

thanks,

greg k-h

