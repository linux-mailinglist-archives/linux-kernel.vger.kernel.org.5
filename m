Return-Path: <linux-kernel+bounces-148917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D229B8A88EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F051F23C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D4716FF53;
	Wed, 17 Apr 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="rQrw7v4Q"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5416FF3D;
	Wed, 17 Apr 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371592; cv=none; b=PYLpkCT8954vcAJfTPBdn4pQv1FNmCTObvJWUjNy1OBzCM95IjJSexkISDMkQTjZVEco+paMnZwqVvPvq6PtEaDChJ+hPKCCqgN2JVlozx/daz4op5wJuHVuWTkuJsvZeF3Ok/qqw00cXIlbLtsNg7rxf7u3PBqqyUvfI9JCR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371592; c=relaxed/simple;
	bh=H16RDcSXiwW3boEkfjBDObKtkSAaLyjSW/xLSJ2yxrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMQgqKgBroqCSYQLXG6cflmZe4LCzBWKXkVt84y4Tm1LXCW0hX2lttlbuxS9EEOL4b2T5LUXQTEJZiEV7svj4v6l/qwAzNbiwsZk42k5Qbw5DXTgtsoITaG936LHEnoeemPW1zrFEnaQn1Bn8Rwa4jBZbWNoSG3xX33wWqg3iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=rQrw7v4Q; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713371575; x=1713976375; i=parker@finest.io;
	bh=ppksCirNLcq+JKWP3akPmNVgbZGLQOhKntxR0CMxoqs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rQrw7v4Q4t5q4tKKuBEcxcDn0kHN+kfQxQ5FOaFrNaQmaozn9Gz/o8bStUoK0FrA
	 k+Gns8ip7itWXIkGJYxOD4FiNn1wjprkpVjx95yEu+a9vpQK9kNjyqlXCt5YADSTC
	 6OEWqmEEbv6DqOIbW1RY5QeCZt0KcBcoTOtPSdiUKAuO7lJlTEcPSPnZ5n0YEn+vg
	 f0MwO5b+QjvpTSo+qJftyYxHVPBgYpCkrnp2BGEJ/2iuY1rtK+DyQ1xEgBWwmvCs7
	 TTEWXDOKElYNz0SsT3e033UJTf8BdLCNZ07NTU+id7lrpAPfjIyh6+7iDEj/4tyZz
	 X9A5Ep4KNXEQ8Dz/OA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M4oHb-1sfiyx47OH-00yxsI; Wed, 17 Apr 2024 18:32:55 +0200
Date: Wed, 17 Apr 2024 12:32:53 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 8/8] serial: exar: fix: fix crash during shutdown if
 setup fails
Message-ID: <20240417123253.0f9d4555@SWDEV2.connecttech.local>
In-Reply-To: <2024041730-abstain-dynamite-054a@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
	<1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>
	<2024041746-galvanize-satchel-09a4@gregkh>
	<20240417082413.70397ccf@SWDEV2.connecttech.local>
	<2024041730-abstain-dynamite-054a@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5a/Hvcp5OCDn59rw5DyL60VoHZtITCe4NYTNqxVWOjiJ9be6i6K
 WKOzRqy/9bWQQHznZLlao120G5VWUWZxbtLXpkZhePqHyz9gVeRzJ/zGvaurDkYdlYfiHbW
 ZRVSd5UrVOvnoyJ8ryyRP9x2POHcaIgpS5zPiqa9I1AEomZr4RVv0X2xMtf9+BxUh1e1ybO
 o4/rRc/koJZzuliRL1mOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NXiMkn8pYOk=;N+ZzIE0jdAiqGZ+cJWp7dZIwUzT
 x2lfqQrxMncWoSozPTvi3TKrG5QIcmnSJT29x4rezzZMzMhYEu5FxNsZdrYT1c0VfZJRRC3DC
 tl1KAP4/iccU/oApSPWJdbM+P5NW5EJgLrv4RIwJJ+bAXN+Sq9HCAW7vczEe5YUGd8XW8e5U6
 eFxMJmMeNp8m8dxlQskZ0IhfnPPk6cT/5N9OBBgA9+il1zUOrbMD8VCbKXPoc8g4pJ25IV4Ao
 0dXFOSmLSxcYLUZMMTEZSZQAqzj8uFcF6D++EG/DiIG9CkDxGEsb/ISg5HusotnKRr11I1SfP
 CnXQ3n3Yc0t5YzkejxNr+EUAEGGbcgysS5L8Q7wBo4ijLZ+0x8K1etVlKxbvK07Zlv+Nun/FQ
 BrOPgdCmsnYimzjM6CqCT8UMzoub1ZjdiwYQ080lgQ787JzPPdIgFIFkLqSlJBGwZquvtZlGs
 +Yl5GhasV/oL7D/fF3PpC1/800BQvt2bSac5+t/6s9gKVVzyvE74jl1tFPzLLDevPBqbwfF8a
 +PUUKsfiB155D2k1yaGRECyma1H2ijVNN9uPK3xIx3kycXBQHCc/DP6kh2g0+8LD178Y57VwU
 loiWRtOG1dVVjrVnyyk7An9XwaPB1XrXbkevU02CXBxvTkd4qVWNWthy8bbOex9hEJXGPbBVu
 ly5NHbgHkSpO2Es6QKSOFQeniCYnYes+jvpv/kI/RgzoflToi2MYHTZmYJX+RH+5A3g1/Pnmf
 3shRKjzTN12LYnDNOrntstXWYsw4se+sr7CAS4Ge9q5RS/H6rDdleQ=

