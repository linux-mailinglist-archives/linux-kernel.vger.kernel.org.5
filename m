Return-Path: <linux-kernel+bounces-153594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A328AD019
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3567285BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F2152DEA;
	Mon, 22 Apr 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/WotRtH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28B152509;
	Mon, 22 Apr 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798169; cv=none; b=WFbMUr+1BhjqrLOxMeAFtCcbrIPj7n3oyJTFeGeQhu8bkSHjd1e4ybBSTlR4e706cVYEQXyt6g0P0QK2gPDm0AKC6qAD37w41dz53/ZxhKyzPSw8UteB3jyENXofRf1dENHeuYi+gVtSjmHLdEH1TR/ZfwIwVu492mZjAVhzm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798169; c=relaxed/simple;
	bh=s/yAQNU9GSF83apsgHMrji7p4cNjFRrC4o9zCRQu88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byvoRK/gZBNuZyKXxSyqt07rjt/vsMTOj1LKMhy+c+6O532baee5gdMojMvkaHxlvsNw9MiQaHAtRE645NxVSeRaHSRN+/5hZCem4JYzmjSLnw/0xhdtrL1ir30Pp7JHK2bhWXnAc2W0WodSkPSk7+dSEoSf0TfGYz7+OBmuu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/WotRtH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713798167; x=1745334167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s/yAQNU9GSF83apsgHMrji7p4cNjFRrC4o9zCRQu88Y=;
  b=J/WotRtH13hvYNM1HVEOSsqMRvm5Lc13bULwp6xZbbDVlxMT6cTLgsV5
   ZjtX5HFj0zC/jO5BgtxFZwZw5KM+6TTyy5O9Vchzfs1u+nJg1x5wNeAhL
   tvnRpcXi5hN7kb6lIYIFHBEVDXvEMoGXPVdfu2EY1NOBO3B3a2YpCYsyy
   1nPQvS4thz4P4FuYCRNs/luWqNoTJnOyOR3ub1GF8uqrz2+/lGSmTLadT
   wrGombMxaIZEkHsxv33TXjCUC6ZyZEiYVcG5ViTazF9En7BXZgPWhNQbO
   K6d27OUfeTHdDi+Ci5vgqq3m6W5ScbUShfiUcmQ8N6ZK4q7neTgaVuMIt
   g==;
X-CSE-ConnectionGUID: XS+jQdP1QS+f1aE1J1BaLw==
X-CSE-MsgGUID: Y8+plzsLSj+vJlHoNhe9dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20763291"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20763291"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 08:02:46 -0700
X-CSE-ConnectionGUID: nrUTY4uHTlerD38yKrgqzA==
X-CSE-MsgGUID: LYNhFMoQRZCSipOm7AL7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24118571"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa008.fm.intel.com with SMTP; 22 Apr 2024 08:02:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 18:02:42 +0300
Date: Mon, 22 Apr 2024 18:02:42 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] usb: typec: ucsi: glink: merge pmic_glink_altmode
 driver
Message-ID: <ZiZ8El4779l0W1Ig@kuha.fi.intel.com>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-7-890db00877ac@linaro.org>
 <ZiZC/l9nOmzWx+j6@kuha.fi.intel.com>
 <46fktwtp3xers6tcpov3qo4zswptvajewsdltm45zbz2kmmpzp@cthu6ylttup3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fktwtp3xers6tcpov3qo4zswptvajewsdltm45zbz2kmmpzp@cthu6ylttup3>

Hi Dmitry,

