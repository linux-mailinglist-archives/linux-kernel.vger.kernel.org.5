Return-Path: <linux-kernel+bounces-158204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABEA8B1CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D682861AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1F8120A;
	Thu, 25 Apr 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6V3kCL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F097E59F;
	Thu, 25 Apr 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034423; cv=none; b=b8XkpnkLxTx2LoXaamPH63TabhCcexcV34jlvaAYsVqoY1p4IrALmLgRrrq8NNm6bZK+3q0eRhxOsVUjMIqeU6b6Aa9KYbTsTXV6zSBZOM5L2jsJ4ngRnQ9zfstAj99S/rEerr4xvbB0sccDc0dJXFYnyTlNmcoZtBifjwt8tXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034423; c=relaxed/simple;
	bh=RMDuqvFO7/7Q9NiAuMf/yHRmFRq++Fy+RMe2Sg9URLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhogI60msJC0LexrlJwtVzIy0XPfl8m+4T7U2nPjcPEjy6Q+29DGNEY1qYugrebR7FqAFj4Ar8eHzQMhR7cAmKItMQY7lOXK8bQv8NHm+qAyh1/uegFRew/090eamoBmR69FYmgUZNjisAqvyoB7O/KPPlWh13oZL3NQj5TQRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6V3kCL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E8C113CC;
	Thu, 25 Apr 2024 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714034422;
	bh=RMDuqvFO7/7Q9NiAuMf/yHRmFRq++Fy+RMe2Sg9URLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6V3kCL/PuQPWmBEYYidX6qJmFsaPflYw4eDVCtdeywnIqBBtF/m9aqMrJ2r5acS9
	 gh19cAiQSkmPQ9PbmFpmnad+DwkRwYupx1WCfKY47xi8Pe8xg19zJqW2PLxYtnveAD
	 6NwLkW4DWta3PWXUWLMJzmQU1/t3thxv2Vr0Ty3MX+NQ8Nt6DEVTRRLMGoEmnu+R+N
	 mCsXk/TrmFHmanUUNkS1Kinm7XcTqfPVsqo+LSAuu76ws/b1geeR2GrT18XEXWj2mj
	 YZAMSEbFflMqN65atM1fLOQmWu1sD1L0hmj4E2bx1uAIjRHBmofpbPPM+2qf4V02A+
	 G9oWGYSsyqmRQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzueS-0000000070M-2S2B;
	Thu, 25 Apr 2024 10:40:21 +0200
Date: Thu, 25 Apr 2024 10:40:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Message-ID: <ZioW9IDT7B4sas4l@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>

On Tue, Apr 23, 2024 at 08:09:55AM -0700, Doug Anderson wrote:
> On Tue, Apr 23, 2024 at 2:08 AM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Apr 22, 2024 at 10:50:33AM -0700, Doug Anderson wrote:
> > > On Tue, Apr 16, 2024 at 2:17 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > > > As Chromium is the only known user of the 'local-bd-address' property,
> > > > could you please confirm that your controllers use the 00:00:00:00:5a:ad
> > > > address by default so that the quirk continues to be set as intended?
> > >
> > > I was at EOSS last week so didn't get a chance to test this, but I
> > > just tested it now and I can confirm that it breaks trogdor. It
> > > appears that trogdor devices seem to have a variant of your "default"
> > > address. Instead of:
> > >
> > > 00:00:00:00:5a:ad
> > >
> > > We seem to have a default of this:
> > >
> > > 39:98:00:00:5a:ad
> > >
> > > ...so almost the same, but not enough the same to make it work with
> > > your code. I checked 3 different trogdor boards and they were all the
> > > same, though I can't 100% commit to saying that every trogdor device
> > > out there has that same default address...
> > >
> > > Given that this breaks devices and also that it's already landed and
> > > tagged for stable, what's the plan here? Do we revert? Do we add the
> > > second address in and hope that there aren't trogdor devices out in
> > > the wild that somehow have a different default?
> >
> > This patch is currently queued for 6.10 so there should be time to get
> > this sorted.
> >
> > My fallback plan was to add further (device-specific) default addresses
> > in case this turned out to be needed (e.g. this is what the Broadcom
> > driver does).

The offending commit was just sent on to the networking tree for 6.9 so
I went ahead and added the Trogdor default address to the address check
for now:

	https://lore.kernel.org/r/20240425075503.24357-1-johan+linaro@kernel.org/

We can always amend this later if it turns out to be needed.

> > I assume all Trogdor boards use the same controller, WCN3991 IIUC, but
> > if you're worried about there being devices out there using a different
> > address we could possibly also use the new
> > "qcom,local-bd-address-broken" DT property as an indicator to set the
> > bdaddr quirk.
> 
> They all should use the same controller, but I'm just worried because
> I don't personally know anything about how this address gets
> programmed nor if there is any guarantee from Qualcomm that it'll be
> consistent. There are a whole pile of boards in the field, so unless
> we have some certainty that they all have the same address it feels
> risky.

Hopefully Janaki and Qualcomm will provide some answers soon.

And otherwise we have another fall back in that we can use the
"qcom,local-bd-address-broken" property for Trogdor.

> > We have Qualcomm on CC here so perhaps Janaki, who should have access to
> > the documentation, can tell us what the default address on these older
> > controllers looks like?
> >
> > Janaki, are there further default addresses out there that we need to
> > consider?
> >
> > Perhaps "39:98" can even be inferred from the hardware id somehow (cf.
> > bcm4377_is_valid_bdaddr())?
> >
> > Doug, could you please also post the QCA version info for Trogdor that's
> > printed on boot?
> 
> You want this:
> 
> [    9.610575] ath10k_snoc 18800000.wifi: qmi chip_id 0x320
> chip_family 0x4001 board_id 0x67 soc_id 0x400c0000
> [    9.620634] ath10k_snoc 18800000.wifi: qmi fw_version 0x322102f2
> fw_build_timestamp 2021-08-02 05:27 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> [   14.607163] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target
> 0x00000008 chip_id 0x00000000 sub 0000:0000
 
> ...or this...
> 
> [   12.899095] Bluetooth: hci0: setting up wcn399x
> [   13.526154] Bluetooth: hci0: QCA Product ID   :0x0000000a
> [   13.531805] Bluetooth: hci0: QCA SOC Version  :0x40010320
> [   13.537384] Bluetooth: hci0: QCA ROM Version  :0x00000302
> [   13.543002] Bluetooth: hci0: QCA Patch Version:0x00000de9
> [   13.565775] Bluetooth: hci0: QCA controller version 0x03200302

Thanks, the Bluetooth driver output was what I was looking for but the
wifi output may also provide some insight.

> Just as a random guess from looking at "8" in the logs, maybe the
> extra 8 in 3998 is the "target" above?

Yeah, possibly, but it seems we won't be able to use the version info
without further details from Qualcomm.

> ...though that also makes me think that perhaps this chip doesn't
> actually have space for a MAC address at all. Maybe they decided to
> re-use the space to store the hardware ID and other information on all
> of these devices?

All of these controllers apparently have storage for the hardware ids so
I'd be surprised if they didn't have room also for the address.

Looking at the backstory for this, it seems like Qualcomm intentionally
broke the bdaddr quirk so that controllers which had been provisioned
with a valid address would continue to work back when WCN3990 was the
only device that set the quirk. So presumably WCN3990 and later
controllers all have OTP storage for the address (even if I guess in
theory it could have been done just for, say, WCN3998 which was added
just after):

  5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990") (2019-02-19, matthias)
  e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts") (2019-04-18, qcom)
  523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998") (2019-04-26, qcom)

Johan

