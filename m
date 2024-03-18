Return-Path: <linux-kernel+bounces-105664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B787E244
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2FF2830AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229461DFE8;
	Mon, 18 Mar 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8vzg9mn"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F61C10;
	Mon, 18 Mar 2024 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730033; cv=fail; b=CXwQ4H+YsXDX8vJ6t96R81j5aD0PRsp/CwnMmUCwXRmYY8mK7aVtwAsV+vpGo7DanM7/bMuB9ZxbChLpYHGB+vrHq2F9yRK3WurKei7fXz4HXBCWKIYl24ipr9JtH/Tmtxsrq58SPMhFBihPnxmsd6/7NHjXDkwUIrP3Zai0YWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730033; c=relaxed/simple;
	bh=sDtglPoaFEw22QeN6AUMzWOHVCLVXTxqMGal0ezbY1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSXTGv1jk+7tTfWMFCnPjyIC8KuXa+LS6s/256gW7UipOnZlqFlMjV3MajDbujZG/bvxbFsjyb3YJZjgzW7LQbfeuLcLSekjVeXH3/dQhxVIMa+4y0my0To9ybZKY4/lJXrEKCWJbhbDI5S+yNBAhhfNgZ/CCHqV+Ev2WI15yDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8vzg9mn; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X51YIvENz08vk9uhF/NLq9kdnbHcgGh64MqJn9+3c9+5jNHvMNEmwQxw7bkJizpLk7vACjt6ru3DEPd9ULih9N7EbC1Z2USO0AvNZMojV/AsKQ9mrWEHYTdx6PfTxydZzLoV7dclWKRa4n3aDj/PIJXLnWrkMsW2LFPJMHtvO1t0wci7FtORHxLmk6QilB5jq5tZZm7Ygq3oIyTLRyZeATo8L5I/ZJKD2CI8JVudBQg1jYyf2UbqVfZNSGSFfXy0PFP18PylK+hqHkQfLAuPksBW5NB1bh4vE+ZzVTfBZb6EnQcD7Ea0I1kPikR54WmJm+oFDZEYBHFxN4oQNiPYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDtglPoaFEw22QeN6AUMzWOHVCLVXTxqMGal0ezbY1g=;
 b=FozA9TAv2tOamxOb/XyNxor7aiQKuboiD+OYsWNeh6WLI3f1lvW15eIdNvaq+3WZyLiTjKCMBHyBgHhc5kzErxoIGoUK9YVcAplr6fdaXoaEaEHVsgH6JeNRQTFGF39ovzY4B7Utg5ORuWvq+SzRX+aCK222mBHoNghVEBcFrtEDmjKZV8kW0zWVrpNTamM/VzDw99IHzdlw0PEmaw1GI7ydfuaJFycv9neVnFKKX63HT571SnkPZv6b8mGxJXAeAHmR+ogFcx4aUM7QGkzO/k0mendOO75CLFr0R8xEsPj3sI2t08i+TGmncSEQn4JQPRtOwfSG4L/+1ONkcpPXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDtglPoaFEw22QeN6AUMzWOHVCLVXTxqMGal0ezbY1g=;
 b=a8vzg9mnb/7rOvrI2AFYP2+aNAmwRiQkkvUje9i2J8VdI4a3l7JUfoiYB0zcxxm6mYJD6/OTwYrJQmuiCBw+pzxm6+c318LtHNo2nTTLuDTNegqV6fzuhas2abrPrn9liIuNCTU9twUTXK2cNFdqsjf3NHkpqO78G8ikupn30Xw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:47:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 02:47:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus Walleij
	<linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHadhNQAq3ztPnC+06ZIaeZ1qof0rE3crUAgACA3vCAARLLAIADylFg
Date: Mon, 18 Mar 2024 02:47:06 +0000
Message-ID:
 <DU0PR04MB94176621F225DA0316E2734B882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <ZfMqWP-t39SCvkA2@pluto>
 <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZfR89rdzRymY1Ovx@pluto>
