Return-Path: <linux-kernel+bounces-9387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650681C4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50321B21968
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072A8C14;
	Fri, 22 Dec 2023 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kifCBQFZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF09444;
	Fri, 22 Dec 2023 06:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF7C433C8;
	Fri, 22 Dec 2023 06:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703225444;
	bh=xYXbxxhkYye8R6cZYemP7SDJUtXgX90hz1d089uRcew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kifCBQFZFekLHT8JNYbslYBtOe6aSFNcJiM7CZBZsVv0qXs/AkQw5/pNqaV3R5jKI
	 UGU1IEJS8So4qEC/2FprG046fMAbkcnv7IJy7MfXa6TTgWJUqr7IaFjS1RkU1UDV5t
	 uZvCTa0J4ZxEZKrcofnINPeoFUC2oCKFQATy3t2s=
Date: Fri, 22 Dec 2023 07:10:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <quic_prashk@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Message-ID: <2023122212-stellar-handlebar-2f70@gregkh>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
 <2023121518-uncharted-riddance-7c58@gregkh>
 <849d0ea9-d4f7-c568-968c-88835f64fadf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849d0ea9-d4f7-c568-968c-88835f64fadf@quicinc.com>

On Fri, Dec 22, 2023 at 11:29:01AM +0530, Prashanth K wrote:
> On 15-12-23 06:12 pm, Greg Kroah-Hartman wrote:
> > On Tue, Dec 12, 2023 at 04:55:20PM +0530, Prashanth K wrote:
> > > Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
> > > XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
> > > which fixes XHC timeout, which was seen on synopsys XHCs while
> > > using SG buffers. But the support for this quirk isn't present
> > > in the DWC3 layer.
> > > 
> > > We will encounter this XHCI timeout/hung issue if we run iperf
> > > loopback tests using RTL8156 ethernet adaptor on DWC3 targets
> > > with scatter-gather enabled. This gets resolved after enabling
> > > the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
> > > the xhci device property since its needed for DWC3 controller.
> > > 
> > > In Synopsys DWC3 databook,
> > > Table 9-3: xHCI Debug Capability Limitations
> > > Chained TRBs greater than TRB cache size: The debug capability
> > > driver must not create a multi-TRB TD that describes smaller
> > > than a 1K packet that spreads across 8 or more TRBs on either
> > > the IN TR or the OUT TR.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > 
> > What commit id does this fix?
> > 
> This doesn't fix any commit as such, but adds the support for
> XHCI_SG_TRB_CACHE_SIZE_QUIRK (which is present in XHCI layer) to DWC3 layer.

So this is a new feature?

How does this fit into the stable kernel rules?

> I have CC'ed stable kernel for this to be back-ported to older kernels
> (#5.11).

Why that specific kernel version and newer?  Why not list it as
documented?

> > 
> > > ---
> > >   drivers/usb/dwc3/host.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > index 61f57fe5bb78..31a496233d87 100644
> > > --- a/drivers/usb/dwc3/host.c
> > > +++ b/drivers/usb/dwc3/host.c
> > > @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
> > >   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
> > > +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
> > 
> > And this is ok if the entry is not present?
> > 
> We are intending to use this quirk for all the dwc3 based devices since the
> DWC3 XHC needs it.

So you do not have this quirk yet in the kernel tree?  We can't take
code without any in-tree users.

> If the entry is not present then we will hit stall if
> certain conditions aren't met (have mentioned the condition in commit text).

When will the quirk be added?  To what platforms?

thanks,

greg k-h

