Return-Path: <linux-kernel+bounces-56906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E15EA84D12C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C63A1F25877
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F683CC2;
	Wed,  7 Feb 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1g0e+uKu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AE83A1C;
	Wed,  7 Feb 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330511; cv=fail; b=LZAZjoTYilLfmUFpdjcdSzPXtgRG+479cdPzetUDOxrCrHrQ5GbcXOzT/p5rhJtSGkDm8JIXHPft2Ppw1EPgQdADQL5gV1SBHfNGPP6kZxw8aXQXx/kXI9S7ljGhQe00Cei2aHpfBN7gzAxRobrWnwht140fdcAj3UKzV7GwQ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330511; c=relaxed/simple;
	bh=6clXSyxKBj1FRpAHXejPZsWSW2ZRJtlV1nvLFVxZY7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bqtl4+ND9EvE51AMLaZAG3RQ33rvmN+HHDiRmsRnvve7ioBYV5NqskfHoLH7HRC5mRFintmAWiLcw2jn9Ys479jQ8Tr4JH61URKm6ZZaijqmuop76WVMa8HvJ1SgdlxRWEMCDkPFB8iJ15P3hFgz3vhP6kEWTWuUZJj38EleyYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1g0e+uKu; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg12FPmaAm88Gxf6B9KibV9dDrcGSvOJR4deF+SJckr6vwERfbrtHku8ydSICjtKSZI5nlshiQGEt6G4TP07WBv6e/hbEpn6Ku7XcSUGsEU8p6v7rpHwSTHFImkG9byvaVR/nmy/p3xMh6vSpKCo1L95Fwi1slB7Ty+ZS2idjHsDbHvs9eGWTy1YP5viurGxMFi/BE77gUwFFfGAGw2i08c9s0dYnjmV22O8l8cEJQ1wJ9R0tQH71hmGSvMZAORsCJixUYe+JEUIz715i8xw7iu8DVGPP5slQzBt9gwa7qx5m4jjAuKjY3zbPgISriqJ3yiUQJd/qpenauWtUqIEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTj2xtQzQHSYx8QzEGnnmILYja37/d9BpzArYV9BUvE=;
 b=YBuluws/l6R3j1LrtEaRSdU6Itww9UFbdO8UWUgZxzTglGC7Fw0gUvFMCNeCpYGCWvnSa/CsJT1FYD1RcX4paLdU1gtXAtq7zFMPzYDPuldRzzA//SQPjXZulDW5BFOxGkGjIEnlVQMcUimP7+32r9toD4HKPImvv3JsMeIZi0SxanKlwUzijynAGB0Upws64q6TU4WG1qtSuWC75P0VGtroTlOEQzHB4NeadfRuTWcnxn3XRwhDD/pOHE/JHpz8YHENIAOLP8N4I7DIQXd/rnxFkbpT+rd4OVTwC+66scr8tTOdvcWjmpcn1ZdWmiuaf6KIfHj4Q8tdZqujtu+vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTj2xtQzQHSYx8QzEGnnmILYja37/d9BpzArYV9BUvE=;
 b=1g0e+uKuKt2QIVEOEQL2RasYNnxddjwPETi8Id2B1bM42foZl25g4ZwJS0YioD1WGcEm1uODVVB04GaasQRVYXYbIDeCpp1aJCzsUz5MvQWzCY2jalVb6X0PMNBIxRnmHr0KC+EBBniTckVkbnb/qC4V31URuZnbQuzFkBDX3nU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 18:28:26 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 18:28:25 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "piyush.mehta@xilinx.com"
	<piyush.mehta@xilinx.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Mehta,
 Piyush" <piyushm@amd.com>
Subject: RE: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Thread-Topic: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Thread-Index: AQHaSkHCXFcPjzrR1kK04VXi4p+RqrDl0hUAgBkloHA=
Date: Wed, 7 Feb 2024 18:28:25 +0000
Message-ID:
 <MN0PR12MB5953C87B0932909BBCE89873B7452@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
 <Za5neDYN9Dh+GwRG@x1-carbon>
