Return-Path: <linux-kernel+bounces-135212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160D89BCCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E14C1F22710
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6D52F8E;
	Mon,  8 Apr 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRNLB9mX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25647F4A;
	Mon,  8 Apr 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571313; cv=none; b=KZ6j2McTLzQSsiZj34QmFg6xmuiNhY8ZF/xWw+BGKWU3s8b8APFRWI5wr2kK4tPZktH+ChdRJqJTwrZsXR9yBN2URCWuP30gNqcILgHeFxmueJG3Y148kB3ZtHJqxSmnlTQ7si2fSMDtA1JdKK2v5qkYCV4Mz+a39xPROoZ5xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571313; c=relaxed/simple;
	bh=teYJATRhSdr8pYwNwJh4nm6MLUUwolqQ/dDBda+u/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7cBaBN4BmsjEvaNUyyGEDQzJoTFnTbgk4DMLWm0pnxyudNF3MQob7Wtp/ujYQfzvgzvkRwIARFIUXaRTJ9ytI2mD4Hf4EakCC2QzvLZwX+FJJHT7FSgGvFHN1tRJTkhRpsFo+554R/eDNKhiBPNwoMQ5YKNfoN0g56Xll+uzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRNLB9mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926FCC433F1;
	Mon,  8 Apr 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571312;
	bh=teYJATRhSdr8pYwNwJh4nm6MLUUwolqQ/dDBda+u/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRNLB9mXM5vnZjeYbpb+MY9nqftNYAk3SshELYIlR8MdF7foXmoEh92+sXQkqgH3e
	 2fBFj5ECKA10azIcdAynu+C+A+SGC8RNGHF6f3wL3pFy/ECwICiURmeN3jXtvRCr/S
	 JbSNb2XISK2cC4EJ8hcu9p2qhd6ezLH8JvV+OEyEmQUWctrIRyzhUaKtt6KeutFF3Y
	 dF63PzlSorLabIsTeAj07/VkzlEcwTDjM1LLUmFz5kyop5Ng5/irm8ptT80rUTcRiQ
	 90uP+CLC7KJ/fxr3pYnEu+1JjfH/7SuSP0R5AAEF+UKvq00M5EL6+/gjh/bej77ZV6
	 gO58583ImAwTw==
Date: Mon, 8 Apr 2024 15:45:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Message-ID: <20240408101505.GA26812@thinkpad>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
 <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
 <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
 <e78382b5-428e-4de8-be0d-b319534238f1@quicinc.com>
 <0cfac65c-8b71-4900-88a3-631c93aebc17@quicinc.com>
 <024549ba-4522-d8d0-08ea-c42966f850af@quicinc.com>
 <fca73905-c6c7-4db1-88bd-fd8bc2d3b3b0@quicinc.com>
 <572f5453-5719-4170-873d-cd3a85287891@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <572f5453-5719-4170-873d-cd3a85287891@quicinc.com>

