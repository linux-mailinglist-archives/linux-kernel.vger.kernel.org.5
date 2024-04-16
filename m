Return-Path: <linux-kernel+bounces-146877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6A8A6C41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FAB28263D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CCB12C494;
	Tue, 16 Apr 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AfSsbqqG"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A712AADC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274110; cv=fail; b=hFMwG8VSWYYe67uNHJfq2Gw2GgazhgEhfNd0N8jN8RxGgouZaB5XMUMmroGfkjzpg/pgjkbk6sBzfaU0AWqCBJYreEDcKU/XCMtGAboleOagpSwPJkjGiL4QmjfAZv8W9axE/nGe/z7lb9l7J7uyrmSpQhmMybd75LENjU6QYsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274110; c=relaxed/simple;
	bh=Jz16rLPELBbckuSWaF4t2EzNkci1x0HW2E1dfMNyPYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwvnA6d4IIb3n2OubM+MVdKvFJJ4Iinskq4V0N2R402S3paSYL32jhOG2pkve88/8KRqi+2C05ZrTDMx84Kw5H4KdWYDfMZWET3UJzQPp5rYg77deyKkHDF+aBh/7xEHkUI9IaQeTv3ShGTeswJ+zUCwGN5MwjNRkRBsS4sMi6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AfSsbqqG; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih77dKeObFPKWWc/IXdhN4y+hkOJDzSfdUys5H61RA9OhAcnEDL1WshM0iQst7CpXCp7rQIxxdBKVj56GL0kv9S0WDGTIeVc1xd3BZVwIf+z/xZ7L0p0m/QJ3mnUol7YpYEj0i8DHUMtgIDY0K/E6vn0RrppzsFfCD5rMvBMYPg602xDslBuNWIz/EgCDTd5VXM0aBtdwBSeQH3cki/iXWT++1IBmRK5MnFarLCrr7hd/79IpM7HooKyd1c3jY2bxcywD4mDBtLD86LtK/XgqgHgciFFfctDrbJ2PT9V/IHnSCSlOl9INpyUthHLP90oIyEyUP2nCSnokAq+FUiIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz16rLPELBbckuSWaF4t2EzNkci1x0HW2E1dfMNyPYo=;
 b=OqOv1yphqIP8Daxnp3Rt9HH83Qp0TW7N51zjouRHki/js1qg8iaDlhpR/Pq2ijBACyxTptmPP+eJgUK9gAFqgC6zRtbOfAnRNUcuXh14pepxHR5YmYgEZ0JcRtNyH/KxArcTVEQHBbAI6PrBgHzc+O/YDuG9PrC27IrTIXQOsECja+3nVy7NrTYKPkigyI6VKoNOui4kuXZW/3/3YQlw7CENaap52BCrYnDjbsBw2Kfh1eLLhHuRMKQOcQnPFqYQmxPACjl6ycbXpbr3gi1u6+QO7yBJEbei7nJOrqvtkeOYvhN1Wad1szs8vVwDn4EFxfHcNqnwWQjAarGkE/jO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz16rLPELBbckuSWaF4t2EzNkci1x0HW2E1dfMNyPYo=;
 b=AfSsbqqGLRXkTwkaoMIXoJeBplAuhy8Ol+N1ly6IdZeq0NlPJTo5NJNqKiW78Us83a+PcdCgvgGUvVFzy5clkwrrbbaAnJN7mkXRBHTu8exgFDd/T0v43VyinwaxlQdxDcIeMHc1w2w5oghHbKPlgxrxk9YCzo4SlewRW3RPg0Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 13:28:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 13:28:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index:
 AQHajxwygJMjjnYsXEamYB79VvBL0LFpzXAAgACrohCAADbUAIAAJIBggAAQP4CAAAC7wA==
Date: Tue, 16 Apr 2024 13:28:25 +0000
Message-ID:
 <DU0PR04MB94178C0D3D26D0818C94B35088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh2R4FZPmVOigfT9@pluto>
 <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zh5P2EtruMmTrgXM@pluto>
 <DU0PR04MB9417FFF8A9FB5018125C524688082@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zh58F_TuQMO-swOU@pluto>
