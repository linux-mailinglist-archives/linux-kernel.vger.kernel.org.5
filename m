Return-Path: <linux-kernel+bounces-159994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE878B3768
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85738B21766
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34A146A9E;
	Fri, 26 Apr 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CudDC94N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C33715E;
	Fri, 26 Apr 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135525; cv=none; b=pxGtmTy2P1pUczBbjjp9tX7qEQ+8GIF/LnzJj1SkqcjaCtvgzdUVE699OukAVQV2gqDEiUxu7sTKtjpMi0PUyItZb1yfjnqEVBDn4XvxdzhSgAl5wNhjtIuEtHYOsnqm/6vAcrHlIrSiPrZFaxrD2mqE9ffwSlzK6foT9ilh+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135525; c=relaxed/simple;
	bh=iS9C+v8odOTK6E1SnSMEn0Se9B5pqsQ8ixkLHQCB1Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl3Jw1ojQDNu422l6RD2bg8EYpX6M80YrS9xidR8WNBa4CGlsx+hfssy+/+2BKu116EHuD6HpV6Y4sJsmNwc3LXTkfiSDnSCiD1dRuC5gyDOHf+5R1OxzJJKmwW86oCwwZHzD+oAzwJtx9x3QT1u2GkA2V/cs1qxTnatpE9gdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CudDC94N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DBDC116B1;
	Fri, 26 Apr 2024 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714135525;
	bh=iS9C+v8odOTK6E1SnSMEn0Se9B5pqsQ8ixkLHQCB1Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CudDC94N4c2KaoET/lq+RGNVMilmMEq5P4LGB6ER77suK4XenFv/TTEiDhxj6A6JJ
	 REdW4Mon161EvCE+B1s89JzFrI3i9VyOiZ8HDK1FrRqlEatJDJitnrDKUQTFk5DvvQ
	 JdTI+GjWSNIIzKlcvMlINe9alDHMEt15g4MhGJUV1mYl1uzy92CdSpPsZFDRXAOJj2
	 eQhl7c4QuMYdT+j9fPdfkw3VuIt1V5DhrHQB0A4wyanA+O6yV9jAz0LGjMCJuX1K5a
	 CdgdE807ARIZIqqlu2XmTFg5ZIjP2T/AGv+FibdkZghW6soY4IUsla/XXGWh8i3m2N
	 9PB83DntvrQFQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s0KxC-000000005fQ-2hYf;
	Fri, 26 Apr 2024 14:45:26 +0200
Date: Fri, 26 Apr 2024 14:45:26 +0200
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
Message-ID: <Ziuh5qO94076gT2G@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
 <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>
 <Zip9vMHa2x-uW-pf@hovoldconsulting.com>
 <bb0e1baf-7e64-463a-8638-d403c7a29317@quicinc.com>
 <c10c94c4-5239-46d3-9b41-95e3c943e969@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c10c94c4-5239-46d3-9b41-95e3c943e969@quicinc.com>

On Fri, Apr 26, 2024 at 04:12:07PM +0530, Janaki Ramaiah Thota wrote:

> Please note BDA values listed below are in the firmware (FW) data
> order, but the actual BDA value should be in the reverse of that order.

Thanks for clarifying. I realised this when I looked at the hexdump for
the Trogdor firmware.

> On 4/26/2024 11:53 AM, Janaki Ramaiah Thota wrote:
> > On 4/25/2024 9:28 PM, Johan Hovold wrote:
> >>> ---------------------------------------------------------
> >>> |   BDA            |      Chipset                       |
> >>> ---------------------------------------------------------
> >>> | 20 00 00 10 80 39  | WCN3988 with ROM Version 0x0200    |
> >>> ---------------------------------------------------------
> >>> | 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201    |
> >>> ---------------------------------------------------------
> >>> | 00 07 64 21 90 39  |  WCN3990                    |
> >>> ---------------------------------------------------------
> >>
> >> Thanks a lot for these. I see now that the default Trogdor address Doug
> >> reported (39:98:00:00:5a:ad) appears to comes from the fw too:
> >>
> >>     $ od -x crnv32.bin | grep 5aad
> >>
> >>     0000020 0000 0000 5aad 0000 3998 0008 0008 0000

It seems the most significant bytes here indeed do reflect the hardware
even if it's not entirely consistent:

	WCN3988		39:80

	WCN3990		39:90
	WCN3991		39:98

but I guess that doesn't help much unless also the remaining bytes on
WCN3988 and WCN3990 can be inferred somehow.

Johan

