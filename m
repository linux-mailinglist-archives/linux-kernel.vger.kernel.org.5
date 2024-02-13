Return-Path: <linux-kernel+bounces-63853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B86853589
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D98B26813
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AE15F57E;
	Tue, 13 Feb 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKCU/dDh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04F5F48A;
	Tue, 13 Feb 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840180; cv=none; b=XnoSBgjADhEwHOKrRQaDiDidNArNsME1+dKa5NgwxJLfXmT24LjeuKBh1pwLnSacExI1BsFDAytcGfZmYCexfbQOMpST45oQSx6SdRSJEAiYZw23Eaxn1uuhaZcgEPrHQFsH1PpCNGniHz9bxT8+Hg4XN1KEFycHpAvm0nfxh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840180; c=relaxed/simple;
	bh=raewERgjnOaT1e4+EDmQFCjp+2Q+nD/RhhrjpVO2oiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=humhp7feYN5H0bUtlYb/4pggrEEJoRN66/Y2cSWkkzU5dpB2/DS5QG7Ka6Ahm/KvqoS4OrUqBlZxx6ix4gc1Sh+BRiZNILU+WBnA/f8kArRwGVCg8GuZyISSwIM1qNsw0IJnp9zR+NiTBKj+AFjQXNfpt7RIPUW9TfGKYQVkXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKCU/dDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E84C433F1;
	Tue, 13 Feb 2024 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707840179;
	bh=raewERgjnOaT1e4+EDmQFCjp+2Q+nD/RhhrjpVO2oiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKCU/dDhcjf0FYDMeJlnF2d1lTWHBDod3yoygbRluKaVtF2rNY0FqBkPP3ihYEhxe
	 MduQWcNBtMVSAEB2FPalhUAeV7tR0wd93T/iob7anoMyfGj/wHM0c5p56fXYxFl6K+
	 xzZYE7E2PDu+x1g6LE4IZY72wFLBp4HWBtJRiwrynhTZFbpxxhuuAW7/Li71TBQIzu
	 fKFZm9dCMp2FuUmo65A/nZ2k3XnnmWG15H6S1ZQPUokMz92sHgDDLeLNTxWL243RTJ
	 7fdaSQbAjve1e8C5yYV7PWyQVAXyxvsVU8Itn4RADKLXkU/hyISFQ9Tn/oIheRh3OL
	 9kadbBY5NJ6Og==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZvFb-000000001ga-3I2Y;
	Tue, 13 Feb 2024 17:03:15 +0100
Date: Tue, 13 Feb 2024 17:03:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZcuSwy0quwKoZkkm@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <Zct_tB-y7HbZU1dp@hovoldconsulting.com>
 <ZcuQ2qRX0zsLSVRL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuQ2qRX0zsLSVRL@google.com>

On Tue, Feb 13, 2024 at 03:55:06PM +0000, Matthias Kaehlcke wrote:
> On Tue, Feb 13, 2024 at 03:41:56PM +0100, Johan Hovold wrote:
> > On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > > device address in MSB order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.

> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > > 
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passing
> > > the address via devicetree in MSB order.
> > > 
> > > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> > > Cc: stable@vger.kernel.org      # 5.1
> > > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Can we go ahead and merge this one to get this fixed in 6.8?
> > 
> > I've spoken to Bjorn Andersson at Qualcomm about this and he is in
> > favour of doing so. The only people actually using the devicetree
> > property should be the Chromium team and they control their own boot
> > firmware and should be able to update it in lockstep (and Android uses
> > some custom hacks to set the address that are not in mainline).
> 
> Unfortunately it's not as trivial as it sounds for Chrome OS. The boot
> firmware is controlled by Chrome OS, however for any baseboard (e.g.
> 'trogdor') there is a larger number binary firmware packages, one
> for every model derived from that baseboard. There can be dozens of
> models. Chrome OS Firmware releases are qualified and rolled out per
> model. FW qual may involve the ODM, usually there are multiple ODMs
> per board. In an absolute emergency it would be possible to coordinate
> a qual and synced rollout for all models, but it's definitely
> non-trivial in terms of operations.

Ok, fair enough.

Could you please provide a list of the compatible strings that you guys
currently use and I can add new compatible strings for those, while
keeping the current ones for backwards compatibility with older boot
firmware?

Johan

