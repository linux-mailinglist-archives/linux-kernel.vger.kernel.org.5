Return-Path: <linux-kernel+bounces-136529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B889D531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EA282F54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4537F47F;
	Tue,  9 Apr 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kn9uwk51"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA087EF14;
	Tue,  9 Apr 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654019; cv=fail; b=jhZjIxU+aY+bA0/qkCjk1bT/gh1p7D+V05Y1B/I8LeI7A7OfOf6701L+n1JLjcXmYZtzcMaogWOBddzA+lbi+QNltG3RGyiTrqtAf1Dr1NEJVcnNY3XpX31lBassD6rVW0Ge0HxiJR2lG3H+aTPlUIGF69nFXiRNIaqE0p9fpb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654019; c=relaxed/simple;
	bh=XydFIg9UgVdJgyoH8Aqi9rXucdSFciPI1K+9cM6SIQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABT42vbYoRfVeJZLeJUwuEpfLjnqBnSjM/WBlXLQJC6LzkzZYNDhJ/5BYyGJQ67Y99WxpBNdkSPK5RO2KoENOqVxqELOdvzTe/Ml+0Tjn35Auew1BRHv2b2cjjTOpummKKT2RqjAAkZiM+CWSGAcZDtlD5E1RolcggJvECkIk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kn9uwk51; arc=fail smtp.client-ip=40.107.8.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDaBzywy8C/G8M6+HTV6YzYHmmSSDpj+XlRgU2I49Uq0AHtvOQdsjULXcvnpwwVmVN2yerh4zrG8E+kpA962K/HMOEPRuw/acAMjm2JkbYKa4AoCWFWyEwzqfQni3ZvfXBZNlSBcVK813U0wojtEKfBpEDGvqjyaTCGOePz/TILuFwFu9kuOMIzRNJIBWeh8U8J6bP5p8GzA7X149Hi+siC0kKimnTtGUart2Y9mNlgLNWZ6aEXr2vHn8RKFsHp3SsWmXekk1JHH89zO9gooXkaBK/M3WHdlB7M18CnRrA37i1GZSb8t9HNOY5cctbe0wK6paNLsfeIUQnDpdEevPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ErfF23zCDug/88cj8gIyeGw/iMN/QADeTMsibn+LMY=;
 b=eHjtGA5uBKhpqWoAZWqnnH+ju3dZjln4K/iyTjvFG9lKmtg3GhvLGg0z7dw/8zxZ/v/LW7loAz2VJRx+oyziDdhdxOBSUkM2c/a5VAH/8ioT1W43bGImbOJMwhbWowyr1aDnxezvcknwogm+5KKnWT/wJYdy6FzXHuWNQHaF5KgbfitGX4uiRjYyDBMUdL06Qc6pyyGdrQ+tC+XX16Z6y33yTtH6aJeyvE8Wj/kjkb84pRvKZnDHjhklVjkff+GeGS0CdEuPPPiNQsO9XIMmNaohPiyTJBwRc/0x09Drbh981F/MvjaFz5X0bEg5SiUVpR/7CdBQL/mDmX2GRTwJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ErfF23zCDug/88cj8gIyeGw/iMN/QADeTMsibn+LMY=;
 b=Kn9uwk51Uaw/UN5sMgjcFcATpqkd7tjbbVZHoRs05ShynlcByaccNEA0rYBBINrFR6i91SuHbQTvZCJd849PSEbuWCvW8DllCGeuewVDx11wFA8fz0aLWq8WnSvgGQwcZMCEcv+Dllb8S+kvwB9gMDqZ7fhfzTvd5jx1iU4cw74=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 09:13:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 9 Apr 2024
 09:13:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Topic: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Index: AQHah1U7U7PbHuwUVkuCiXWcSbaKerFer8yAgAD57wCAAACBQA==
Date: Tue, 9 Apr 2024 09:13:33 +0000
Message-ID:
 <DU0PR04MB94175384AD9113AC6F60546588072@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto> <ZhUDZGJilhczKlDD@bogus>