On Mon, Apr 08, 2024 at 04:10:40PM +0800, Qiang Yu wrote:
> 
> On 4/3/2024 1:44 PM, Qiang Yu wrote:
> > 
> > On 4/2/2024 11:33 PM, Jeffrey Hugo wrote:
> > > On 4/2/2024 7:52 AM, Qiang Yu wrote:
> > > > 
> > > > On 4/2/2024 12:34 PM, Qiang Yu wrote:
> > > > > 
> > > > > On 1/12/2024 3:08 AM, Jeffrey Hugo wrote:
> > > > > > On 1/9/2024 2:20 AM, Qiang Yu wrote:
> > > > > > > 
> > > > > > > On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
> > > > > > > > On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
> > > > > > > > > On 12/25/2023 12:47 AM, Qiang Yu wrote:
> > > > > > > > > > From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
> > > > > > > > > > 
> > > > > > > > > > Forcing the device (eg. SDX75) to enter
> > > > > > > > > > Emergency Download Mode involves
> > > > > > > > > > writing the 0xEDEDEDED cookie to the
> > > > > > > > > > channel 91 doorbell register and
> > > > > > > > > > forcing an SOC reset afterwards. Allow
> > > > > > > > > > users of the MHI bus to exercise the
> > > > > > > > > > sequence using a sysfs entry.
> > > > > > > > > I don't see this documented in the spec
> > > > > > > > > anywhere. Is this standard behavior
> > > > > > > > > for all MHI devices?
> > > > > > > > > 
> > > > > > > > > What about devices that don't support EDL mode?
> > > > > > > > > 
> > > > > > > > > How should the host avoid using this special
> > > > > > > > > cookie when EDL mode is not
> > > > > > > > > desired?
> > > > > > > > > 
> > > > > > > > All points raised by Jeff are valid. I had
> > > > > > > > discussions with Hemant and Bhaumik
> > > > > > > > previously on allowing the devices to enter EDL
> > > > > > > > mode in a generic manner and we
> > > > > > > > didn't conclude on one final approach.
> > > > > > > > 
> > > > > > > > Whatever way we come up with, it should be
> > > > > > > > properly described in the MHI spec
> > > > > > > > and _should_ be backwards compatible.
> > > > > > > 
> > > > > > > Hi Mani, Jeff. The method of entering EDL mode is
> > > > > > > documented in MHI spec v1.2, Chapter 13.2.
> > > > > > > 
> > > > > > > Could you please check once?
> > > > > > 
> > > > > > I do see it listed there.  However that was a FR for
> > > > > > SDX55, so devices prior to that would not support this.
> > > > > > AIC100 predates this change and would not support the
> > > > > > functionality.  I verified the AIC100 implementation is
> > > > > > not aware of this cookie.
> > > > > > 
> > > > > > Also, that functionality depends on channel 91 being
> > > > > > reserved per the table 9-2, however that table only
> > > > > > applies to modem class devices as it is under chapter 9
> > > > > > "Modem protocols over PCIe". Looking at the ath11k and
> > > > > > ath12k implementations in upstream, it looks like they
> > > > > > partially comply.  Other devices have different MHI
> > > > > > channel definitions.
> > > > > > 
> > > > > > Chapter 9 doesn't appear to be in older versions of the
> > > > > > spec that I have, so it is unclear if this functionality
> > > > > > is backwards compatible (was channel 91 used for another
> > > > > > purpose in pre-SDX55 modems).
> > > > > > 
> > > > > > I'm not convinced this belongs in the MHI core.  At a
> > > > > > minimum, the MHI controller(s) for the applicable
> > > > > > devices needs to opt-in to this.
> > > > > > 
> > > > > > -Jeff
> > > > > Hi Jeff
> > > > > 
> > > > > Sorry for reply so late. In older versions of the spec,
> > > > > there is no description about EDL doorbell. However, in MHI
> > > > > spec v1.2, section 13.2,
> > > > > It explicitly says "To set the EDL cookie, the host writes
> > > > > 0xEDEDEDED to channel doorbell 91." So I think every device
> > > > > based on MHI spec v1.2
> > > > > should reserve channel doorbell 91 for EDL mode.
> > > > > 
> > > > > So can we add another flag called mhi_ver in mhi controller
> > > > > to indicate its mhi version and then we can add mhi_ver
> > > > > checking to determine if this
> > > > > device supports EDL sysfs operation?
> > > > > 
> > > > > Thanks,
> > > > > Qiang
> > > > 
> > > > I discussed with internal team, look like devices that reserve
> > > > channel doorbell 91 for EDL, thier MHIVER register value can
> > > > still be 1.0 instead
> > > > of 1.2. So even if we add a flag called mhi_ver to store the
> > > > value read from the MHIVER register. We still can not do EDL
> > > > support check depend on it.
> > > > 
> > > > But I still think enter EDL mode by writing EDL cookie to
> > > > channel doorbell is a standard way. At least it's a standard way
> > > > from MHI spec V1.2.
> > > > 
> > > > In mhi_controller, we have a variable edl_image representing the
> > > > name and path of firmware. But We still can not determine if the
> > > > device reserve
> > > > channel doorbell 91 by checking this because some devices may
> > > > enter EDL mode in different way. Mayebe we have to add a flag in
> > > > mhi_controller
> > > > called edl_support to do the check.
> > > 
> > > So, not all devices support EDL mode (even v1.2 devices, which I
> > > know of one in development).  Of the devices that support EDL mode,
> > > not all of them use the same mechanism to enter EDL mode.
> > > 
> > > It appears all of this needs to be shoved to the controller.
> > > 
> > > At best, I think the controller can provide an optional EDL
> > > callback. If the callback is provided, then MHI creates a sysfs
> > > entry (similar to soc_reset) for the purpose of entering EDL mode. 
> > > If the sysfs entry is called, all MHI does is call the controller's
> > > callback.
> > > 
> > > -Jeff
> > 
> > 
> > Hi Jeff
> > 
> > This idea looks good. We can add edl call back in mhi_pci_dev_info and
> > assgin it to mhi controller during probe.
> > Meanwhile, we can get edl doorbell address in this callback instead of
> > mhi_init_mmio.
> > 
> > Mani, what do you think about it? Can I implement the EDL sysfs entry
> > like this?
> > 
> 
> Hi Mani, Jeff
> 
> I plan to implement EDL sysfs entry as Jeff suggested.
> 
> 1. Add an optional EDL callback in mhi_pci_dev_info and assign it to mhi
> controller during probe. All logic
>    to enter EDL mode will be moved in this EDL callback.
> 
> 2. Create EDL sysfs entry anyway, and check if EDL callback exists, run EDL
> callback, otherwise print log
>    and return.
> 

You should not print anything on unsupported platforms while introducing a new
feature.

MHI stack should first check for the existence of the EDL callback and then only
it should try to create the sysfs entry. But the EDL callback varies from device
to device afaik, so I would've fancied to pass the callback from the
mhi_controller_config structure. But the config is meant to provide config
options as opposed to callbacks.

So I think a neat way would be to add a new flag,
mhi_controller_config::edl_trigger. Then enable that flag in the config of
supported devices and during mhi_pci_probe(), pass the
mhi_pci_generic_edl_trigger() function as the callback to
mhi_controller::edl_trigger.

In the future, if we happen to add more EDL triggering mechanisms (vendor
specific), then we can use bitfields to differentiate them.

- Mani

மணிவண்ணன் சதாசிவம்

