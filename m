Return-Path: <linux-kernel+bounces-100174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285748792FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B761F237D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053779B8B;
	Tue, 12 Mar 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq8/0wpG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8253AC2B;
	Tue, 12 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242881; cv=none; b=GAGTlXe8ZD628Y0YHYKmK4cC32p95wiHP0cByilkJ3Og6wDzjykcITsPQNbdu/KQfdRkqP33yTtdCZk/3K5frvzg7EuPpRpYxmFrdgJmF4z4X2Zy2aBvOkeg/9LTFqWMsjvrBJ2yItViNU57XFO6O8kONlzyQf8zg1D2QUk0Dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242881; c=relaxed/simple;
	bh=fTDdQSbH+VezGIErXbkefNgabzYn5ecGA2WOWFZOMRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwmtwnm5ueRgKcOqFS7Zwd6h5WhdbYeWsKOOHTYgCXYnKQUMICDynomi1QxFrxEzfAg0LFCjQqQZUNAyQYmBm9lDry1kVeQd1iNVWj7rnZzx1g5P1nOiYAR2dH8VgDQkqckVOJy47Hr6JSqitmpa7vCSbxOhMeoWwbn1NugViJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq8/0wpG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710242879; x=1741778879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTDdQSbH+VezGIErXbkefNgabzYn5ecGA2WOWFZOMRA=;
  b=Dq8/0wpGyi+0HpY+hhehXcififOfjdZZZJl01pT1OF44sqtiNdicvdiw
   HSB6CSz3lhPiGivVUKwn8Cc7uKhgj0bwmr9ywK9RIOVM6ZLUwBNSbLOIJ
   Piv64Tda3DM4EuMu5pqrbxSwR6iQppC/JsiStE3Az6WSoUayobw+k4Pku
   Mp1iYUavLMqboEbm8XFrt8qgP0n6UCnJMPp0jbHydHZnOkqVDDBJ2GGNt
   dMO3esydEPg/gIdrU3l7e5i1J0POoXCyRMk5Ya76f/jFpTRPi7pEbJMP7
   UKnOYytUCGmijHR2iONDw8yj5lplm84TJOxW8Cast8SqztAqwWWgZByGN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30383671"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30383671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051687"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051687"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 04:27:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 13:27:53 +0200
Date: Tue, 12 Mar 2024 13:27:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] usb: typec: tcpci: add support to set connector
 orientation
Message-ID: <ZfA8OXPOp6Xg5fDb@kuha.fi.intel.com>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-5-m.felsch@pengutronix.de>
 <ZdxII9W/CBx76Xai@kuha.fi.intel.com>
 <20240226122701.inqpodm6mdfxwjo2@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122701.inqpodm6mdfxwjo2@pengutronix.de>

Hi,

I'm sorry to keep you waiting.

On Mon, Feb 26, 2024 at 01:27:01PM +0100, Marco Felsch wrote:
> Hi,
> 
> On 24-02-26, Heikki Krogerus wrote:
> > On Thu, Feb 22, 2024 at 10:09:03PM +0100, Marco Felsch wrote:
> > > This add the support to set the optional connector orientation bit which
> > > is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
> > > allows system designers to connect the tcpc orientation pin directly to
> > > the 2:1 ss-mux.
> > > 
> > > [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > v3:
> > > - no changes
> > > v2:
> > > - Make use of fallthrough 
> > > 
> > >  drivers/usb/typec/tcpm/tcpci.c | 44 ++++++++++++++++++++++++++++++++++
> > >  include/linux/usb/tcpci.h      |  8 +++++++
> > >  2 files changed, 52 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > > index 7118551827f6..73a52e7f95c2 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > > @@ -67,6 +67,18 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
> > >  	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
> > >  }
> > >  
> > > +static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
> > > +{
> > > +	unsigned int reg;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(regmap, TCPC_STD_OUTPUT_CAP, &reg);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return (reg & mask) == mask;
> > > +}
> > > +
> > >  static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
> > >  {
> > >  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > > @@ -301,6 +313,28 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
> > >  			   TCPC_TCPC_CTRL_ORIENTATION : 0);
> > >  }
> > >  
> > > +static int tcpci_set_orientation(struct tcpc_dev *tcpc,
> > > +				 enum typec_orientation orientation)
> > > +{
> > > +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > > +	unsigned int reg;
> > > +
> > > +	switch (orientation) {
> > > +	case TYPEC_ORIENTATION_NONE:
> > > +		/* We can't put a single output into high impedance */
> > > +		fallthrough;
> > > +	case TYPEC_ORIENTATION_NORMAL:
> > > +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL;
> > > +		break;
> > > +	case TYPEC_ORIENTATION_REVERSE:
> > > +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED;
> > > +		break;
> > > +	}
> > > +
> > > +	return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
> > > +				  TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK, reg);
> > > +}
> > > +
> > >  static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
> > >  {
> > >  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > > @@ -808,6 +842,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
> > >  	if (tcpci->data->vbus_vsafe0v)
> > >  		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
> > >  
> > > +	if (tcpci->data->set_orientation)
> > > +		tcpci->tcpc.set_orientation = tcpci_set_orientation;
> > 
> > I don't think that flag is needed - not yet at least. Please just call
> > tcpci_check_std_output_cap() directly from here.
> 
> The reason for having it this way was to not break exsisting user like:
> tcpci_rt1711h, tcpci_mt6370, tcpci_maxim which may or may not implement
> the TCPC_STD_OUTPUT_CAP_ORIENTATION. This way the users of
> tcpci_register_port() can decide by on its own if they do have this
> feature or not and how this is checked. I'm fine with your proposal if
> you still think that we can check this unconditional.

Ah, I failed to consider those other glue drivers. This is fine as it
is. I'm really sorry about the delay.

Br,

-- 
heikki

