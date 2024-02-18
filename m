Return-Path: <linux-kernel+bounces-70150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B74859401
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15B32823DA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DA15C0;
	Sun, 18 Feb 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZ5ZqHn/"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CEEDD;
	Sun, 18 Feb 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222790; cv=fail; b=mSphUB8uCvPoGmmV3z1AoNhHah4DEtlZD5SHFYcdBE+ru5GmNYBVD+NmkmtV24SD8FeKO118DU075Q3tAPJhhrUgpsrCP2PHu93LAAkyeAjSprFIG9NLZdYT2vhIccOyCyaLTfmdLmku1A7OefrqK75YPGcVgeWJ0YRlN3mYNYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222790; c=relaxed/simple;
	bh=rLR3MIZu+o/aA6eYs2tgMlNVayQehlrBySjlNJoU6r8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1zdrVlJQh2UyaU7/LfCqskQcxbv6nN8Qqn+73ynDcGZqDkGf+aVdzR9SnfC510HdWiZ+TXtA42KM7HcIX47A+/xsuxo0JJXlMQ/pxYhykgZgFUMEPkAT/61wFKu+A6B6CIzFQMA8pNy18Jf+DPsU6SQs7aKToclPgINCZOQrF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OZ5ZqHn/; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny5b4cDck7wgKo5xsHn6EGWeCrLfp9xYCBW8ISgn8YpaKQYMXqW1jPj5oRTXLDbVm62rg1YsJfBgbZ6yFUq3HC7J+n4kFNK2XfAI8tXUwA45iBmgvZAf9naHrPFtoKdzvqRoJb5f6O9EgFkYlWGBw8l+rQMIKaYWayVuzfFRkIJV6jP7Ps0F9QMJWk7fmSRlf6sEDnkXZG4/0PQ+e5kRc9i8B4RvHg/ZXSTOJivXICU/tJ3B/DjpE6l+SQItOl4dJDmF673NSvzhJhxyfatH7KgAHYARNmGo0we/sm8GTeH/mkjadpGEELiI3LfR2lPKIA74XK1528mmeZXJnpl8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUFzU5tMZji+fheQI4MwejMk5u2g0MxxAB0UUSVuXVw=;
 b=T/snmOteQhOOzjlQ+4FPXQscmp0HgxaMmiu1a3pxXpdLN1cw/dYkZ6v7jEricBVCfJ5/Mb76HGkWkiqKB6tm3cJ6qBKcaPpOWgQpxDsOfHKsTUzQcmsLIrRdWGDbUalsurVNLkBUTNpx3bVIAjJY9boXrFxgxElBy4y0YeCQ/QiDwCL+j9FXbgKXynNjC+khomhQtyHQFSm2Ao9sliPUfU5gibLgsmE0qN8Ost1MqZJvJjfNonuLO0PJEm0xL3G3im2rUKxHBxV4W8AL80/JGsR6W/w4kjXKrZ4fET+kxhmKJt9wifr/oHgo+A6M7uTKiG6skeoo6PtYYLgd03rRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUFzU5tMZji+fheQI4MwejMk5u2g0MxxAB0UUSVuXVw=;
 b=OZ5ZqHn/rTp1FSIvgWdVvnG5nnHS2imeCvPT4LMfaJoIfDKheyJLIZX+LNMeDVY3kJv7f9VdK2HcLCi2TMnO6eRVbBhaq6iI6eGYAgEgl3YFt6ej3TWeyM+vx2tz7b45lxYErECookpFSMNQt1eKOdwEPrbcBsCwG6Yis2sbAfI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sun, 18 Feb
 2024 02:19:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 02:19:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Thread-Topic: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Thread-Index: AQHaTFmmql8ovfOyiECAB0+XRIDNZrDnQZ8AgChHR/A=
Date: Sun, 18 Feb 2024 02:19:45 +0000
Message-ID:
 <DU0PR04MB941784A5A667756BD1CC584288522@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
 <20240121110901.1414856-2-peng.fan@oss.nxp.com> <Za-fTES4owsmmxgO@bogus>