In-Reply-To: <ZhUDZGJilhczKlDD@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8721:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wTHlc55uUtQVzYDy0oKvrRNw9kCZizBjW5KeJA2bqXjTTW3ei3PPk7gvHuGR+gEc6RgjlARzDG6NKqxLADuICxJx0BfY7Fwp4w9mVyYd41AULD8ouT+UhOhgAumoByBvspldngRDZcQSk1pIQFMgYAEeCkjh+yuJ7f0eROqPXGJzyJYMo4J/yYLcBJoEvLYJBLxk8cc5nFRGeaCTE5q2RNpJvrxlKjUwVD0K1obOHia3ngk6dNB9xJBhKxQGF3fGjNxRAyAwCd1K4z3EcxnYG/1aBqeC/yGAoK+HPyVy/mCo8wY8kVMfWv4dBBPrsnIT61eVK5sAvU3BtC1P0oQPZnq7k0RJ9SSob1HLO/imdgOtltOCQskTWrVgJULw1QXtVsiIDZi94NTLQeaQlkzpIzWampSHo9m8dfdVTcE7D4GL0xivLVfEWxQm3QOR9eWH98ATEKOG4KUspO41e9VJNTjpSWVyRLDap3zH3Tld082Mbf7/5daNfPWR7OgnSBYl17jkA1nHiBWtCqHgr97+WQfIVfcJBOfopwBIHzHH+0a+fzTXkPj3uv6Vl3Geb8sJvyOoji6ov6eHSkti/ntBBrpTXCpJTIVud5iYX2HbUoPwhCcP97QxlmwqClSNvABq/U5c3WwrJhFymJiUZPzERxZfOW27x0BZGwOKE/et21s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w5yWex9aDsSVsc23kZDRYLRJBnMWNELV8NBxnoxa7uKVoBRIpDQRIxjQQxMM?=
 =?us-ascii?Q?HRWhIiv+0csoaJh5WcQXorcVdqK35MlsrCHPHwG7W61E8iMU9O1+i1O+PXg1?=
 =?us-ascii?Q?rzlYbpgBPp/m7OXAI3FMp21qx6zGKTsPKpeVku81x1k23Hz/LGxqCl1wy3Wx?=
 =?us-ascii?Q?awwDZxUjhIuDc+GUnIyajvMUoJpovZ0j0rog5ive6ufp3ilt/fm7eH75l9wb?=
 =?us-ascii?Q?a6HWx0VXmEXEfCdqNvYdWq5tuhIB2tFj/Jz6Tg1oFG+0uDSsE4v3xNInJnah?=
 =?us-ascii?Q?fNMq7kuyFBpm+MhInpXOnkHei4HSb4nSu782x1sZSpKYhTqre6H75WrYfEdf?=
 =?us-ascii?Q?+ag8Lsir6ea9ielh1M3X8ehVwuCqdljBTr0Z8owUZ0p6S65UIix0nIgW9Tpf?=
 =?us-ascii?Q?dOrynAl75RHMPeqCe6pci29YeuSTaVgjckBCnFhiuzpD+TqbMIbhD2v2I8c1?=
 =?us-ascii?Q?fvZB8jMGUW77CPyGMC0Cc+pKeSIVGs6RU1yh1EsqYtk2EMsm+xpb2gcreNVU?=
 =?us-ascii?Q?n7TrIH8w5oBITqtO3NjhlDlT56x2om+hHd347KlKZ5Kz1clCRRxnnoE78pq8?=
 =?us-ascii?Q?Nzz0RvlNpEsxyC2IvIp0fqKK3C188Y33wFrZIFAiYjyVoi22JRCof/age9aE?=
 =?us-ascii?Q?nsNuWig1e/Ty9Kjw2sf532XKDb6nbkLclMoYHzJw70gKFDwKZiVrKiJPRc1E?=
 =?us-ascii?Q?q6/+Xx6PtylwWL89XL8y8/qyIF7TA5g5VQ3nVlB5yfhQrbXBRX7mDO52C2TD?=
 =?us-ascii?Q?T4hZ7wrUqz4JTHqqrrLtdUnIfY22L8h9ShxF+JPnsbRIEBDuGGr3XsWZZdTX?=
 =?us-ascii?Q?A/u1t04RFyKBnIP2qGrEYg3zaDyjizDyU9KTrIck9CVUWxuQQXRJZt0gMABs?=
 =?us-ascii?Q?XaCYWIllvz3UftHCsIZmg4NiMx5QaAeYcPHcIOUWCtT0iXeRCDdm71Ik5V3p?=
 =?us-ascii?Q?FLu91JztArvgG4DpHv6h7r2+74ARn5bmSZQtHZu6SWREcdlrnpDCuAyaAmWI?=
 =?us-ascii?Q?yLlh2QGkHRLmURhyMoh8Q8hqrElMkjuhrVGMWk5dTEC/0HUGc9O1lf2C65oV?=
 =?us-ascii?Q?Chv2PcJnyQDuune4rUu7WRD3mmc9lDGJSAUCpq82ZbI8it/gMWKy8ZKEWalN?=
 =?us-ascii?Q?jDLSR95LuH2GG59xMBgddSu/bi//evs/3RSsIXDecugDR+F30K6r+A3J8Y1o?=
 =?us-ascii?Q?e3EABQ1u7jrl17RdUfg4mS+Kd2FBktMxkDhguBaYDGXFiQiUBnjRL/zzwkRd?=
 =?us-ascii?Q?95BEtaNCVTOH+LNvfcCLmogn3S6H8LEW/V97JSS+2mPYHpo78N5GAhikNPoF?=
 =?us-ascii?Q?Bklesybr9lRNhPSslb1MhtwcAmSp53pNXfdwIr0lSPtR6lbYTEHuHJVZWXFr?=
 =?us-ascii?Q?Gfj+zaL+6z4Nnq7Pg7rM3DzuPGk9MbDDVG+rBk6Pgn17fJQrKkVmuuEjqj0L?=
 =?us-ascii?Q?M6HmvLt29Ml1YbKhp0uuLHxwxvSnGbRVDJbPSd6VTa9f0D72olgDVHMWiX+s?=
 =?us-ascii?Q?oIIxOIov37dWDC6AVGzo1YIk3F/uztrF9PK/Hov8/Sdj3hbNZ47xtd/mV6fW?=
 =?us-ascii?Q?Bgd4xyCuf6gsY3S+r2Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ca76e-9c4d-4f74-7b45-08dc587554a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 09:13:33.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj2mM2JNB+sOTnTMZ0+D+JLj4uhWn+VeG7v/iCR2Z0DcDzYz+/GvX503GfOYnqPj2vVQeVaADpH9WhCs4687gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8721

