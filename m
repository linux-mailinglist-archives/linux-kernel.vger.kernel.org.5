Return-Path: <linux-kernel+bounces-107853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2078880282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6062852C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE5E1118E;
	Tue, 19 Mar 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJY+9+pS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF27470;
	Tue, 19 Mar 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866331; cv=none; b=n7GEtrU6Dmlo+vxNWVdp0evU16q+28JCA7uVyOlR940fmSZeRF43tsc+Sr0g78mlPI5WYeHUv+wtGBBywkyGl7lBPqHDlnZCz6CDEtZoLb9VccB8WjFrpUehIY1Nd2cMgXMJWGq2ofq9HQ/oNKDkbsRIJUggQDNbTNd/Cz/rhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866331; c=relaxed/simple;
	bh=dYsylaBpQOp3sMEqxBcd5E0VBO1SUJjmx6IkRhLuU/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNmYiXpgMCopPBR1OZmHmHbyc9um6HsR5Rt85FMZ0MnvFXmR0QXGSalsKALDRuu0PxXxcIp4r7JwKwsQ/uBdpNFiVx3ZNk6EPqQrEJqAjtiDtJ5B+Z+5RbIdzzlZ7oWsDvuQHF4OykUsR9iliXa6dbAJ5b/Mb8gk6h0GZrW0P0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJY+9+pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81801C43394;
	Tue, 19 Mar 2024 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710866330;
	bh=dYsylaBpQOp3sMEqxBcd5E0VBO1SUJjmx6IkRhLuU/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJY+9+pSarDhpFmWIuEdBfUThaZYx4IzquJlP5O64VzWFDoFioQINcZi4p+yopd6F
	 ErebcMpVyh4KjLRkxscbDd7pdoed6R/I3g9++/WFyZQPcZ8z17rWY3gKGmaeCYZk64
	 hn+/Y64HGirKPes9zYqyBKvE/jnlNtWaKjws6jjAhQ1G4V31ooEJqiMm4m0c33GZBa
	 6NWaIKh5JXdu1eel98bZoLAH92veFrGvDHWgbuyrJSiSjmlVz95bjBEweJdwkSCB8T
	 mVKrcpSYzfMonTbtZj6OW2xbxjp/3XC8WWfwU3MvA5UJx3oYj8gJ9VE339DdVziiOI
	 X470z+WxwiZlg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmcUK-000000000ul-22u3;
	Tue, 19 Mar 2024 17:38:57 +0100
Date: Tue, 19 Mar 2024 17:38:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
Message-ID: <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org>
 <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:
> On Tue, Mar 19, 2024 at 8:30 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > device address in big-endian order when setting it using the
> > EDL_WRITE_BD_ADDR_OPCODE command.
> >
> > Presumably, this is the case for all non-ROME devices which all use the
> > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> > use a different command and expect the address in little-endian order).
> >
> > Reverse the little-endian address before setting it to make sure that
> > the address can be configured using tools like btmgmt or using the
> > 'local-bd-address' devicetree property.
> >
> > Note that this can potentially break systems with boot firmware which
> > has started relying on the broken behaviour and is incorrectly passing
> > the address via devicetree in big-endian order.
> >
> > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> > Cc: stable@vger.kernel.org      # 5.1
> > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/bluetooth/btqca.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Personally, I'd prefer it if you didn't break bisectability with your
> series. As it is, if someone applies just the first 3 patches they'll
> end up with broken Bluetooth.

It doesn't break the build, but yes, the device address would be
reversed for Trogdor machines for two commits and possible break any
previous pairings. That's hardly something to worry about.

So I consider this to be acceptable for sake of clarity, and especially
since these patches will be coming in from separate trees anyway.

> IMO the order should be:
> 1. Binding (currently patch #1)
> 2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
> 3. Bluetooth subsystem patch handling the quirk (currently patch #2)
> 4. Qualcomm change to fix the endianness and handle the quirk squashed
> into 1 patch (currently patch #3 + #4)
> 
> ..and the patch that changes the Qualcomm driver should make it
> obvious that it depends on the trogdor DT patch in the change
> description.
> 
> With patches #3 and #4 combined, feel free to add my Reviewed-by tag
> as both patches look fine to me.

I don't think it's worth spending more time and effort on this issue
(which should have been caught and fixed years ago) for this.

Johan

