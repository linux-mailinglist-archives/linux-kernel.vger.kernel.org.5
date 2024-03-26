Return-Path: <linux-kernel+bounces-118227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CD88B679
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514481F3FCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87E1C6A8;
	Tue, 26 Mar 2024 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZdwHvuR"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9741C2A8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414941; cv=fail; b=YejpCRYDtIJLpJsv6+QbXm3MTmoVK3Kr3iSCyZO/lQKlXXkEiZKl7+SjBN4O4VHDAA9rEd7Ehbf8WT1ZCwqOWZvvJap7uHnYD/d5KtLS9nvHMCT7rbII9XSPfddCXrDybDasyGLJpHCiWtluBsreUwRnrp41WsvqZ1CF5DNsOLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414941; c=relaxed/simple;
	bh=Y3TGKB9wUTnEHBNjDR1MzoiiUjlLWBYq5Lk3R9lMLYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8E7PnwCvQu792pIBAcosA4GJBUlYvqI8HFDoZ1Zds0+V+fpGPiqEzCPYJ3RhqyAM6avsyoaFtydmF8RaTzXURSyJCEAPyVZAHd5PcJmxrX7OBoX8ZhpiYQDPuB9oy92wU5F/ZSCZzZoBxK1kCFCo74DJ6P2ZW2Lrjenbx7Bxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BZdwHvuR; arc=fail smtp.client-ip=40.107.21.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APSe8G0VTFETjMw2Em4V4MbuW78/G8FXsXykJnh9XZNHoX16s8yWBpVnIy2v5XyS2Ejm0usg3g7RohtdApV8vz6lsEREW7xp7+nlEKxUmaJhZKI+W7VRpJlBxw84qDo50unjCdisGuZKaRR0BgkDNjibLeJiMwA6U0w0Kb/Sb6JSj80jKT/doPu/xCr5k6vcuMrAghXVzJQoxpc6GLY3/7QUOYNaRNiYR2JroYgdy6zFWz5jkurcGM4lvsmwn0shsJVr2Z9ASnlnXTm9u9bIRGQEXpcFO3OKqRKxaV89v85lBlk23vAXZZ5uFNTrAAZO/Bh/I9no7JgO//k32KbmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMWSsOG8TmcmjozC5NOM4eehBcuYstZfttdpuP/WUNc=;
 b=b0HGAZrP2t+8e9S+PoKAMMXOjnaPwl8iqqRPJa4FdDbkYPQBU4/9OdIRRDjDHReKPy7RcoM8512FT1ZLypKWVqOuC5aZJ0xG0g+Mn6UtqwNa45qMTfo7J9au+q5+809XkCVSYONWQiNbKPJw+OdBFrXo0ipcSikqUIuCbhu0UXFlJm20nwdTw3FmhSNLBLt/QK186r0OrFdXPjPVWrM3/uUofsvlHiSS2lTQW63lcXA6HZ0MM+iG6mJV1OlTVElC3M4LfSKAWHCkOR6PRJEMMx2SIkHaFFR206pOrhy9z+VraSIT/pEnO03wl0XFBQJ4sG22Ev/CabcZ45Rr8SGAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMWSsOG8TmcmjozC5NOM4eehBcuYstZfttdpuP/WUNc=;
 b=BZdwHvuRZV0dl5blVxszWKabFlyFmdDzFOCSbGthuhg72y7EWJJdRsQ/sa1ynFmMrGm3w2qGnStkbGhhZEBuk8N2Qw3Z2nyETo/sNXgKno7aLXj6MXvlOibmw0dQ6MkGiZaEssgm+BPDX/Y6oTinXHI9rZX0Wg1aOKg7+yDINd8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8419.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 01:02:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 26 Mar 2024
 01:02:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Marc Zyngier
	<maz@kernel.org>
CC: Bixuan Cui <cuibixuan@huawei.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] genirq/msi: cache the last msi msg
Thread-Topic: [PATCH 2/3] genirq/msi: cache the last msi msg
Thread-Index: AQHafeW34dOiKtZ0j0mwPH9MiAa2yLFIu2UAgAB4hmA=
Date: Tue, 26 Mar 2024 01:02:09 +0000
Message-ID:
 <DU0PR04MB941785FA6A6AB309E300571188352@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-2-11bc96e156a5@nxp.com> <878r26fbv9.ffs@tglx>