In-Reply-To: <Za-fTES4owsmmxgO@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8763:EE_
x-ms-office365-filtering-correlation-id: 69ef42ce-36cc-4296-0dc2-08dc302812d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O/gtwYZSxH1U37b2robv7iSgV5BtzThM3H0z8717yyXWJPTEIGR0mEsDZAXq3iM1PRAGGZ0qGfVoBIxmVvYK0sY40GX+1h8GvRsOOQaq6iirWw21wdIoyZ1aPVPY2DXTDRtcu9x1hhNBtj5biOEtXR9v8SC3PUMYbP1x+24IAgFfW2Amlas3yPTI+cBBAE3l25i5E8aK+26IFhlsrNvkZ/SwsVoCY56WOzo6ofhRyrhPL0/v1HLGyJs9KBvgMAnCngodiqB81a6hXHh77RbcUaguZzrSZrDGfCxo60XSyEIcneeY1L1uOpjpNn6uXTPZYNgsdUcjxUKP5uGJRqOm37JROgtAXUttEcose8fiJh84uqRClPuv6uLOSLkpZO9kPTLZeLrOPBzqRdrPI3HvOXhjbzIe9AyeAtSX8EBqjLEluPqGBILIuSVNM88qlFT604529PEHwlWeKm9YiMDuKY+FSN2knoLuIFPhekBfsAlHhrdl+b2ghBQVdoSN0qK8lynY7vTeI6+bJ7H2a8aheTY01jIarmk+EZW4DfSbr+TmALn1WTCWN5eOYuQKQja0g7maCuMRof+3/pXAQkOFJfQt1wJ3Gk0L1sRt3mXETkFz9SDM3h9yQsKZO4a8mVet
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(122000001)(83380400001)(38100700002)(66476007)(76116006)(66946007)(66556008)(44832011)(8676002)(52536014)(64756008)(8936002)(2906002)(66446008)(5660300002)(41300700001)(26005)(9686003)(316002)(71200400001)(478600001)(54906003)(110136005)(7696005)(6506007)(38070700009)(86362001)(4326008)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D8JflmW59l9yVHdTsCwkFBiEFQ2bNvQ3l7i0oApOncJq+AMN8ACRZp0f7/tZ?=
 =?us-ascii?Q?hH31AUyl/kc/Nl/QGo8ao/o2aw7NZ3ooFX+cPoDn2L5YP9XYYabdKUArprVL?=
 =?us-ascii?Q?vjLdmhkqXwbBMDdEITXYFzg7QQnlSBcwpBe2+QhJqcQMQniL6XEkbZSvV3NY?=
 =?us-ascii?Q?EUUIC3rm73RZ+O/2NYeLDrSSXQqdwm8/DD8z2w76iHMu0YGbNLFzoiSFkUQb?=
 =?us-ascii?Q?ohmb5vaL+VC0uzoyl98929vG1TAhAyCT/2lz6UEfMhRyhnHhPYTBoaM/0wRm?=
 =?us-ascii?Q?zYYAmrKhrgHdZSW1kdp1atMZsCzIja0nq7hQi3f/gpkeQcc9d/3kSMiuyjRY?=
 =?us-ascii?Q?m+FW+AxXvbqIzI3OayBfmHRJzqRcJgj2G/ZKe4owiU86tvQq+4rIurQhVHJn?=
 =?us-ascii?Q?u5fBJNIzwcd/O87bUswS//xZRot4EFfkBm06UcvOLTKg6sQNLMQj5onRytGb?=
 =?us-ascii?Q?vt5yN1czd/F1bQ2Huv9ZPLlZLnk5ka7dgUbDQBSqcia+QUAEEGwNtb3I1VXq?=
 =?us-ascii?Q?5eVTr2Y61Wv5wqJ8gH561yrzr1tMTxEoEqytxrc3Zwewzou++puKG33r5ap5?=
 =?us-ascii?Q?xe/7K77P58VblyTAATJ8f7KIDqYkB2tvx8CVTfTPchpx7NJu30ih6a+zKGAa?=
 =?us-ascii?Q?zCsT+tKPckcyxzyEpoJez4b+0fl9/mz4a7X8oBFluLEZTGfRMtGkJDyPgaG2?=
 =?us-ascii?Q?6cGa1WXgejmbrLDv/lAtXQ5foSN/lJ1MDrX9sHaycd/MdqXxkYGg2EDX+H0D?=
 =?us-ascii?Q?DCFLS7rGfHQvivAuK4jhGmqI83ExF0lhOt0uh1Z8mC0G1VYUe/CnpRFDgb+Y?=
 =?us-ascii?Q?vI2yo+ZsMggVa6eNg12LkBRf3KGrqGk7lVGmzvSLAngPFCEU9pmhSM/WfTNY?=
 =?us-ascii?Q?mh05KImWRz8dcqC5W2P9YKnJuYydVFSSTUPWL1iqP3a7Dj84Dd3YwVSqRhG0?=
 =?us-ascii?Q?s708ThR6XQdlWKbl4dz6eJJenM6LVmqqO4T2/DScegfcPPDiAFLDTMmX4uhg?=
 =?us-ascii?Q?L9oL7f0kPixqEYA9ZIvLiew26LeQwH3OqBKIcbW3ke88/HLqBDU+mdnPhsD6?=
 =?us-ascii?Q?UdcoTKfNd+3wsmL++EceJ7OBGGjMGjy9lWun9PLY9OUMA9MPohJJcyV38/Mb?=
 =?us-ascii?Q?+wPLQj/naV1HIvA++f0JYnwJiV+LAxe07Hp/4870C+HvQk7D98i3ItnKVaqx?=
 =?us-ascii?Q?oFQ3WW84AvQ/z5Nd7zVh93mK3i96I9Il8Pc7HPF/P4j+NUcgzlZ8QEkPqW+8?=
 =?us-ascii?Q?rzUvSs3g9HbQEjXJr7TbR86FwsJJEcGz0ONW18jrpdm0vYZOJMt4ZXmkAEbc?=
 =?us-ascii?Q?/L6wkrvqh7B3G8q9r1RU+BH0Z7fvWP98/LTJ5I5tJnY9zzVETH/xIN1NLHrf?=
 =?us-ascii?Q?Q3+S9a8RwGzOYAem7LpG3UqXGXc1KCWgmm6Zfhf168R+4cg20EAOH4Xlk5r1?=
 =?us-ascii?Q?pgcnuGR6QLwSltzokkFcEQOA631Pg7CdSMzlPU3zvz6kB1oW+p0LyHQU03EK?=
 =?us-ascii?Q?KEsVAHSwS4QzNM/f9P8hNBthfSX7AXuNHoSeLpM2Qa67A8Edc62QJ4CDt3ML?=
 =?us-ascii?Q?JdTb/eqOIhoNJCdYLEs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ef42ce-36cc-4296-0dc2-08dc302812d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 02:19:45.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5qefS9uQ3YiQRZAyiSdx+IY0xIMy6wb9X22oISyb+/Y3OXzeRjQQzpNDUfz0o5CnKD2ui9X0A1LuGw0MOIkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763

