Return-Path: <linux-kernel+bounces-28572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587283002D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB5A1F24DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543B8C1B;
	Wed, 17 Jan 2024 06:35:30 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E751FAF;
	Wed, 17 Jan 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473330; cv=none; b=Af20X0ChSWRhGukBHpJgVJILTORNxlc80iGKTRCtzXGUnG1RxknZpqkhJJ/3qRuUKkSzWdWBD/u2EPFZKjSeQSWOW0DZJQlzbiAks9NJZ/OwOnW0QJWEPfwO4s6DThw4/Ecw1/DCM65vMoe+q/FrC0i7LJtikdL4CuqF/mo37wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473330; c=relaxed/simple;
	bh=4WpP0RvtazlSMb2/5wbc9Q7kdkvYUdvnJl4Gn1aF5AA=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=sLbp4/e5lbge3kLvgbtxPnnKN7uJmxKGeOmJHPFk+g9TIfT2gy3+HcxoRG3vH1VS7q5IfTG8PVMound3FY3JXLtH2noCVfnfHDMPlQfbaZkFwZrCL0nZm2UbOP30LnFJdpVwGVpSjlmG/jNRQUybQSyR9VDvd64vb1nM9p/cRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8A100140327; Wed, 17 Jan 2024 07:35:23 +0100 (CET)
Date: Wed, 17 Jan 2024 07:35:23 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix stuck UCSI controller on DELL
Message-ID: <Zad1K5V8mhNiiMWl@cae.in-ulm.de>
References: <20240103100635.57099-1-lk@c--e.de>
 <ZZadhlh3q9ZInxvU@kuha.fi.intel.com>
 <ZaV/kwuh2MBNY5d2@cae.in-ulm.de>
 <34101c32-65cd-4433-974f-23a16f9981fa@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34101c32-65cd-4433-974f-23a16f9981fa@amd.com>


Hi Mario,

On Tue, Jan 16, 2024 at 09:00:03PM -0600, Mario Limonciello wrote:
> On 1/15/2024 12:55, Christian A. Ehrhardt wrote:
> > 
> > Hi Heikki,
> > 
> > sorry to bother you again with this but I'm afraid there's
> > a misunderstanding wrt. the nature of the quirk. See below:
> > 
> > On Thu, Jan 04, 2024 at 01:59:02PM +0200, Heikki Krogerus wrote:
> > > Hi Christian,
> > > 
> > > On Wed, Jan 03, 2024 at 11:06:35AM +0100, Christian A. Ehrhardt wrote:
> > > > I have a DELL Latitude 5431 where typec only works somewhat.
> > > > After the first plug/unplug event the PPM seems to be stuck and
> > > > commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).
> > > > 
> > > > This patch fixes it for me but according to my reading it is in
> > > > violation of the UCSI spec. On the other hand searching through
> > > > the net it appears that many DELL models seem to have timeout problems
> > > > with UCSI.
> > > > 
> > > > Do we want some kind of quirk here? There does not seem to be a quirk
> > > > framework for this part of the code, yet. Or is it ok to just send the
> > > > additional ACK in all cases and hope that the PPM will do the right
> > > > thing?
> > > 
> > > We can use DMI quirks. Something like the attached diff (not tested).
> > > 
> > > thanks,
> > > 
> > > -- 
> > > heikki
> > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> > > index 6bbf490ac401..7e8b1fcfa024 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> > > @@ -113,18 +113,44 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
> > >   	return 0;
> > >   }
> > > -static const struct ucsi_operations ucsi_zenbook_ops = {
> > > -	.read = ucsi_zenbook_read,
> > > -	.sync_write = ucsi_acpi_sync_write,
> > > -	.async_write = ucsi_acpi_async_write
> > > -};
> > > +static int ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
> > > +				const void *val, size_t val_len)
> > > +{
> > > +	u64 ctrl = *(u64 *)val;
> > > +	int ret;
> > > +
> > > +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
> > > +	if (ret && (ctrl & (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE))) {
> > > +		ctrl= UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
> > > +
> > > +		dev_dbg(ucsi->dev->parent, "%s: ACK failed\n", __func__);
> > > +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
> > > +	}
> > 
> > Unfortunately, this has the logic reversed. The quirk (i.e. the
> > additional UCSI_ACK_COMMAND_COMPLETE) is required after a _successful_
> > UCSI_ACK_CONNECTOR_CHANGE. Otherwise, _subsequent_ commands will timeout
> > (usually the next GET_CONNECTOR_CHANGE).
> > 
> > This means the quirk must be applied _before_ we detect any failure.
> > Consequently, the quirk has the potential to break working systems.
> > 
> > Sorry, if that wasn't clear from my original mail. Please let me know
> > if this changes how you want the quirks handled.
> > 
> >       Thanks    Christian
> > 
> 
> For the problematic scenario have you tried to play with it a bit to see if
> it's too short of a timeout (raise timeout) or to output the response bits
> to see if anything else surprising is sent?

It is not a problem with the timeout. Waiting forever in this case
doesn't help. IMHO this is actually a bug in the PPM, i.e. in Dell's
bios.

Sending an ack after the timeout fixes things, though.

> Does it always fail on the same command, or does it happen to a bunch of
> them?

It always fails on the first command after UCSI_ACK_CC_CI for a
connector change. However, there might be no such command if the
next event is a notification.

I did play around with it a bit more and came up with a way to
probe for the issue:

    https://lore.kernel.orgorg/all/20240116224041.220740-1-lk@c--e.de/   

regards    Christian



