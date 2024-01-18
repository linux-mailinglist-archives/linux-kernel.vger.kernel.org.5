Return-Path: <linux-kernel+bounces-29958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A399C8315D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A42879C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FF1F934;
	Thu, 18 Jan 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YPb1106H"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479001BDFC;
	Thu, 18 Jan 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570114; cv=fail; b=TeEqtg/pydAckxXiePK21x+e+tsoRCg8I1g2lT7HsWWUly3EbuLO4nsbhkkTP7e5Y2M0fmJNCyg8LUazPeokZdWa9VL0bZh/O7RFmKfeZfvx4Y30rI2I8FGit0S+VOBwPyRr0dFMDRhFcw/GMD7kH/I+ZKGVq2JaqJDnekdrQfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570114; c=relaxed/simple;
	bh=mi2W1fdYWq/bi3dp+V49Eh5MFjh2oxZN194pyvtl1Rs=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=DDRe4ljHBYKJ+gU8utWhZvSuIAqJqDDb3NoBZ6fWMgXSxexb/p4JetMkRQsJJBcboQUySjiBRe5uCgSmm7UklJ//tA2bRnF8YPGPmzpK8MV3sF0Hbw0Knv32DYktrMciG3gTS4RJllltXizWicheIMYVSd46O2sSnA3j3lYu9Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YPb1106H; arc=fail smtp.client-ip=40.107.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlX7s7HxOj/9DMCpvHTFgCgxmjyKpBORU1dcMxRxS8h/rYoDgNzXZ0LrJponb8i3n7XkKd36jORNZ5eEwZonByieX/Du6DLU/1Fidp/SFLJ+0BbY3spbCxbXh+Ip1ciYadfdQb25hvMcKGlbKIgRNGt2landBMIW0tqdiaNY/F6lZo4kYt7Z677rLBxiM8UfY2DHtA69XyjOZglhJthpdUUSRY/Xr5lE1vW7QcVLK5WVp29ESwcKFuyjm0D5OIWT5EsWDVoN2Dqnu9TU+pfDnpwvRXeUtmwCqXRcz6agdr5MoNtup4+yKYxB9Rjt9nOn68gx89+PPFqYi/ArU8eZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naSGFWt3loXchwowv6jebyx+n5uVY9k3ysuvesuYm/g=;
 b=P1sFTIhbpIgKyqzkYhvIPJ+J5iGH/qtbYyQhtmuvXR/uKoiRrpo/xMAC6As6aC9v/f/K8fJtQ1BPaP3YJqf60bPb+9PV5aMXx928UjZuA9TpeIqdkUN6J8YADT0DHA66xyWkLBT/19wwSHPg2gTkgWtxXQjle9MSkewO3PAlWfBpF8GI4MTF2IpffAEhf+fgCa0DfbNjometl9XYkcmUV6WmEFf6pIgyzeXKF+ZHRcHlJ6NNqXPGCT9S/QI8Pr3hZzHZzHHS5soxiQUxspdGbzGWa4dI95376YGLlGhBd+B9HQCze/Wx9eQnaqokKj478v5Mc0hInrfApHMTsSJc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naSGFWt3loXchwowv6jebyx+n5uVY9k3ysuvesuYm/g=;
 b=YPb1106H6OTP9ZlaGPR6VQb/LSf1tuPmBj1cz6coUIugv5Qgcb23lGu6M0FwSbzMqRAUFOm9b//PmL1YMFbCvDBLlZQZ8F6Hr1StJJh9Vwm7D14bwoWFt66iG+n5dR67o7PpNlPXDWJFOMeBilSCHTU4Agq//vCahBlCEcp9k1o=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:28:29 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f%5]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 09:28:29 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Horia Geanta <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>, Meenakshi Aggarwal
	<meenakshi.aggarwal@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Silvano Di
 Ninno <silvano.dininno@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Thread-Topic: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Thread-Index: AQHaSGCYr0WDHP3yKEe2VG16zWQxl7Dda8kAgABkXzCAASAtAIAAYBmA
