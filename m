Return-Path: <linux-kernel+bounces-136020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD689CEFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C91F23D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE2149C63;
	Mon,  8 Apr 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EU1vSKqt"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2138.outbound.protection.outlook.com [40.107.249.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AD762CD;
	Mon,  8 Apr 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619321; cv=fail; b=BUkyDdQaYTpExu+SO3/7bSMKSLwPFtnMFosA0q5oqz2mKuGQcXTxJK+nOvVazqdGNWZmPCVfmo+DP9GlMYRtT0wtnmwfjSmZDDYiSsU/y5327x5gHxVFFS8SimwkSGzvt50vUW1QDn6xlQQLXyvn4D5TpSQbPf+8dKlMzkW+iJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619321; c=relaxed/simple;
	bh=sEJqhQqPGwvI+8COye5VT8Kl4Rzr8nSpX2RCQSGMOEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XD2DH/AYiA0GYcO/G9Tz4y/Uoc/KafhzvMOXYNNSGQBZA5e6TTTUqwjbKUNr9XdWP6pPcDf3cKk/zD+cpS3qVrptMTVdv57V9mDWp80vWu24x6/S42fcmJibbomxLnxpJCyvk5hzYzrOS0ujIOy0/ySqnwOenKqwS2bCoWdsP+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EU1vSKqt; arc=fail smtp.client-ip=40.107.249.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDqexZ8pWJiBkbRtl+yjN6xR0e7T24tDRveImjGzd42pEkbynkSm7zkSmVPKEzwvqaFo5mIWQKrTz8dDjN36k+/PLLCsSiHq9yz+FKUo93TtO5pfx8gdC+LfkhMUjKAc3YafgEzB5AoySx/HjyaSX/f1GZzoppoe+ddeCPBboknCknJ1AohzSS5B8CbrrkxIXldgBgy9x8uc2Dy6DJuvTZ6qW4lwbBY/nLUVfXadgNyAOrr7Ovz9QI7DDBe/GQPl96xwG3bRPUS6fQZ5PwgOiBq3i5O6iJj3T0Qxz2RvEySaLEY1Nc4AnGd3W6iarZnCchOmFPytZQMnH28nz+NBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUif7FUUYB93BItDAZY+SbxxIbRClPw4BAHSRWyLzno=;
 b=dcJI1aopM/TkDxv2PPpbhpFtI8/pIwwrZRWGp9I74t73RM9V8aNSPizUzO6ahM5XbF7qHa5D+/gAePvFozPu4WJUEPAOPpkImFsfu+7vhXv4ut09JR1aWe5y3deEzD4h5v9JXabsjriUT7t4DX4aNGRuxslYdaErH9hOCHhEKS6duQjifgDvstpayOk+6vD6DCJo8FaFEw7bakg0Gm3tzt9RypK5Z1zRfzr8LmiBX6Z4j9EOAtGblB95l6ff5JsTXV8GZ0ETpfi0nYaWto0Jk+6C6J8s1n16YyMNrkXmqu/h3A2NbmPiksAsH6VsuTgX/lOgdYDqgu9AW1WKVOK2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUif7FUUYB93BItDAZY+SbxxIbRClPw4BAHSRWyLzno=;
 b=EU1vSKqtihXV4SEs8lhP6/j505ICdkZYltgJDCr/oC8cAmVUj+4sPTOyYwXtZULa37YrWnCa5XVXHAOUNH0eMG3LmEB6f1GqxYzgiWbRGcJbasqa/Zrd+wYWeTjYyqHfBpM7X2IGudyNWSSBJeJqaqUkNV5dK7UfVmSoiLZYWzI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 23:35:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 8 Apr 2024
 23:35:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Topic: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Index: AQHah1U7U7PbHuwUVkuCiXWcSbaKerFer8yAgABblqA=
Date: Mon, 8 Apr 2024 23:35:16 +0000
Message-ID:
 <DU0PR04MB9417DCC510F2A08F3C6B1D8B88002@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto>
