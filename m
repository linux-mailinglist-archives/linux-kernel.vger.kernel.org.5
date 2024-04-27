Return-Path: <linux-kernel+bounces-161189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFFC8B4825
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1FF1C20CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A58145B29;
	Sat, 27 Apr 2024 21:01:33 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689710E6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714251692; cv=none; b=LIAckZuDrwXPqkDcX9M9ra9zBj09NoQv63yjSALHAobRRVG0I773AdnaXeu2M3VROytVFIngm8Aq1C72hG3ro3gomadCmVSr/FEutUmZEq1spozjRMZQhXY1MYGuzoUDW1xMf+q0JRwbT4439ICOjzdOlLysnLo8dZ6owMfRzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714251692; c=relaxed/simple;
	bh=ypscR+3qCxpM1RhQ3YAYgMq1bVR/OwF890AX19OR/fA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=S0S2DugCa4Kfh89uPy5sPnuLsacoe7lcoof6llvxiDxOm6Yhp0BI1GE3P7lbOSgi0rl9aNi089Trc8bNB9z+kdwyeQLwvj78+XBEuN8BC+PJ0oulhCpgl0u6ERRc1K4QnXmcq2dGTN19P7/XcXWe6u5yqRdkU1e7yFJRQQlDAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-184-vJTZZFxDOK-mjlH1jpPhsQ-1; Sat, 27 Apr 2024 22:01:19 +0100
X-MC-Unique: vJTZZFxDOK-mjlH1jpPhsQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Apr
 2024 22:00:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Apr 2024 22:00:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Alan Stern
	<stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gerd Hoffmann
	<kraxel@redhat.com>
Subject: RE: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Thread-Topic: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Thread-Index: AQHaloHtuZ6Ib4ELhkipVPWjjF4HNLF8nf2w
Date: Sat, 27 Apr 2024 21:00:48 +0000
Message-ID: <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
References: <20240424195951.3749388-1-linux@roeck-us.net>
In-Reply-To: <20240424195951.3749388-1-linux@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Guenter Roeck
> Sent: 24 April 2024 21:00
>=20
> Testing ohci functionality with qemu's pci-ohci emulation often results
> in ohci interface stalls, resulting in hung task timeouts.
>=20
> The problem is caused by lost interrupts between the emulation and the
> Linux kernel code. Additional interrupts raised while the ohci interrupt
> handler in Linux is running and before the handler clears the interrupt
> status are not handled. The fix for a similar problem in ehci suggests
> that the problem is likely caused by edge-triggered MSI interrupts. See
> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> edge-triggered MSI") for details.
>=20
> Ensure that the ohci interrupt code handles all pending interrupts before
> returning to solve the problem.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Only repeat if the interface is still active
>=20
>  drivers/usb/host/ohci-hcd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 4f9982ecfb58..bb6b50b4a356 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  =09/* Check for an all 1's result which is a typical consequence
>  =09 * of dead, unclocked, or unplugged (CardBus...) devices
>  =09 */
> +again:
>  =09if (ints =3D=3D ~(u32)0) {
>  =09=09ohci->rh_state =3D OHCI_RH_HALTED;
>  =09=09ohci_dbg (ohci, "device removed!\n");
> @@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>  =09}
>  =09spin_unlock(&ohci->lock);
>=20
> +=09/* repeat until all enabled interrupts are handled */
> +=09if (ohci->rh_state !=3D OHCI_RH_HALTED) {
> +=09=09ints =3D ohci_readl(ohci, &regs->intrstatus);
> +=09=09if (ints & ohci_readl(ohci, &regs->intrenable))

Doesn't the driver know which interrupts are enabled?
So it should be able to avoid doing two (likely) slow io reads?
(PCIe reads are pretty much guaranteed to be high latency.)

=09David

> +=09=09=09goto again;
> +=09}
> +
>  =09return IRQ_HANDLED;
>  }
>=20
> --
> 2.39.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


