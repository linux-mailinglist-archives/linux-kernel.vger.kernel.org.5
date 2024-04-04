Return-Path: <linux-kernel+bounces-131046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558689825B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0806B23587
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5505B208;
	Thu,  4 Apr 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="aVmJioy2"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BA1F95E;
	Thu,  4 Apr 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216688; cv=fail; b=mSGEyM9uzk0us8R5YvTpR2t0ni/MQvxV/utf8GqFQcEuabr267+H4WtCvjZM6JU7dCDszUrtfbvSlt026GfrGT7D0YsCG7MSd5Niyenej0W1Ebi85KmGsKcFh2tXhxPsuJDSr7V5dIqlxy2trYgKy/s4EF9fDDighMXXP6dkLVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216688; c=relaxed/simple;
	bh=NQRwhbD6tmXJ2t7804/tPmdqRA2dhHzAhx/9af90Ocg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NfW6sQqKNoyFvRlpYplxQyy6jbCt+neMFdWMCfcpJ2TDpibe/DLkk3wcr9TBsTiE0+Dc1CEYBllUdVnLlrc3r7yTC9OiNshITKmGNbOZGzFGQido0lgKpHxoYz89NEDBpBI9Wn5k7ibjJZX6ZqhcbjT4kN24ykks07LVQR7I8AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=aVmJioy2; arc=fail smtp.client-ip=40.107.113.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAB6vytw0qZkbq3YkxKjZ6X3v1/m0Q08+ncgMbplek77mvX5+7gcr3O4txt+3nVu80BN4eukeTdXO4uKiHIHMaruccLR/yVt1SpjiLCsS14EZiOpbttrDmA57ZuRpRByoZGFKPTMg+DEIs9trQtBPNJMjEg74wgy4beJ1pO1r+lcYWjdkZvC/waPTOPQrbYy5wsX5bgadWmmXlw4sT++iZZ4igs8poqO0xcYOD6OSYqa4IijFf0opvhG+9l7sJnxjy11gChmV4iG9kwT5xlrjneumNC+467z8nYxhum8LjGvt3lH0hJqHkOZzOZ//DfD1JzjoTiovG0bH1jnh5jj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4oMsZe76ly0hfyLkx+41BZgF9pkUGK1aeoX0G/2JJ4=;
 b=IGEY0UjyvsZZh8hry1OHBJNj/VlfCVCfxpHWxAiHZ6fmh4huPaVE4DFQnefIRZvj9lLMNnscG9rRqOUaNPbL7HVp3BT8QdkOBDVn/8Q7Wz/jRIDrfgqQFlIs0QY2HwN8wnI8xE7uaZNZEIMJxNjpDi1tOWz3DrVbDWwtk3U3eGgsisjWdG8W1lRizvbfyVQ68owhNaAL6RdEa1sQwdx71FglB1A7A2qvu4bOvk+eAsu4mERTEqajWoKqHzImXKu72Wy0ae040tMDy6vJp92rPFK5pl68TVdVeC++6UNrspQ7XNpvyt6G/IGhKOrGQFIprW3tVuK5utbA/CNKEVqcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4oMsZe76ly0hfyLkx+41BZgF9pkUGK1aeoX0G/2JJ4=;
 b=aVmJioy2O28fnueWnmRv7iJZXPIB206HlrUQ23QclieWVzdYvxoHrzqxwdu8hp0Wy/LHmuLvgw+r0aHr3AjJQjj0/1ZuPjr9fmqSRoimfslNAFx+n+C/fVimNFkmx5YjhBDTa8Vr+Ed0Ftk6dM02yxDzyWI4g/ieeLaSXi87zac=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OSRPR01MB11660.jpnprd01.prod.outlook.com (2603:1096:604:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 07:44:41 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 07:44:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
Thread-Topic: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five
 SoC
Thread-Index: AQHahgawx6i4BBuUjUOQbcTE7AeY27FXt1rA
Date: Thu, 4 Apr 2024 07:44:38 +0000
Message-ID:
 <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OSRPR01MB11660:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XcWb0bHY0r/ACLzlrP6ycEBRSBfmT5zbxrdFXNvAY+eF1wbBMQGlIBLCkRTh8hsPHeMzKG42+fIrV5fGb2ncLk4T8Cb5+HTXLuyNwnco39rqqT1ld1noWRdK2Bvi68+J6lneYliJkm5CTZokAYpyh6cCO7uaTL+vk6wwqKa3Da32MrADAA9WqQ47yUWspxOzVO6PISlhQR7aivyTopIsCNxijY+kpJaAtrj5C627wwXvsCU2iqdFv3Lj88Y7fmcjZLKVkWE2c14e+mbtu7DLRzJxjeqCTrLpMBjWFk4raY38kfSVJGqLGFS9dB+FFAFrQed8AOQBY9gxNLS61DWbW4Ib+6QCJpYS3CNwdE6X39omBSO4f5ayCB4qO1DQ4PYXW2bFXe9uCR39Db10FAXTKOmq5aYotphJxqWEmlmKy9rxC6TJNOlbaaedpHKSNEkJlo3kvjkMmNE1CKeMeedqYqTCOYoUNDcE0gRvrdL/duM/7nSiSuVAvRdjEHdsF70t8jYa42ScxTVABEBEovCCMLiazAdduwP3BBtYMWFEOP4rjNCRPOiOapI7tYPp2kE9I7mw/UYUbl+VAV0P+pIxZjiTnnJu8kZrk4qs31xfnnKVHgEczHkID2ffQCrde8bL0z4QccJqsTqtv9U6d7m/Nw407bNdmTk4J2sGI01VqvYQL/dn5WOmgQF3Ci7UbKFg5bOi104Ru6HVtPXNMbRT/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?llL1AwiHrnz9zNataza6NxQtwNSJSNqmn0umSnkrcIHJdtKwKHghCTQuHrbP?=
 =?us-ascii?Q?0zxGNRwmnxdL0CJ3UFE5XxofOtnu19Qr16MAIj54rtEyn1d1rWCXTVYPNTNA?=
 =?us-ascii?Q?AQuzdRM3dSCg/4CZL1wEtG//XPoUym5q2RIjAoHLR5dzKEdEMVdXeuK2joDd?=
 =?us-ascii?Q?zB50BInGqwHBtjNpmq3qoyqGQrKr5ARfCmOV/MiCj2pt0WsDtYnagz0m/xfp?=
 =?us-ascii?Q?C19b5Rt2p1+n7p2myhG+g6rNdbg4w5NK4ubFccwa4AZ+VqgbWaLvlk+JpE6y?=
 =?us-ascii?Q?+6u87DAV56OvJZ80P4dcWDKwK/nrEPCagBhSJZVOXB5l7naDP3J4rW1xpJUO?=
 =?us-ascii?Q?9g7vNxXNp7rz2VmzecxGPRS9vE5RrYfSzKMKv2luOn5IYjIaC57Xvl6epAWL?=
 =?us-ascii?Q?yg70SRWByUGt0a52/8/P0ylPLNIFfAFRCcSV406/JUm8MgGB0v7jkw2w3Mjc?=
 =?us-ascii?Q?oQWl3v2nDwHtBkg8DZUSorgghSLD9p+qCLzZgafvhGgds9OhoP74s/1fjGq1?=
 =?us-ascii?Q?Nl6wYdy5gIpRq2Jwdek3+hoeHIXDoB1CTrSn12TwhPOMqlqydoxxzyNGk5yA?=
 =?us-ascii?Q?V7dqpmqXLVmmaTxNSa9YPKRQUK+RUpRugv4AqO3SehY4DLKKJr+bGRDi/lBr?=
 =?us-ascii?Q?msYZAqxw30hcFWtkIf27l1oYlcVXI+oCrBmK0/duBHpSMInGusoS/uE8WY0U?=
 =?us-ascii?Q?oaZ7QJpm2kPrBnljMwG+tu8MBNGik1gk9YBFL/1y5J1oYYDuZMRUbAOXf+VM?=
 =?us-ascii?Q?PE7vIRrLgAxgWhFDjPB4ybuCRaQRYI35kPI1qMzuQL19gLQP0m5RKcuF8oiJ?=
 =?us-ascii?Q?1gGi0ymr4s2gCpbx9YLk1t4fLPRTAiNtDG4/tXPWWjjTmnhEqBQ80ERJ7S9R?=
 =?us-ascii?Q?OAjHN/iTf+IRmmmtQ/89b1AH2Z465tUdxSNPGfMONBh+fjwAaE2BBGSYSHfv?=
 =?us-ascii?Q?Onv7csVwaiAK1k1jNvZAcP7BSWdGXxHfglNPum+UCxSfO9N8QurN07LMfdXf?=
 =?us-ascii?Q?05MjWgsGmEBS5r3GFycWBMLqwmaCLGZto0fEcwXugEIbvW12LN7oqpIyvvtk?=
 =?us-ascii?Q?dnuH3w+geTKwRPZh+FR9laCys361d9Bu16Kdb1A15jZhEU8bkUY1tse/+8a0?=
 =?us-ascii?Q?eNUi1wt2PfzHJH7muSo8Ca7qbBd2gyxQTVpf2EFC6RMsT85UuoB1CXp+gZLi?=
 =?us-ascii?Q?fk6UVi1rgXwcYfUOBjSAx3ZHx3IpLE3i8FCm3J/Y1BX+MF5w+ozQfTXO9m8z?=
 =?us-ascii?Q?K961D8vNjGsFuu8r0vPHl9mP4TWoho9eEjxxociy27fGYS/1vHYUCcmaLjfz?=
 =?us-ascii?Q?iMJ5GhQF7Nu45qoQGE5P+3QNx+gJ23T3n+Ct9kBJOfD8DX8aHdzcl2bTldzt?=
 =?us-ascii?Q?kzq9yNleuarJrCbN4mGIhL4YlTZ/YVliPrzPEGCOZZhkdsHjlwGa49dUNkCG?=
 =?us-ascii?Q?wXhHJWwbCWkR4LzeUznfvkLbhhftV6V+vdDdOyLOd/nfwhBT8l0qB3TnCGrb?=
 =?us-ascii?Q?jDEG6TJnFOe7i4x7rIXUDzkGSzZMpojsScJG2EscwHPZ/nz8NkIu86FnfmwD?=
 =?us-ascii?Q?Rec9Uq70OWFGEl8tbxT19VfNHioddIKWJ0uk3FQFLJ8EzDT+wVSMlzuMxXqz?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fc12de-37e3-4f70-26da-08dc547b14e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 07:44:38.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkpjAtrDlj2JpdMKoa1CjyZw4CRUjZHWHft1156iGNL7tiJnh8W7vLZHSUljdGAkDs9zVqIazwovG4SVMZCX6bxHvwv+KHPy3AxLJG7if3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11660

Hi Prabhakar,

Thanks for the patch.

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Wednesday, April 3, 2024 9:35 PM
> Subject: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five So=
C
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compared=
 to the RZ/G2L (family)
> SoC.
>=20
> Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC c=
ontroller driver. Two new
> registers, IMSK and TMSK, are defined to handle masking on RZ/Five SoC. T=
he implementation utilizes
> a new data structure, `struct rzg2l_irqc_data`, to determine mask support=
 for a specific controller
> instance.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - Added IRQCHIP_MATCH() for RZ/Five
> - Retaining a copy of OF data in priv
> - Rebased the changes
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 137 +++++++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-re=
nesas-rzg2l.c
> index f6484bf15e0b..6fa8d65605dc 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -37,6 +37,8 @@
>  #define TSSEL_SHIFT(n)			(8 * (n))
>  #define TSSEL_MASK			GENMASK(7, 0)
>  #define IRQ_MASK			0x3
> +#define IMSK				0x10010
> +#define TMSK				0x10020
>=20
>  #define TSSR_OFFSET(n)			((n) % 4)
>  #define TSSR_INDEX(n)			((n) / 4)
> @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
>  	u32	titsr[2];
>  };
>=20
> +/**
> + * struct rzg2l_irqc_of_data - OF data structure
> + * @mask_supported: Indicates if mask registers are available  */
> +struct rzg2l_irqc_of_data {
> +	bool	mask_supported;
> +};
> +
>  /**
>   * struct rzg2l_irqc_priv - IRQ controller private data structure
>   * @base:	Controller's base address
> + * @data:	OF data pointer
>   * @fwspec:	IRQ firmware specific data
>   * @lock:	Lock to serialize access to hardware registers
>   * @cache:	Registers cache for suspend/resume
>   */
>  static struct rzg2l_irqc_priv {
>  	void __iomem			*base;
> +	const struct rzg2l_irqc_of_data	*data;
>  	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
>  	raw_spinlock_t			lock;
>  	struct rzg2l_irqc_reg_cache	cache;
> @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
>  	irq_chip_eoi_parent(d);
>  }
>=20
> +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
> +					  unsigned int hwirq)
> +{
> +	u32 imsk =3D readl_relaxed(priv->base + IMSK);
> +	u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> +
> +	writel_relaxed(imsk | bit, priv->base + IMSK); }
> +
> +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv=
,
> +					    unsigned int hwirq)
> +{
> +	u32 imsk =3D readl_relaxed(priv->base + IMSK);
> +	u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> +
> +	writel_relaxed(imsk & ~bit, priv->base + IMSK); }
> +
> +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
> +					   unsigned int hwirq)
> +{
> +	u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> +	u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> +
> +	writel_relaxed(tmsk | bit, priv->base + TMSK); }
> +
> +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *pri=
v,
> +					     unsigned int hwirq)
> +{
> +	u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> +	u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> +
> +	writel_relaxed(tmsk & ~bit, priv->base + TMSK); }
> +
> +/* Must be called while priv->lock is held */ static void
> +rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
> +{
> +	if (!priv->data->mask_supported)
> +		return;
> +
> +	if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> +		rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> +	else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> +		rzg2l_irqc_mask_tint_interrupt(priv, hwirq); }
> +
> +static void rzg2l_irqc_mask(struct irq_data *d) {
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +
> +	raw_spin_lock(&priv->lock);
> +	rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> +	raw_spin_unlock(&priv->lock);
> +	irq_chip_mask_parent(d);
> +}
> +
> +/* Must be called while priv->lock is held */ static void
> +rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned int
> +hwirq) {
> +	if (!priv->data->mask_supported)
> +		return;
> +
> +	if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> +		rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> +	else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> +		rzg2l_irqc_unmask_tint_interrupt(priv, hwirq); }
> +
> +static void rzg2l_irqc_unmask(struct irq_data *d) {
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +
> +	raw_spin_lock(&priv->lock);
> +	rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> +	raw_spin_unlock(&priv->lock);
> +	irq_chip_unmask_parent(d);
> +}
> +
>  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)  {
> +	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
>  	unsigned int hw_irq =3D irqd_to_hwirq(d);
>=20
>  	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> -		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
>  		u32 offset =3D hw_irq - IRQC_TINT_START;
>  		u32 tssr_offset =3D TSSR_OFFSET(offset);
>  		u8 tssr_index =3D TSSR_INDEX(offset);
>  		u32 reg;
>=20
>  		raw_spin_lock(&priv->lock);
> +		if (enable)
> +			rzg2l_irqc_unmask_once(priv, hw_irq);
> +		else
> +			rzg2l_irqc_mask_once(priv, hw_irq);
>  		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
>  		if (enable)
>  			reg |=3D TIEN << TSSEL_SHIFT(tssr_offset); @@ -157,6 +253,13 @@ stati=
c void
> rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
>  			reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
>  		writel_relaxed(reg, priv->base + TSSR(tssr_index));
>  		raw_spin_unlock(&priv->lock);
> +	} else {
> +		raw_spin_lock(&priv->lock);
> +		if (enable)
> +			rzg2l_irqc_unmask_once(priv, hw_irq);
> +		else
> +			rzg2l_irqc_mask_once(priv, hw_irq);
> +		raw_spin_unlock(&priv->lock);
>  	}
>  }
>=20
> @@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscore_ops =3D =
{  static const struct
> irq_chip irqc_chip =3D {
>  	.name			=3D "rzg2l-irqc",
>  	.irq_eoi		=3D rzg2l_irqc_eoi,
> -	.irq_mask		=3D irq_chip_mask_parent,
> -	.irq_unmask		=3D irq_chip_unmask_parent,
> +	.irq_mask		=3D rzg2l_irqc_mask,
> +	.irq_unmask		=3D rzg2l_irqc_unmask,

I feel this will be clean, if we have=20

static const struct irq_chip rzg2l_irqc_chip =3D {
	.name			=3D "rzg2l-irqc",
	...
	.irq_mask		=3D irq_chip_mask_parent,
	.irq_unmask		=3D irq_chip_unmask_parent,
	....
};

static const struct irq_chip rzfive_irqc_chip =3D {
	.name			=3D "rzfive-irqc",
	...
	.irq_mask		=3D rzfive_irqc_mask,
	.irq_unmask		=3D rzfive_irqc_unmask,
	....
};

And passing this in rzg2l_irqc_init() and rzfive_irqc_init(), see below

return rzg2l_irqc_init_helper(node, parent, & rzg2l_irqc_chip);
return rzg2l_irqc_init_helper(node, parent, & rzfive_irqc_chip);


>  	.irq_disable		=3D rzg2l_irqc_irq_disable,
>  	.irq_enable		=3D rzg2l_irqc_irq_enable,
>  	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
> @@ -401,7 +504,16 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_=
irqc_priv *priv,
>  	return 0;
>  }
>=20
> -static int rzg2l_irqc_init(struct device_node *node, struct device_node =
*parent)
> +static const struct rzg2l_irqc_of_data rzg2l_irqc_mask_supported_data =
=3D {
> +	.mask_supported =3D true,
> +};
> +
> +static const struct rzg2l_irqc_of_data rzg2l_irqc_default_data =3D {
> +	.mask_supported =3D false,
> +};
> +
> +static int rzg2l_irqc_init(struct device_node *node, struct device_node =
*parent,
> +			   const struct rzg2l_irqc_of_data *of_data)

Maybe rename this as rzg2l_irqc_init_helper()
>  {
>  	struct irq_domain *irq_domain, *parent_domain;
>  	struct platform_device *pdev;
> @@ -422,6 +534,8 @@ static int rzg2l_irqc_init(struct device_node *node, =
struct device_node
> *parent)
>  	if (!rzg2l_irqc_data)
>  		return -ENOMEM;
>=20
> +	rzg2l_irqc_data->data =3D of_data;
> +
>  	rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, =
0, NULL);
>  	if (IS_ERR(rzg2l_irqc_data->base))
>  		return PTR_ERR(rzg2l_irqc_data->base); @@ -472,8 +586,21 @@ static int
> rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
>  	return ret;
>  }
>=20
> +static int __init rzg2l_irqc_default_init(struct device_node *node,
> +					  struct device_node *parent)
> +{
> +	return rzg2l_irqc_init(node, parent, &rzg2l_irqc_default_data); }
> +
> +static int __init rzg2l_irqc_mask_supported_init(struct device_node *nod=
e,
> +						 struct device_node *parent)
> +{
> +	return rzg2l_irqc_init(node, parent, &rzg2l_irqc_mask_supported_data);
> +}
> +
>  IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
> -IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
Retain this name

> +IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_default_init)
> +IRQCHIP_MATCH("renesas,r9a07g043f-irqc",
> +rzg2l_irqc_mask_supported_init)
Maybe rename this as rzfive_irqc_init ??

Cheers,
Biju

>  IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
>  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>")=
;
>  MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> --
> 2.34.1
>=20


