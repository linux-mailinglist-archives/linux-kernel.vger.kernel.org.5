Return-Path: <linux-kernel+bounces-82501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351686856A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF445B22616
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A735C96;
	Tue, 27 Feb 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U4SjoKUq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19905672;
	Tue, 27 Feb 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995706; cv=fail; b=KSKSjBKVxF3JqzZJbW3QWKOXXwScszoY0BAIwJUurzNsqXYpBm2V2KZUehxznGiT1k8RqY5nJVE9QnM5UyVDf6W/b6dcpvxyUksYmZRAAIabHM3u7RbhQ5qm2PMsjW5gXX2GYQL3cuS+DCfCyzolY7x4z4FTJUtosVGApd2ykdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995706; c=relaxed/simple;
	bh=QPR3cM68Vi4Zid984dwJCcKqGhfcyrNq6GcXWobYcIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZZwlztCq0/tJ1pCHzeCqkvCctjXQdH383Gnqd5qpg0AJapcUkZCir3WuZkNTXmKX9ndGPjJQwlhnPzv5lfcQoYVEKB8oCZ+58fbdCZUMc5/w4g5FkcLTIlOY+d02ZgLSomwww3UjPRSzW4wuecvOPERcfOCP5WpIsUPszvR4qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U4SjoKUq; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anq5QFvkpDKeJWqHVDUNK3oQEERLUNav2Wjz0Nls4g7cR5Pb4+v/el4NMp1WUbd5ZQh41pp4qYDv6ojoYOgr2IKRXnKzghaEGigIfN8H0DAAo4IGII39Zuj4r9OLrPLlc+zit+WOp/GYnIsQAOfwbYM2kS2a2GKyvH3d/Vabp5vEzFLo4Ua2czlDyTAJZYxaxJX4G2IaXIgEMKPxS/vb/akHB9vSmnE15uBG5bo4UKp8UXvfUACW8O6Rsfc7DdHiGWOZXiHAyoeW/Cr7Fb24Tqxl710BAGumAx1JFCrEVQbBhUq1jpFYQQ4lSpl1M5YIgtgbR6AYTQf+SGqAejOaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPR3cM68Vi4Zid984dwJCcKqGhfcyrNq6GcXWobYcIA=;
 b=MjUmYFU+pooWp/YCciVwtra0qKz54kXd2ilycxFZwjs06uJNM8vaTKp+kX77717Wx+FSL1gFYiYtrjEu7OJtHBSgkGDXDG2Os2Q8XlXgdkmgzKaG8yQEPUulZ+7FgJ7EmYNXIs0rdVW1wjrb0FDMQvgTc0fRCFLqvttzfS80HSn3E4RFIO2E8/d+oXZRr9CXNfa2WtXG1ii/rbxdpgj4hRP9pQK34LS/IFTAilPjdGGUlrd9xndNOZy/+WNMZLy+DRQaTTHj2HT+Lpqmet/Md9sVLW7mUEFLYnu7uzqoZRk1gmfy+FlRIPcsBG/A+YIF2rlBQCNq+QqwGtP5K6r+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPR3cM68Vi4Zid984dwJCcKqGhfcyrNq6GcXWobYcIA=;
 b=U4SjoKUqlFpsARV+Pks6ah2jfNP5Xw4feYUAOIajq16eHWYCz+UN+Y3dGO6suvTm6ijE8LlcLPx4ZTsPChO7ubHThEBWzFav7E4MHUKlxva2g5X/cY9kt9e/mzCqruEOX9WduRg8VWNZd05M2yKRsE3B5z49DolyPBSbgVejnRI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 01:01:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 01:01:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Topic: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Index: AQHaaLLyfnmFjzyGqEimlBHwa2+g1LEcnfcAgAAaQQCAAKcG0A==
