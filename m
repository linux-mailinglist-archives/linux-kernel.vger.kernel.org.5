Return-Path: <linux-kernel+bounces-946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DB81485B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B6286337
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220B2DB6B;
	Fri, 15 Dec 2023 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wb8qv6yO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8102D7BB;
	Fri, 15 Dec 2023 12:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A80C433C8;
	Fri, 15 Dec 2023 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702644261;
	bh=OE6L5PNX6SGRt851a9OF5sucHu+J1674aufGgMwMSXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wb8qv6yOz7kb7SzBjxFcHjpjelmwnipxcMznBaBt6H+xVhnYCcBH9uZ8G03LxTgZe
	 5PJaTNm5lNhooQavzZeTDPyNQAqYjOWvpNdeVlQARqgiG8PX1PY7e4HHexIht1j3nZ
	 0pzKzbpFZLMp1lhSVL6hL0bzUI0srek605qS1vVU=
Date: Fri, 15 Dec 2023 13:44:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: host: Disable USB3 ports if maximum-speed
 doesn't permit USB3
Message-ID: <2023121506-persecute-lining-45bf@gregkh>
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <20231208210458.912776-3-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208210458.912776-3-CFSworks@gmail.com>

On Fri, Dec 08, 2023 at 02:04:58PM -0700, Sam Edwards wrote:
> The DWC3 core can be configured (during IP instantiation, and/or via
> configuration signals) not to have any USB3 ports. Some SoCs, however,
> may have USB3 interfaces enabled that do not have USB3 PHYs driving
> them. This can be due to a few circumstances, including:
> a) The hardware designer didn't include USB3 PHYs and neglected to
>    disable the DWC3 core's USB ports (I know of no instance where this
>    has actually happened, however, and it seems pretty unlikely).
> b) The USB3 PHYs are present but powered off. Perhaps a driver to enable
>    the PHYs has not yet been written or merged, or USB3 capability is
>    unneeded in the system and the system designer would like to conserve
>    power.
> c) The USB3 PHYs are muxed to a different controller. This can happen if
>    the PHYs support non-USB protocols and one of these alternate
>    functions is needed instead.
> 
> In these circumstances, if the DWC3 does not receive clear link status
> indication on an enabled USB3 port, the DWC3 may not allow even USB2
> to function: in host mode, the DWC3 generates an endless barrage of
> PORT_CSC status on the accompanying USB2 port, and the xHCI driver is
> unable to bring the USB2 port to a functioning state.
> 
> Fix this by first checking if the maximum-speed property in the DT
> permits USB3. If not, pass the new `disable-usb3;` property to the
> virtual xHCI device, causing the xHCI driver not to enable the USB3
> ports. This allows USB2 to function even with USB3 PHYs
> missing/misbehaving, and may be useful even when the USB3 PHYs are
> well-behaved: a DT author may know that USB3 support is intact, but
> disconnected (not exposed off-board) and choose to lower the
> maximum-speed property to avoid an unusable USB3 rhub showing up in
> sysfs/lsusb where it may mislead end-users.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  drivers/usb/dwc3/host.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Where is patch 1/2 of this series?

confused,

greg k-h

