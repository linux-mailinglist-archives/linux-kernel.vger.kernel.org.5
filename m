Return-Path: <linux-kernel+bounces-47989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995128455C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469872856D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5615B973;
	Thu,  1 Feb 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r/a2OJlv"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E639CA42;
	Thu,  1 Feb 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784440; cv=fail; b=mE6G05R5gC/loY1oqXj+7tst9HhFJj6bZuEpQaWPYELcWmtnyfwqulvM3YCeqpNFGjcZJRyqQ3LGFZAXhbp7iVbw1UBCwZ6ug94cHf5zroaMemkVsaNIxQnqBQzG1tmU3qoXbSvMckyxMj+lKA7yfciC8PrlrqJHYKeHcCLJu80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784440; c=relaxed/simple;
	bh=wJ+q0Ix+cfBJDD7nyEgJ5SppUHk+rX9d7sriLfsdiMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYGj/Z7z/zSFc9vbPRO6Loi2xz2jNvFIjliUWPqwzWVx/RkNREA1lLU/mJWDqw7mYEq7aQrJp6rsO1/yD7Dab5ehhcKGwqZDDgMNeISNvUuSDy3cEnM97Q3Q51bhZvZ7N/UMaRQHHrEhJJWZhppjWT3muC4sM3lvWJD3IXuxJjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r/a2OJlv; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR4uGLCeS7BJnly2UijEFE/BZswRSI0mkAs8qx8MsnSGjW1zGGzmxiCX5ccYxzAKDGcN0sy3jt5UICproNnk5Xz4M4P+s/eb5ddtuj1/wfy+ihbXoenV8/+dTFPJ5xRCYy8W8q22L9KugE+HwPJzWlOL9xCqSwjBO3hmbZ5xYuaUtKcw/ZhkNJe1qyih8g4xYUuC+KjYfsGjqwnx7u6MscPhb/xGZecW6w6it9CZOG0EyMbwyqq7OXFZ87AD3568/t1QGLlsjKKnhf+dbb4a0kWAKyS1OoRwQzqlZCHvDKtY5RWlO27t3brtK6GNYS8bntvYVsRnk9QS5zvgHmxfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMD/SrffeHjoGR2WDDNQdMRfwR+l9/JgMk40yI8FGvk=;
 b=f7OLHtLgIb387BkCKYk1y563AKovBlEMsySfts4P0h+c9XLQ4aOMbr5edG4cIhWxIKY6u4Zaun8nidbJfww397DdleNf4wXU3sULBDRVukMiV7kriSWDfN/biX5NGdNi52+ZcXPaLDZ7qOMgzHOBOIlj92n0d8fDVuU92IHlnr4ztLGGdikA9Uda3mi+f3X2BrRtCWfEcI1a9f/X5m5W3Rt+2jC5lMU7ZOJN2fdr1m4uDauDv7sMjK4dKjwkNo5iveq9D5eaS1kr6cV28XXX2HSL6otEoNfL2cqippLJMDm6zZtj7AG2asT4ZwtAdwqrMcUU/wIbEQ6orYI7RkQaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMD/SrffeHjoGR2WDDNQdMRfwR+l9/JgMk40yI8FGvk=;
 b=r/a2OJlvokhi5d6LneJMEtpNIwhtLYq4dWB8DVrskeQPR7G9NIRu4zMHTWLFiXELHLCKY7zrQ9+EO9gVOGfSer4zDQmKpd1ZiAY1nsqeR6ZyhyLgmyKl3O0jDU/4crbBQXrl6vC57Y2DpHaEo5Td1+a0QK8g7+x/yGnRniYluxU=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB7718.eurprd04.prod.outlook.com (2603:10a6:20b:29b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 10:47:15 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 10:47:15 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "benjamin@bigler.one" <benjamin@bigler.one>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Topic: [PATCH v3] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Index: AQHaVPwEME6t2WRuYE6Wft2lrEFNzA==
Date: Thu, 1 Feb 2024 10:47:14 +0000
Message-ID:
 <VI1PR04MB500557BCDB04B9385F20906BE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240201100115.503296-1-carlos.song@nxp.com>
 <20240201-resupply-doorframe-feb41940155f-mkl@pengutronix.de>
In-Reply-To: <20240201-resupply-doorframe-feb41940155f-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|AS8PR04MB7718:EE_
x-ms-office365-filtering-correlation-id: a85fdcb9-e17d-44ef-9d7b-08dc23132745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 18jwcDTLNjM5KYteSwG0uWJbClBGQ2kObDqT8AuTq6KysJ2N4lHY0QLERrAm6k9hvfQoIPUJCq0XKxsrq2nUxFASQwug8ZnEpzNTZwa5/0lVLug+r1zjnjUvb9qrnnn277kg+Ox8sJtN+XI3KF2rFBUwL7MhQcxpFGP35fWvRUW/SBUMhrIRXUZuctLkmiM/41KASlQ3AYiDUQBlpKWcRBY02UXhvv+yFme+KFJsstwlyzm/lg/WXrnaWIEAPzOgcr3FRFRHchgziFtezZM1FSKuh8SPlXa4lFDZCKnqEvpmiPoITXBin9WoDD1tm3nMigEHvA7Tk3wF6qAWxNK1VIOwQCygCt2AiNi7obM97XXs7lbYUNb+RQw30liFNj03In2DFv8c3lvzIumjfX98nz/rattiMF8p455VrlhceCzmRdQCdo4VdARsVVYHMYFUV+GDaeRzlKtEfzzixjRN6he+mDoyJ+EK+S3j92imC5YD9n5gGPMUGXMLi9cCkEKWZaWUVTXgtwKND9chmJF7/UumSog/MKVXG0yarw/VlVz6dGOj67BTxDCZY6RAvDNff7EVziGD7rC1RfmyCNDY/QweQGIFPgakig9h3nSgjdGf5IMo6mFnuKhOoopOhFGyYiH97wx1lauMrrLNEVW6fw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2906002)(44832011)(86362001)(4326008)(8676002)(8936002)(52536014)(5660300002)(33656002)(7416002)(76116006)(6916009)(64756008)(66446008)(316002)(66476007)(38070700009)(54906003)(38100700002)(66556008)(122000001)(53546011)(83380400001)(6506007)(66946007)(478600001)(9686003)(71200400001)(45080400002)(7696005)(966005)(66574015)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZT9r/0u6yMmWvs/VDu+N373vuUBDqfhmCYnIlnidRKBvmXVSsFeT8AeRje?=
 =?iso-8859-1?Q?8Umg26gTgsiUTeLZVF87Krc6t39ZhFz8JHrae/SNaf3dm43FgiXAZGjaOE?=
 =?iso-8859-1?Q?wKUs46eux5Ftbt4/MrHh1JsCsjJLMD0cFpcUZl8p5wMk+mG8mhLix9gVTK?=
 =?iso-8859-1?Q?zaZGPSomNJYhzelP0S09LTxnH9SqNH6toUmi6A/fyvXm7nYhnkvicjixjc?=
 =?iso-8859-1?Q?ncwtUB3pg2TVSWe4YQwIMPQk66GxMJOC2KWsvvOjeboUuDE9DnV/gCxBfv?=
 =?iso-8859-1?Q?/cIZ/5MWx0jSza4L4UDfYesUZg8H1YtMYLlcb+gIHS7TgJvisbgv/OQGWy?=
 =?iso-8859-1?Q?6O/89rDKkbBk2n3LF7EOAdqvLX5PiI2jat3EjWjFwiMk1sTdGAmC2nCuLw?=
 =?iso-8859-1?Q?5k5lDjap7dpUxhZ5suR5aSE7PC9rE+h2HMYLHJeeKGbxAWz1WmdQAVkT0p?=
 =?iso-8859-1?Q?hFFlVlUDwENDJouAYAB29OTa/KCUpY/J0biMMDOjkPs3/D+oYMNzCE3mzX?=
 =?iso-8859-1?Q?jhRs2vhrKvUYk0Zg4ARc/+bJqAVBrWZmkeNirPZi6YJWaCf2398E0tV8/5?=
 =?iso-8859-1?Q?f02XnwbLaZRaOaWVRy/StOGxVWLx1knS9NbQp9MQ1s/P8WEs4/NeRA2m8H?=
 =?iso-8859-1?Q?tBflHEmAgVTfrYuBDyzviZ7C8Wpsy6fjM8NUI6tXUel/FngJyCA3/GzYc3?=
 =?iso-8859-1?Q?bI0a78yb8BESwLHnh6CUPVvwcce/QbwE7MrVYom/COEWA6eeOvej4OORV/?=
 =?iso-8859-1?Q?19KRzwLMsRHDeBPvdUJURbHffd0VGqEi7/CEhUbk8kGmi7fr++UFL35wIX?=
 =?iso-8859-1?Q?vrQderKY+75olZrYoYFL968bwXxMPdWXoAleteqtfjnkJDLChGkZNtOWSc?=
 =?iso-8859-1?Q?IeiAF9JYhhGqJ0jkjZ4ov03gNhXzvsTchDhagUmJa9UnG/BcHm15qFUW8G?=
 =?iso-8859-1?Q?XYqbG0tqJaA7w2u+/77wOV564D0A8SGl3fG6PtRdmH1sP1kWhJAco3TCtc?=
 =?iso-8859-1?Q?HiWpJaQclltgvlZOmgoN8ZcJeRE+Nj50/59cJRgO81LfYoPf7ckspWRO43?=
 =?iso-8859-1?Q?+d914Gv/siyWYiyppAIfXCcib+dEjGcdiFIPow3pAucsLBL7qThXLS//9T?=
 =?iso-8859-1?Q?dKBJvgTc/tyoBxXu4HqeBwc+dSx4I70MjyLlXMxloi5TtDFa/ZcaBQHTuJ?=
 =?iso-8859-1?Q?PQQdxIi/Wjn/QRY0F8UQ+41394hx6e9Sc+7ofxnaS97l1CK+Hm2hfSYF9a?=
 =?iso-8859-1?Q?oHhx6kqF4MIYRezDmY4r9WjPk6v6MYRz5u1ccCZmABCw8IQTv4w0vvBpbG?=
 =?iso-8859-1?Q?abqy6CEIrf+gLHtV6piKcPxM+EwZrKXjCffLZfhN9H1qN/XHpHg0/Twfqb?=
 =?iso-8859-1?Q?8OVx4FOFYXaiogI7Hsmcj1a3wIok0yspcX2TcQwRIze9n142O5ZLSwM8Hx?=
 =?iso-8859-1?Q?mlZBG+c5UiBh80l70tnqh4d/08dlKXc7jXg0O3UMVdbqWenCcUbqdLY+B6?=
 =?iso-8859-1?Q?xIZIAQPSxjbP8C2t4MYYoDjtRd/00NBhDAG4xb4Gd5CPMEoqlrNjiO3Bja?=
 =?iso-8859-1?Q?yFHlkDEew0WRnZ32sX4zT1BbV1BC2upSj9ah31M4NCDvU+RM5RyikSlVuE?=
 =?iso-8859-1?Q?kCPzqOupqrKSsttXpAX/SBd6mYeqqt3V2X?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85fdcb9-e17d-44ef-9d7b-08dc23132745
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 10:47:14.9461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtgYZhvXjjAb09pMI9N+8NBGadaMEpdN1UHKBZ19nqPQZuyg+ksjHFY1KgxNn5TZJwsWHuke6S9aT8SDoXweSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7718


