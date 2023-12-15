Return-Path: <linux-kernel+bounces-941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69F81484F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E0B1C23360
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D42C6A8;
	Fri, 15 Dec 2023 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MAX8XRts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF412574B;
	Fri, 15 Dec 2023 12:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28356C433C7;
	Fri, 15 Dec 2023 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702644164;
	bh=6irgSRIOBfDx7Y9R4iebo0z59NK156l2slhjQb5uxoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAX8XRtsMR7KN/CX4loqTS3cNHS+A2K9md2xahwOcn1k5HGpybvApb4ssdQgs0G1U
	 6rjzXMWainYRiHm2pt9OtNRh2ZCJaTNy1XLuYHGzHfNhDgOuIYs9lVl7vzBMHG/y4t
	 hyTjyonBwa39LfE9FtSyBVDS+jDbgknSBWheQTNE=
Date: Fri, 15 Dec 2023 13:42:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <quic_prashk@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Message-ID: <2023121518-uncharted-riddance-7c58@gregkh>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212112521.3774610-2-quic_prashk@quicinc.com>

On Tue, Dec 12, 2023 at 04:55:20PM +0530, Prashanth K wrote:
> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
> which fixes XHC timeout, which was seen on synopsys XHCs while
> using SG buffers. But the support for this quirk isn't present
> in the DWC3 layer.
> 
> We will encounter this XHCI timeout/hung issue if we run iperf
> loopback tests using RTL8156 ethernet adaptor on DWC3 targets
> with scatter-gather enabled. This gets resolved after enabling
> the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
> the xhci device property since its needed for DWC3 controller.
> 
> In Synopsys DWC3 databook,
> Table 9-3: xHCI Debug Capability Limitations
> Chained TRBs greater than TRB cache size: The debug capability
> driver must not create a multi-TRB TD that describes smaller
> than a 1K packet that spreads across 8 or more TRBs on either
> the IN TR or the OUT TR.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

What commit id does this fix?


> ---
>  drivers/usb/dwc3/host.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 61f57fe5bb78..31a496233d87 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>  
>  	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>  
> +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");

And this is ok if the entry is not present?

thanks,

greg k-h