Hi Sudeep,

> Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i=
MX
> BBM protocol
>=20
> On Mon, Apr 08, 2024 at 07:04:43PM +0100, Cristian Marussi wrote:
> > On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The i.MX BBM protocol is for managing i.MX BBM module which provides
> > > RTC and BUTTON feature.
> > >
> >
> > I appreciate that you added versioning but I think a bit of
> > documentation about what the protocol and its comamnds purpose is
> > still lacking, as asked by Sudeep previously
> >
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-arm-
> kernel%2FZeGtoJ7ztSe8Kg8R%40bogus%2F%23t&data=3D
> >
> 05%7C02%7Cpeng.fan%40nxp.com%7Ce92ff78b9126447afe9708dc587358d
> 4%7C686e
> >
> a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638482499632395762%7C
> Unknown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVC
> >
> I6Mn0%3D%7C0%7C%7C%7C&sdata=3D7QP%2BkkjHA3Sa0CdcbbObGG4kgYYK
> XAGA2r%2F%2F
> > x0MogqU%3D&reserved=3D0
> >
>=20
> I have decided to ignore all these vendor protocol patches until they hav=
e
> some documentation to understand what these protocol are for, what are th=
e
> commands, their input/output parameter details, any conditions are the
> caller and callee,..etc very similar to SCMI spec.