> -----Original Message-----
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Sent: Thursday, February 1, 2024 6:06 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: broonie@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; benjamin@bigler.=
one;
> stefanmoring@gmail.com; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-spi@vger.kernel.org
> Subject: [EXT] Re: [PATCH v3] spi: imx: fix the burst length at DMA mode =
and CPU
> mode
>
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>
>
> On 01.02.2024 18:01:15, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > For DMA mode, the bus width of the DMA is equal to the size of data
> > word, so burst length should be configured as bits per word.
> >
> > For CPU mode, because of the spi transfer len is in byte, so burst
> > length should be configured as bits per byte * spi_imx->count.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> > Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length
> > when using dma")
> > Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead
> > of assuming 8-bits")
> > ---
> > Changes for V3:
> > - include <linux/bits.h>
> > ---
> >  drivers/spi/spi-imx.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 546cdce525fc..2a1ae7b00760 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -21,7 +21,7 @@
> >  #include <linux/types.h>
> >  #include <linux/of.h>
> >  #include <linux/property.h>
> > -
> > +#include <linux/bits.h>
>
> nitpick:
> Please keep the includes sorted alphabetically.
>
> >  #include <linux/dma/imx-dma.h>
>
Hi,

Hhh, thank you!
I will try my best to strictly adhere to the code format in the future!
This is a good habit and I couldn't agree more! V4 will be sent.

BR
Carlos


> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   |
> https://www.pen/
> gutronix.de%2F&data=3D05%7C02%7Ccarlos.song%40nxp.com%7C53112bdae1e4
> 478f5fff08dc230d69fb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638423787724098671%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&s
> data=3D33MzYSg%2Fq5ciMNGJmbrUcprP%2BH%2F%2FNl0IPNcUO%2BHoeF4%3D
> &reserved=3D0 |
> Vertretung N=FCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

