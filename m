Return-Path: <linux-kernel+bounces-138314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32489EFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70514B22F78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3BD156F2F;
	Wed, 10 Apr 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lVh6aH4t"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2059.outbound.protection.outlook.com [40.92.23.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48046158A3A;
	Wed, 10 Apr 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744221; cv=fail; b=BJM7YcXWty9csP1Vw7iRS8jkpZRkYRxpwv19DA/llz7ZeITR8tVl2maBwU+BYv1+M5I7ISGrvNInkQiGTNN7fUrcGEaxhK7MYQho+UYloiSVW4XvnaUZuXMkLeRHnEwkh7mbM5bu4Nyro1lZsPtD/xlXyRKXsDBFhoWyByiUThc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744221; c=relaxed/simple;
	bh=CMHg7h2YNN+2xSD2uqAmVhPkqfTg3g2Izpa/RLoN+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6meWj67ueMwUIlAYBfhMNw/vg2ngOCrCB2ZGJomrp6QH9XixDt9qTokaKn35kRSu+buqXOB1+kFoXggmiNKS2HxymBkLdRfnG8A460HDt+vpIbWC/0oo8on3lzpxtqkrI5CXvVl2hUT8621ZoBIdRT58ysj0lRjLm2aQP/+M20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lVh6aH4t; arc=fail smtp.client-ip=40.92.23.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9iAKgpTtquGKCkZkRrfY4c8T+cYAluLIUWCz56cgHcPb2fLcw42HJ8C/7mRepjhXQeJq1RqvMvvmdvum9nS6T+8wPYw6SUyVRvkGVzmJ+0iigL3ftBPYfFoes+Y+437sZGAvJjbG6zj4GzEeeT2XjbSfBSungZhFJ5wNskpoSTpzRuEgcSMREfePfBef/TfTPFQ/OUqf4zPIA5KoNMmbpNwQbhSlemC6gPD8/JH6zrUZSHmkNdBO+U53EnUVavgIZ8MhLbkM/ynBBwek/6yt8vv5hlaIjYYvJVsb2WXz4/80rt4Gclug+d8m57T6HibaClXyKLorJdF4VoZPYhToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn2f5ff8033IAMmi+7JVYLxi/c2u3VBTYdBB/CJnqNc=;
 b=P6eDfor1prMXxu+PKoH3C2B7pig2MOvNFwKekjWGEDrbZitye3nY9FaBwL9I5jKYdf+Mo7/RSCbXEvjiPWD6QQYIYwbddddWIpwetuv5w8KUMLnkqQ3suiiPJvSyzHmgsDDo/szYYHStoiyuRboh/2poT6wUWQPOoIbHniSC4AwLJ0k0x03/+I2a45E7tcDu5LpQKOnXOifFfMC9KRoeK2cSIm17rbTivf4FHKo9FgcAH+Vlsct/8O33qhTCBQshzBFK79Zn8WH3PKVk59on5BiSfwBAZMUe4Wsc2txWMVezS834V1O8jVEq6QgADDLvEgt8pNzRhPgn6dPZZxpiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn2f5ff8033IAMmi+7JVYLxi/c2u3VBTYdBB/CJnqNc=;
 b=lVh6aH4thobfuJtpbeEUxQXbCRKUHvveCZtHsDiWvDbVrehqZMwFO4YipRwvlNs0fQyghg5gUexeC0IUPPemJ+z5Ww+x8jbgwMLIbYZ8gdnyG5BywQytwQh1pCTgUhoOxVqkXe0zGIarbhrEL8bWNWpKVg6XTMK4h7QH3YsfB73E773mllZ08+gAMTPai6/n7sKss2eJBpgBfV1N6yt/tBS18LOrvU4LjjHdsGEuEVpBpXg71m3f9WWTFMTcxs1dPHumnxl5OyhYoLuHSK29e91IPRuyDpt1lczwyCm8o/a8LVxZbDcP0igYp+Z+9naHbhI54eZxGz7fQ6LYVbMcew==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5257.namprd20.prod.outlook.com (2603:10b6:510:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 10:16:57 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 10:16:56 +0000
Date: Wed, 10 Apr 2024 18:17:14 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
Message-ID:
 <IA1PR20MB49538EC805A17513DF396820BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240410062254.2955647-1-michael.opdenacker@bootlin.com>
 <20240410062254.2955647-2-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532EC9B654B5B1C2538851BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
 <115662f6-a390-497e-903e-5a9bbb15e08b@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115662f6-a390-497e-903e-5a9bbb15e08b@bootlin.com>
X-TMN: [/kqvkq5bJNnQgR90TdcyEw6kzjs7e7jLq9SwCRz5ToI=]
X-ClientProxiedBy: TYCP286CA0229.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <yj5oxxquzg4zrbqvvlsaj77n2cmbbp2uwtbjkhwkk3lrr6v72y@tbwnm67qtgyv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fa1d1d-d1ad-4234-389a-08dc594759e3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+KNaoQq+1q/TdEh+kUYZ6F+OtGPZ2Dw8WCthKQ6ntBc8Uvr9kCgY0xuRkM1j3QNW7eR9pcPhd+L/rkwt0xk9iqB3SpYAVZUvWS/lNuQMKd33zYDxEnRve2mR/i5bb0YhKVu/RR7uVn9F9aj7L1OE6IjEUtg9Aignum3f++Umep6lI2dgYel/V3217+I9y7JONFjXYteKVpzJc/wXTyrF6uhMiUuHt3Q3oMx9b2gdLrM7wmUdLXl+Ni/iLkU10QBNHxqeIPWUmxOEXNvSvH8QiekMekDwAiymexXFkVWBCNK0+iSQGHCj13TYb2PX5jPYG0pnQRoGIlA6cyFA4In86gZSJOaG4u1+Qf6LcbC1yC4xon6VNywGPBYwsVKJJ6fl7jyez7DO1dAmVDPUqDMINiVC/c9RIkyGQkyt5n79bUoej5Qa2vQSIlnozGiNUeCECwN/OSmXn7rKimpZGHh8Hf49DqgD80CtLimkXJ6ubLHW+W8usz4EsXK+vSkJV5XE1I3H9p9CAqjx3O7uun9T48hRspPxXI1bIg/Ue42KCj625BKeZTlS3o54ACh5XRucLRga2YrQCa2SKcmY/6q/Ak+3aidkFdd9Lu0BC7hQTQbYomej7QBVqGpTMDNnnPETttW0igcICjIk2CpI/vLJqotR+0OE/R/S9QhG82n8RNMEp4y4Lh8Z23oZoaSlU8t
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTGe9Bx1r2wqJLRZNQCw3QCaDihYTUf/EKmOTlI657bnKV3jFm0yDkp9pyfG?=
 =?us-ascii?Q?ctZLGmV9N02aiRv6cPzhCTz9hstCbk5mfAStPQp8RUYjnq1hR6aEZ1nB9qk2?=
 =?us-ascii?Q?toEkF7/RzkU3w9GNoD31z0+kJHMLoX0stwrHZx0RPoGBTC7LLSBFhLVDQb77?=
 =?us-ascii?Q?RUenM8PcdLUyJ1IbC5HIKwFVe1D2yN44nOzERAYtpTLTqh0+zk9vUWEDCne5?=
 =?us-ascii?Q?LjeBrFuUqUF3nPouu5XZzSx9w5BPAAlH78FJ1Smo3uUT/hq86r1wMnvQ1IFE?=
 =?us-ascii?Q?0YnUAsluZb4fFKgxzVxvCDTDfEpKe6UUlTb9Lr4wUgEOMh5mJE+RLJ6g0+kX?=
 =?us-ascii?Q?vGF0o4lMYFSUDJ+4u054M77SNdR+FnTReRk5iKR2Y5s6Qf4S/6W37OLQDNvE?=
 =?us-ascii?Q?kKjnYvH9e+2pV06246hNxE1wrypYaD+iGqwKN3LvuBEySkgVbRQTBnTbYKI8?=
 =?us-ascii?Q?wVRd9j9F9IXjkLv89xkS03G6tDOKFUxev5gEY5/dLrvx1bi5fZPqU7kBNxTH?=
 =?us-ascii?Q?yCtmlKHNrNO1MIVNSHjh7PbYeV4dW3yRf59S3PHx1A3Q6oACMBkUgxC2Zk5n?=
 =?us-ascii?Q?tkJWU3Sf9yewalpgYFPR12O/H6rSBnHdUVPTKzfycFp5bsy3eXW5elxuIkVz?=
 =?us-ascii?Q?BNlxj5nxB5zgl7K29DvVCd8dt+PaGGs6ggCm1rj7HmNGusi3CeX2MwcB/m0W?=
 =?us-ascii?Q?OIwhuBYUXC6rDfksmrIE1bh5ONzI4bDKzIBhTnctIIYmeqsZ6GfS0npOrzfa?=
 =?us-ascii?Q?zRS1RThZymmaLqRIJpNqTnVXQ76SPhLZ5Tr3V1o02LqAnVBM5C+5u8Zk770n?=
 =?us-ascii?Q?TJektZ/tRR84j9TdErtRzOl+mrxpMEPtDqXcUF96yPhPWwE6SbAvT/+n+G7M?=
 =?us-ascii?Q?c6uHawanDcG8elbxG8gvZo+UvS3AQDKuH+CYVGe05QLRIYERwWYzV75nrMYc?=
 =?us-ascii?Q?TqpNnKBNX0PdaP9IdD74JLnb1YLCmb8fd9JRPylA5gzAcpJnbD/TBl3ABEUm?=
 =?us-ascii?Q?K83jTTjH4fcr++onUz1RkW9zWYQt2Qhk9MoWmIWfrHCpis620B2iB1xrABNt?=
 =?us-ascii?Q?SFs1m2BV1hIb1Qd3ekjyoLPZVnRjfG8zozTxt/c24y0n4FKH/lj7Gk8mN1aX?=
 =?us-ascii?Q?hcEcJRyOuhSaHxnV+4VjRDZVITI+wAO7GkeJuElck+2NldkQ0DkzgucWUSIG?=
 =?us-ascii?Q?DvEevsRMQQa+VnHIfUReDjkUgL8VV0t1nsgK4aK0ntmD3/wTKLuXdBOYAamd?=
 =?us-ascii?Q?Jdk2v43LXgsNm5af8CPs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fa1d1d-d1ad-4234-389a-08dc594759e3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:16:56.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5257

On Wed, Apr 10, 2024 at 09:55:17AM +0200, Michael Opdenacker wrote:
> Hi Inochi
> 
> Thanks for the reviews!
> 
> On 4/10/24 at 09:19, Inochi Amaoto wrote:
> > On Wed, Apr 10, 2024 at 08:22:53AM +0200, michael.opdenacker@bootlin.com wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > 
> > > Document the compatible strings for the Milk-V Duo S board[1] which uses
> > > the SOPHGO SG2000 SoC, compatible with the SOPHGO CV1800B SoC[2].
> > > 
> > > Link: https://milkv.io/duo-s [1]
> > > Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> > > 
> > > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > ---
> > >   Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > index 9bc813dad098..1837bc550056 100644
> > > --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > @@ -21,6 +21,7 @@ properties:
> > >         - items:
> > >             - enum:
> > >                 - milkv,duo
> > > +              - milkv,duos
> > >             - const: sophgo,cv1800b
> > Why not adding sg2000 property? They are different series.
> > IIRC, it at least a cv1813h not cv1800b. I suggest checking
> > the vendor SDK to get the right board compatibles.
> 
> Here's what there was in the vendor provided DTB, if I noted it correctly:
> compatible = "cvitek,cv181x";
> 
> Cheers
> Michael

That's true, the chipcode can be only see in the build script or
the board dts. You can use this as a base. For example, sg2000 
can be something like: "sophgo,sg2000", "sophgo,cv1813h". 
But in fact, I do not prefer to add "sophgo,cv1813h". Because
sg2000 can also boot as an aarch64 board, but cv1813h can't.


