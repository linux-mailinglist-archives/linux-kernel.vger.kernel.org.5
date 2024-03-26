Return-Path: <linux-kernel+bounces-118251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F188B6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92861C35795
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5351CD16;
	Tue, 26 Mar 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5AAqABs"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2096.outbound.protection.outlook.com [40.107.20.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF01CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416366; cv=fail; b=RtyvLJJG6rmcZQB6KKhDS6PYmc16HHjYzcNXHmy05q4MgKJ6QLAt3ZUmQoECG4+yfjMTCaty6kXuiA9nVg87wwUomNnL8Mwd6HyvEjiiZ4Fe1UCjgIEuraX6xSxDyKKZKtBokQFaYDn1MaPsDMdmrKa26bM6e1pCwFqEOQwo1wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416366; c=relaxed/simple;
	bh=rTwsC946haF1AzmFBOhmn37TAGsRwoAu3QiekoCSxvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZGfhUBn06WA7O22XeLmvSglPt2gfo57ZJejAEIeRPk3Di/PfUh8/xhiuB6vRYUN5xHDDwdinwKu+GNejmWNux2ERVUtb8t2B7kG3f/iea7+UtVADUgFxut7AL7GAApbeIUcw+hySCDTfHYaeQnQWKR/D7LDFTgIZGCn3K5a+Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s5AAqABs; arc=fail smtp.client-ip=40.107.20.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA5UYUa2gPi7JjthrL+b6hYpz5uuhTaDXzSMZKjzUEV9UPJsX4xNrH2nbkj1apwV/S15NxILqKkPDbMraYe8pHqdZZKvLnf11ZTs6IlFRqZ3/FpSgUCQWAkUnF3gTaE9HgzDbJ/Ba2AiR1L2Zd4UPpdtx596PgM5Fsa7JqA52Tng22B+RRqoxoYJDy4uoEFSYNKigTAQw8mMOn3ODPolcg75rHSSoowEdkrTUuPhghrBUsbWil83Ok4E61bnT3CCUmr/4KmI0JghA/3GqllapFF0KpqxbfgAo5zfII4DePKjCQQl8CKDUjpqmmAey4mvNBMR3JxeyZldwK/itfsnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqNM+wNuW8IN2D/fumsv/R/Q2OzlUeH8RtCOyMU6bWE=;
 b=dNeAf7z+4MsdmqxU5KltxcsrxvG3/5zbiIf7yJ6VrMLaIOVKCo5niX8AMLuNCkOA7ejEfkw4LIYaUHbQ3drVrhKzVLzfdlpfnN99mAcqHVuk1GcegjtKxOax716dV2MQIVxJBD0biCGJilMHx+003DYHVnQitRytciNVEoG4/wveWdqMBml3qalSuQlOlUUdkZhbO115bB6C7i1B3GZAOrmnmMH8UxtB4ZqaMxKwnyRHr1m+IQx8Hq1NY7CeoWGZCJ/ZJgk1vm1Xysn+FNKopK+wVRGXlQJvq60Lfbau3bnCX7+tCSsP/XewauYXJgDlRUE8+KtqTumDdZV/n3o5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqNM+wNuW8IN2D/fumsv/R/Q2OzlUeH8RtCOyMU6bWE=;
 b=s5AAqABs9WsZnOkIWLwamIo/YLkhcf54fwBDLxm3zdZbw2gqD8u0oTp++VzQ8TnUJJr5VS7AMGhr8HqnG6WUeFgNzvYMbFEd7yv8/r3butzWSccmGj7xTVq7GVnOlaEP5sf1mnvRR1cjEopRWvSDaHmEZgK31OE6GavRApvnX+g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9867.eurprd04.prod.outlook.com (2603:10a6:10:4c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 01:26:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 26 Mar 2024
 01:26:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>, Bixuan Cui
	<cuibixuan@huawei.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
Thread-Topic: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
Thread-Index: AQHafeW5Y57Zt6YgTUODhc56ZNJBpbFIeocAgAA9iYCAAIRpIA==
Date: Tue, 26 Mar 2024 01:26:01 +0000
Message-ID:
 <DU0PR04MB941779A13906E00ACAC987AA88352@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com> <20240325134848.GA8419@ziepe.ca>
 <87bk72fcf4.ffs@tglx>
In-Reply-To: <87bk72fcf4.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9867:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TNpbo9m4BE71xLIFW5sycMHd4PcoGD+mstcMx72UyRwlNWPBv/smCTSzuXdUt5CeaePwP75O+/DO/J1mm9QexJQXXYhAtq5XBsKOFQQ+iNv2yuvS0K4K34DPi1z+MWqtYP3yDOi+ihegU0zBnBhK4UEohuxTTVTIXSr5jw3FnvMI8T0QC+7dRO6QQxnuRMn2nTf53StjGuXYxd5fzYAKjFyN/bYDLYakyADV5parqQq1U5tsLAtgvlbpI1ZERA0bzvrWOpLTbbRMt3gT7TDI1+m0Ud16Wn42WAPf67rmnoFBRILOftLY4psqWDDMV7i8bB51AbsLlc1o/wl5DDM6pTkD1Za4f/Or1psAzTv0qwgnLnkhFwPhJhFHmhD5z/cMuUrSBCIheD8ZCUa0VYBgz1LRCF1cajNyxmjPxbdUPRZgeE5qJag23yEGeC6kS31H/CdepP/xED1qcdIPwJgmR09pctPyixtIDgZZwUs/UmkUwMBBuKTO/9RhSMx58+MmplZEse50VuvQ6QtCyMnxtwigo3UjNPYlClNPdkqzKwovPjmQGdasD6BJWO9sRWPVYlusW5FCHwANHdAEksdQ/gzK0lfqUFmE6rpL3QhBO4dVDz0SzefbvWILMUat0/kLgj+NaTXz1jnIpH1m4snBGGtFSiZNMZ0uBn4ziYyczIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+2r99nOaAtZXfoPJw3+sJ0P+P3x4t351O6E5nv3ewoE70OAQKjWexG0q10/A?=
 =?us-ascii?Q?4fvUlkQVUUc6uDO9H/tCNEw7aCe3TDVDM6MYIIVozrENIaJ5sqRW17sIoG36?=
 =?us-ascii?Q?9AKzxa6TpAk+r9hxPBCxe6ipBI5wOCpFPp3KdHKh8+9VmxcyuGvVAGSf2wH7?=
 =?us-ascii?Q?lwq39EDW6GjZPKXZzi92AP8wSZqz69cg/oSSO6GqH1OEpmSu1w/URpsLvxWo?=
 =?us-ascii?Q?BNwrsmhplmHHMA11haqE88FXLHa9zzRJ27TbdLE7RTz3XPEhyFMbc8Fg/8LV?=
 =?us-ascii?Q?fnB9J/M1d4pxNxRYkZvKplOhO0pEEq57orHRy6wd5ZwOkXtjDKONHsj1Q62b?=
 =?us-ascii?Q?fSu2J2DgMEf9b3zxWum47P3KxRlJax9QniNSumDpO0k5qdL7RRQirnUhZOMl?=
 =?us-ascii?Q?BWYwZhHflV+KK5gdFCt4XpcNaHpzKDrdeEr36P13tzJMTnyM7yaZZ6Qxw6Ld?=
 =?us-ascii?Q?L0ihcYEsNphp6VVVd16Wbt4fGzh3JqnEWyI7VrvQIAc/HQUoeytmgQGSmehM?=
 =?us-ascii?Q?SsQ2Ys/dgIRcKIFfMQqqD+jVjf99kvwYmR3KW3IWknmk0+xHzH/FAc2Laorh?=
 =?us-ascii?Q?EWcj7ZBcWezpsy1m3pXV1Wo1+QG1aV1DTN+HpEmS2qJay/wpRwadSzv/U536?=
 =?us-ascii?Q?pGGhqiEgpOjeoJ4u0MS7kzAF/g64x1L4vaDedxnIy324wPMeq01eiMHwd6TO?=
 =?us-ascii?Q?6zri2b/1U9jJliEOu4PHfC/eegic7LapBnaSM69eo2RNwSylsgvtZ41+NKdW?=
 =?us-ascii?Q?g4nxWUmIyMJGAY00hOSTU8decvnZyOpQwLhz7kFNE9U6wpVV1G3OkfyQDeMs?=
 =?us-ascii?Q?N6b7UH+IUUslNE4TpzHQUdQ1cOuTS/7SYmPdtIOayYTAAR1qwBrObfzwS9ZF?=
 =?us-ascii?Q?gA1oKHvaGH62NkhwLUwDBRmw2kPsIZtBZSYmcpjA0k2h2LwWr4sh7JDi15/a?=
 =?us-ascii?Q?dSxCeM3qjF5q4ypnJ/sJ78oVv8to01flMDit/2658bpiIIP0P+F1VJ2Ap+WB?=
 =?us-ascii?Q?qTpFbGqCewezmjLmw8RCNPlxYsVb+aY83hQs6Vm8tLGamWtMnUuPvqdagwSG?=
 =?us-ascii?Q?uyfu3tna2mGoPCZX/H/uInmK9Dr5bsTW8KSnUo6FlQDuMCTtbL0wUKMMcDqm?=
 =?us-ascii?Q?43PjmrlTpxE4M1+YR2YBodlBxO4vscozcVdobKpal/yl5wTxPdxJu0iVW1th?=
 =?us-ascii?Q?KaXejnJjXWltHpoJleQ6HWzM6jL7TfrOqwTCzb40izWZbDHUxSmdNlPsxYl4?=
 =?us-ascii?Q?lWJ9xAfpaIEvIvvJ+kz46XGvZw8A3JKFQok9zQ8zqZRfh5tNVXOMTYLOPI4f?=
 =?us-ascii?Q?th6l3ZXoKMSmL7bgOtErDRjUwOAnaPWtFkf9PVWuxMvG7ZCSRF8Nb3Y11Cc3?=
 =?us-ascii?Q?NLKJi/xVvZQm0qbSS3LMTDudAwSR6I4Zj7q4/wYwh/5y/3T2xq6rJ0jxiVg7?=
 =?us-ascii?Q?lw+3doWMSHT60EBZLPd6DiLFtPoMyWhNtitHuKJFKlnSGyZhGpxcenExT92v?=
 =?us-ascii?Q?lWfiVURu1i52LyXNr7RDDCMDVV1lHibxaUxpUNY14VOztJTIpdcwAPJyn31E?=
 =?us-ascii?Q?kEaNEWUxRnvUxHKlokc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b32f518-a8c2-478a-50a3-08dc4d33b2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 01:26:01.7926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvsCvVLjO5l8xh+yHBtkrjvSDDFrZj5epW2WCis+SbdNQDKua4xBpaexiLlyp/hJiU032eycCQoCcsDA3lghvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867

> Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
>=20
> On Mon, Mar 25 2024 at 10:48, Jason Gunthorpe wrote:
> > On Sun, Mar 24, 2024 at 08:29:00PM +0800, Peng Fan (OSS) wrote:
> >> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device
> >> +*smmu) {
> >> +	struct device *dev =3D smmu->dev;
> >> +	struct msi_desc *desc;
> >> +	struct msi_msg msg;
> >> +
> >> +	if (!dev->msi.domain)
> >> +		return;
> >> +
> >> +	desc =3D irq_get_msi_desc(smmu->evtq.q.irq);
> >> +	if (desc) {
> >> +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> >> +		arm_smmu_write_msi_msg(desc, &msg);
> >> +	}
> >> +
> >> +	desc =3D irq_get_msi_desc(smmu->gerr_irq);
> >> +	if (desc) {
> >> +		get_cached_msi_msg(smmu->gerr_irq, &msg);
> >> +		arm_smmu_write_msi_msg(desc, &msg);
> >> +	}
> >> +
> >> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> >> +		desc =3D irq_get_msi_desc(smmu->priq.q.irq);
> >> +		if (desc) {
> >> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
> >> +			arm_smmu_write_msi_msg(desc, &msg);
> >> +		}
> >> +	}
> >> +}
> >
> > I wonder if this should be done instead by converting the driver away
> > from platform MSI to the new MSI mechanism?
>=20
> There is work in progress for that. Should come around in the next weeks.

Then I need to wait for your patches, and rebase this patchset, or could
the non-msi part be reviewed first?

Thanks,
Peng.