Date: Tue, 27 Feb 2024 01:01:41 +0000
Message-ID:
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto> <ZdyoAsYGXK9GjHVx@pluto>
In-Reply-To: <ZdyoAsYGXK9GjHVx@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9689:EE_
x-ms-office365-filtering-correlation-id: 503ef300-b719-433e-33f9-08dc372fa8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ft6HWzKsDjU8k5uD11JiGHf8jF8xZ+m1cw29Eq09R+280IUw4h0VzHgPOLlYTh9VtvgJo9x5ls8Sz9k921bDxAXkDCyIs5kr2XOT86B/U2C6+M9IklYS7Y4mBwgRR7ZzwfVZQTsSy/cp0/uPFPad1zqlvSydIBxY7x99uKzVUmpRKbb4mbIQjMFV0GzevvFC2ZXluqnhsYjHpeQ4yGdC+NqbybkKSc0FlxiFaFiH+xPzIC2XNOU/AOVgUiI5nmOHEhXdtVYEOMNg8iBCxdPQfIng+7kTxTmWOrLKEdTGuinidKrHvFZz4jaEM8173TIdg7UoT6fneM2ctXvb/hPqaI7W6dpBnC2gg3LrWFZCBR2/vLXRoTIY4IQL7l8Mo7LG1aMspaqnNey6MOuNAKn3r0zv+R4xoZqK4N10KN6WukylrJcGdRi2sPqVRae0shRSPmMp+iJwybsJNCSySNUvYq7zY1+i/eHDqHmZxCxHImS0Cq+ifkoI1JxBjTuIyARuxSP0UKggQeLM2Foon+gI35Sg+oknfA0QHtrqUutY2E7+EBxCjTte02ULVmZg9sdGo7m5FZSZu8DkLn5LRGcsHpoOfpylWEKghJlBO0PpMagoF8e/OjltmOt4OB/cPMUZUzYo8CuAZrKIvkNnonMllVq3Db5dpsUfXMGi4LF3JBWil3rQ8/ThjTZKVJ6TJUSK1TNbxwjoecZ9uRn17wBEHg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ObbTDApp19cgLwBt0N3UeHg5gxEanpq18LCWs/wS6j64R5RkdTBVBnnWm4oH?=
 =?us-ascii?Q?URovmhCa+/4NSRNK8wwXvgtGUchTJPBi1t+2Em5gNKjZKZMN861M/vIqaCC3?=
 =?us-ascii?Q?KI7fuZsVq6W1otRWkPupbKVsaKlL6bif1IQKf/aYtMKRL4Np1FYs6nZwKCd5?=
 =?us-ascii?Q?DqOOdYpzEshYzriCa96tAXD4IVfur4jEBz3DKvtG5fEesivWr0pwMqPtFPKr?=
 =?us-ascii?Q?G893qhAnGTa9hZ3KRc4UUN2EafQVLkVDBdOJgCqqPrUYzHdqaxlq0/23bdjX?=
 =?us-ascii?Q?w9VzmMdfpfJXiMvOucL0vcq+4kw3YYwG5stS+gsptRJ/7zev8eHzB6m8XhQp?=
 =?us-ascii?Q?n7SZRsaEaOYxPl1SGuK+zEvWciTrN8oPv0ST8/iNqRACfpPkzDUXxdDxOCAy?=
 =?us-ascii?Q?fZtJOPB3bGkFcvUAVYSZlvTawA3G4KVAOfOeOOqv16o6S/VKTjymKs+iFIvc?=
 =?us-ascii?Q?oN6s0Xp8m7YawiKmBkO76QyXLLZNLZhzzlCMunnpRWQRQt8IJ3aBUCbmSGyA?=
 =?us-ascii?Q?s0kDUoHGg7y50NcaahbF4OFJ0+0gXTEzcRzZYRkoFfUfeCCkb+Q7rFvlbDtm?=
 =?us-ascii?Q?klyzOxTn29BdEiYjXRcoSbCEhsgzOkMuX95MANR4xiLcDklUkPDS1Of/BCHH?=
 =?us-ascii?Q?LLWksWiUS/oSbq1momKR5fiGHNILPPZZHrvR32/4P+kQQTdk/HMsiRE1YrUc?=
 =?us-ascii?Q?LTLv2Bkn8U5mxYwWbDZM/aJw6yihxK68T+xCxmOQfxIem9aChKg2ig642VNq?=
 =?us-ascii?Q?e0yGI/1Vk3sF3leHos36buB2OK1XdOst+CZU4/5uwRf01dxaOGsi/BRn/F/c?=
 =?us-ascii?Q?MVS7HIkU4iwaxiE5olNQZrsp5DA13U6LnDkAU7/FHdfgfgmEABXZS45QKY3y?=
 =?us-ascii?Q?X/SYoyPjWSBaExeoyb2dDiuQkbSivJtLIWqdzyXcbPjA6tqwUFfpCmOdirwP?=
 =?us-ascii?Q?4Cw8BqyTiewCx95oOcwQskyXY80GklK8x+PQ1s2Tgu7Sfy/+LFdsDNAdl2mI?=
 =?us-ascii?Q?eIspEiUPyy5uD3RN9loBM8nn/q3wZKVAg9XTNl91f5Abwm9FkJ0pf2F1ZSpI?=
 =?us-ascii?Q?+7SR/CYD0lnen6GA9sRgqKM0ery1XgTLd6gKLbJLW5wvGDCgwgjDYxqjJEqZ?=
 =?us-ascii?Q?y1Hi7QrEdHIRi9WXfRB+PgwalIk4RjR231Ty/2DBwfdfyRdqE0U9BtENKz/B?=
 =?us-ascii?Q?WdiKsZBxSDy5Xm/riqP8E4sDdmdUykjgxmbWfdXR/yg//WlTedpGzJR/WNAs?=
 =?us-ascii?Q?dSfNFA1YPuKOOzxNemnWWGg08mui14py02Ltu4HgYrz08enUr9f6OfEMHkoe?=
 =?us-ascii?Q?SjnUu6aFlzHfxZIYudws60pMYpLCRN/38QP/vTqiLHDSuxDJqbP9tkeUA1DK?=
 =?us-ascii?Q?sGMrAm5epBMI1hgjo75lOiEJ8il5NcJG0KUj5HRl/fVhJo61w/Af0Mozkm1Q?=
 =?us-ascii?Q?COQKneg3tekI6o0BLphJWv1mbbnFZOptKMDydIBcjGIfvy/k0EtLviRsSVrI?=
 =?us-ascii?Q?erNbNV4kYIDYEXrCpzz45GxSg9y+ipBiEAHSP2bFm/3GizBNKqCSj4jW1uRQ?=
 =?us-ascii?Q?biUj5QvxG0OoqTGibHU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 503ef300-b719-433e-33f9-08dc372fa8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 01:01:41.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh15pucGI6MOZlNSxxNZi4vd9AI3Pnj5Ru4aD+bLrxjXWrWNC732qC1TlgBfxaKUIfUQ18rV0MCD0lVmySkRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

> Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system powe=
r
> protocol
>
> On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
> > >
> > Hi,
> >
> > yes this is something I spotted in the past it was missing and I
> > posted a similar patch but I was told that a protocol node without any
> > specific additional properties is already being described by the
> > general protocol node described above.

Without this patch, there is dtbs_check warning.

scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#

Regards,
Peng.

> >
>
>
> I was referring to this old thread...
>
> https://lore.ke/
> rnel.org%2Fall%2F20230124222023.316089-1-
> robh%40kernel.org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C73d2d
> 867857f409cfd2608dc36dbf475%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638445565544388755%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 0%7C%7C%7C&sdata=3DSDKSIbYQq5YS4M7SJXyWwaPLVvQK6wIPtjUYi%2FW3
> p6k%3D&reserved=3D0
>
> Thanks,
> Cristian