Date: Thu, 18 Jan 2024 09:28:28 +0000
Message-ID:
 <AM0PR04MB6004C56470D075284635E008E7712@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20240116094405.744466-1-gaurav.jain@nxp.com>
 <20240117043308.GA1137@sol.localdomain>
 <AM0PR04MB6004E3B9AB6DB6BE3F6BE48BE7722@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <20240118034348.GA1103@sol.localdomain>
In-Reply-To: <20240118034348.GA1103@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8318:EE_
x-ms-office365-filtering-correlation-id: 0b66e78d-9f33-45ca-3484-08dc1807d493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YtqDkTnCPpo610oRMQj+awS5nbwH9yM8UMTtDEXeTdn8nYx6ZwqBXOcbdE/Kpy7A05eHiQutBIyEVw9DhomEg33zZ3u07FEPllIeGjKo9QiYM7tV0KnKaXhlYS6AHdc1vsmd/6IpFS7wSHT9r0ucqzgJwxNVuPy9Mcz5Nj1VvtlagXEAwRX2EvQOpr8GH+MyJkHGaow7sjqF9pXDgy8VDXCcrz01sPiq7Mu6PW502Q4Q8/NQbB2Fvp6+esQxdzjEO0vnOQUacWL5QNdVvxtUkVCbhsP5EFsDlyuEbcGTPmoelXgIA2n4WC/gjv7sc/D/pPzMdnBjgbStNP+nwmMat+vu2wiAXAx9yZpXQzGdfgtSCIz2ZxMJPViLszXYZcXnlSUmjAc2VfMh8+BCO046HpGKWMCn0AuWYL/4zYvp1ePY6BSVaMNNgYS1IMhnx/ibT39eZ/q0JqDCzfTZl/18kIB++JAf58wybLTfN/sI9Z9wTslrFKIRFVQc5BEZ4v8sp8C2+iZa+a1DcQ9xc0tR8bfsu1QTf7hbqSdiu0AwbEFUz6dnLIKq3xUKCpJQTtM7EN5qhde4ClxLSZwfF/0AN6B5TkaJCVWlmlDdmSRUprKUOSpZQAnnf5kQTdtzE9D5aiH2Cksm+w9FLpd0gL7RkBfOIl2uo3sX1L0muFrY8aw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(55016003)(53546011)(7696005)(71200400001)(6506007)(55236004)(9686003)(26005)(8676002)(8936002)(52536014)(316002)(64756008)(66946007)(66476007)(6916009)(4326008)(54906003)(86362001)(5660300002)(76116006)(44832011)(478600001)(66446008)(66556008)(38100700002)(122000001)(83380400001)(38070700009)(41300700001)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3WPe/YlxBSeAYWkqGc7sgYC8dc+ErBPg5mhN9MH09XP3KBH0OOkUOqzuriph?=
 =?us-ascii?Q?Frsz2Qa8+3Zb/sqSDzV1cYOLQUtOHEUrxhyETFWXQV2d2l9c8ijbLVoolhdB?=
 =?us-ascii?Q?0RnWp+OlPBBiLIqiQfF/6L06lW+cNcKRHW13oq7844iMrI+FbwV+A064i6EF?=
 =?us-ascii?Q?BqFUDNbAyTaIn3rMzCx84hiTs3D6Gu+8xpNvY9O6+ahIAIR+KAuiaXx/3VUJ?=
 =?us-ascii?Q?8iNqGOY8ShqjsheKkg34NgtXT410HKNCvVV4MobBlOUUvc9OYS2o0xxp1tlU?=
 =?us-ascii?Q?cg0aCVIcqR9NsfvEVUBoAdIiJ9FZ4DLt4glibfQITTq4T0qcNiyl9GgQ7yCo?=
 =?us-ascii?Q?UdOBn9jcp2MVnR6Dkif3iauMG8QXFnUtigNBbkljMvpOSMy63Hdz5eCvSPAL?=
 =?us-ascii?Q?H4kXQiHFeAWOIoP6/iixwW3pX1ZU0Nbik8pkOQNx5rtv02ClGXvbYOajPwZt?=
 =?us-ascii?Q?qSNjaEMBOQ6CfOF/5CqVmXFx3wvOgy09RK3THLP8HrZcSRsk6d53VkLNMaiQ?=
 =?us-ascii?Q?TytgESJM9q+yMKotwKVxGKmf4aDXr2U7rj/9FmATudx+nrGevedi7ngYvUxj?=
 =?us-ascii?Q?qvSKr5j6EGXUxmT1lsYoZMNX6WqM2KUUjInsWlEQw9oiuxVe4xRe/N/Pobfu?=
 =?us-ascii?Q?QLPqzxEGOe4SeeqGyyv7kLAOxN3ar4gw54SOWeeDa3CWHcyLf7zD29v1vgDI?=
 =?us-ascii?Q?htnviILGO1o8n0iPSuRiMgHzQ5QNS3vhs9wNJwc9kadpmDtVTASiSKaajpyA?=
 =?us-ascii?Q?C5hRIoDzFWyG9jUvdjxSck4FW2F6OyB4/wQipWlWf7U8bkWaSHo617nVbKE2?=
 =?us-ascii?Q?5sy+y8IZCbBA61PqDzf80wg3PWq20zA2gHSH8vBqRP1oVjgfrD+uo9wIgZkc?=
 =?us-ascii?Q?WNAzocPXkUjOb49ShK2/bzqgLtkXrT5LB5DlHiE4aZ038OthDy9TM2EIXgi7?=
 =?us-ascii?Q?lqTpA58K5SnN+Vu+gfipU5fF3RSKOBlRM0iEGjaf8St1iHBN9zX+gh9SvL3l?=
 =?us-ascii?Q?jPtrIx9vxCOGcXti1/f8k0fohycEvSJPVQo+D3Vn5WMTzHPmqllEe6pwgZkI?=
 =?us-ascii?Q?y0Kv31kwgJ7TL0WL7hEBXeLM9nfOcaeb8TyIcDRgdu0DizJaafig0WzCxlBh?=
 =?us-ascii?Q?eyawVKDaYsQqoILEO+lomqZ9yt3TfR7FSsVofhTQceZMIXzFffqpLsIfZg7H?=
 =?us-ascii?Q?+qoZtn/bEL9uHBsVMc8LUrktp7D+Pg3BKWf+Db3bAjieBFpStHkQDU5VIGeI?=
 =?us-ascii?Q?zk5Ne5XbdNYu9A4LZYxudb+CN4a9a1knvqUISj03u7X2M7Vgt4CuCmpPj+L8?=
 =?us-ascii?Q?dl1G1ay4g0HBEjwMsTIJVbWoEjPhIv2XCOoR6q90/FWNHUGaoWCbMF5ARFCo?=
 =?us-ascii?Q?NYJHpD08s2ddZd6KwfShsOaEGRlF5aL8zWbrB+sE6uc9hZRI24HSzSSAT71V?=
 =?us-ascii?Q?y3kdc6S94Ou3ax/MqdqfIjGQGJYYUjgv+9xY/i2yGLbqinIuJIW4RzTVjCf9?=
 =?us-ascii?Q?zaPiJpX5/Yju7mTWv7G4X2IfPQYF/cqELi2NoL3kPPwRZVBcg5uk43Vc0rju?=
 =?us-ascii?Q?rTbfxMY5WA27QVBlRGAUsfd7g9NPmLdCT27YyclS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b66e78d-9f33-45ca-3484-08dc1807d493
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 09:28:28.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHFeKTHCwON7RjVP0uXQGfQ479eakS3VwqphdVL2yL71KBPsfnHmKCczIfbQsu01k4ZxtghwO0Efr7pLZ86rVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318



> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Thursday, January 18, 2024 9:14 AM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Horia Geanta <horia.geanta@nxp.com>; Pankaj
> Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> Aggarwal <meenakshi.aggarwal@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>; linux=
-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <linux=
-
> imx@nxp.com>
> Subject: Re: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Wed, Jan 17, 2024 at 10:48:39AM +0000, Gaurav Jain wrote:
> >
> >
> > > -----Original Message-----
> > > From: Eric Biggers <ebiggers@kernel.org>
> > > Sent: Wednesday, January 17, 2024 10:03 AM
> > > To: Gaurav Jain <gaurav.jain@nxp.com>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> > > <davem@davemloft.net>; Horia Geanta <horia.geanta@nxp.com>; Pankaj
> > > Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> > > Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Aisheng Dong
> > > <aisheng.dong@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>;
> > > linux- crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux- imx@nxp.com>
> > > Subject: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Tue, Jan 16, 2024 at 03:14:05PM +0530, Gaurav Jain wrote:
> > > > ahash_alg->setkey is updated to ahash_nosetkey in ahash.c so
> > > > updating the handling of setkey in caam driver.
> > > >
> > > > Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when
> > > > wrapping shash")
> > > > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> > > > ---
> > > >  drivers/crypto/caam/caamalg_qi2.c | 4 ++--
> > > >  drivers/crypto/caam/caamhash.c    | 4 ++--
> > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/crypto/caam/caamalg_qi2.c
> > > > b/drivers/crypto/caam/caamalg_qi2.c
> > > > index a148ff1f0872..93a400e286b4 100644
> > > > --- a/drivers/crypto/caam/caamalg_qi2.c
> > > > +++ b/drivers/crypto/caam/caamalg_qi2.c
> > > > @@ -4571,7 +4571,7 @@ static int caam_hash_cra_init(struct
> > > > crypto_tfm
> > > > *tfm)
> > > >
> > > >       ctx->dev =3D caam_hash->dev;
> > > >
> > > > -     if (alg->setkey) {
> > > > +     if (crypto_hash_alg_has_setkey(halg)) {
> > > >               ctx->adata.key_dma =3D dma_map_single_attrs(ctx->dev,=
 ctx->key,
> > > >                                                         ARRAY_SIZE(=
ctx->key),
> > > >
> > > > DMA_TO_DEVICE, @@ -4611,7 +4611,7 @@ static int
> > > > caam_hash_cra_init(struct crypto_tfm
> > > *tfm)
> > > >        * For keyed hash algorithms shared descriptors
> > > >        * will be created later in setkey() callback
> > > >        */
> > > > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > > > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > > > + ahash_set_sh_desc(ahash);
> > > >  }
> > > >
> > > >  static void caam_hash_cra_exit(struct crypto_tfm *tfm) diff --git
> > > > a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
> > > > index 290c8500c247..4d50356b593c 100644
> > > > --- a/drivers/crypto/caam/caamhash.c
> > > > +++ b/drivers/crypto/caam/caamhash.c
> > > > @@ -1804,7 +1804,7 @@ static int caam_hash_cra_init(struct
> > > > crypto_tfm
> > > *tfm)
> > > >       } else {
> > > >               if (priv->era >=3D 6) {
> > > >                       ctx->dir =3D DMA_BIDIRECTIONAL;
> > > > -                     ctx->key_dir =3D alg->setkey ? DMA_TO_DEVICE =
: DMA_NONE;
> > > > +                     ctx->key_dir =3D
> > > > + crypto_hash_alg_has_setkey(halg) ? DMA_TO_DEVICE : DMA_NONE;
> > > >               } else {
> > > >                       ctx->dir =3D DMA_TO_DEVICE;
> > > >                       ctx->key_dir =3D DMA_NONE; @@ -1862,7 +1862,7
> > > > @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
> > > >        * For keyed hash algorithms shared descriptors
> > > >        * will be created later in setkey() callback
> > > >        */
> > > > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > > > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > > > + ahash_set_sh_desc(ahash);
> > > >  }
> > > >
> > >
> > > Thanks.  Did you also consider putting something in struct
> > > caam_hash_alg (the struct in which this driver embeds its ahash_alg
> > > structure) that indicates whether the algorithm is an HMAC or not?  O=
ther
> drivers use that solution.
> >
> > Crypto/ahash.c has this API to check the setkey so I used to differenti=
ate
> between HMAC & only hash.
> > Let me know if this change is not sufficient, will add the flag in caam=
_hash_alg.
> >
>=20
> Currently crypto_hash_alg_has_setkey() isn't used outside of crypto/ahash=
c.
> Since there's an alternative that matches what the other drivers do, I th=
ink I'd
> prefer that you did that.  We can then make crypto_hash_alg_has_setkey() =
a
> static function, private to crypto/ahash.c.

Understood. Changes done in v2.

Thanks
Gaurav
>=20
> - Eric

