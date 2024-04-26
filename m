Return-Path: <linux-kernel+bounces-160134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB78B3995
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4864B247C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA9314882D;
	Fri, 26 Apr 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHUkCn0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D9147C71;
	Fri, 26 Apr 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140946; cv=none; b=fqG458mK9G+3IPTxUwO24yPkZQCUwamE4wkLx+RIJH1uQ5aCOwnB2eZ/bWU48eEk04oJoD2Gtzs0tgQn6kIdmeHRtAzEQZMCnCvL+2r1I6O1+wREmJjSGahRoYNOAhq2Mhv+sm53cZ6MXMA/SnMxdtBJOtCpsBIJaDlZ8rPU4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140946; c=relaxed/simple;
	bh=vHwphVY9R9gHlIczykudcfQXMFvgMLjNLlypjlDkYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2505pwVWq5lbnpvYy8ohZcEfwzL7mpAaOwSsXO+O+COSFERN9ofM4vLOiV0q5/YXhthHbshKahaPS+JXp146GdPH4tTb5ZcSjinxCOH5dlCdok6wkcggeRSRYXeoqzyphZkxeVlyT1hWqVjsslKctpfNpsHFLNZZXrchnISh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHUkCn0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F0C113CD;
	Fri, 26 Apr 2024 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714140946;
	bh=vHwphVY9R9gHlIczykudcfQXMFvgMLjNLlypjlDkYr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHUkCn0qyWJvHy+b7VEzxtGK24ZAHQXSQVCdjJjHLa49do+gq25/eEm8lIEU1RftA
	 nAOFlO31R0WT84k40Y+h6vFRtpAgLPLOv63f5jFWsGVghsSez5S3AI4SmnQo5cO4e/
	 SRBbrohz8KKfxMzHGrShkMS0hd5oaltGy65qbRjVi6DwDJdQ8hEFWk5vXLUQIafPzq
	 Zo3hIplTpEbLhrRC1LcIJ6eSwuDkWrFW+ZTXFRImHtwkIsfurYEOx0XfA+YjwrF254
	 lNBco8R2/eIzneVbtMr1W0yEoJkf3RfWWsktcESGZo7Uk8dnyNbcMB3+b3Dk8B+LP9
	 lN3XzObktbUuw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s0MMd-000000000Rx-2Fzy;
	Fri, 26 Apr 2024 16:15:47 +0200
Date: Fri, 26 Apr 2024 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Message-ID: <Ziu3E5hD7L8CAn-1@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
 <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>
 <Zip9vMHa2x-uW-pf@hovoldconsulting.com>
 <bb0e1baf-7e64-463a-8638-d403c7a29317@quicinc.com>
 <c10c94c4-5239-46d3-9b41-95e3c943e969@quicinc.com>
 <Ziuh5qO94076gT2G@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ziuh5qO94076gT2G@hovoldconsulting.com>

On Fri, Apr 26, 2024 at 02:45:26PM +0200, Johan Hovold wrote:
> On Fri, Apr 26, 2024 at 04:12:07PM +0530, Janaki Ramaiah Thota wrote:
> > On 4/26/2024 11:53 AM, Janaki Ramaiah Thota wrote:
> > > On 4/25/2024 9:28 PM, Johan Hovold wrote:
> > >>> ---------------------------------------------------------
> > >>> |   BDA            |      Chipset                       |
> > >>> ---------------------------------------------------------
> > >>> | 20 00 00 10 80 39  | WCN3988 with ROM Version 0x0200    |
> > >>> ---------------------------------------------------------
> > >>> | 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201    |
> > >>> ---------------------------------------------------------
> > >>> | 00 07 64 21 90 39  |  WCN3990                    |
> > >>> ---------------------------------------------------------
> > >>
> > >> Thanks a lot for these. I see now that the default Trogdor address Doug
> > >> reported (39:98:00:00:5a:ad) appears to comes from the fw too:
> > >>
> > >>     $ od -x crnv32.bin | grep 5aad
> > >>
> > >>     0000020 0000 0000 5aad 0000 3998 0008 0008 0000

I took a closer look at the configuration file format and it seems we
can just fetch the default address from the file. The driver is already
parsing it so this should be straight forward.

I'll cook up a patch.

Johan

