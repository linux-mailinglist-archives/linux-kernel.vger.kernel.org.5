Return-Path: <linux-kernel+bounces-2858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA18162E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706E51F21726
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E034AF93;
	Sun, 17 Dec 2023 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vTuABx1C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574154B134;
	Sun, 17 Dec 2023 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=283olUZWXoRvFe1qG4d0iFlOJnatVaq3Eq/A7zg0yes=; b=vTuABx1CIetIEPDr/0CJFyKpJO
	kCxltH2Kb9zpvrcINBN+X6O1BV+SYIrgoMqVrSUY9YpfZDFGEzQ51cBs8x58GAlL03PS5JduGqiv5
	5DVswWL5TYFtMb3gu7zSmxXN/USpBEsUBWIQqgy4JSMMZf+byXisoivw0OgLTuKpTDyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEzve-003AuU-1w; Sun, 17 Dec 2023 23:48:10 +0100
Date: Sun, 17 Dec 2023 23:48:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12 net-next] qca_spi: Improve SPI IRQ handling
Message-ID: <0a372815-ce13-4254-ab3b-12bc2ca1b1a2@lunn.ch>
References: <20231214150944.55808-1-wahrenst@gmx.net>
 <20231214150944.55808-3-wahrenst@gmx.net>
 <c5b81005-e309-46df-b534-b24814d10006@lunn.ch>
 <8cdac20c-e860-4157-95c0-6e8250e50af5@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cdac20c-e860-4157-95c0-6e8250e50af5@gmx.net>

On Sun, Dec 17, 2023 at 08:17:56PM +0100, Stefan Wahren wrote:
> Hi Andrew,
> 
> Am 17.12.23 um 19:14 schrieb Andrew Lunn:
> > On Thu, Dec 14, 2023 at 04:09:34PM +0100, Stefan Wahren wrote:
> > > The functions qcaspi_netdev_open/close are responsible of request &
> > > free of the SPI interrupt, which wasn't the best choice because
> > > allocation problems are discovered not during probe. So let us split
> > > IRQ allocation & enabling, so we can take advantage of a device
> > > managed IRQ.
> > Could you replace the kernel thread with a threaded interrupt handler?
> the kernel thread is responsible for receiving, transmitting and reset
> handling (there is no GPIO reset in this driver) which must be
> synchronized along the same SPI interface. The interrupt just signalize
> a chip reset or a received packet is available.
> 
> Could you please elaborate this request more in detail:
> What is the problem with the kernel thread?
> Why should i use the threaded interrupt as a replacement instead of e.g.
> workqueue?
> 
> Please don't get me wrong, but i need to convince my employer for such a
> big rewrite.

I don't know this driver, which is why i asked the question. Its just
a suggestion. Maybe it makes no sense. But there have been other SPI
based Ethernet drivers which have been simplified by using threaded
interrupts rather than a kernel thread or a work queue, since the
interrupt core does all the thread management, and in particular the
creating and destroying of the thread which drivers often get wrong.

	 Andrew