In-Reply-To: <878r26fbv9.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8419:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SMBu9KBhzXBgTdV+Kebk6EOWbycl1ZnSkjodn/bUcZ53s4QIyKEWE+FtdQ6xRyngKoniY/OiBTH/sOLJkCUWnYprJM2VSJBQX1f/CvM+4k5M56JdmQakRTho+/i1Ncyw4B1k/+5HMCXf8vKbiw3EmJncGQ3DzPh4BgRWBwL/3PHN3icchbl1JDX3ekelLUADYUT79y/tQAd4Ob6007lJ5d8MC2rlCfFqcRwGN1c14jzpZTDmuV23nHJC3n3af5PfS0B29rYg6tPFh/PntAzbafIxzhjMQ6qa/Je3tU530h9fbC3rsmOLGVBpW0KNB7XD/1NFUwGubL+2ixYJsEzBI/hnn8+1/0NPGPq3dsvEqghOd3XWSMr4li7e7ZSNwKQLl1KQQ1xPiDUrnl+E+uZvrcuGFgojOnh5eK0M4A9jsxU1IP+1Gglo+yfRQXryla89z//mvT7IfSzncdfMnqSkvPV8Ymto2BhTsvDzQnIM/9oUZ+dJ/Bx02KlSn5ORT8GRFPaLmuXwwD3Z7HBBsCuDY/1B7LRSSvNRKY8DrBA57AIj4TP1qLnvIOVq9GQrD0xxXqkOUQhXb27v4eMuV/2/H6hDIqv89a2VDRsQcc+GQU0P51RaOQ3/TXUCF7Kv4VXZH4gFSmHkOS9uKDOv8rolY9ZHlkf4sbP1u4FgUs5u/NY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MtAa7TFRzQhqZRgLnFhDpAEGMVkF1s5x5bGuuKmX+p1SRTBsPuugqmXK1HYD?=
 =?us-ascii?Q?Kiho6055HjmfKemmx1KI0cXG957tIDnO7pp5o/fFMUTZ+QUDMNbtxBNgBBdp?=
 =?us-ascii?Q?W08zAModobUNRg6+d1eR+MPylNmrLyXIEZ154ipUymy6N+XSZI0vGabI8Lgr?=
 =?us-ascii?Q?n86jQR1rvbjynLKh1jqT0unY8ppBdvLcAtuSCquv8KHUzxXzjHGpzexFM716?=
 =?us-ascii?Q?wc9dQXMxYG8KJGLfYe2rTIPsqmQLTQ2TvIIQwF55TthzRDnm5P+leNCoiL91?=
 =?us-ascii?Q?o9WPkXntdmaqijR3SchmcP4ht+hpWGZh9uwvgJkRTt99s9GkRq0UkC69pfMl?=
 =?us-ascii?Q?6GPYf9l9+lq8x4zMgm1Se+qWvjH/MxUJzYjOpzKaAyqIRzpDPA8YbIUL1AUJ?=
 =?us-ascii?Q?g877iV9R8rCx7YQaV8qWKXWZr9Xhi825Kl/3V+dUZ4kLLDAexmBVK7ZCyU6j?=
 =?us-ascii?Q?maeHIJ103CgiFSKpiqkG/fH3CP8qVOwRhz8NqSDIdAeHIm80nVJ1ShaYp+Gd?=
 =?us-ascii?Q?lypyZEHjn8RCDZCRMFkmYWXNoa6GBxb/gKf5aB1unp6WXXnqGQEQOaklneD0?=
 =?us-ascii?Q?HS3qAKCIA9Q0qfWFcg3PgGaku1H3XE93ysey9S+2YBomVWozsZAU0+vTfLwz?=
 =?us-ascii?Q?bZLSkq/7b3JzRclvxRvKB8yRxz8XPD93A3pol/vr88XIfnhQPuBRme7I3qYx?=
 =?us-ascii?Q?JFfd7E0/UxZl+JH/FKqHP9clmaGBA22Q845BUFsXYbDRlK0c0DFh8AU/yA8H?=
 =?us-ascii?Q?D4oxzr7VqWizmBeoVgzPNXdd+c77MqTdoE5JN8OODTxW4h8ZLhUiK4KTGi/z?=
 =?us-ascii?Q?WNEOGFNQcy9HDWP30CZ28nh03X9sraaTsJHNuoKoWlpKkPXEZG9vkrgi7xJs?=
 =?us-ascii?Q?NE+8t18u016X3+duzzLf0iohr5yaLRH1+8LufY0brpjlIzabF1eMpbxtLYJJ?=
 =?us-ascii?Q?mY+72e7pmGvv8MjduD9TmxsewflsMrqUyOz4/4r9RvNBDRZLm6ut52/Xvtqm?=
 =?us-ascii?Q?YUddjzRk06MX/GjdT2mJMddZNQCGMSImu6syyxR/mb2nzJEz6SeAwWEROMol?=
 =?us-ascii?Q?FL6L24D00LNUFEejT/fCJCXVRfjC/oP1nGl6bdHUtmshIHn0HDRhyQWwRRjQ?=
 =?us-ascii?Q?A2zntnvyXXQWBN3y4HpAet6althXvZbxmkKClK0EaMaDKIrpJCrnVfujf3lR?=
 =?us-ascii?Q?B22EI/mL9uXf43IyY5yr1d2garQGceLOPsNsoQubMXjDGmuR+ZCfkHtP/5UP?=
 =?us-ascii?Q?IgHLSeJL/2QjZtk1BRkptsq8caJ59hh83VfzG4Ev9WWcNdcSgpw7wye4wIpW?=
 =?us-ascii?Q?H2C3W873MALVnIMT3+gkQXZirj4QXdSUcjeJ+efRLZIcnEZaN1zY0SgN8tdi?=
 =?us-ascii?Q?2RWGSSKJHSa3oXYWoCXfGbb3WZRo/Si41MRR5ThJuRobKsd5/ENCrdH3HTET?=
 =?us-ascii?Q?/mTmJugPh8/795FPv3zuI/UGnbr+PYpKlw+/rjy2WN3JgBmgpl0P/hsRHbuu?=
 =?us-ascii?Q?9FD1G1z/Al0okOCtxk3aZaqWJogYswgF80wtEEHHly9w0zHEUeNNqtKyzza/?=
 =?us-ascii?Q?JmjMJNQoyA+CMPSLrPc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf34ecf0-8958-4836-4333-08dc4d305d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 01:02:09.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcSrNRDAyecsoYMA8DUKDkLwz4D8skhUVidyku+2HFW9Hu0EmNyb/4EsDFNxnGPKlx4TfEFDuUKPH/UlvzxlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8419

