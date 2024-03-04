Return-Path: <linux-kernel+bounces-90137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74086FAE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93B51F228C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251C1642A;
	Mon,  4 Mar 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVYuiS1d"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3416429;
	Mon,  4 Mar 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537515; cv=fail; b=GvDGayGaJycpLWTgvCigr2DCHNy+plC7TryKwjgET4Wu4DnmvNa43U10hFRBoYuetddhIe8gTKhuyCZTDV7HeavhtIYz8+xuPGF9Zx6hBN5mlSMHw/Kn1WWZFDU3ye12Kq+kr0QxB/OEbbC3JSiTJ2eXTYQl0y5qjMHjhf1ZaNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537515; c=relaxed/simple;
	bh=GKmuv+kiqcGTTQUt31n4NAAA0E5BzXFZ3JnToX7aOUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajA4XKyaTtyxShG6sSul+8OczO1AisVifm+iUDK9QcRgAZd/ZMfmt4zQ/MvlxSlH0oFYuEHa234D06RtJq8v7q5lwuonQGXnG3bTG+tlaNaKAqPFxjvh0K9ua7RJAq8q03zYmWtr7q+K4VhPg7ux0UjiYZ3X0IU6C4J9m46qNnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVYuiS1d; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF6Z54yzb6Rnlm2Wz/E4OYzhBgA0cgfNtubGdForIZpjtUkVX85pNmuSXYzOWE4T/4Gc1dUtwKibHyMkfTzSntXGHfcDY7WgUYiy0g/HRy0667P9dmrsgMufTarrxHcKCrjJumFubiqYG2+oyiTjr/sLQGIQq9OIYqt8nmDxbJagm4TTmX7vOWHLYQnck8M+JSllxDCik/Gmo/dLhPiVo0wn21rqj2uK88MML0NiG+4YxdS7dEbikmensglrvoohOaCNe6pgJmeRBz4DE8D395fh7iyzlk+0AoxmFgXgpaNSBLE+rpXnceG7QLKz61RCuOO+6zetiXj1kppRTRuefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKmuv+kiqcGTTQUt31n4NAAA0E5BzXFZ3JnToX7aOUE=;
 b=FY24lDQYYMCJgqKGNGagnIzf9saCfE980qXTLGIf9Fg/yEtB9/JevRi1IhRVUuMBr7FxKcWzLFjmzAx0e9d+49/Q+jFJ0QiMCbSLd5okBNi8S/bb/x/iL43rSSCcjnuoKFzTEHDDGQJ5H5mWNyltWyjo4VvWStaCFX6cuBNiTvGe9oproxs43+Sf54wxc82wWmTdfj3CXIZoq0Ufsf0TP+FCmuWh3W0jk0kL6D6Th3JwwBCNthJaQ4xfBSE6cNi+6B2+E71MQD+2YKWrjccX4eJGu8bOYvhJmXrKXoA7JOmWkIt33NU2TLj9k0xLtUDfp+2ajSsK1YjmcKEUyw6jIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKmuv+kiqcGTTQUt31n4NAAA0E5BzXFZ3JnToX7aOUE=;
 b=hVYuiS1dccllPUUg9rS9JuctIE38ep1o+rmKYWjDNNC1y78db3UlxMLD13rroiVO9qjgkWwcPsKsM0cFL7vACDeopZ3YN/OSTznqrp8NiQDhltRHqbEoL2eE3vmPjJ82GBAKGWuwZ5PcAC0c9FmdHBQaHuGrP8VVS6v4JU1Y5x0=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS5PR04MB9772.eurprd04.prod.outlook.com (2603:10a6:20b:677::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 07:31:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 07:31:49 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "robert.hodaszi@digi.com" <robert.hodaszi@digi.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Index: AQHabder1X9YMJ50WEuZehMzhpFcmLEnKz4AgAAEAoA=
Date: Mon, 4 Mar 2024 07:31:49 +0000
Message-ID:
 <AS8PR04MB8404FEA637E51E3B258BC28C92232@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20240304020712.238637-1-sherry.sun@nxp.com>
 <2e1b1eae2e9d3cedcd270e35cfcf8086b914b7ff.camel@siemens.com>
In-Reply-To: <2e1b1eae2e9d3cedcd270e35cfcf8086b914b7ff.camel@siemens.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS5PR04MB9772:EE_
x-ms-office365-filtering-correlation-id: aec94d66-af92-4eb8-3ac3-08dc3c1d2767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9NcfsptKh8PUNjLPReXzvEvjNRNKjN9SZxEbewMOsMzp9v1IG54kUFIq4pWZNi1ZITnx3qbm7sxiFFqhm4ssciUOuLh2BPKa7TnK5FwwlLYGQ1htQpHmu8tYnzSxKAXWXitSiFAna1LqrawhHBoDbayi6ZHYTQUnx3HShm8uZQCU9yKc2t0gohFpJemWhzmRxLUxeK/zC1AN0+5Jj4wglq9rKDDsBcJmVm5PJkJ2vsciMe6/y5Kmoe/Codv8/9PkTegtRWhvjTJ9gFj3VFMcArqR+047Teu8Svs69jqEgGTWp4DZsPiD65gkApLSEKpanGSZXtm0KhCyn+RDqIKofcDjWO2DgxG8/hOp5xDsUro21krAa9pwUeFls0znI/5Gr/VC5ZKB9+6wL6ZkThKnjofZrBkCQtxKl4Tm4Hazj9YoSYWbKpppNXP3MvdaXXco4wbtxbGJu9o58TCWusBfCcNh7n0DvnbnwC71N/M7CvF8gHtrgi8Ch8/O5raqn5gBi4nru5LXQ/3uu1PWmibuRGL/AAPZEmSfSAmjh6WOqzoowv/cJckKo2pcZ/oA4ulJR9m9ecPNrXxcfBEN6RXbn4KCv4mjyLYx+tWSb0VZkgvIrtT+4kJdOPBfeQ6LK/6TK2gWeBqK/Q81GR571/m66nYZPqU9mGyKxBVLFxa/z0pErhAJFAH8R0vYNQuXaYexYNqrmG3+4KrXOF7Uq0Gv4NuYQcpCVSzj+5s+0Vw6OCI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Bwn1nhk3W1IwUVE9ARNqJEU/C/LFkjZgDQvQakVyap6kXO5L6rCJplUg7C?=
 =?iso-8859-1?Q?f0FO94/CytaQrYUrnFl9kzQ9RfAQW67TJYww7OQaTYT/yWq1DLr8IkSDMe?=
 =?iso-8859-1?Q?GP8rlSw4yAR2DTMsOJ4Dv4K64sF1A1GKRQkY5/vXji16j1pndf7AWjvTWP?=
 =?iso-8859-1?Q?QEktQL/Kj+T0j5e12EajMIpNVrowl5nwwlPscyU6aunw5REupDREP0wDop?=
 =?iso-8859-1?Q?X+B+VehkrEwG0ZDS8lwLexuspvAWI6vdLBERe1XUi9Hhh6SedjW4RKFfgh?=
 =?iso-8859-1?Q?vz64bpLw5eH4Q95O2/eSlYDi5hu3mc9FgTqnx+hacg3g3iTvt61+OJDFUG?=
 =?iso-8859-1?Q?Fzs+xyN1/h7GebYyWkK0C0sGdkAN37tGMjdLJ31R5Ykz5UgriC7WFOZBI3?=
 =?iso-8859-1?Q?xFXKlYCgMJlloDAZK/80Pw3pQ/P8BNx6/QiLOkZeeEuUU8ObgllEnmwtsm?=
 =?iso-8859-1?Q?P++WIFV88m2pJ1tYJf72ztMa7X2Mq9AGXfhkFBcjPa1k/8L7Pb9lFWgEqf?=
 =?iso-8859-1?Q?CDzvznO/0nIEQvPoxlbPzZRn4FEepAJH2wmAXuyK9cBOlRiSJn+ST9fQep?=
 =?iso-8859-1?Q?zz79FohrosIj38nNL78NCNxPutAsDsl6wyZcXcNfaFsaCvU7chO4L2YVam?=
 =?iso-8859-1?Q?BoctOAY2J2QA0S+4e62iyvLPj5g2NMfHVDWWJ5E86t/zOfxofk2/wJC9h+?=
 =?iso-8859-1?Q?XxA1WIyWPvwcCcYUTJXxEQ3eL6OC25soEgGDa/0eu/l6sFvUrVQs6e1bA5?=
 =?iso-8859-1?Q?94F4aZwfkVbhH49yEdBDJ+u62L1/CEOYWsWoJ7LZAhpvuf5MZdd7ld7tGX?=
 =?iso-8859-1?Q?pzHJfiWC1Y2DzmzMfSqZOHo9Ry3fys5IHFpgiYivycs6TbelPfxxboeh66?=
 =?iso-8859-1?Q?osVNziW+zlSe0BS1SS3RnrMQ0L7ArwXzFHmK/EASMa28IBP3YPEczmfasn?=
 =?iso-8859-1?Q?mEgG7xhUiRetmDfBc+MxBvtqP807oOWiqO7OTYU6IgMRJICyMPvcsd+QQ7?=
 =?iso-8859-1?Q?QVvfsqJPmIckORk0DLwDqvBbADP2O+V8N4wDVyG1JJp7Tf5SZfr2DQ4kHy?=
 =?iso-8859-1?Q?qTStS40mNpPBvh1stU3Q7b06Hd4U/UmmUaH9q/z7/J3zBTiCXOWttjcJmM?=
 =?iso-8859-1?Q?77Zf7eHcBUUBo1vy3aJG4qGbnSlKIF7ssd3InZo4ANOOvNzsMB3bSiTUIZ?=
 =?iso-8859-1?Q?46yD75m7/Z7vzzZIcqpOImDj9aGYqz3pAymK5O4mlDGfCaZ77ku8uh9T/l?=
 =?iso-8859-1?Q?F9jUmVBO7VheO4S489clfW4ev2v2wrywLlWCdbiRkNGGZsKMvDv9OL8wnO?=
 =?iso-8859-1?Q?bdDlwg3cKAD88sAhsYOuNLHZImV4grUFvmqOHYBSJrbYzC2jrvgUMivt8Z?=
 =?iso-8859-1?Q?/A6GApRiMpvCSLfUI1O+kPND4eyyVozgJPp2TXsIvOCAXzeDbSsYu3dLZ7?=
 =?iso-8859-1?Q?aFFBd+2KBCyvLXlDR56u0LnkDQNRp9TxNHiS27Q/GEieX5jUZcVw1m4rgH?=
 =?iso-8859-1?Q?82RGu1rTXVAv/cwRTjU5YpNF7sDLZDMA5cbuxtUncW86nzaQgrxEezNxg/?=
 =?iso-8859-1?Q?TLG7mKF9ZV2oVl3lKcj9/L5Hzdcyvj01kM7vIlQYl6GiA54hwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec94d66-af92-4eb8-3ac3-08dc3c1d2767
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:31:49.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ/nQ+0SE1IIu2+68K3jQG22Oss6wcL2NFCCouFnG29a0+n0PE5pvmETJw+UP0KFn5NAspFHJeMxJrhHe3LRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9772



> -----Original Message-----
> From: Sverdlin, Alexander <alexander.sverdlin@siemens.com>
> Sent: Monday, March 4, 2024 3:14 PM
> To: u.kleine-koenig@pengutronix.de; Sherry Sun <sherry.sun@nxp.com>;
> gregkh@linuxfoundation.org; ilpo.jarvinen@linux.intel.com;
> robh@kernel.org; Shenwei Wang <shenwei.wang@nxp.com>;
> tglx@linutronix.de; jirislaby@kernel.org; robert.hodaszi@digi.com
> Cc: linux-serial@vger.kernel.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Frank Li <frank.li@nxp.com>
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending=
 if CTS
> is enabled
>=20
> Hi Sherry,
>=20
> thank you for the fix!
>=20
> On Mon, 2024-03-04 at 10:07 +0800, Sherry Sun wrote:
> > If the remote uart device is not connected or not enabled after
> > booting up, the CTS line is high by default. At this time, if we
> > enable the flow control when opening the device(for example, using
> > "stty -F /dev/ttyLP4 crtscts" command), there will be a pending idle
> > preamble(first writing 0 and then writing 1 to UARTCTRL_TE will queue
> > an idle preamble) that cannot be sent out, resulting in the uart port
> > fail to close(waiting for TX empty), so the user space stty will have
> > to wait for a long time or forever.
> >
> > This is an LPUART IP bug(idle preamble has higher priority than CTS),
> > here add a workaround patch to enable TX CTS after enabling
> > UARTCTRL_TE, so that the idle preamble does not get stuck due to CTS is
> deasserted.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> > =A0drivers/tty/serial/fsl_lpuart.c | 6 +++++-
> > =A01 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 5ddf110aedbe..dce1b5851de0
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -2345,8 +2345,12 @@ lpuart32_set_termios(struct uart_port *port,
> > struct ktermios *termios,
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0lpuart32_write(&sport->port, bd, UARTBAUD);
> > =A0=A0=A0=A0=A0=A0=A0=A0lpuart32_serial_setbrg(sport, baud);
> > -=A0=A0=A0=A0=A0=A0=A0lpuart32_write(&sport->port, modem, UARTMODIR);
> > +=A0=A0=A0=A0=A0=A0=A0/* disable CTS before enabling UARTCTRL_TE to avo=
id pending
> > +idle preamble */
> > +=A0=A0=A0=A0=A0=A0=A0lpuart32_write(&sport->port, modem & ~UARTMODIR_T=
XCTSE,
> > +UARTMODIR);
> > =A0=A0=A0=A0=A0=A0=A0=A0lpuart32_write(&sport->port, ctrl, UARTCTRL);
> > +=A0=A0=A0=A0=A0=A0=A0/* re-enable the CTS if needed */
> > +=A0=A0=A0=A0=A0=A0=A0lpuart32_write(&sport->port, modem, UARTMODIR);
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0/* restore control register */
>=20
> The fix makes sense to me!
> I see only one issue with above comment, which commit 380c966c093e7
> already have put quite sub-optimal (after the actual write), but your com=
mit
> now shifts it even further making it completely dangling.
> Should it be before last UARTCTRL write?

Hi Alexander, good catch, I will move the "/* restore control register */" =
message to the appropriate place in V2. Thanks!

Best Regards
Sherry