On Mon, Apr 22, 2024 at 03:45:22PM +0300, Dmitry Baryshkov wrote:
> On Mon, Apr 22, 2024 at 01:59:10PM +0300, Heikki Krogerus wrote:
> > Hi Dmitry,
> > 
> > On Tue, Apr 16, 2024 at 05:20:56AM +0300, Dmitry Baryshkov wrote:
> > > Move handling of USB Altmode to the ucsi_glink driver. This way the
> > > altmode is properly registered in the Type-C framework, the altmode
> > > handlers can use generic typec calls, the UCSI driver can use
> > > orientation information from altmode messages and vice versa, the
> > > altmode handlers can use GPIO-based orientation inormation from UCSI
> > > GLINK driver.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/soc/qcom/Makefile             |   1 -
> > >  drivers/soc/qcom/pmic_glink_altmode.c | 546 ----------------------------------
> > >  drivers/usb/typec/ucsi/ucsi_glink.c   | 495 ++++++++++++++++++++++++++++--
> > >  3 files changed, 475 insertions(+), 567 deletions(-)
> > > 
> 
> [skipped the patch]
> 
> > > +
> > > +static void pmic_glink_ucsi_register_altmode(struct ucsi_connector *con)
> > > +{
> > > +	static const u8 all_assignments = BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) |
> > > +			     BIT(DP_PIN_ASSIGN_E);
> > > +	struct typec_altmode_desc desc;
> > > +	struct typec_altmode *alt;
> > > +
> > > +	mutex_lock(&con->lock);
> > > +
> > > +	if (con->port_altmode[0])
> > > +		goto out;
> > > +
> > > +	memset(&desc, 0, sizeof(desc));
> > > +	desc.svid = USB_TYPEC_DP_SID;
> > > +	desc.mode = USB_TYPEC_DP_MODE;
> > > +
> > > +	desc.vdo = DP_CAP_CAPABILITY(DP_CAP_DFP_D);
> > > +
> > > +	/* We can't rely on the firmware with the capabilities. */
> > > +	desc.vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> > > +
> > > +	/* Claiming that we support all pin assignments */
> > > +	desc.vdo |= all_assignments << 8;
> > > +	desc.vdo |= all_assignments << 16;
> > > +
> > > +	alt = typec_port_register_altmode(con->port, &desc);
> > 
> >         alt = ucsi_register_displayport(con, 0, 0, &desc);
> 
> Note, the existing UCSI displayport AltMode driver depends on the UCSI
> actually handling the altomode. It needs a partner, etc.
> 
> > You need to export that function, but that should not be a problem:
> > 
> > diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> > index d9d3c91125ca..f2754d7b5876 100644
> > --- a/drivers/usb/typec/ucsi/displayport.c
> > +++ b/drivers/usb/typec/ucsi/displayport.c
> > @@ -315,11 +315,13 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
> >         struct ucsi_dp *dp;
> >  
> >         /* We can't rely on the firmware with the capabilities. */
> > -       desc->vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> > +       if (!desc->vdo) {
> > +               desc->vdo = DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> >  
> > -       /* Claiming that we support all pin assignments */
> > -       desc->vdo |= all_assignments << 8;
> > -       desc->vdo |= all_assignments << 16;
> > +               /* Claiming that we support all pin assignments */
> > +               desc->vdo |= all_assignments << 8;
> > +               desc->vdo |= all_assignments << 16;
> > +       }
> >  
> >         alt = typec_port_register_altmode(con->port, desc);
> >         if (IS_ERR(alt))
> > @@ -342,3 +344,4 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
> >  
> >         return alt;
> >  }
> > +EXPORT_SYMBOL_GPL(ucsi_register_displayport);
> > 
> > <snip>
> > 
> > > +static void pmic_glink_ucsi_set_state(struct ucsi_connector *con,
> > > +				      struct pmic_glink_ucsi_port *port)
> > > +{
> > > +	struct typec_displayport_data dp_data = {};
> > > +	struct typec_altmode *altmode = NULL;
> > > +	unsigned long flags;
> > > +	void *data = NULL;
> > > +	int mode;
> > > +
> > > +	spin_lock_irqsave(&port->lock, flags);
> > > +
> > > +	if (port->svid == USB_SID_PD) {
> > > +		mode = TYPEC_STATE_USB;
> > > +	} else if (port->svid == USB_TYPEC_DP_SID && port->mode == DPAM_HPD_OUT) {
> > > +		mode = TYPEC_STATE_SAFE;
> > > +	} else if (port->svid == USB_TYPEC_DP_SID) {
> > > +		altmode = find_altmode(con, port->svid);
> > > +		if (!altmode) {
> > > +			dev_err(con->ucsi->dev, "altmode woth SVID 0x%04x not found\n",
> > > +				port->svid);
> > > +			spin_unlock_irqrestore(&port->lock, flags);
> > > +			return;
> > > +		}
> > > +
> > > +		mode = TYPEC_MODAL_STATE(port->mode - DPAM_HPD_A);
> > > +
> > > +		dp_data.status = DP_STATUS_ENABLED;
> > > +		dp_data.status |= DP_STATUS_CON_DFP_D;
> > > +		if (port->hpd_state)
> > > +			dp_data.status |= DP_STATUS_HPD_STATE;
> > > +		if (port->hpd_irq)
> > > +			dp_data.status |= DP_STATUS_IRQ_HPD;
> > > +		dp_data.conf = DP_CONF_SET_PIN_ASSIGN(port->mode - DPAM_HPD_A);
> > > +
> > > +		data = &dp_data;
> > > +	} else {
> > > +		dev_err(con->ucsi->dev, "Unsupported SVID 0x%04x\n", port->svid);
> > > +		spin_unlock_irqrestore(&port->lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	spin_unlock_irqrestore(&port->lock, flags);
> > > +
> > > +	if (altmode)
> > > +		typec_altmode_set_port(altmode, mode, data);
> > 
> > So if the port altmode is using the ucsi_displayport_ops, you can
> > simply register the partner altmode here instead. That should
> > guarantee that it'll bind to the DP altmode driver which will take
> > care of typec_altmode_enter() etc.
> 
> In our case the altmode is unfortunately completely hidden inside the
> firmware. It is not exported via the native UCSI interface. Even if I
> plug the DP dongle, there is no partner / altmode being reported by the
> PPM. All DP events are reported via additional GLINK messages.

I understand that there is no alt mode being reported, but I assumed
that there is a notification about connections.

If that's not the case, then you need to use this code path to
register the partner device as well I think. The partner really has to
be registered somehow.

> The goal is to use the core Type-C altmode handling, while keeping UCSI
> out of the altmode business.
> 
> This allows the core to handle switches / muxes / retimers, report the
> altmode to the userspace via sysfs, keep the link between the DP part of
> the stack and the typec port, but at the same time we don't get errors
> from UCSI because of the PPM reporting unsupported commands, etc.

I understand, and just to be clear, I don't have a problem with
bypassing UCSI. But that does not mean you can skip the alt mode
registration.

The primary purpose of drivers/usb/typec/ucsi/displayport.c is to
emulate the partner DP alt mode device a little so that the actual DP
alt mode driver drivers/usb/typec/altmodes/displayport.c is happy. The
altmode driver will then make sure that all the muxes, switches and
what have you, are configured as they should, and more importantly,
make sure the DP alt mode is exposed to the user space exactly the
same way as it's exposed on all the other systems.

There are a couple of UCSI commands that are being used there yes, but
by modifying it so that those UCSI commands are executed conditionally
- by checking the ALT_MODE_DETAILS feature - you should be able to use
it also in this case.

You really need to register the partner alt mode(s) one way or the
other in any case, and the partner device itself you absolutely must
register. The user space interface needs to be consistent.

thanks,

-- 
heikki