> Subject: Re: [PATCH 2/3] genirq/msi: cache the last msi msg
>=20
> On Sun, Mar 24 2024 at 20:28, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Cache the last msi msg which will be used for ARM SMMU V3 resume
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  kernel/irq/msi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c index
> > f90952ebc494..9d7e0a675089 100644
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -617,6 +617,9 @@ static unsigned int msi_domain_get_hwsize(struct
> > device *dev, unsigned int domid  static inline void
> irq_chip_write_msi_msg(struct irq_data *data,
> >  					  struct msi_msg *msg)
> >  {
> > +	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
> > +
> > +	desc->msg =3D *msg;
> >  	data->chip->irq_write_msi_msg(data, msg);  }
>=20
> This should remove the very same line in the PCI/MSI code, no?

I think no, but you have more knowledge than me, please correct if I am
wrong.
To zpci_irq_chip.irq_set_affinity
  zpci_set_irq_affinity->pci_write_msi_msg->cache the msg
In kernel/irq/msi.c
msi_domain_update_chip_ops=20
        |->        if (!chip->irq_set_affinity)                            =
                                   =20
                                   chip->irq_set_affinity =3D msi_domain_se=
t_affinity

From above code, the pci/msi code should keep the caching code.

Thanks,
Peng.
>=20
> Thanks,
>=20
>         tglx


