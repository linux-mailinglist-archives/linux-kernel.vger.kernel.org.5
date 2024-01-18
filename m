Return-Path: <linux-kernel+bounces-29848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6A831457
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984B51C2114E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D411CAF;
	Thu, 18 Jan 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQGJ+MAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60631170A;
	Thu, 18 Jan 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565869; cv=none; b=ezTLZHHAznBmyTborYO+N55PkasmKqbTuDtESJZJGN3zKcnYL4pV8RiRtz5Ksdc5aZS2aVbaSnY4YrQTXXWc3bBl7W6g3pVsGyC/Od6tZhEVaKcdqUmfRuTKNz7xL4VLPF/NAQ8iHoM5wTQKECdX54A5t2TiJxQq65Lh6WdoesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565869; c=relaxed/simple;
	bh=/Frwy4cBveeSxvMgx3OjZscR3f48byOksWLqeCmuCRw=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=LyQLZT5pQL63LYN7ZLMxXfWRVYatJRl8UmTjj0s+GwIbpL+R+Ou9a+BoXo2XI19W01jqGoFL57sLRsxnNakDh6qs5MEMC6c+4YtorLZur/FQ2dOCEWUSGu8eGthw7XvUzH+A0aA35nqJDL6RUG83L76rOaNpuOaRGOZwhA3rxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQGJ+MAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197C3C433C7;
	Thu, 18 Jan 2024 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705565869;
	bh=/Frwy4cBveeSxvMgx3OjZscR3f48byOksWLqeCmuCRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQGJ+MAVvemjTDRtxWOquEkXyP9FZ9rDWI3WpkFGVvZzW0wHPmCyhAgNx4Y8RRbje
	 eqS8j2rIEFvwUd1FWZWN30IhP4bmHdOAOhFzMYnuAI7BJmyhFlxSDkYZKrPyw8D5CM
	 Aq3k3D+mNPPpJ/h41/FyvqT9TlDyeYqEa1X6SVTAPGAV0S5yYB6r0VISNO4I73Aycl
	 dt2KI7SroyN7E8awCf2HbjzT/qipOgoMSkrctWbCtrQzjjP0rMY4Hu1uVd93wSlvy7
	 ifLMM/bIWqO0fVaRHwpWHzaFhAyQstFrFUG9+fnvQ1O4YeZ49V2oD0fn5/j33+bdd9
	 Zo3afNDv2SU8w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQNb1-0001nu-0b;
	Thu, 18 Jan 2024 09:17:55 +0100
Date: Thu, 18 Jan 2024 09:17:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <Zajes1rCgGOY9jXe@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com>
 <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com>
 <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
 <CAD=FV=W61ZHYJADiR1CYgS-aNisDR4KoEA3RW2_8kW3KUd1g5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=W61ZHYJADiR1CYgS-aNisDR4KoEA3RW2_8kW3KUd1g5g@mail.gmail.com>

On Wed, Jan 17, 2024 at 01:52:08PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jan 10, 2024 at 12:12 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > So the first question is whether there actually is any boot firmware out
> > > > there which passes the BD_ADDR in reverse order?
> > >
> > > Yes, (at least) the boot firmware for sc7180-trogdor devices.
> > >
> > > hexdump -C /proc/device-tree/soc\@0/geniqup\@8c0000/serial\@88c000/bluetooth/local-bd-address
> > > 00000000  8c fd f0 40 15 dc
> >
> > Indeed, this should have been LE order.
> 
> In case it adds any extra data points, we also do similar with the
> WiFi MAC address and it also seems to be big endian.
> 
> lazor-rev9 /proc/device-tree/soc@0/wifi@18800000 # hexdump -C local-mac-address
> 00000000  8c fd f0 3e 3e 86                                 |...>>.|
> 00000006
> 
> lazor-rev9 /proc/device-tree/soc@0/wifi@18800000 # ifconfig wlan0 | grep ether
>         ether 8c:fd:f0:3e:3e:86  txqueuelen 1000  (Ethernet)

Yes, wifi and ethernet MAC addresses are always big endian (i.e. on the
wire as well as in UIs).

When the corresponding devicetree property for Bluetooth device
addresses was added, Marcel explicitly requested that the address be
provided in little-endian order:

	"I would prefer the boot loader actually providing the BD
	 Address in the correct byte order as the protocol expects and
	 not yet another form. The string representation is just for
	 reference since that is what most people have seen so far."

	https://lore.kernel.org/all/41A0C162-4AC5-4969-813D-9E2C7F5D5031@holtmann.org/

and this is also what made it into the binding:

	28517c02e1dd ("dt-bindings: net: document Bluetooth bindings in one place")

Perhaps someone should have pushed back at the time to avoid this
(apparent) inconsistency, but this is what we have since 2017.

Johan