In-Reply-To: <Zh58F_TuQMO-swOU@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB6776:EE_
x-ms-office365-filtering-correlation-id: ec02ec1d-1a5a-466f-0e60-08dc5e191844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8YZ7o0jATt/KOOGdWkcyevVRfWfSLgewxZgcFlIHIWJpqeoOyDvIRaD+PtbyXV0IRhBOVtFYDbYw4sU8bf+OL6Df/LDD1TdEosRHFFHy1G+lm7M/VmYKncNC5+5i74gpPqMgL418M7i/Xca68DNtMHJVG5yjiY+bAI8AvQizhw7bmbt2za48cR2PmLvskRMi9g5D3FHnjUnzNlHn7xEOauAmonuEEg8rZVrq92JNCVUJZw/NPSlYJwMhjKbVJi9kGgsHxbjIzgV+Z7Yo/2I8+HmUscdahANvY6+PJjGmoTcciZmVcEPjZKGeGLe6mZXC6Kllpsj4k4vHLtc95Dm9X9rdZDVO/aHUz2J8sHYcDIy9G6/9O4xJ0YhJFwOsxkwwEuTfwgMORIOAVFRbVa3jZwDTZNvir4dh4ZTCR7x/fFd9roAa4HifZGOCV5trLRKWMl4rQycGXLVlhVNigvrWuDtGnm2B8jjfF5zMif7Vt9uUzrxMZ5vNfCcuu0XjrzN3koiOaXyXv3uwgRGwae1AjHSkWW4husWVYIvzar0uHyGEdpA6EFCfYu7rLPEZWUkztWElITtTwAJymnwJfN/jPf7DpUpcwnmojsoKuNVK2uZpGlKfk+rm7dqmqIkLgPm5oRxP3dVpyWjNU3w6U1wqXbyJxlohG01FMV0hQ4APdoaPQwgGW4o6ta+gC/wYONJuviAE/VqLyl9OkEd0HecooiwExU5xyR1nWT9I8c9YHUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8tVZerMSrvd/T3cmCmOV0dg9j7chnGrORoOsx+CK03dzqKBuLQB30RBsFccu?=
 =?us-ascii?Q?WPNtSor+NHJNXbzbYNkPafnAymP5dIf/hW83U35eDR3MR3npmK1VhXgjJlo9?=
 =?us-ascii?Q?GHT3eerbVepOo0pUt526a0YKxfoagrUSM2mMvc+u1AayBCKugWDf1PIie9DM?=
 =?us-ascii?Q?Cx8xb5GBIaC0B09Lvbq89PvPTyH6Zu52zdggHfcz8ueLwMsZPIFoq405VqlO?=
 =?us-ascii?Q?lXgHKHaSNQby4KpeK2Pp4bseG3oKU5zO2TTJMA0GjBzEc1BRZgmyyUzCsSYe?=
 =?us-ascii?Q?+mbbYPrAA1VjSqh7o06XXJxiB5DNyEVAICV6PVVR7W9jicCvYr7iwp3ukcqN?=
 =?us-ascii?Q?IBtm4nAV/nmJkEYGqmMAOXZOE6BHcT6fQwu237QyXClBF3h83OA3QGZfT+HR?=
 =?us-ascii?Q?WA24ikuHAfbtFSUlcruoJGT986QGyJ0azRkM/ra95E+DNEmzuTS5TLyiUHLU?=
 =?us-ascii?Q?gV7q2ztBmsnVR1zE5dVnGzWXnY2fdYurZQnwp02m2bYFFLfhibKTM3ZKFwzY?=
 =?us-ascii?Q?ouWpQmLEslubsZzgK1376V09f1lZbkPtuOjDOjXQtr4dDMUk/goIh/Vf11Dn?=
 =?us-ascii?Q?3shaaMSC5rQoF5IMVBPjEPW1dXoXjUr8q8SlqR/HQPNtb66D77408AbhtS9y?=
 =?us-ascii?Q?BOMQkgmuat1vgGb7OlTeU9AFVhQzpX0w5aCow2W6mP+MeMODgYQXjZjPemkK?=
 =?us-ascii?Q?B8SLqeZGB9NIoJMVqirgR/rZWb3d+tSBFwrnARPrbEu62eeBQiwhMzhjkbiD?=
 =?us-ascii?Q?bino0Tq8ILg2zsBS98LxaREdwBDQN6ce1qdmCB5N/UihaxxLNXSBvqdeNfsC?=
 =?us-ascii?Q?cxR0mi+Xm3m50Ou/gY14gUrjNFfPhW6mj4v+bvodHMTjcyLiMBl+8doEf3/l?=
 =?us-ascii?Q?7f+2eA+SBMK7Y4QFw+3xOIvwD5xgqI9WC/WAnwBEMX4YthjgIb+5OcvAeLtF?=
 =?us-ascii?Q?laTqiv9x5PZ7CCfaG+wdVwMBhOv7WJyl+pEc4po0uVWx3kY8iXKBea2XxDFU?=
 =?us-ascii?Q?+tvsSYvrxVcvMygH+qad6IoXzUXIYrFLGSO96PNHiuo6wANPF7ZcFmYCrf8U?=
 =?us-ascii?Q?/Ck0Bm3q210Q9IhAuwaTA+QsCwjRytPnytkiN585cT7EInY6z0yAlkcYo3Zx?=
 =?us-ascii?Q?3nr0QYH27xsB2gozZZGfuTxhpMWstLhDlUTpyV4Znb/e5JbEP6ifOzXTSj7Q?=
 =?us-ascii?Q?TFVsz+BBWApHNjRxyhNS1O6mYzniAGR9n1gZQZNwVZsXGVv6iFhNI36RjIUW?=
 =?us-ascii?Q?C/cfAwYQ8xHQ2WC1OYK2V4mO/a7Aezkb/WCe4RnaQGccjuNKfxU/YNVw1vEW?=
 =?us-ascii?Q?iih4MYrTxLVu0ANg5U/LSpgNwvh7C+jd5AxIWUiiyU6WGu6709yWSK/tTlWD?=
 =?us-ascii?Q?I3Qhqo0CZMDFuNB116Ffr47FsJsgRPjj+Kb8OZDUEkTne6+Isj89qdIr63pb?=
 =?us-ascii?Q?CbRXnS7aEvZAdzWGpZI37nuv4Zb8JJbGEDYBraUj8iaKC8/DZf8JV/LzKz87?=
 =?us-ascii?Q?ihSRmG8zI0jp/nWPobPI7h5r5tiEzPEvsu/J8YvVjjel1wm404h8QknCcVjD?=
 =?us-ascii?Q?uZsYSpOoR6yv2SzituY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec02ec1d-1a5a-466f-0e60-08dc5e191844
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 13:28:25.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0mBFj+lLH8tCexCc3Aj9tfxgioDI8hfFPhZnX1eQFaWk8XeXJ8qjpAOlwmGJOp1Eoj/OnSKedaYVb9A2kWTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776

> Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> command
>=20
> On Tue, Apr 16, 2024 at 12:34:14PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support
> > > suspend command
> > >
> > > On Tue, Apr 16, 2024 at 07:01:42AM +0000, Peng Fan wrote:
> > > > Hi Cristian,
> > > >
> > >
> > > Hi,
>=20
> Hi,
>=20
> > >
> > > > > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support
> > > > > suspend command
> > > > >
> > > > > On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Support System suspend notification. Using a work struct to
> > > > > > call pm_suspend. There is no way to pass suspend level to
> > > > > > pm_suspend, so use MEM as of now.
>=20
> [snip]
>=20
> > > But, as said, I dont think there is a way to trigger a userspace
> > > suspennd from jernel like we do for shutdown/reboot...I'll try to
> investigate a bit more.
> >
> > Thanks for helping.
>=20
> .. also
>=20
> scmi_power_control.c:95: warning: Function parameter or struct member
> 'suspend_work' not described in 'scmi_syspower_conf'

Oh. "@suspend_work: A worker used to trigger system suspend"

Thanks,
Peng.
>=20
> Thanks,
> Cristian

