Return-Path: <linux-kernel+bounces-36945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137483A93A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FB91C20A65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016660EF5;
	Wed, 24 Jan 2024 12:04:18 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438260BA8;
	Wed, 24 Jan 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097858; cv=none; b=ARf8Be/7UG1D4kYQNtPDv5irHocRnY/yzQtnQpetsHILgQxJ8AfKQr5gn+LfHufk1O9D8FuC4L37z+gnpUAt3Peot2SeKjmFnhsH+36atVQNf8kpHylkT1Dt6DahmL+jhtkt5nfsMeoufW3SX4JOtGCnF8gXn5vB3O4LLt+07ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097858; c=relaxed/simple;
	bh=McfebLYXAumKQIwkfYKxxs0qSSSveGNcXva0iTP08KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1SierxbLKDe8rs36kAEGOoDiu4aSD+8KwM1Rzqefd/JpEYLV/xJsWvPS0f02VrMn3Cv5P33RLj+9j1tGQUutvzlX1uKxjKCjaRcJS6wacdJKhN0LSy+pzJ3CzIy+eWkSvPO3e548A4P1yhbsklg4ThG4K/ekpZolCYrTYWdlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8554814033C; Wed, 24 Jan 2024 13:04:06 +0100 (CET)
Date: Wed, 24 Jan 2024 13:04:06 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: ucsi: Add missing ppm_lock
Message-ID: <ZbD8toNjyjiLp8an@cae.in-ulm.de>
References: <20240121204123.275441-1-lk@c--e.de>
 <20240121204123.275441-2-lk@c--e.de>
 <ZbDFoGL1GnxZAXER@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbDFoGL1GnxZAXER@kuha.fi.intel.com>


Hi Heikki,

Thanks for looking into this.

On Wed, Jan 24, 2024 at 10:09:04AM +0200, Heikki Krogerus wrote:
> On Sun, Jan 21, 2024 at 09:41:21PM +0100, Christian A. Ehrhardt wrote:
> > Calling ->sync_write must be done while holding the PPM lock as
> > the mailbox logic does not support concurrent commands.
> > 
> > At least since the addition of partner task this means that
> > ucsi_acknowledge_connector_change should be called with the
> > PPM lock held as it calls ->sync_write.
> > 
> > Thus protect the only call to ucsi_acknowledge_connector_change
> > with the PPM. All other calls to ->sync_write already happen
> > under the PPM lock.
> > 
> > Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 61b64558f96c..8f9dff993b3d 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -935,7 +935,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> >  
> >  	clear_bit(EVENT_PENDING, &con->ucsi->flags);
> >  
> > +	mutex_lock(&ucsi->ppm_lock);
> >  	ret = ucsi_acknowledge_connector_change(ucsi);
> > +	mutex_unlock(&ucsi->ppm_lock);
> >  	if (ret)
> >  		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
> 
> Is this really actually fixing some issue? The function has already
> taken the connector lock, so what exactly could happen without this?

I've definitely _seen_ issues with the quirk from PATCH 3/3 if the
lock is missing. I'm pretty sure from looking at the code that races
with other connectors can happen without the quirk, too.

The PPM lock protects the Mailbox and the ACK_PENDING/COMMAND_PENDING
bits and I could observe cases where ucsi_acpi_sync_write() was entered
with the COMMAND_PENDING bit already set. One possible sequence is this:

ucsi_connector_change() for connector #1
	=> schedules partner tasks
	=> Acks the connector change
	=> Releases locks
ucsi_connecotr_change() for connector #2
	=> acquire con lock for #2
	=> Start to process connector state change
	=> Processing reaches the point right before 
	   ucsi_acknowledge_connector_change()
Connector #1 workqueue starts to process one of the partner tasks
	=> Acquire con lock for connector #1
	=> Acquire ppm lock
	=> Enter ucsi_exec_command()
	=> ->sync_write() starts to use the mailbox and sets
	   COMMAND_PENDING
	=> ->sync_write blocks waiting for the command completion
	   with wait_for_completion_timeout().
ucsi_connector_change() for connector #2 continues
	=> execute ucsi_acknowledge_connector_change() and start using
	   the mailbox that is still in use.
	=> BOOM

There is a simpler an much more likely sequence with the dell quirk active.

     regards  Christian

