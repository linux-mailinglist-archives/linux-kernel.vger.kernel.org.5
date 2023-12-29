Return-Path: <linux-kernel+bounces-12999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A481FE39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35FB1F217E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6948488;
	Fri, 29 Dec 2023 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbZfQ7s9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2979DF;
	Fri, 29 Dec 2023 08:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF00AC433C8;
	Fri, 29 Dec 2023 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703839461;
	bh=BKbW0iQ7EYDzIsWyVqNMV+YR/FLupt8q7knhPlO6dmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vbZfQ7s9y3e7sbS5nrDW81XzEHi6PiCRF9aNHDJ9MNhnFeYM5bzkf1r9lcWj7l7UP
	 X2XVrOiIsNrnkvw/CRFaOB1H5/x1Tm36ptZemKYgJtB4lmtOrztS5/uPDPymTXGbtx
	 DXJn/WCmeaq7qT8r/7kQDHTG3KMkiuOYIPqbUfbo=
Date: Fri, 29 Dec 2023 08:44:18 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror
 detachment
Message-ID: <2023122900-commence-agenda-db2c@gregkh>
References: <20231218164532.411125-2-mailingradian@gmail.com>
 <4713072.LvFx2qVVIh@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4713072.LvFx2qVVIh@z3ntu.xyz>

On Thu, Dec 28, 2023 at 10:59:59PM +0100, Luca Weiss wrote:
> On Montag, 18. Dezember 2023 17:45:33 CET Richard Acayan wrote:
> > In 6.7-rc1, there was a netif_device_detach call added to the
> > gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> > the netif device and suppresses pings (ICMP messages) and TCP connection
> > requests from the connected host. If userspace temporarily disconnects
> > the gadget, such as by temporarily removing configuration in the gadget
> > configfs interface, network activity should continue to be processed
> > when the gadget is re-connected. Mirror the netif_device_detach call
> > with a netif_device_attach call in gether_connect to fix re-connecting
> > gadgets.
> 
> (+Cc Thorsten Leemhuis)
> 
> This appears to fix the regression on a 6.7-rc5-based build for
> qcom-msm8974pro-fairphone-fp2, that the NCM network gadget doesn't work.
> I've also heard reports from qcom-sdm845 and a PXA1908-based phone (if
> I see this correctly) about issues on 6.7.
> 
> In postmarketOS on the device side the usb0 interface doesn't get the IP
> address assigned correctly it seems, but it seems to behave a bit
> inconsistently - but always broken.
> 
> Anyways, with this patch everything looks good again. I hope this makes
> it for 6.7 final still.

It will have to wait until 6.8-rc1, sorry.

