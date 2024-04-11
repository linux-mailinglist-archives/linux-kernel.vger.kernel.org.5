Return-Path: <linux-kernel+bounces-140430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F658A1452
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6EB2663D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C514D44D;
	Thu, 11 Apr 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qE/lgtbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D013FD66;
	Thu, 11 Apr 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838002; cv=none; b=MVs+DRwowoxArj7fyrHpaGfjhI7AKh+qZsyVlQikYgYEFrutsfR19+PvlSHBob/ZBR6r5EgoUfUScW/ovZZaw9eMivwIuE5UaBgpsM1kRLawMITEk3CnOiLqsv4BjXUypg1cVyVyfs75ZrvnO49yYKUAVKXW7CWgopHpNUmpRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838002; c=relaxed/simple;
	bh=KPb2wG+19jdDcMoEVEyKILaMpDqPAMPBDpsfS3XR3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqznZO67NzNpXIPx2gfd1K4RAm5NySrwvnVnPMp8FqB4AtZD2T2cT01U5hTSsYwZwrlonbqUZS2rNmxX3QyBZTQYd1jHvYQYxaRJn95I/FljDY+wf7HS9FokdqW9dZNYLn9SYIj4tyHwskF0KXkEvtmS04VgOQ4aU72RgZr9fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qE/lgtbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A294C43390;
	Thu, 11 Apr 2024 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712838001;
	bh=KPb2wG+19jdDcMoEVEyKILaMpDqPAMPBDpsfS3XR3AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qE/lgtbRux/KFdT/kukz10+93UuJeasYA5Ev3LDTHFK7DSy/4HzyaD3qUAJbO+C60
	 uA1is1M279TXMcrbQvmTegTei+2GTcD9vjbMfdt3fJvfLVHRfXRxqzSmm9JSe1nTdn
	 Ffxo2yoICktnPsRBhgUu5iYpVj4juHxcnqz5LAAc=
Date: Thu, 11 Apr 2024 14:19:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <2024041138-alienate-october-030d@gregkh>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-5-quic_kriskura@quicinc.com>
 <20240409011046.zgjqvhewldch3snu@synopsys.com>
 <3ab9badd-2cf6-4fe0-aaf0-d08614418968@quicinc.com>
 <20240409181342.wmjvi6rwtxphnv3z@synopsys.com>
 <60e569d7-0d63-4b62-b666-1dd7919c8af2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e569d7-0d63-4b62-b666-1dd7919c8af2@quicinc.com>