In-Reply-To: <ZhQxu8LVNKf5QDLm@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8989:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oL+kmvzgLhT/mB64mS3c4diCGyeSeHT8qTQTurPAtr0h1tIlNFz5rVuLh7kNGgu07Q1ZvIRXXkojhQpULRwardOhzomj524C8TuxnFDYGgYWr5eF6bZxTOp43er1Hjkm+oVVsnZsGBqaNxaYKd6Mk0EPjGMcFwnEYfBXFlVuwCKd9htjz9A/9pDL185rJ+Avd104Bk4iIpsKlDwQ4qd1DjKr4yjnRnE6hHI189s9mFzUJoFWR3Y7UYv6zimEu21bvPDzetVFiyfyH8FwoAzGBmaq9YY/nqvHs8eAPH2K6ekLbgy0hrs6A4n+yiao3X6Z1q2epGDyV63HqRzqZt24frhZTCt6jKxsyjKlHKq74I7R9AVGFG00Bs7/7gOfV2XjS/ZRLljb6s3tKDzsUNEOwHTfTSnr3bBnJ/OjgprwN2lDMW/Vf88ir46jy3K80AnJtXH6SwgPpUzhi2Vc5AAuxmDIlEP38tJ0GIVnXWP+sCEv9HsIHSJPJXE7bU9OZNn1Rm/GhiqiMfogccCcoIHJ1oMFePIeniAwU9Vz4U2ztFonc1vMIIjgNKKqK12ncBduJf5T/ngm1vKT2cM2bMY0CuVXRcP/o18CaQuSe1TkuPY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Af+T0DwUBldTKxXidHZOfHUCo/7MC2UCd2VaeiJHIKVf5QAfxex1Inar6ba7?=
 =?us-ascii?Q?YgZl0uTazNE2sHELFnSIsAS/KrHo6oktU+mtkSiBPp5wfy9kYOpixO33ShUy?=
 =?us-ascii?Q?+UqqQ6UbD1FQ6YCl+FMFMBJCHyQwPScL6AR2hRz6lN+95ld5RHPwHqXZAvFl?=
 =?us-ascii?Q?W7IgaOPwW6tOXhSDwi76fE4jdm726wCQdZVRfZ1uHVFIoa1SMiTE5kfu5La3?=
 =?us-ascii?Q?m5FVoJJoVfa9U74YKJGAPjyuAU6tAXAf4wVOCfdIa9QALW++eoZ4/IE6fpNT?=
 =?us-ascii?Q?iUV8pl6Ycqqlo5LOXGt2YCH/Sw9iBB7/tOvAjzyQHgYS3llLzb1/OXxjqHmQ?=
 =?us-ascii?Q?r7el6rTDwy9DVWiuBBEX1HtFU6wy3KyfW5p4IyIqXEkOnzuwHWTNkuHf4+gW?=
 =?us-ascii?Q?Veul3Kwc9+ELsbjwtJJM5LtLtpBY0zB0lDygbq8XQdSeFpp+o/cniaxVxbym?=
 =?us-ascii?Q?s9B5p8PnzEqMrqCe/yaML88t439Eoh9L73JjV6l4PsoSo6eKVnJjI9l6LRiw?=
 =?us-ascii?Q?mNyX+EhDg9LKtfiKmmXQTxji8m2vvEwT54f+38PprFX+uvqqxTCSkxEJi+Zh?=
 =?us-ascii?Q?Uu1vKARaWapK1gRScyvIv5KmmEfrGorjzcIZH8Ou+7dXK+YyTmchhvHNNjIe?=
 =?us-ascii?Q?bM1XPUtD3Gtq3ynEagwNwAdFNrSL6iXyrCgKoX0FvXyEMuoKi+yePBy2govl?=
 =?us-ascii?Q?EPdkGggIJsMUMXTpv4Zpty19Qtovh33n0L9sUcYETmjJUvz7Q7r1x+flq4kU?=
 =?us-ascii?Q?jvhxuDMBWnOCKnPONUbaNcisR8C6zqv1wbE1L4QLvwpnXOHs76mIZcPJ+Ux/?=
 =?us-ascii?Q?xtrDvwb1XdO6eBzhMjr0N5P6ai+0e2isv7+ghOYz4iTZ0DKOWn8NgbIX+wrA?=
 =?us-ascii?Q?wzwQ3tzMU+V61T6PQZqVyS6tWkzKcDK19/94QERL9wCsrgVmH0aHnzK9cphJ?=
 =?us-ascii?Q?wbYifhZdpN+9Y1S8YAVE6we97HSwzP24zEkqO8TaEPjGDAl10s1EhIAFyrrz?=
 =?us-ascii?Q?nswYaPX0GrhtthNlOlZIDfHwNvRi9Gip28smez8dNiq1aKlh6IYo8iTv0szJ?=
 =?us-ascii?Q?1sFJqN8ZoEyI/O57H2BkkmSolyYFh5ahVeg/83RgLmzqCJreLiN7s2rvtN3A?=
 =?us-ascii?Q?hRFw6TGCi8MYPOsvQc3TXP3UUS4JPYm20GdDN8iKwDDxMzmjzwHXYD2TmR0I?=
 =?us-ascii?Q?700qQYq8H551aM8IKmcUyII16sb/bHXk+do4FPxj0Y912sTGilgHAfnu31jn?=
 =?us-ascii?Q?KXK0Ddqo1z8LZqXIYxd82BPB3RHqeXzMvnETbA4wh+t3Mvnn7Wk5sOpyDm5f?=
 =?us-ascii?Q?xj+xEsT32pilcXxL68SF4clI4YAUhtEt5YNQL1v72wG5h6fGMQ8uZ330eKOF?=
 =?us-ascii?Q?mMo6Vc5ZO3SGhRlDjBTh44SaY23dk0pDUM9A3tJWP9E7e0udXpAqv6BWKHPZ?=
 =?us-ascii?Q?/OuBQLnnBF4/c1eOfRqVihnxtqNsg7UAeejtnPAH7ebW2FxTmxxHuN35ohWZ?=
 =?us-ascii?Q?y0kO6ASbFbZfJe0WaDQfo+P59NN8vh0eKPDCKJjtJMxPbipjiLt2E7k4irnX?=
 =?us-ascii?Q?QcJWzTmQCVYMxZDHbAo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b9aaa4-19cb-4d43-cf10-08dc58248bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 23:35:16.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doVA2fuGimEaQe7A1T3FbrzAPH6+xYnAio1CgJqK0Cl2Q597tpx6UzbqXwnsSEgKhwisWTpXGNjFs7F4BPrM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989

> Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i=
MX
> BBM protocol
>=20
> On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX BBM protocol is for managing i.MX BBM module which provides
> > RTC and BUTTON feature.
> >

....
> > +#include "notify.h"
> > +
> > +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> > +
>=20
> I appreciate that you added versioning but I think a bit of documentation
> about what the protocol and its comamnds purpose is still lacking, as ask=
ed
> by Sudeep previously

Sorry for missing the previous comment. Will add some comments in the file.

>=20
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2Flore.kernel.org%2Flinux-arm-
> kernel%2FZeGtoJ7ztSe8Kg8R%40bogus%2F%23t&data=3D05%7C02%7Cpeng.fa
> n%40nxp.com%7C37b12c01b51f4329e9e308dc57f66153%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C638481962901820964%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dd2XRugSYyiFuUnE5R2Oz6p
> xmXBaPC9lZ%2Bb%2FcMBuXeKo%3D&reserved=3D0
>=20
> > +enum scmi_imx_bbm_protocol_cmd {
> > +	IMX_BBM_GPR_SET =3D 0x3,

...
> > +	cfg->flags =3D 0;
> > +	cfg->value_low =3D lower_32_bits(sec);
> > +	cfg->value_high =3D upper_32_bits(sec);
>=20
> Sorry I may have not been clear on this, but when I mentioned lower/upper
> helpers I did not mean that they solved ALSO the endianity problem, so I
> suppose that after having chunked your 64bits value in 2, you still want =
to
> transmit it as 2 LE quantity....this is generally the expectation for SCM=
I
> payloads...in this case any available documentation about the expected
> command layout would have helped...

Got it , will fix in v3.

>=20
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle
> *ph,
> > +				     u32 rtc_id, u64 *value)
> > +{
> > +	struct scmi_imx_bbm_info *pi =3D ph->get_priv(ph);
> > +	struct scmi_imx_bbm_get_time *cfg;
> > +	struct scmi_xfer *t;
> > +	int ret;
> > +
> > +	if (rtc_id >=3D pi->nr_rtc)
> > +		return -EINVAL;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET,
> sizeof(*cfg),
> > +				      sizeof(u64), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cfg =3D t->tx.buf;
> > +	cfg->id =3D cpu_to_le32(rtc_id);
> > +	cfg->flags =3D 0;
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret)
> > +		*value =3D get_unaligned_le64(t->rx.buf);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handl=
e
> *ph,
> > +				      u32 rtc_id, u64 sec)
> > +{
> > +	struct scmi_imx_bbm_info *pi =3D ph->get_priv(ph);
> > +	struct scmi_imx_bbm_alarm_time *cfg;
> > +	struct scmi_xfer *t;
> > +	int ret;
> > +
> > +	if (rtc_id >=3D pi->nr_rtc)
> > +		return -EINVAL;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET,
> sizeof(*cfg), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cfg =3D t->tx.buf;
> > +	cfg->id =3D cpu_to_le32(rtc_id);
> > +	cfg->flags =3D SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
> > +	cfg->value_low =3D lower_32_bits(sec);
> > +	cfg->value_high =3D upper_32_bits(sec);
>=20
> Same.

Fix in V3.

Thanks,
Peng
>=20
> Thanks,
> Cristian

