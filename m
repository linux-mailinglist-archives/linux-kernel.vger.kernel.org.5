Return-Path: <linux-kernel+bounces-167107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677D8BA49A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DB71C22BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F589FC0C;
	Fri,  3 May 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i6BA4DT5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2050.outbound.protection.outlook.com [40.92.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD21E574;
	Fri,  3 May 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696580; cv=fail; b=cbNV2NZO6WU7Mr1X49R51JAZScDot7t1lYz+HlR7j4fTjk7omz/4z/jKT25YftS6kf7sjaQBwHahdMEvga3eqzbMfUNT4kKOPQVHnw8yWNh+3ObWF/DFsA7vuGiVYAI7IhgalrKenk1MFEmO4W/MeqlJFBeuzZy6Aw08SXzLygw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696580; c=relaxed/simple;
	bh=DrNoIIqfhB3KJkbLEDtLsWJZaNnf/RN1OXx/TGQ6k8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heuhBdZPRcx1fWS6SIS7k0dhczqe2rBBlLUIyjLmLLucsSPrgB7AqiAECas5DOJmgpTv9vsFMkQVjIkWXMqNl5dQAs/v3ZRDtq98+YpBjODQWn0RLFt8vLatRoj2kt91jLbK2NGJuO+VxwrPchKDf1yy2/fgIZOjnAlJ9CvE+Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i6BA4DT5; arc=fail smtp.client-ip=40.92.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwu5A4cQiFoPqfd64OJlPfG3x96CysyVHD1qBVP3c3hY+gto/mYV6lHOaRyDEYMujONmD5e4qMH0IttKww13UJjhQktVoBhThnOgLAQdfVy7IWTrUxQyT4ScQoq5MhuwBjfKGB9vTegsb0Ph7xo7jqFODMblC+XMZbiIZBl+ZoSeqjePco5yni7B0C4kI4is7TTJWPKxgGOZqSnys15FF2aQYkKCmtIfcpQWO7k/NNICAoueFuRu20646TYGID62rDENCf0MTdccBss2jj14XWGVW9Yp5wAWKb/gmdz8jFcHQ0fipDyuQMCLiAurAYteOu5Sl/6I81d6vqRo+8MFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmNN968i6dDqnEafFyrdiq5/ZDYK8eYFtiI6oF/VrTA=;
 b=KMAvCgq8Mw7pVLfV2vvLGMXYpzeVIsOpUvEh6Ep+Yz6cEvzsAwIrTEdHgNVQcqTapW07z/uJEmuIF8MIKXfi2hyzAfT6vG7yLzuIo493Ef+YCWqEAI0Ox307iSD2nmDyYJVeagyEFfPjm8Pnp1tMDptsUTN58lcXqTl3zsibFdcP6Immdk8SiDQ1OwVh59XY/jKucbE5COhSI0L25qJPW2hGJDmHR9gN7VzFgyfZ38TUJ3hXlqL2Ni6QZD3s25B0oLGK2BpUzIz8YXTdeAzEQkU7Lu50e+whKUiC/W4kNet43uQHrQWxga84O6axxivcdgSi56jgpVSnn69mmPEjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmNN968i6dDqnEafFyrdiq5/ZDYK8eYFtiI6oF/VrTA=;
 b=i6BA4DT5h9j9SDI/AV+1kmCdmFUysa2ataayRlBIyyO6hEgeuOZOpw8n9c9vr6rg4bP/g6OYxxxr7ASogTHufHG3feqHnD3K+6ns5VQI+8yTgA0gI9kg79OMr6a8vf+OLlM1SBGpXsIgD24y2IHgYipfXo+y7zNNlqaS5mFyrnLURtuK/t2+JOF+s5fCw9VabUNJ0dwpQPSEMFEF9snvLLQoQuMER44ENGGaOYAa9k0iLJDzoMvWn9GxvrWu9WO4JNQWdQl/cm/KWBawI/af67xSii6eCtJP1hdkKh8JTUNeSl44y5tYmBiX58eCHTNk0iOfaKoCFITwjJ/M604W3A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5908.namprd20.prod.outlook.com (2603:10b6:8:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 00:36:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 00:36:16 +0000
Date: Fri, 3 May 2024 08:36:47 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID:
 <IA1PR20MB4953EF886763A05EE6DDEF25BB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240430-crummiest-overnight-0f46dba32bb8@spud>
 <IA1PR20MB49535665CF1C89FFB4E1E46DBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240501-effort-virus-9baa07daf429@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-effort-virus-9baa07daf429@spud>
X-TMN: [BOLdy2BA7V7Gghk3OrONgPX2iHe2ToqSedWzNfSgeh8=]
X-ClientProxiedBy: PU1PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:803:29::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <wkbjnwlejolan5xi7hmvpxhjahbgvqt2z5heqtr4cblwmc554w@u53lgvyudfrt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: bd90a6c1-7803-4a10-2637-08dc6b090ae2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	gBafjgBgrSBxUmBG0mO23OZsCvZjgNDnUcEfBOtkpqSB/7ZK9nem3doYF18mNyUi1AMtrmOntFK8Qjdn0lPi0Cz5nD8uvaAXec8GYdGvhVfuyJ+IuWC727tB1b8n+COKdMAUb7OrUJ2KWSyeUKehskH/cEIYf/bSwV9ok4Ny0LuDXyDD17/wJk/G4s6abY6vFZZFFhxWrQyeyAAzCkfdl/SLLK+uSH0Vlkc1TLymalH/P0j8wRcVOEFDoH6Rclv/08cf0EZQtLzc7Qwe4tagVP6vAMFGa5viSAZFg04KQ3yvQwFqfVLkebWX2ebpkMZo1kL+p1ohkebHFm1pV6wpFugoCDvQF45Fq6aVDlum+LuzSUjaaT/EPQoBdIx/ezDJUB8WxN2xwdfzKQpcsp1qY0YRVA4Xn2g9OhvS9AWrhLsVdy48PeCoS1l8ga1fzNr/rvFTsthjBfePXW03cTiJ6rioYlIZ/p9j9UaWi6HZy0CpeE/5YAZwdd5UDHnXgYnbGpLT5+5qsCXUkpyyyzgLXrdd7KM3pXzFq6EqfBtFxNWd0iEYP+8FHjfvyRHPyIGLSCXsn1SMcKTk7UOqZPqcrupFknHZ2NyKOO8Nxn+HVqypweqgsYjeom25eCZyHy651LWj6jqr5MUq0fkoiLOir8k4Ccuigc5mm2ENJdwX7+Ec6TpBqP5xZZhxEmI824tr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J5S2PuRq0UnmFl5qIMkZXabM/nS59HC6+EeQcVfG8rhw4fjydtoHpUQ7waKC?=
 =?us-ascii?Q?GDYv0VegIgn2qj2a+9/9x0l0pnBuRYFTETEYUU2pZMKfOC8FPL9JD5/yxbz2?=
 =?us-ascii?Q?gzABK8NCNkJD+ywDq5aTU4Fj6NcHhz1tDEHd0r7pGgFeUMd/r5+hegAvFJtN?=
 =?us-ascii?Q?fROHOv7nfIzDM8SwevR0QiMBPc4mlPseIL4YS3Z3kATpCLs5MgozLntVfQi4?=
 =?us-ascii?Q?UYK6DJjNhipfW1jtTqGZ02F9TBBGwCC+/04nj2o+1HnaewP41i76ZfjelZhA?=
 =?us-ascii?Q?bG52tETVpJxsa5AgVwxXSuCLbLZ44CzVKjS87VqOwskYiXp2a3vb05os1t/C?=
 =?us-ascii?Q?cO2W22jiAVHEvreR425VTAYKsFm2w5NCKbcE3YwhqV73SMf/F4TrfV/T+/RR?=
 =?us-ascii?Q?e/kPArFWlgAaBOHFcuXvMm9WowRmIHgQn1FcxLAJpDWn+fQyqZp6mxVj24ne?=
 =?us-ascii?Q?qRDvBidWsEKM1J46CnIXGGyrv2vv0hQ1nsND2tK3EdQVIvVj/UzK3pRrwV5C?=
 =?us-ascii?Q?A3/HSlIUBPzGxVAv6vgY/nQ3u5doIlBr//34rcC25Cnxw4IF7ZmJLRMpLyNP?=
 =?us-ascii?Q?eceC7S2hwt7WYVKzn3TLqthpeKtXK2TCaw+wNtX+stekJdBgQXICR+CuwD4S?=
 =?us-ascii?Q?YATmh1UyfSJAyEkAOuqqtRoj4l8z1rvwKXAaGlYTRLg6+ZMFgcXf2LP50K16?=
 =?us-ascii?Q?4qQbIfLZUO3v3P5lzj1prdwf33SSlFcrQGTDRIyrWqlkGwubwK2w1XtpXzRP?=
 =?us-ascii?Q?Sh+jttfWz16B9P14glL7yMv47Fu1Vs1rjuy2iypePUY9WNt3IKKdsiggQ6yV?=
 =?us-ascii?Q?IUswFQgidHm6jBPIhZMkx3yt7kt8678424k5R1tYMV/wBtMNQ8TE0MZxnyTm?=
 =?us-ascii?Q?z15sjuaLdOADr7AuxKVGnEStNLa4vrMdc/EZxIcjRJn/N93Axe29zhfV8vuZ?=
 =?us-ascii?Q?CuIaUb/Qd5BrmMuXNDczruz/fY3b5gAQTuk7Sx4I9xxdv+KzGjx/kKzjjYqO?=
 =?us-ascii?Q?hKJ8AEZwnuQH+cQhkQsGm8JkINZ/+XbyDFy4O8IpmrsBWGPAZYbPyFPoXl3g?=
 =?us-ascii?Q?voVsDQTZduYvqwQi8g2sQbFFUApBmOpqRL7xsFH7ERTHi+qd5NS+0WcfMhyA?=
 =?us-ascii?Q?5NVgJOahKvc/ufrzpcNy2Colzy4oGs13Rv5zRVvabrIaEXJV/cFpDakN6wWA?=
 =?us-ascii?Q?/iT16QPOAPWvDH/2gMCHvJaZcQFt6757kccESqPFdKRNYqUisMf07CRELXuQ?=
 =?us-ascii?Q?2m8c0sRoCax+3hsm9PgP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd90a6c1-7803-4a10-2637-08dc6b090ae2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 00:36:16.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5908

On Wed, May 01, 2024 at 06:05:28PM GMT, Conor Dooley wrote:
> On Wed, May 01, 2024 at 08:28:47AM +0800, Inochi Amaoto wrote:
> > On Tue, Apr 30, 2024 at 06:09:20PM GMT, Conor Dooley wrote:
> > > On Mon, Apr 29, 2024 at 08:31:11AM +0800, Inochi Amaoto wrote:
> > > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > > connected, it only supports setting the mode manually.
> > > > 
> > > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > ---
> > > >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 68 +++++++++++++++++++
> > > >  1 file changed, 68 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > new file mode 100644
> > > > index 000000000000..7e3382c18d44
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo CV18XX/SG200X USB 2.0 PHY
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: sophgo,cv1800-usb-phy
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#phy-cells":
> > > > +    const: 0
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: PHY clock
> > > > +      - description: PHY app clock
> > > > +      - description: PHY stb clock
> > > > +      - description: PHY lpm clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: phy
> > > > +      - const: app
> > > > +      - const: stb
> > > > +      - const: lpm
> > > > +
> > > > +  vbus_det-gpios:
> > > 
> > > "vbus_det-gpios" isn't a common property AFAICT, why does it not get a
> > > vendor prefix when the other gpios property does?
> > > 
> > 
> > I have seen other binding (such as sunxi phy) uses this property without 
> > vendor prefix. So I think it is a common property and don't add perfix 
> > for it. But it is OK for me add the vendor prefix, thanks.
> 
> I asked yesterday and Krzysztof said:
> "gpios just like supplies - no prefixes, I think."

Thanks for your explanation. If I do not understand wrong, you mean 
it does not need to add vender prefix?

> The other phy used a different property (they're not identical), I did
> check that yesterday.
> 

Yes, it is not total identical. But they do look similar.

> > 
> > > > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > > > +      defined if vbus_det pin and switch pin are connected, which may
> > > > +      break the VBUS detection.
> > > > +    maxItems: 1
> > > > +
> > > > +  sophgo,switch-gpios:
> > > > +    description: GPIO array for the phy to control connected switch. For
> > > > +      host mode, the driver will set these GPIOs to low one by one. For
> > > > +      device mode, the driver will set these GPIOs to high in reverse
> > > > +      order.
> > > > +    maxItems: 2
> > > 
> > > You're still missing the itemised description of what each of the gpios
> > > here are - how would I know which order to put the GPIOs in?
> > > 
> > > Cheers,
> > > Conor.
> > 
> > In most case, the order depends on hardware design. But following the
> > guide sophgo provides, it does have an common order. Is it good to add
> > this description as a reference guide? If so, I will add it.
> 
> If we can say "gpio 1 connects to xyz on the switch" & "gpio 2 connects
> to tuv" then it'll be easier to understand how to write the node.
> 

Good, I will add description of reference design for these gpios.

> > 
> > Regards,
> > Inochi
> > 
> > > 
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - "#phy-cells"
> > > > +  - clocks
> > > > +  - clock-names
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    phy@48 {
> > > > +      compatible = "sophgo,cv1800-usb-phy";
> > > > +      reg = <0x48 0x4>;
> > > > +      #phy-cells = <0>;
> > > > +      clocks = <&clk 92>, <&clk 93>,
> > > > +               <&clk 94>, <&clk 95>;
> > > > +      clock-names = "phy", "app", "stb", "lpm";
> > > > +    };
> > > > +
> > > > +...
> > > > --
> > > > 2.44.0
> > > > 
> > 
> > 