In-Reply-To: <Za5neDYN9Dh+GwRG@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB6208:EE_
x-ms-office365-filtering-correlation-id: 00c2e7fb-08fb-4066-cf86-08dc280a92ea
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CR/FNpfXjmrNJYJlNvwS5teii80RWa9L9HPmzGoIw45Vm5ehYN20aZ/JdgKUw5/Fchktomd+FmnlhHBWYKRq+5Go4MtPkJkB8CvKCwhlaqY0kmNkM0T1xd6O92NOu8sAADpVJbuKv8jw22IiPtdCJE/eQk8ME7loDwGTXWj4LrnKdcDuberSbPpq7QdRy4ywW3b5u7WrDaw+ryX2yO+hZNom0kDgjpwPLnmNNOQb95BXDBJaZ1tT7nSHna9jljXeaQImWwCRuWq9RU3KfY43x9seSYkCHv8YwQGg+iOEVYKhVULgLiqKJE+xa7AUOQVCdLV2QDQd/7r7XMx2Yu7XVtxMv2jOD7orwBwRu7/xEDWCc1mqAaHgUvLIgyGtPDeMMED+bsiaoaxXKTPUbt8CsVTHSuNthBUQDAL/mSvS5EkkVpIVpEvydZ9EgTaN6hADM7Fd9XjjjVm22LzwLsjSrMgrQ4sSqFcwgb3vINB4ompG1JbRvlfSdGSH7oduxl66ZRMJ1zILKjc3HcT25x42Zgb/0Cmv9t5qcgZA9ibz4I/c047bxvG3qy7qkRTLtu8KXxA64w7mFJihnGZKB0xnwPkm/Frl2eQFHwC345OITAg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(7696005)(9686003)(71200400001)(38100700002)(26005)(8936002)(41300700001)(5660300002)(966005)(8676002)(52536014)(2906002)(38070700009)(4326008)(478600001)(66476007)(6506007)(66946007)(66556008)(54906003)(66446008)(6916009)(64756008)(316002)(76116006)(86362001)(33656002)(122000001)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Mx8P+pJOEtWzB8j1Gg9TNuLUvaO0DPpBPfJYWsakjQKLI5nYZNx2Su/HC9B?=
 =?us-ascii?Q?Tcc7RGY1PhOvGUHXK+k2y4SJ7z2eQBOY5tsgweTSmYVDl2r1jnyT8hiNde4n?=
 =?us-ascii?Q?KuLR9Xc1l5mL/4JYELRRnhuW40i7JDOVqd0aFtfcyusUZk5TwE9UqD47DlbD?=
 =?us-ascii?Q?0rMTVnB/3B4HmjNnQBxwcPXy5pK0WrS0ZDaaN0HB0YicZgPI6n9xaB+5Aszv?=
 =?us-ascii?Q?qAEOTUnM3JBheV6Ud6eaGkIajfjfLf4NO46BpmczxFVkbqGeXwXhjBt2wOPw?=
 =?us-ascii?Q?i/OeSgYJkoUgQhgcjiT/7UM6RKeZmOg58te+K9nmX4RN7hJ00VVJVtvZZdUs?=
 =?us-ascii?Q?1/Vccgl2pYbFWlFTQQIXrKr8u2+dJPWv5KRV829p3+tVQGnZeyAHAZqfOTsd?=
 =?us-ascii?Q?PHfXZ+4gLi2ZcqaAxViEZsGWyeThMv0sV7G43vDqzMyZU/s99U23/t17c3QX?=
 =?us-ascii?Q?zthqcWW4VGMf6vOQ4NHoMy3KTIxDN2fi0D6q5ETLGNQ2tllvidSyUB0ALVhV?=
 =?us-ascii?Q?Hb6SoKOBqbju7rPP8/mXsYI8uZGq97pIGxxfMatVz1WetT86q3KDP6U8dxT2?=
 =?us-ascii?Q?KBBZBV1+Muo+aCRDmJLMqLTCtuuRNoXTyykhggUqgX325xRl5kYwT9p/TbiT?=
 =?us-ascii?Q?OxkxdyhY35lz7QmGFtO45KCy3KsgBnNZF6fxI046694/RaKtw+M+KMa7PxCW?=
 =?us-ascii?Q?q6nYMoUbHdrFG5zE+FUZTmgb6TxM/hgVVXAEFdpWYogfg5n8f6c2B+ZfIqFn?=
 =?us-ascii?Q?yZ0SGtxYqpAWMhPPHrYTED5b1fZ8BDn5tKtGYvtN4cVIfUnZ4DiS4cFMS9qL?=
 =?us-ascii?Q?/7QbQLQLg3l9BhweSrE4kujVVy7jhiHXORfh5zPxexCNIe1Q3W3eKpmZQjhL?=
 =?us-ascii?Q?d92Bs5HMP1hXwRjITLfHZ2wxU70WoBt+A6EVQtEmmYlIisQtRTVT8Sve5xFF?=
 =?us-ascii?Q?1teUdxfuU34cIKQhL86+SBdAgo8bbJ7JoeOU281X3NM4QfDqXHMBeByBcvEO?=
 =?us-ascii?Q?poU9uyJyY1oE055SvBJJIimUjumuHuOZ/8SaBKTTckNtZLrnQf+Yyr5XhJNn?=
 =?us-ascii?Q?41V8sG6YTr/fFjpzmnHqWwygTPiSxjHauYA01hXoehZ76f3TgAfo5wyyCcd4?=
 =?us-ascii?Q?IIcgd3Yayfu1PrXDtYy0HSwtnx6bjw00aH8uowtdmyR6CxuLLDgOgStEu+bA?=
 =?us-ascii?Q?21IuokqzByk3+PULZbv3l00FKih22+AedG6/Wk3ZntpbBhXQoG/kLTpxM0hG?=
 =?us-ascii?Q?S7Dvsty7lCm2UkJX1xW7YIDOtAG96+k8lHuN8VNmCmVJ6Bj9wUsFz/eHzL0C?=
 =?us-ascii?Q?HTG/khTSihQcl5vNcHERH3SXpXEduPHwIw2BIufF/F+SjRocWwdhxxYk6sRW?=
 =?us-ascii?Q?6UAMKsWyWXdE+ArACJl3AhEesum3aZBXZGP8Pfodsnwp8EFDuPeTa7aErXBD?=
 =?us-ascii?Q?0PQvZGFhgeSYoZQyonblkU5bIFc+a+pKkj2Uhzr6vDbYGKPWKS111prw6S+H?=
 =?us-ascii?Q?LmXtj3Efi+FW9z8jt4gYbzgOh37EkWVFXAUo2a1yvv6xkwErJI328ttlZG7U?=
 =?us-ascii?Q?qEN7HvlqM5Ambyc4z+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c2e7fb-08fb-4066-cf86-08dc280a92ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 18:28:25.9340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+6e4qedVk+202AXg9ETsYeTLeAMg56NKFwCPPhUm7d7CqbizYEfQp7egfkjVarB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