On Wed, Apr 10, 2024 at 10:10:54AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 4/9/2024 11:43 PM, Thinh Nguyen wrote:
> > On Tue, Apr 09, 2024, Krishna Kurapati PSSNV wrote:
> > > 
> > > 
> > > On 4/9/2024 6:41 AM, Thinh Nguyen wrote:
> > > > On Mon, Apr 08, 2024, Krishna Kurapati wrote:
> > > > > Currently the DWC3 driver supports only single port controller
> > > > > which requires at least one HS PHY and at most one SS PHY.
> > > > > 
> > > > > But the DWC3 USB controller can be connected to multiple ports and
> > > > > each port can have their own PHYs. Each port of the multiport
> > > > > controller can either be HS+SS capable or HS only capable
> > > > > Proper quantification of them is required to modify GUSB2PHYCFG
> > > > > and GUSB3PIPECTL registers appropriately.
> > > > > 
> > > > > Add support for detecting, obtaining and configuring PHYs supported
> > > > > by a multiport controller. Limit support to multiport controllers
> > > > > with up to four ports for now (e.g. as needed for SC8280XP).
> > > > > 
> > > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > > > > ---
> > > > >    drivers/usb/dwc3/core.c | 251 ++++++++++++++++++++++++++++------------
> > > > >    drivers/usb/dwc3/core.h |  14 ++-
> > > > >    drivers/usb/dwc3/drd.c  |  15 ++-
> > > > >    3 files changed, 193 insertions(+), 87 deletions(-)
> > > > > 
> > > > 
> > > > <snip>
> > > > 
> > > > > @@ -1937,6 +2020,10 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
> > > > >    	iounmap(base);
> > > > > +	if (dwc->num_usb2_ports > DWC3_MAX_PORTS ||
> > > > > +	    dwc->num_usb3_ports > DWC3_MAX_PORTS)
> > > > > +		return -ENOMEM;
> > > > 
> > > > This should be -EINVAL.
> > > > 
> > > > > +
> > > > >    	return 0;
> > > > >    }
> > > > 
> > > > <snip>
> > > > 
> > > > > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > > > > index 341e4c73cb2e..df2e111aa848 100644
> > > > > --- a/drivers/usb/dwc3/core.h
> > > > > +++ b/drivers/usb/dwc3/core.h
> > > > > @@ -33,6 +33,12 @@
> > > > >    #include <linux/power_supply.h>
> > > > > +/*
> > > > > + * Maximum number of ports currently supported for multiport
> > > > > + * controllers.
> > > > 
> > > > This macro here is being used per USB2 vs USB3 ports rather than USB2 +
> > > > USB3, unlike the xHCI MAXPORTS. You can clarify in the comment and
> > > > rename the macro to avoid any confusion. You can also create 2 separate
> > > > macros for number of USB2 and USB3 ports even if they share the same
> > > > value.
> > > > 
> > > > As noted[*], we support have different max number of usb2 ports vs usb3
> > > > ports. I would suggest splitting the macros.
> > > > 
> > > 
> > > Hi Thinh,
> > > 
> > >   This macro was intended only to identify how many USB2 (or USB3) Phy's were
> > > serviced/operated by this driver, not how many logical ports present (like
> > 
> > That's not what you described in the comment right above the macro...
> > 
> > > in xHCI). I don't think it would be confusing currently given that it is
> > > only used to identify number of generic phy instances to allocate and not
> > > used for any other purpose. Once the num_usb2_ports and num_usb3_ports are
> > > read by get_num_ports(...) call, they directly indicate how many ports are
> > 
> > Those fields are clear. But for DWC3_MAX_PORTS, based on the name and
> > comment of the macro, it's not clear.
> > 
> > > HS and SS respectively. Keeping the same in mind, I returned ENOMEM above
> > > (as you mentioned) because we don't allocate more than DWC3_MAX_PORTS and if
> > > the number of hs or ss ports is more than that, we simply return ENOMEM
> > > saying the driver doesn't support operating those many phy's.
> > 
> > The error code -ENOMEM indicates out of memory failure. The check
> > condition dwc->num_usb2_ports > DWC3_MAX_PORTS indicates invalid config.
> > There's no allocation in that check.
> > 
> > > 
> > > > [*] https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230801013031.ft3zpoatiyfegmh6@synopsys.com/__;!!A4F2R9G_pg!azHqgm92ENkFQrpv6Fhs6PCe210VGOAIrsuGFhrgmfaor8N_kWLu6rxkPpbeCBTLL4NbUpOWlQ0ufmP9DFwO9iFc0XdSEg$
> > > > 
> > > > > + */
> > > > > +#define DWC3_MAX_PORTS 4
> > > > > +
> > > > > 
> > > > 
> > > > But it's not a big issue whether you decided to push a new version or a
> > > > create a separate patch for the comments above. Here's my Ack:
> > > > 
> > > 
> > > Since this is not a bug, I would prefer to make a separate patch to rename
> > > the macros. (If that is fine).
> > > 
> > 
> > That is fine with me. Thanks for your effort pursuing and continue
> > working on this series.
> > 
> 
> Thanks Thinh. If there are no other issues, I will wait till Greg picks the
> series up. Thanks for the reviews throughout the series.

I can't take it yet, based on the review of this patch, so I'll wait for
a new version of the series.

thanks,

greg k-h

