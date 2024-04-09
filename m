Return-Path: <linux-kernel+bounces-136909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746089D9B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B31CB2224A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF0712F36D;
	Tue,  9 Apr 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5GJ3QF/"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2116.outbound.protection.outlook.com [40.107.105.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79F12EBED;
	Tue,  9 Apr 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667671; cv=fail; b=XatTv2I7y2xIslhv9JJDMj+Cemu/+3qwGjceBeZkOV2lMEJtWzfrr4DpXidNUNyPFAagoifR6CAArwQx88loma0r77kvfKLVuenJg9kY8LDmcywn34C4ER++Et/oIIornZ2HGMdBKTzcJdkhhySYb15s91mGwTghYfVuAgt4tZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667671; c=relaxed/simple;
	bh=vANFlBy+7N1eLLQvYW2vD5kiYjMqaUAWli5wzx1OuxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDhag2+kNDwIkfqXKzBF1wrbuylGWRysu6JPxmezi6S/lWKcTMG1fkLrr1WxS6cJsJh6zzTFVHAK8zJJIDBIoDJIQMtSw5jQQpqE4nUGjxAcJcR3CHKso7Z3SuSjzcnW+j0IuOKDe1xzeWVPGK/3c4k2EBjOGpqoyA5SEj8u1+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e5GJ3QF/; arc=fail smtp.client-ip=40.107.105.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djmXARke2vxflXiLUOeGd58D1lRdLVyJxbzSCR1SJkjBpDGUlNCEjoYi5zMNTJjqb8EuYn4CV2F2MZce4lm8KdyUm9TgDVTjTuUwLmbprPgkaEUDN40O+w5CA7aNr6F6RmJ3AuGz26t/gWuNHZ8yCbFH1ZjJOWOLJ/fs0pNX+DG2YyM9Jy46AOLitlsnigeQaw1e/O+5vCZarxMSTXxx8bf5xHMoMgdiPMUOcUZdTz2CgxC2vwxwQwi4eGARqCowZNDF/NUlrs1YVp1JQV4je6dslf7HrA+k79C8lw0DuCIqmiY4LrckXsE2jbG0Dt0m06qfzHl15BM1QPEB1Z3O+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vANFlBy+7N1eLLQvYW2vD5kiYjMqaUAWli5wzx1OuxE=;
 b=ilLWG4zh+FQ8lTmwzEEs9hT14ST14WtODITPFZQl+Fxez7nNabLGjYLwj1EHl20guyyOh/wCr3ti9cS2zjD5jnFSEbkHn2HhL1rrLTs/L+M6OxMlEM05wa1an+yT4TyawhuAR2nBKd4AFcf9N57WpKoSFxyzOKxYiNad4y/MM6TJfB5CWNJ2GHiSzJ4igEy9nh9aSOtmvjH3pbzltcvYavWeJlWYMx0y4bZ5rKnRzX7KhHrDJCZ0jJxKDyJRcVI6V+lQ9wWyWb1Ff4rx957OwAdiqXhCy9cYNkYuqPRGUr5MGxTrEioIBOsB6hQmQDdPvUYTVK9UPeGiBX0ViLFryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vANFlBy+7N1eLLQvYW2vD5kiYjMqaUAWli5wzx1OuxE=;
 b=e5GJ3QF/B4CPbsxQt7VY4ckvqPsKm/TZjgGcKBxV+q7FNOBAIfxkjGfbxumDnb6tc5SQ7VfJuQciyNUXwDlocP4k0VD6/Fe81NRKMp2VLq72xZbxdobTv6yef1yglsXGHhBb7vx2r77376jSSSQDyFATGO/ILR9BQMaa2lSt+U8=
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7)
 by VI0PR04MB10392.eurprd04.prod.outlook.com (2603:10a6:800:21b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.49; Tue, 9 Apr
 2024 13:01:06 +0000
Received: from AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd]) by AS1PR04MB9431.eurprd04.prod.outlook.com
 ([fe80::95f1:f32e:75b4:1ecd%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 13:01:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Topic: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Index:
 AQHah1U7U7PbHuwUVkuCiXWcSbaKerFer8yAgAD57wCAAACBQIAAHlaAgAAGZeCAABvrgIAAAhDw
Date: Tue, 9 Apr 2024 13:01:06 +0000
Message-ID:
 <AS1PR04MB94317CC761A641B7B29C7F8588072@AS1PR04MB9431.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto> <ZhUDZGJilhczKlDD@bogus>
 <DU0PR04MB94175384AD9113AC6F60546588072@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhUdQ6M0GkL0do_l@bogus>
 <AS1PR04MB9431F99D49D6A777B09814FB88072@AS1PR04MB9431.eurprd04.prod.outlook.com>
 <ZhU6C2Ovh7xxeREP@bogus>
In-Reply-To: <ZhU6C2Ovh7xxeREP@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9431:EE_|VI0PR04MB10392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5Bz3GuQBUKqEc1mD+AvmewkaEV1nlxsxYjFs45LUFTlu6mOLZ4PhJ4vCosxTZ5NibgrtJJvAfNvVTVQM9AzXkbZMcG4u5ho/ivSKZde1vsptLHVN//3t9kfHtinSOSo9j2UB3qbBTkWKocUMbI8RPBKlrLekTUj87yP/A6uWSv5go9zTKP/p2BQyv1StAVRN+Il65BhwKrtmb7FGAcZe4T9r45g4IWhfJog4ANP5mqta+lnUd+ENUdb0QSKiM/FMPdR9IgBhqYMnPdR4xuBCskN8HfW1WDzc7tGIiO8X6ZoFW9gnTNbVNV7hd25cX1k3QwGgWBARbsJ7BKyz3wdn6se2f38i5i7unyNPi+RDEOSr/H4gkHeaKZ9pMbNRZVaxXkVRfEmsWDDz1jiBe8wYfOUA1Z9uE+w991YEKjN3g7h0XVgBPobMCMmUawTWx53oiZ6gD+yQAUVPEhtmeWhUwnbgGGSofEtW6jILlxuZ/IWYITlQFhjmnJh7yd6OFzhjBPIMLf4XMqvFXxTS6/Bpmo9EF55Pm2OLlHcg+jU47aiM74goXS5D6FkQk0xU2P8yu9brlYZC9qf8XYpoj06Vo0Phma3Zod53WKuqqngLwmXmfl1F7hPitQotm6R02IiessAG20MjFr9tNF5pRXi7u0DIIlCL0F2IRzOSN5gwZo0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9431.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9eFvizHQCNlilyF8KhaB4F0MNfVKx9RnafkbmDW5v//JOHi92ui7XbqcpUW+?=
 =?us-ascii?Q?CMcl5WRC2Px/mUy4uuT3RoYvFVdkiZuPAJp8AbUQwDigiNym/bvyrCYbXJPn?=
 =?us-ascii?Q?nk8P0lErfbR9PqPondkqUBGNC/Bj+agahe8QDMT20mNEbGbX72LOPKhO0Gv7?=
 =?us-ascii?Q?yU20diTMe502AQ7BvoHMW/9ErmZwmoAxA6wSOvtZ4XhwBxHi5OTVA0o7nJ9b?=
 =?us-ascii?Q?M6W5oc7oOFcEa1eb88CfTvm+BqWVtk5i7EoY5T+M6YF/M97cl5wpuw/Zh/XH?=
 =?us-ascii?Q?xoo/EuBJSgEmGKANLDtrvvyQOlgtgbTOwYQiyqI8soeo0o8ho9KPMah1NdyR?=
 =?us-ascii?Q?KS0Yt+v5yUCVQ2q2oQPnwQPtfnmfJcuWvG7XR6O56LE0OJ31x9vDhB7GQkqQ?=
 =?us-ascii?Q?xffUMqzI9nV4pWfYn2ICi1emL7DzP1F2FikzMXSYgmy+c+u0rNyy8W4HCzEk?=
 =?us-ascii?Q?pvo0msIAK9uxprr0sSa7ML0Z0/rBFWATHididL3OW43Wr1fO1SMJO9H0g1QN?=
 =?us-ascii?Q?O9UslOSpyVTINyCyPlTUddw9DZ+bAL4Xzg4xwAztfYxRvPpy57PvbLv5wRUc?=
 =?us-ascii?Q?vrY6XOZjYTlYawyw5wCtyvYOwOm4YRXmbBmV9HjiSx9hOZcAPzp8LhWjhpGo?=
 =?us-ascii?Q?jflu3+L/tw1c3r9TJZ0yTxIeRPULbuNX7TOBzxLCVlOlO6HllK8qk7M/xb+m?=
 =?us-ascii?Q?KJicEaRMjFwpCPj/+9akiL5Bl3OpmdZOeb1ulwtTtznP8O4sZuPwMkPhVyZq?=
 =?us-ascii?Q?CkytTtBaVoqGm3SiKcKMRc2Z7H981/aWRL7uHTa9JQSlQDcCpSbx5mac3VBl?=
 =?us-ascii?Q?6YDTrz0QNKZmnSVnpQpnjrie7X57pKcfqqCn02+sV4vvX9TNI1N0VESXRV7y?=
 =?us-ascii?Q?9OTJcFkXRzy8FeISJXeXyPJSGnGGihfqXR920/IL9iw1Ov4QP4heXbgwbLbB?=
 =?us-ascii?Q?NbtuwMutkhxNXmcketEi6v4u3iSvc/BEAzFkO5DSee6hWJr1yYwQUOm+PmZc?=
 =?us-ascii?Q?libdQ20APAX/POM17gXWfF4bT1+umlee5OVaq6RNcF8tDbJoHloG4N5FWVC+?=
 =?us-ascii?Q?PwG6GVNzZxxkVEYFC7yWC1hsGe2iVALz2j2z93QVDEZXW6Yoejfb0i2Em68h?=
 =?us-ascii?Q?VuOFk70wyM5302Xi8N/PpsIsM4v0WRVDWBkyAkkux5GG2kurSNQTnezNtY6s?=
 =?us-ascii?Q?UVclKWTxyn/hyfdrabdoFgPh/aJX2ZFlvhD8qTGUagiNCfVrILMC0FhNatp9?=
 =?us-ascii?Q?AWnocNll/+xxq3HIDXF0RmMohA/pYnuO+FWI5ZHyTLcJxJeZu6+pjKE/2Uln?=
 =?us-ascii?Q?c3Pew3KeDEnMxUliA7Ad5drMYSSUi3/MHmE/ouJcGz7s//5851rmHidzUIxZ?=
 =?us-ascii?Q?xXvi32Lt8kZx1ObgJGbk4qtW3xZDW/7f7W0EdhlPT52o0DK8wQ9+ZsoEg2Cb?=
 =?us-ascii?Q?hAMIgllgDAQ8qhkpwxFB7Bb8d2/zPIoOY3uLJYVCb37K5UemxqDofdZ/sMrf?=
 =?us-ascii?Q?wrIPO25GE2NHndfMvxcxiOFxP7MycUxtrTT8cA4CHqevZ+Sm+bxTpx4W81+e?=
 =?us-ascii?Q?QF0985XrExABiQZnIZM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9431.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a43c26-1e68-4623-abe4-08dc58951e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:01:06.4516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmG6pPSf9IUgmRNBOEcO7WpZt1JG5dJCi4ZeVJTJukGOSwZ1DAo1KsJusGyqoAoPz3mMMpNM1PsvVc13SdubYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10392

> Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i=
MX
> BBM protocol
>=20
> On Tue, Apr 09, 2024 at 11:19:31AM +0000, Peng Fan wrote:
> >
> > ok, will add more comment in the patch for the commands.
> >
>=20
> No I meant add document/description similar to SCMI spec for each of thes=
e
> commands. Not just one line comment. For std protocols, we can refer spec=
,
> for these vendor protocols, just one like comment will not suffice. Descr=
ibe in
> more details and hence the request for separate TXT file for that.
> Hope that is clear now, I have mentioned it several times already.

I see, will try to work with our firmware developers to write the details.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep

