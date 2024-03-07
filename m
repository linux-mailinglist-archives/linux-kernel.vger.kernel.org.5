Return-Path: <linux-kernel+bounces-95588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341A874FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2C81F21E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9C12C7F2;
	Thu,  7 Mar 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NS0qDYMY"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509A129A98;
	Thu,  7 Mar 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817726; cv=none; b=ndl2XnXnMczd09DEBS2G8zcTXojNIPd4JCMvRaRIDUMPPw/jv0cIrD64gtbMtpkK8fGWE1Gei9mIbDGtWckrqytq1pJekuHM0N721G2BkTsC1z5MH/JxBX7WK4S+LSrIAmYdE6fk8gtBBPWUGvThmMo2aXU9SbC9NWf3LctuH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817726; c=relaxed/simple;
	bh=w2MkkM7a8PG5sSCI7iTEMgtD4tpClgb1lVwK2p69wa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRopV+l9UhaFto6Fs+VsjY8tQC+5HMEBatY8l5QzO0Y4lJww0Y2GZ+iktO62VPc9RcFU2rKrPZX4grQtZo5fMGgykyo1WwNhrfw/GFz+cy+7WfhKnjBWRv1iOCjcWhX/W+yUEyDymVk6YL2rOcEMf4/CE2O+xS0oP49a44EjWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NS0qDYMY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2adjiSztGzfYM9T4lx+mXU7akcr/eZ53zqRB/d3naCg=; b=NS0qDYMYyfSg/DYyBW0xzZV6ke
	O5nAjui8RFwzJMoYUkx/9X+X1rylXwKUHbQF1h1POAX8BoZEODQnlVDeKWQo53ajra4vj97Rt7eXD
	kqB4a0NOvWQdq1Ihs2tuNw9oVYkEBYLlVr9OiOjB7ZAFLQgYqRFd6cPn30NZWNi5m16M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riDhR-009aTZ-0R; Thu, 07 Mar 2024 14:22:17 +0100
Date: Thu, 7 Mar 2024 14:22:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Message-ID: <d2f254b9-7e7a-46ed-a979-00bdf92899ac@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-4-Parthiban.Veerasooran@microchip.com>
 <48b65759-6e69-46ef-a2ed-857d04eadac8@lunn.ch>
 <83e0b340-521e-4d60-90bb-92d2ca6f5abe@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e0b340-521e-4d60-90bb-92d2ca6f5abe@microchip.com>

On Thu, Mar 07, 2024 at 07:04:20AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 07/03/24 5:49 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >>   enum oa_tc6_register_op {
> >> +     OA_TC6_CTRL_REG_READ = 0,
> >>        OA_TC6_CTRL_REG_WRITE = 1,
> >>   };
> > 
> > I thought it looked a little odd when the enum was added in the
> > previous patch with the first value of 1, and only one value. Now it
> > makes more sense.
> Ok.
> > 
> > The actual value appears to not matter? It is always
> > 
> >> +     if (reg_op == OA_TC6_CTRL_REG_WRITE)
> > 
> > So i would drop the numbering, and leave it to the compiler. The
> > patches will then look less odd.
> "drop the numbering", do you refer to this patch alone or previous patch 
> also? If it is for this patch alone then it makes sense as they are 
> going to be 0 and 1 anyway. But if we drop the numbering in the previous 
> patch it will become 0 which will create an issue in the below line as 
> it needs 1,
> 
> FIELD_PREP(OA_TC6_CTRL_HEADER_WRITE, reg_op)

That is why i asked: 

> The actual value appears to not matter? It is always
> 
> +     if (reg_op == OA_TC6_CTRL_REG_WRITE)

So the actual value does matter, so keep it in the previous patch.
Does the value of OA_TC6_CTRL_REG_READ matter? Is it also used in
FIELD_PREP etc? If not, taking away the = 0 will emphasise that 
OA_TC6_CTRL_REG_WRITE has to be 1.

	Andrew