> Subject: Re: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
>=20
> On Sun, Jan 21, 2024 at 07:09:01PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Some clocks may exported to linux, while those clocks are not allowed
> > to configure by Linux. For example:
> >
> > SYS_CLK1-----
> >              \
> > 	     --MUX--->MMC1_CLK
> >              /
> > SYS_CLK2-----
> >
> > MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> > then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> > So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable the
> > clock of MMC1, adding scmi_no_state_ctrl_clk_ops to use software
> > enable counter, while not calling scmi api.
> >
>=20
> I would rewrite the commit message something like:
> "
>     clk: scmi: Add support for forbidden clock state controls
>=20
>     Some clocks may be exported to OS agent, while certain configurations=
/
>     access to those clocks are restricted to the OS agent by the SCMI pla=
tform
>     firmware. For example:
>=20
>     SYS_CLK1-----
>                  \
>                  --MUX--->MMC1_CLK
>                  /
>     SYS_CLK2-----
>=20
>     MMC1_CLK needs to set parent as part of it initialisation and enablin=
g.
>     SYS_CLK1 and SYS_CLK2 are exported to the OS agent. The clk propagati=
on
>     will access SYS_CLK1 or SYS_CLK2 based on the configuration. However,
>     we need bypass the failure to access SYS_CLK1 or SYS_CLK2 when
> MMC1_CLK
>     is accessed and enabled.
>=20
>     Add a separate scmi_no_state_ctrl clk_ops where the calls to the SCMI
>     platform firmware are avoided if the access is not permitted.
> "
> No need to repost.
>=20
> I need Stephen's ack to take this together with scmi clk changes.

Stephen,=20

would you please ack if you are ok?

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

