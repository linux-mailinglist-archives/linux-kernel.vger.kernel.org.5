Return-Path: <linux-kernel+bounces-164338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121128B7C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE1B1F21D62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D30176FA3;
	Tue, 30 Apr 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Trsa9OpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302731527B1;
	Tue, 30 Apr 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493205; cv=none; b=QegZ6wlOdT1PxDAwKIjz223ZVzG42k67ir2z7m+ZRn7wUmAzi+4aPjLKxpODMCuTXWyLQGy22wMm8BSy6GABkyfFoV9kKsRbZ1rptqhjmZPU8DAEahU4pa/9RSuDz/G0eISZPXcbkoU1sIG5uUgD3vVtA2PZsr855+KVoE3S0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493205; c=relaxed/simple;
	bh=36pB0GQAKQuOsq3AByAb3OXyPXgZ6QZz7qChxKaHd74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g89M3zkiax+xawhcZK02fbZFwbmvpuPVtvVrjIR9uNb6Z57PLR8U2j5M4yURUM3LNQ26p3wJvOnVOCILFXecNvqcS4cvGgwaw9juYJZP8uN1j1KfCePOTI7Wosb3c85aY6SCkkAMBD6hep77lvkYzssdJDisyOqtV1ERRg2aIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Trsa9OpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F86C2BBFC;
	Tue, 30 Apr 2024 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714493204;
	bh=36pB0GQAKQuOsq3AByAb3OXyPXgZ6QZz7qChxKaHd74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Trsa9OpCArsRh1drLMBPcVhkyklWUNkMN8H91XyFl/FgG4tcbgcbGmkek5benYgYp
	 OhQ6tBFcDU6buvSnLwduvbd9fq3WWbe9X1zaHpTRmjDZqPR4IFwziLmjTQ0eh9UGkq
	 uVSGFP+e+Gut+lKrVBbSIm5pAAIXqMRLv7fBZBtE=
Date: Tue, 30 Apr 2024 18:06:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Wait unconditionally after issuing EndXfer
 command
Message-ID: <2024043022-chatroom-backwash-371e@gregkh>
References: <20240425045749.1493541-1-quic_prashk@quicinc.com>
 <20240425232200.kozymtwjxjs7nmoz@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425232200.kozymtwjxjs7nmoz@synopsys.com>

On Thu, Apr 25, 2024 at 11:22:08PM +0000, Thinh Nguyen wrote:
> On Thu, Apr 25, 2024, Prashanth K wrote:
> > Currently all controller IP/revisions except DWC3_usb3 >= 310a
> > wait 1ms unconditionally for ENDXFER completion when IOC is not
> > set. This is because DWC_usb3 controller revisions >= 3.10a
> > supports GUCTL2[14: Rst_actbitlater] bit which allows polling
> > CMDACT bit to know whether ENDXFER command is completed.
> > 
> > Consider a case where an IN request was queued, and parallelly
> > soft_disconnect was called (due to ffs_epfile_release). This
> > eventually calls stop_active_transfer with IOC cleared, hence
> > send_gadget_ep_cmd() skips waiting for CMDACT cleared during
> > EndXfer. For DWC3 controllers with revisions >= 310a, we don't
> > forcefully wait for 1ms either, and we proceed by unmapping the
> > requests. If ENDXFER didn't complete by this time, it leads to
> > SMMU faults since the controller would still be accessing those
> > requests.
> > 
> > Fix this by ensuring ENDXFER completion by adding 1ms delay in
> > __dwc3_stop_active_transfer() unconditionally.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer")
> > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > ---
> > Changes in v2:
> > Changed the patch logic from CMDACT polling to 1ms mdelay.
> > Updated subject and commit accordingly.
> > Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20240422090539.3986723-1-quic_prashk@quicinc.com/__;!!A4F2R9G_pg!fa3zoJhmfdChG32lHtAa-7bxJpxPsw2wgzQwQAq9gWG2LwWyr9WnIzm9Eol6hmiKLEOTJuqjOeTYVYZ_sNnER6p_uF4$ 
> > 
> >  drivers/usb/dwc3/gadget.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 4df2661f6675..666eae94524f 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1724,8 +1724,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
> >  	dep->resource_index = 0;
> >  
> >  	if (!interrupt) {
> > -		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
> > -			mdelay(1);
> > +		mdelay(1);
> >  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> >  	} else if (!ret) {
> >  		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
> > -- 
> > 2.25.1
> > 
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

This patch breaks the build on my systems:

  CC [M]  drivers/usb/dwc3/gadget.o
drivers/usb/dwc3/gadget.c: In function ‘__dwc3_stop_active_transfer’:
drivers/usb/dwc3/gadget.c:1702:22: error: unused variable ‘dwc’ [-Werror=unused-variable]
 1702 |         struct dwc3 *dwc = dep->dwc;
      |                      ^~~
cc1: all warnings being treated as errors

so I can't take it :(

