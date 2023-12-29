Return-Path: <linux-kernel+bounces-13152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFE820067
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567CB1F22CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372812B7F;
	Fri, 29 Dec 2023 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv8Pia6H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E62125DC;
	Fri, 29 Dec 2023 15:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12719C43391;
	Fri, 29 Dec 2023 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703865092;
	bh=7O3tlE/TnK1/XnaVJFlVImIMjHjO4tOg8Bzzxg1t2QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rv8Pia6HyhjgKIdp3aIC9TJ8IMuQkjU+xFoZYQHFVi3bYo0W7bq/M6eSRHSG9DCQ5
	 h+MlW7AW8pcTqylL0C2uuHXrOHgUX5YcbK1+5CMcYs5U2OXFGiJGialB+38u4IClI3
	 jPql9i4xdDjDokz2etKcR9gm7w0V+U3Nmp7cVYOkiIyL7n1RHKAU6wcHqJEGjUl3bX
	 QLmWQyhV9aLtxgYzafd9FOkdlyWr13sY2BEzw76VfSq+SqCxTJXVGGx1XpIibiXcvY
	 247PLrOXNl0gEp6P8BdWKcWTtTFzibE/m5QX67quu/JDl3zAeG1aD3Orx4IPnsSsQH
	 mr72NXNFs1p2A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJF8v-0005m6-1i;
	Fri, 29 Dec 2023 16:51:25 +0100
Date: Fri, 29 Dec 2023 16:51:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Neal Gompa <neal@gompa.dev>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Felix Zhang <mrman@mrman314.tech>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as
 invalid
Message-ID: <ZY7q_XOKya1MjH9h@hovoldconsulting.com>
References: <20231227101003.10534-1-johan+linaro@kernel.org>
 <CAEg-Je-WJZGMgurcQY3p9wQffEJmN3OsiK_9ictsFV3uTGdS9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je-WJZGMgurcQY3p9wQffEJmN3OsiK_9ictsFV3uTGdS9g@mail.gmail.com>

On Fri, Dec 29, 2023 at 10:11:32AM -0500, Neal Gompa wrote:
> On Wed, Dec 27, 2023 at 5:10 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > A recent commit restored the original (and still documented) semantics
> > for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
> > is considered invalid unless an address is provided by firmware.
> >
> > This specifically means that this flag must only be set for devices with
> > invalid addresses, but the Broadcom BCM4377 driver has so far been
> > setting this flag unconditionally.
> >
> > Fortunately the driver already checks for invalid addresses during setup
> > and sets the HCI_QUIRK_INVALID_BDADDR flag, which can simply be replaced
> > with HCI_QUIRK_USE_BDADDR_PROPERTY to indicate that the default address
> > is invalid but can be overridden by firmware (long term, this should
> > probably just always be allowed).
> >
> > Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> > Cc: stable@vger.kernel.org      # 6.5
> > Reported-by: Felix Zhang <mrman@mrman314.tech>
> > Link: https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech/
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> Looks good to me. This replaces the other patch[1], I take it?

Yes, but as Sven explained here, that patch is also correct even though
that wasn't obvious from just reading the commit message (which should
be amended in my opinion):

	https://lore.kernel.org/asahi/AB87C916-9CF9-4B8C-AFF5-74CA4151C4FC@svenpeter.dev/
 
> Reviewed-by: Neal Gompa <neal@gompa.dev>

Thanks for reviewing.

> [1]: https://lore.kernel.org/asahi/aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech/

Johan

