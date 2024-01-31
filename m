Return-Path: <linux-kernel+bounces-47369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EE844CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773051C212C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971A13F01E;
	Wed, 31 Jan 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YKmIYGPO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C23FE2E;
	Wed, 31 Jan 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743375; cv=fail; b=p4rUYZxz2x8DRHZqXOjgwoxqbJRbPpOPz9DSsfSa/CJYujyP9udrYARGypgt5gkAQv+nKSfLRHzM8vS8sl3o7ifEnhnaqgnZsNO/Ce6At5Kx9wxBoQdaumNa7Lri9tY7I38GGhuhdQHxqKH6CMxx/kf0YFnxADIL6/GPlR6GKKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743375; c=relaxed/simple;
	bh=JgoEwJM0ScqUVhuhwlHJ8OeJ7RMwayj8ZhylfWEKyl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1p4y/JsxN6/59snhJAZNn2nF/kbLI4cKOPB+XTG2Z7R625M2R0TLwfJYu0vTL4OmLb8AH+XUXEP6FrNmMBbABO53u00od+Q3K375wsPqQn6P/WeIVCgbVFo7ugxwDBCC75UL2KA1kVqMaRsL/F1G4+dWr1oRRic7UiNNTDAex0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YKmIYGPO; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJro0y5xvOoOD40tgYH74EY4709h8Nx15TZPJ6/ew108FNN0QW8AEKtl9HODWaddGAdcLbfTiUARwe1w7W6pUGGJvLHt+O4okzfBODLFF9E+bmfktU1JHOHZpNQQ/Nm/RVWsnOz5zWLPv/VsNT/1AqrjlAgNZCN6qnreT9qX4HvSfmLgc873GK5IHLR1aq/msgsvzHZCOqHKQK+JPLIy48x/fHEZvCqXGcX8ZMqz7JCCkI4ujpodWTTApLnGvMDIXqi0MbjR2Lril1wjkDJ7lV+UpChDqid+0r9CfThAUD2SmpPqwmwvIzeUcBT30MWjGf6Mw68P0eMRAjzmmCL4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgoEwJM0ScqUVhuhwlHJ8OeJ7RMwayj8ZhylfWEKyl4=;
 b=RF0bofzOM5kXSkaTBZrCbRJKVy5/Wm/7kUyFfWiYE2E6l2hOLyxYTwTzKy+IqMXvDu/jhakPi3jXwv4XhqVFBtt4JRbwXFyV4mYoJflOY6bcW3gxsidYBeXL7H0FGbZf7Qx3QYBtQqoGwnRu/LHSG/Q3pWHHh3Tiwa4XtmGJuQEsuhGfxFRnd/VgMn0TjZuI6jcPoukYia1KHyEbAwachwfdnTT2r4tevyBK8VDpoX6R1DwRtCIiHRJDc5Lonaw+eWM9KjFbkvR4+a3DjiWOnNjizC0C5ZNwqLVVbryZYkRHFFrtc5zSBLqhhwAiAcQLDe9pMC45Julih7HPWqmVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgoEwJM0ScqUVhuhwlHJ8OeJ7RMwayj8ZhylfWEKyl4=;
 b=YKmIYGPOqHJTMAurwRrHEWIOJyZhvBy1ZfDwr3Io0uwkTRjswy/eLJ6RP6l3SYi7okhg31G6Kxb67DmuhzgUg4cww3nSSC8xTgbtj6C81YukNua6NhHo3Tivj4xpKqdZL+M8rP2UlNaLnD1vNMmtLt8W3ree+6Y6YxFO7u0N0qA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9869.eurprd04.prod.outlook.com (2603:10a6:10:4ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:22:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:22:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "wg@grandegger.com"
	<wg@grandegger.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Thread-Topic: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Thread-Index: AQHaTRM/wbiiEv9ixEO2u0SZ0nixIrDloMCAgACwDYCAAKhyIIANGEEAgACM2sA=
Date: Wed, 31 Jan 2024 23:22:49 +0000
Message-ID:
 <DU0PR04MB94178632D6F774339FB13375887C2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
 <20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
 <20240122125631.4c54eba1@kernel.org>
 <DU0PR04MB941750744E86A1656009B7BE88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240131145736.GA1262278-robh@kernel.org>
In-Reply-To: <20240131145736.GA1262278-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB9869:EE_
x-ms-office365-filtering-correlation-id: f6a025ea-543a-45f9-5028-08dc22b38a9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Sy1S09OHgsS55jF4qGU4HyLE9gVb5PN1bbbELlbVSWpoymIphKKtTqHEzuWHRyrc3M8jtQlYAnBZY5SHD4ioswPfkSzbCqZekPUXh7ZqTKUfA2H5JbOugiM0WfaRYTS9QrxLieWnf7nUzk67xvCY0R157OetunFpXetA9729ANs/SUbw7t7OS0EU+d9+SODLGGwjy7X1vU8IZrI9g4Ce2LVwmgYSlQDTM9XmJcBtpB2V9rL8OBT8KFmWDS2CjwejKETuVYXv2awgKaBqHAYryr0dKWaZBYsIUug1T+F+m1f9RP2oBoQt0eWIdHbTWxvZN6FbnHuJ8Vt6TvigkMmPMmVk7JAGFmE10CSjV1dQfB/B3r7Y/uID3kv7mnJtfcdTgfkY3SqBOwwpV+UWOw00RxhjyDX/9wLpEs8UUAvBq+ixmQ3QJsi9xEfFeS9PUMR5SFHL5J7NCnqySPhw0r58mLBGPwO4PzUsNdlIZmLA6W1noUpHhkmy9XJJkzBea05jpSZAi2OeLhC5VuHwYKHezygCLw1dlGo/0Z4acqbYibxrTmt/zbyhzkVobjahwx0do3xlcGvEPi9YgsFdYYyGQF8AGHdb2i4Lts2GFv67rk4ZC36nQpLuiFS5SGY31dlX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(41300700001)(33656002)(86362001)(76116006)(38070700009)(122000001)(52536014)(9686003)(38100700002)(26005)(7696005)(71200400001)(2906002)(6506007)(4326008)(316002)(6916009)(66946007)(66556008)(66476007)(66446008)(5660300002)(8936002)(7416002)(8676002)(54906003)(4744005)(44832011)(478600001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J8e2YcEIMNFnrKIn2w/VwF7nbDs2irCLMWMDHMn2WXd7jFvX0nFF5nUFUmFF?=
 =?us-ascii?Q?E6DhVoDIj9ADDfTmgZ1QevxaXBHLDKQGLiQNScYs9gmjYflQd2DTQUHajwao?=
 =?us-ascii?Q?skCNnBPnXwzTh90yz4LUxB/Ij9fdnvkcyFGihNFhgNVPdiZcvpuAq1kJLk0Q?=
 =?us-ascii?Q?HArM1ZsEvOGhJoZ6X9k1bX+QnFVMqNqZivNF9B6xD2adEGvsUYGorpR+V3yF?=
 =?us-ascii?Q?j9QOqjGUP8kIObxfUpsa4i41xA+GnwZzwefej72rU5NOLfaGq+BFjrflYHdm?=
 =?us-ascii?Q?QfPLvCvSSdHPAubxK8DRHbu4azxe7+Z7xyJEQMr/CKl7F2xljbR3IAr8uAUd?=
 =?us-ascii?Q?A4q6JuD+ZAG+Ltvfy3IZv7ro/WqbM14+U5f+mZKbucuNWr/QLT5ORJSzjX/A?=
 =?us-ascii?Q?pQZZ7gAIBGw6KZjfWseXc+xa+ImaOruEjm0qHbriVYf61HFZiY8XaVxg5zZl?=
 =?us-ascii?Q?dkpQaxo7meIxOYZVpoU0/SWsuOqHytVfRpLi8C72Nb+tEXx3iWL+ILHpIDAl?=
 =?us-ascii?Q?QSKRmGeMXhZC9omerGFHedwxpfAyyUNIfT8bQT3ul4wt3uR8Lr1v8UQEcm9A?=
 =?us-ascii?Q?FRqeXD2NkU32GqJ6fowOEI1ZTSUCt0126l82uI1cGJ/EY1narwvDcASZKjBm?=
 =?us-ascii?Q?H98Avma7HSkVYIABEN78qC8yypPYwcabGLLgO7XNkRS7Ha4HeoIFnYNtHKCn?=
 =?us-ascii?Q?9HcGCvv1vTsrp+DTNqfdZ/748GDaChBvXJNSxe9BROJmAjkjE/GlubN0k8pm?=
 =?us-ascii?Q?jpQRQefJoaxxS99EEcnRXFbpaKfnbt5vYnBNz4Dw2NUa/q/d2qruK3bbK6cO?=
 =?us-ascii?Q?3/aXrrqOIpLKfY5qm1ZnScC5h4QUUSw0BPsSZCdYSjxI5rnMaEc8tMZIcINN?=
 =?us-ascii?Q?FmqvIgXgNicHRTy0jyTlzFFt6DbMFUk7Enai/9a0xXq5T584EE7eSpjeoXIJ?=
 =?us-ascii?Q?yzvTwzk1NFleA+QM4FDCELXTfUek8Gi/gx0t5rbkd2bRXX9WHca8tWBPBYPX?=
 =?us-ascii?Q?U95Igf2XKNVA2Djvmt4eOx2KK53Qk63bQMmpL14zYyKaOSZCPrpBD76HGtoW?=
 =?us-ascii?Q?JfO3cU2YrrqSucNSQRqGHAUFDsK+IKinQjjJjwHE5KqlOUflA7lOoDH2BrMH?=
 =?us-ascii?Q?bGSOGzIXZ19xyxICigLNVoGQOacYIGjqCxWvRwe54OXUui/3pjpYNm2zDLVd?=
 =?us-ascii?Q?9YMcpvjJRPzo7JA0werifmjZWCMSpbrp1ZsZYCHjNABxNqrV5mkwSttI59bJ?=
 =?us-ascii?Q?uvE9RGcjH8eNZCvArgFfudOFDK8jRYSordOaetpvXvzIqvie3N0UrNpNT9Mq?=
 =?us-ascii?Q?Qq14ovdEu88oGQJP7dScmJHQ1yhO5INIFn4IAB0DxU/q+6MlIRx54XOROLwE?=
 =?us-ascii?Q?JvxshaNk5xlC6jYqQytF6kbJTXOCj0d8w0y84e595mizH71g9BtvKJHgbE1q?=
 =?us-ascii?Q?YgNGNzTOtaE1PQVOo3vxweHZdBoYBFB+mzs9Ze2Xln0ZoAg3Qzg3hjBwYbF1?=
 =?us-ascii?Q?SBPa4PU5d5fNQgThDvEpvWjgdbNdYSElDg10mWRLJNTm6WhJquM/up+xBvMX?=
 =?us-ascii?Q?+ihqO3zXPsEBjyHbvcQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a025ea-543a-45f9-5028-08dc22b38a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:22:49.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhqkmdMcH5mhMOciM39BmCivtjqOuyrs+N6IYMk+5kRPN04+nUOZmy1F7MuZCWbZDQkWwAUJLZb8Du+y1NM+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9869

> Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
> string
>=20
> On Tue, Jan 23, 2024 at 07:00:27AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95
> > > compatible string
> > >
> > > On Mon, 22 Jan 2024 11:26:25 +0100 Marc Kleine-Budde wrote:
> > > > > Add i.MX95 flexcan which is compatible i.MX93 flexcan
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >
> > > Hm, you don't apply CAN DTB patches?
> >
> > Nope. I am preparing dt-binding first, then post the i.MX95 SoC dtsi.
> > The CAN will be in the i.MX95 SOC dtsi file, not a single patch only
> > for CAN node.
>=20
> The question was why isn't Marc, the CAN maintainer, applying this. I hav=
e
> the same question.

That's fine, let's drop this patch, the CAN node will not be put in my soc =
dtsi
patch file, it will be in a separate patchset with some i.MX95 patches.

Thanks,
Peng.

>=20
> Rob