In-Reply-To: <ZfR89rdzRymY1Ovx@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7088:EE_
x-ms-office365-filtering-correlation-id: 94f92e92-9533-4631-209b-08dc46f5b30e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3Q/kuJAGVO51Kp4SWp0N3E3tKiahce3QM4sZLtFVl4RbKF1MxWdSvtvOwl7p4k5rh3vA4qvHrabCYVJLa1huD8gZiraHQ0Aw5l804vMSaqAKPBo/k6AypouLCTNMMu8TpB2v0TDrGLYg/nPYAe6vW6XaHNfH9xAqbuh4+E0ZxTgUCubFJ88bCTH+aIiGIoJHSHO/h9yFv2nMyPXXMDpHMME/iWv+bCbCQbUobjtvix6iB3xL6BK+hOzMhQaNOwnpLKb0qrO3IFcJMiwWhWQVjtNF1PKkee178O/y+s5tlvDZSsbMSO4YK7OxiK9BoGL9Nga4hWhwMQxMceGa+GUH3rqQqTGrkaU1vYCjvmZkkYK0L4SndE/bAvPzmhaEAFAJss2rDskBVVTiCfVkMgDpwfdz/a0hlhobE3kLNZoIiPhYWISJM5KecGpto6w2hOLTs/lmLSoHgIIe8KIfrOGsqRRMLcWpvqfyGs8zQyv0DS4u6/t2hCDm7gdu4SqGmU50jsYDLW142LSBPIzIg8AxvcnQXbJRh6C3ZEaL4rQOo1QyVCLgqJh9of9EFMdesDXojvAwOtj+7dJpkLRDbzVyr4HURnnB/GlIiiXWTUzDAlm1i1jNUMBB9dDZHOFfacTFFjr6vYCIuoGr0u19uY7PRB1dBdpV/9SMdm3Yd4KhxUBj+MXev7PCnZACPJjuk4lwcA0YSwgA+V3CrgBeBMeogQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PNUKpYaTTyWEQzHufsmIay6ouM/BktSNzmXOkrMabVfZ9A/fSORAJTw229Al?=
 =?us-ascii?Q?yzSbU25TBOnlzfkbaiTkMEe2bL0Y85tVa7YyZSzv2ewcBmlI5He08Sucx2T0?=
 =?us-ascii?Q?701Z0bNdFOAOELLaYBJ4cqDWmkWTbaoJmoPllSS8RAW8GVmL4KbLm1SM3nwU?=
 =?us-ascii?Q?PdWEf1LQAK1tMngJLC60tJU+kdvv2fNvTKpHzMMB1c6LmnVZRrkmQhrk6LXg?=
 =?us-ascii?Q?SOhUIYtghoZFQFbAjluelXnmVepcAniyshGB4rjkD/MOJRqb1cm712S0MKOE?=
 =?us-ascii?Q?sO9I7SXWPXUqN+CIovWOiIhv1MuWw+JoAN5q0S6+PPyWBSYdTLGFT7lK3Kfc?=
 =?us-ascii?Q?o/uuLVSv8q3tK/FL4Ur0gK0qaj57rx37ejrwAqZN5BOkNMuL+PAazCr6yHOw?=
 =?us-ascii?Q?29p6e3IL089iD/CWRVgqCax2HWtR0OxvupDZeEfH+dq/Bc1gGmI3Lp+I2g7g?=
 =?us-ascii?Q?hin/tw1gJXLMkOwgOtdSsGvFVCSonu24dVJu5OHqOiwfxRC53QUXi9N2ZFLT?=
 =?us-ascii?Q?th3vNanrCIwD+tIc30m1h7kF8V489H/aynY/Pkvn+vTK0Rrd7Qzs9vhTS0Er?=
 =?us-ascii?Q?9c1oTje2L08rv72qr/9PYwObbHBaPptan/tdbfhS6Nyok4SSFDdprpzZBr8a?=
 =?us-ascii?Q?YFnd261KQ/66Kif1Kfr0dLJ/Z9plZ0BBW54l2P2zN72ZWq4nakw1F3Dwj4G3?=
 =?us-ascii?Q?QiyuiOLEa/nEf+CID0uqWRu42CCXcGp3DjsQ/2+Di++oxQCX7B77BrOoC0Oz?=
 =?us-ascii?Q?y1HDKM2zDngNp2V9T+G+IVl5VVdUt3zBJls1HlP0iPFUkG5vCL386MleP8rq?=
 =?us-ascii?Q?cUIDvP50GcAM/AlldTeDiry5MhivIHloUEp8yMRkZXhvo496TPXJ7cLsqfS0?=
 =?us-ascii?Q?TSWAIksdPtU75kwoN9liNiEY2r4jUFRaXZMHNd0jNSAKJes78TrTVjsqyqJp?=
 =?us-ascii?Q?X3cZA9dZ5sVBBIL8Ylt6kszRBuFu7qTvcgV+9AYy3a7fi4fy8gmVv7ALEs/O?=
 =?us-ascii?Q?hQZTAAaiDfSUbakh9ZNi9dSl0ZlejNMyV/1BbeH6MjzLwmEiLjCdQCHwg7Fg?=
 =?us-ascii?Q?mzOOisFIUZUh4KGwPXyyzU/jZooTEZ15nMGv1r9lWdhKtCyDKoqqTtEVkAO6?=
 =?us-ascii?Q?yLV1bqDQhWWW7dxKlYnf7MnheUDT8mQrZi8KzxpKsML0i4YgTxDbJvqDzBRu?=
 =?us-ascii?Q?J9bXT8Ou44lbqy8IMgALuO0Z+7Be8r0ovqg6io8nzD0QadRcFSFlGYsgQinI?=
 =?us-ascii?Q?qnHTMPy2OjKuw4Gke0OWZU/BKKxoe9i1Q9uJ457f/qxVXxl6W1wk7vyWWjcH?=
 =?us-ascii?Q?Fr/Ch3ILcELl9Hiejq5FBgubzjztIdY2a+gDa+Qa6ClKYd/3yNxYKp+O4h3/?=
 =?us-ascii?Q?NTWV/e5gRyMmBgJt7ad+T5nB2S/556fXjIo/91hIhBaHhAfQhpatI3WUuxqn?=
 =?us-ascii?Q?9PYcjfkUmfT/38VOwi0emGuUb3Fn7iYWO+rdSRLbx4S3M5LDmFYggX7+TRLO?=
 =?us-ascii?Q?0J9HbiaMVeK/WwC4e5oFeXaMaSfMoCBgktLFUAaiB09rShxasv+5QLzSapEu?=
 =?us-ascii?Q?bQ3KqtSu0w4KHcOqI1o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f92e92-9533-4631-209b-08dc46f5b30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:47:06.4259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orwncCbPk70BI+qWM3bQxxw+HzVHP/ZEKCnyU3MPaZNfuFU+9ypM+/0aBYcadjgL7sI/jjvDrVZYWdX7PZVtqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

> Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Fri, Mar 15, 2024 at 12:31:51AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2
> > > pincontrol protocol basic support
> > >
> > > On Thu, Mar 14, 2024 at 09:35:17PM +0800, Peng Fan (OSS) wrote:
> > > > Since SCMI 3.2 Spec is released, and this patchset has got
> > > > R-b/T-b, is it ok to land this patchset?
> > > >
> > >
> > > I'll have a look at this last version and a spin on my test setup.
> > >
> > > ...but has this V5 change at all since the Reviewed-by tags due to
> > > the latest spec changes ?
> >
> > The tags are same as V4. I only did a rebase, no more changes.
> > >
>=20
> Ok.
>=20
> > > ...IOW does this V5 include the latest small bits spec-changes or
> > > those latest gpio-related spec-changes are just not needed at the
> > > level of the Linux pinctrl support as of now and can be added later
> > > on when a Linux gpio driver will be built on top of this ?
> >
> > In my current test, I no need the gpio related changes, so I would add
> > that later if you are ok.
> >
>=20
> I COULD have agreed with this, since AFAIK there is currently an effort t=
o add
> support for GPIO on top of SCMI Pinctrl BUT not in Linux, so no reason to
> block this series for gpio-related missing features, that should only be
> additions not breaking backward compatibility...
>=20
> ....BUT, I've just wrapped my head again around the latest public release=
 of
> v3.2 spec (which has gone through so many changes and additions that I ha=
d
> lost track O_o) AND beside the above mentioned GPIO changes there are
> indeed also BREAKING changes around the commands
> PINCTRL_SETTINGS_GET and PINCTRL_SETTINGS_CONFIGURE (which were
> the old PINCTRL_CONFIG_GET/SET), that now also get/set the selected
> function: so that, at the end the payload itself of those commands/replie=
s has
> also changed IN SIZE, so the driver needs definitely to be updated (and
> whatever you use to test on the backend server too, if you want to test t=
his...)

Ok, I see, there are indeed some changes, I will update the driver.

>=20
> I think these changes (which I forgot being there) were in since last mon=
th, so
> already V4 was broken in these regards (which I have not looked at)

I may need to drop the R-b/T-b?

>=20
> I'll leave some comments along the series and test all of this again next=
 week...
> ...since too many things has changed and I want to re-verify all on my si=
de.

Thanks,
Peng.
>=20
> Thanks,
> Cristian