On Wed, 17 Apr 2024 15:30:56 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 17, 2024 at 08:24:13AM -0400, Parker Newman wrote:
> > On Wed, 17 Apr 2024 13:19:07 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > > On Tue, Apr 16, 2024 at 08:55:35AM -0400, Parker Newman wrote:
> > > > From: Parker Newman <pnewman@connecttech.com>
> > > >
> > > > If a port fails to register with serial8250_register_8250_port() t=
he
> > > > kernel can crash when shutting down or module removal.
> > > >
> > > > This is because "priv->line[i]" will be set to a negative error co=
de
> > > > and in the exar_pci_remove() function serial8250_unregister_port()=
 is
> > > > called without checking if the "priv->line[i]" value is valid.
> > > >
> > > > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_exar.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/ser=
ial/8250/8250_exar.c
> > > > index 501b9f3e9c89..f5a395ed69d1 100644
> > > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > > @@ -1671,7 +1671,8 @@ static void exar_pci_remove(struct pci_dev *=
pcidev)
> > > >  	unsigned int i;
> > > >
> > > >  	for (i =3D 0; i < priv->nr; i++)
> > > > -		serial8250_unregister_port(priv->line[i]);
> > > > +		if (priv->line[i] >=3D 0)
> > > > +			serial8250_unregister_port(priv->line[i]);
> > >
> > > Is this a bug in the current driver?  If so, can you resend it on it=
s
> > > own so we can get it merged now?
> > >
> >
> > Yes it is, I can split this one out and send it on its own.
>
> Great!  Bonus points if you can find the commit id it fixes and add a
> "Fixes:" tag to the signed-off-by area.  If not, I can guess :)
>
> thanks,
>
> greg k-h

After looking at this again and doing some testing this bug does not actua=
lly
happen with the driver in its current state. During my development I had i=
t
happen but that would have been due to me messing around.

When "priv->line[i]" < 0 it breaks out of the for loop and priv->nr is set=
 to "i".
so only the successfully registered ports will be unregistered in exar_pci=
_remove().

..
        for (i =3D 0; i < nr_ports && i < maxnr; i++) {
                rc =3D board->setup(priv, pcidev, &uart, i);
                if (rc) {
                        dev_err(&pcidev->dev, "Failed to setup port %u\n",=
 i);
                        break;
                }

                dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, t=
ype %d\n",
                        uart.port.iobase, uart.port.irq, uart.port.iotype)=
;

                priv->line[i] =3D serial8250_register_8250_port(&uart);
                if (priv->line[i] < 0) {
                        dev_err(&pcidev->dev,
                                "Couldn't register serial port %lx, irq %d=
, type %d, error %d\n",
                                uart.port.iobase, uart.port.irq,
                                uart.port.iotype, priv->line[i]);
                        break;
                }
        }
        priv->nr =3D i;
..

Thanks,
Parker