Where do you expect the documentation to be put?

similar as scmi_protocol.h, put in scmi_imx_protcol.h?=20
>=20
> To start with can you please expand what is BBM or MISC protocol is ?

ok. Sorry for missing your previous comment in v1. Let me write here briefl=
y
first.

The Battery Backup (BB) Domain contains the Battery Backed Security
Module (BBSM) and the Battery Backed Non-Secure Module (BBNSM).
BBM protocol is to manage i.MX BBSM and BBNSM. This protocol supports
#define COMMAND_PROTOCOL_VERSION             0x0U                          =
                        =20
#define COMMAND_PROTOCOL_ATTRIBUTES          0x1U                          =
                        =20
#define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U                          =
                        =20
#define COMMAND_BBM_GPR_SET                  0x3U                          =
                        =20
#define COMMAND_BBM_GPR_GET                  0x4U                          =
                        =20
#define COMMAND_BBM_RTC_ATTRIBUTES           0x5U                          =
                        =20
#define COMMAND_BBM_RTC_TIME_SET             0x6U                          =
                        =20
#define COMMAND_BBM_RTC_TIME_GET             0x7U                          =
                        =20
#define COMMAND_BBM_RTC_ALARM_SET            0x8U                          =
                        =20
#define COMMAND_BBM_BUTTON_GET               0x9U                          =
                        =20
#define COMMAND_BBM_RTC_NOTIFY               0xAU                          =
                        =20
#define COMMAND_BBM_BUTTON_NOTIFY            0xBU                          =
                        =20
#define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U

For now in this patchset for linux, we only use RTC, and BUTTON
for system wakeup

For MISC protocol, it is for various misc things, such as discover
build info, get rom passed data, get reset reason, get i.mx
cfg name, control set(for gpio expander under m33 control and
etc). The command as below:
51 #define COMMAND_PROTOCOL_VERSION             0x0U                       =
                           =20
  52 #define COMMAND_PROTOCOL_ATTRIBUTES          0x1U                     =
                             =20
  53 #define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U                     =
                             =20
  54 #define COMMAND_MISC_CONTROL_SET             0x3U                     =
                             =20
  55 #define COMMAND_MISC_CONTROL_GET             0x4U                     =
                             =20
  56 #define COMMAND_MISC_CONTROL_ACTION          0x5U                     =
                             =20
  57 #define COMMAND_MISC_DISCOVER_BUILD_INFO     0x6U                     =
                             =20
  58 #define COMMAND_MISC_ROM_PASSOVER_GET        0x7U                     =
                             =20
  59 #define COMMAND_MISC_CONTROL_NOTIFY          0x8U                     =
                             =20
  60 #define COMMAND_MISC_REASON_ATTRIBUTES       0x9U                     =
                             =20
  61 #define COMMAND_MISC_RESET_REASON            0xAU                     =
                             =20
  62 #define COMMAND_MISC_SI_INFO                 0xBU                     =
                             =20
  63 #define COMMAND_MISC_CFG_INFO                0xCU                     =
                             =20
  64 #define COMMAND_MISC_SYSLOG                  0xDU                     =
                             =20
  65 #define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U

I will add the information in v3.

But as of now I am not sure
how to proceed with dt-binding, add in vendor stuff
in arm,scmi.yaml or add imx,scmi.yaml

Thanks,
Peng.

> Don't expect me to respond if the requested details are still missing in =
the
> future versions, I am going to ignore it silently.
>=20
> I have asked for these in atleast 2 different threads may be not just NXP
> patches but in one instance Qcom patches, but they apply equally here.
>=20
> --
> Regards,
> Sudeep