> -----Original Message-----
> From: Niklas Cassel <cassel@kernel.org>
> Sent: Monday, January 22, 2024 6:33 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: dlemoal@kernel.org; richardcochran@gmail.com;
> piyush.mehta@xilinx.com; axboe@kernel.dk; Simek, Michal
> <michal.simek@amd.com>; linux-ide@vger.kernel.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Mehta, Piyush
> <piyush.mehta@amd.com>
> Subject: Re: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT=
 PHY
> support
>=20
> Hello Radhey,
>=20
> On Fri, Jan 19, 2024 at 12:38:23AM +0530, Radhey Shyam Pandey wrote:
> > From: Piyush Mehta <piyush.mehta@amd.com>
> >
> > Platform clock and phy error resources are not cleaned up in Xilinx GT
> > PHY error path. To fix introduce error label for
> > ahci_platform_disable_clks and phy_power_off/exit and call them in erro=
r
> path. No functional change.
> >
> > Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support
> > xilinx GT phy")
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> > ---
> >  drivers/ata/ahci_ceva.c | 47
> > +++++++++++++++++++++++++++++------------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c index
> > 64f7f7d6ba84..bfc513f1d0b3 100644
> > --- a/drivers/ata/ahci_ceva.c
> > +++ b/drivers/ata/ahci_ceva.c
> > @@ -196,7 +196,7 @@ static int ceva_ahci_probe(struct platform_device
> *pdev)
> >  	struct ahci_host_priv *hpriv;
> >  	struct ceva_ahci_priv *cevapriv;
> >  	enum dev_dma_attr attr;
> > -	int rc;
> > +	int rc, i;
> >
> >  	cevapriv =3D devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
> >  	if (!cevapriv)
> > @@ -219,8 +219,6 @@ static int ceva_ahci_probe(struct platform_device
> *pdev)
> >  		if (rc)
> >  			return rc;
> >  	} else {
> > -		int i;
> > -
> >  		rc =3D ahci_platform_enable_clks(hpriv);
> >  		if (rc)
> >  			return rc;
> > @@ -229,8 +227,11 @@ static int ceva_ahci_probe(struct platform_device
> > *pdev)
> >
> >  		for (i =3D 0; i < hpriv->nports; i++) {
> >  			rc =3D phy_init(hpriv->phys[i]);
> > -			if (rc)
> > -				return rc;
> > +			if (rc) {
> > +				while (--i >=3D 0)
> > +					phy_exit(hpriv->phys[i]);
>=20
> It is ugly to have a loop both here and at the end of the function.
> Why don't you just goto disable_phys here?
>=20
> Just like how it is done in ahci_platform_enable_phys():
> https://github.com/torvalds/linux/blob/v6.7/drivers/ata/libahci_platform.=
c#
> L52-L54
>=20
>=20
> > +				goto disable_clks;
> > +			}
> >  		}
> >
> >  		/* De-assert the controller reset */ @@ -240,7 +241,7 @@
> static int
> > ceva_ahci_probe(struct platform_device *pdev)
> >  			rc =3D phy_power_on(hpriv->phys[i]);
> >  			if (rc) {
> >  				phy_exit(hpriv->phys[i]);
> > -				return rc;
> > +				goto disable_phys;
> >  			}
> >  		}
> >  	}
> > @@ -252,52 +253,60 @@ static int ceva_ahci_probe(struct
> platform_device *pdev)
> >  	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
> >  					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
> >  		dev_warn(dev, "ceva,p0-cominit-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
> >  					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
> >  		dev_warn(dev, "ceva,p1-cominit-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	/* Read OOB timing value for COMWAKE from device-tree*/
> >  	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
> >  					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
> >  		dev_warn(dev, "ceva,p0-comwake-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
> >  					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
> >  		dev_warn(dev, "ceva,p1-comwake-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	/* Read phy BURST timing value from device-tree */
> >  	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
> >  					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
> >  		dev_warn(dev, "ceva,p0-burst-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
> >  					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
> >  		dev_warn(dev, "ceva,p1-burst-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	/* Read phy RETRY interval timing value from device-tree */
> >  	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
> >  					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
> >  		dev_warn(dev, "ceva,p0-retry-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
> >  					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
> >  		dev_warn(dev, "ceva,p1-retry-params property not
> defined\n");
> > -		return -EINVAL;
> > +		rc =3D -EINVAL;
> > +		goto disable_phys;
> >  	}
> >
> >  	/*
> > @@ -321,6 +330,16 @@ static int ceva_ahci_probe(struct platform_device
> > *pdev)
> >
> >  disable_resources:
> >  	ahci_platform_disable_resources(hpriv);
>=20
> Looking at ahci_platform_disable_resources(),
> it calls ahci_platform_disable_phys(), which calls
> phy_power_off() and phy_exit().
>=20
> This means that if you jump to disable_resources, you will call
> phy_power_off() and phy_exit() twice.
> Looking at the phy code, it does not handle these functions being called
> twice.
>=20
>=20
> You already call ahci_platform_get_resources(), so why don't you just set
> AHCI_PLATFORM_GET_RESETS, that way you should be able to remove a
> bunch of duplicated code from this driver.
>=20
> One major difference seems to be that ahci_platform_enable_resources()
> does not assert reset before deasserting it.
> Can't we just add a reset_control_assert() + some small usleep (e.g.
> usleep_range(1000, 1500)) before the reset_control_deassert()?
> Have you tried doing that?

As I understand AHCI-platform library supports shared reset control=20
lines and AHCI SATA platform driver request exclusive reset lines.

So we need to move reset request out of ahci platform library and
make it driver specific as done in commit "9a9d3abe24bb=20
("ata: ahci: ceva: Update the driver to support xilinx GT phy")

Furthermore SATA IP programming mentioned in=20
Zynq UltraScale+ Device TRM mentions -

Assert SATA reset.
Set PS-GTR configuration (Part of phy_init)
Bring SATA by de-asserting the reset.

Now looking at ahci_platform_enable_resources(), it=20
enables all ahci_platform managed resources in the
following order
1) Regulator
2) Clocks (through ahci_platform_enable_clks)
3) Resets
4) Phys

Here reset is de-asserted before phy_init() which
is different from SATA Controller Programming Flow.

I assume because of above programming sequence
differences we earlier didn't use generic=20
ahci_platform_enable_resources() and instead used=20
a custom implementation derived from it in ceva
AHCI SATA platform driver.

Coming to reusing ahci_platform_enable_resources(),
if we have to do we have skip step-3. and let ceva=20
ahci driver request reset and then call
reset_control_assert()/deassert.=20

However for single controller IP programming sequence
deviation I am less inclined to make modification in=20
generic enable_resources() API . But if you strongly=20
feel we should go ahead and make changes to the generic
enable_resources API, please suggest your thoughts
and then we can get started.

Thanks,
Radhey

