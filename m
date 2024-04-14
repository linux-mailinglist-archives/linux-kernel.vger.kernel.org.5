Return-Path: <linux-kernel+bounces-144006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B88A40AB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06327B210F8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C851C6A3;
	Sun, 14 Apr 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EkCvsSDV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2061.outbound.protection.outlook.com [40.92.23.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A81EACE;
	Sun, 14 Apr 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713076866; cv=fail; b=iiCILl1K9BPvLBhEIgpWWQC8EV1KImjkBzSdxeFqOn14Gu3JT+/BmTiqTpc4JEFCc2LUftYFxrPe4Z0k1W4bF7BCasumXRVLLZpNEWMEDZvPfq4n+sNZYMRZQoevS1HAmKUe4mDIuJBu9vrssB+oQte/CWqRCSNvJjvxV0YRhhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713076866; c=relaxed/simple;
	bh=TRZy3OOeN4nleqqemC6hBOL1xCFoUcvTLRTPNTwzDMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2v4Z8AjVuaklqP26Cy2m6cfYVA0bRabc6p4R1pYO9FfPOb46fgQbOHt8tEZAOa3kMv0zabvyszjeZgEaYbIZSGbRZcCpJqLeCPjilyk+sjzaFZKnUMYV4b9Ja5xTLu7MUdD08TPkdUffo2MOVpu4jiZx4yj3r11hMk+fLvmlCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EkCvsSDV; arc=fail smtp.client-ip=40.92.23.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqPNsqy5ZydkjBqSfXP2d73qGS5kdluUuUQy9On582Yv1EU4wEyh4Ip+5cx46zF2c1EyHZfqtaGa20VKCcZqMUmqbK36xw7K7oanlLfBG91Ie06MjISj1F0gX1QITc9vnYUgPjt1GeqluE0El0q2vL3P98gkc6O8SlMWdmjrpKfC26pyIEfpX6o1DwwJFI8uXUmDjU8ZhKh0Db+u1kcoFwAraspKJsrWnGt7W36IhkN9mEPznEy7tbdaIlRWs8YvZkGeA/v/dUOalUySH6yL8LDm4IDHM0TRgtVwB3ctLYH5XXiga2yJfdeO/QAl1EDw92qYCtQfxJSywOByf/9s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPqnSJlTCpzmTfOGUVT6Kr2sGW5ryadgdq0jNs8r+K4=;
 b=odYNuSaKuXMAxKcIMfckOUIA3MYpjCbE/COG+3+92Bdvl10eB30KmGEMjyJAK+cXdB4sh1Pw4/ki83RxAIWj1/UWPRRP418Xv9sfCS6AFljNuxscdEfLJw4l3BiRVr5MGUOS3nhUc+YUcGethc8nyulCt7QufUgP6LBnLI+7pXSP+2mc0vNIKobJTb2eVz5U4PFYZ6JQCx7KcGzAR94bVUh06vjTaLKAvXanRxQAMpoaK1PtthXx7aEZvAbMhljtuvDO01YvVI5u5T0sUxjxl0B+wZ+ZwrcE/zzO4GBjLOBgGYHaSD9PXKsfC3GcSp8+s2rH1lLPczZ8IV/H/hG3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPqnSJlTCpzmTfOGUVT6Kr2sGW5ryadgdq0jNs8r+K4=;
 b=EkCvsSDVQrra2lzeYk/kA9Dhhen1w9n5S0IhMqQZr6kSOiSBOKKpvOdlBNrveq6h0XnI082MAxtSNmKAU2LdtjuoqH2jlqbFUV2aL74KOtKS7wQy1rtO8NgaVIcoFVOg3md0CSeFEOn7TRLNxTGi6RPhSqtwpGftRpeTdB5E8BEyWcyAFdqU18FhEITnebKoTErHaYga0NNVuPNiQLB+cV6iZHiSb8MFy0Dt29i48sJK5wAdsRV9m+OsZEeR3HBrgLt6OY8NyEyKPmiI6ItyLQqWyPC9KleBqQ2v8IyKY56ymXGsI6mGLuvaLjCMVWViYOaZrBRWEJgVseMIkk0qdw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BY1PR20MB7512.namprd20.prod.outlook.com (2603:10b6:a03:4a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sun, 14 Apr
 2024 06:41:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 06:41:02 +0000
Date: Sun, 14 Apr 2024 14:41:21 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v9 0/6] riscv: sophgo: add clock support for
 Sophgo CV1800/SG2000 SoCs
Message-ID:
 <IA1PR20MB49536A93C7A684EAE844E316BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
X-TMN: [p5mwzyThm9faVPZ0BZNz0RiKJqWiP5D/GzdN0etKhIg=]
X-ClientProxiedBy: PS2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:300:5c::21) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <p5hrf2bdyhbyx7fw5rbvmdx7tir6mxlf4xzk7ruqlnxv356y3c@td3fnbuh34bf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BY1PR20MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d816a00-c8c6-4084-be9c-08dc5c4dd9f9
X-MS-Exchange-SLBlob-MailProps:
	0YULWdH+7mChbaCZv10gjZdR5M+Aa9K07V+FkQu9csKrinwkEAS+8Xgx4FYASICQcsA1wUUfnxq9BJ39wpOF3lcjVDhzvQEXmXHO+n8q3ku8YWCle3VZy5mt4lwHjGGTT2J6xN8/JldgJy+EowM+a0PMk7hKbjeCBl8Kf3dhvZomeBzqJllhAY03uPwC80tI5IKwCtniE4a3iUPOhSvFVvlIcwqhkKEv3iaMRxjCZkM6hxpACa1xOLKmksfTNESGTIq/UE7ERCgQhp3ZJzSfnOok5t0qEM2PiflXP1NTpfgOz4z87suKyX//Lh6FaWESFu2mDu38zYW6RWb7H40X9GPkFOOUvJbmWXFYCiA1QqrXLkWjF+yDqpZaPixH52q7u3Yp0jeKeHSk9zjzLVFq6qe+BWc/hKdIXTXzIysdIR+Vuv+DmlzAdruyAqxWhu1fsWz1HrF8hLdWDymE47lGx12TgwoJ+/5WOK94YBWXLsr8sLG5/zxz2LzqWTtaFinjFEc/1kG5vDCp4On823t6Q5hWmxdbsOdAGcVtSWMTMnGJMxKwg28eST8OzSHrQuYFg43OPSuMy1QvpTXJX3f8zbpda/ei87vACJMYBhhPK/WGkyP7AlDnN2boA2T18x1TEE1qc4yhkzpQdo9l035mOBHre6qgzZ91XqVCnbgmsfvuwlgiPZdGGLMlanWZVk5KeVhNWFeYdYSbqBXCK37CmlPf3ZPYKQLcIkQ1uymYahGyZxtnYK+obqIYaiYIsRrzLZlUC7QvsocU+lSz/2tfyJY7q7ySI7mvaQYo+l50G/s2G8cQlEnfh/dk6gdUJfInX5XxGEEua6kHOqkg4vvrdJOMRUp/+N2pusxjzY7Ta8DR4ignul44QQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tj+cnadduPsDF6BH9OA+xw2YrlGy5GyQwntKxBhBB2sNU88/eo4anQin74XgaZelFPdcAML9njXlvOcI1i2vaqo4NtjpmhDmCucVqJks8iES0NrV7PbC4qx36ACBivBV9ugp74XP2in25urpu2bHy8aMwmxpiunz65TcYsMCSSihDfWhQ5I4RueqzwnPkwgtzN4PZbt89OUgv8J686jYEuNinsNCkgGPD8+sqSTtnhLP0lYvVBvFuH5Z36m7NnJdBq/UsGHpxR3ox8ti2G7ZoFspJWBaOf0cEsaJJ1oSAg0xmTQTU8QwKGyA8X32Q06yBDwOWrkVrBGOL7HtscKWOL915HYEP4C26MiJmRiExZjMSI4HIijWPl2NfUQcQtd3VmqMZ/84j2gAmc4mNE1p9dExLtKYpGX5zwCAA+xT7TR5jOl36WDoi1VfvJ1ZcnFKss2dxetu4Hkhw4KKWhDnBNRdTlKYiYsRRN4HJ7OTjcQxUAhbGPT07XrPRjpu1iEPD27fKAEPLxmFvShCB2xOFMpGc6ileAUsg+2dqiQcQDKpRwxCz5HBj0Oh465ogWRCxd0/ftBJGuMOPTHwgvPVfytBM6naTVHb/otyn0lWX3eyDRabGeN1hdadMXVhGgeSId6MjyjnX4puDxiKZF10UqS8V+Fl6nRrlESpsN40NSTa9zbdP2qBbqAcC9pTW7OzxAqzPoBAjFBx+qXYFh+zYQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w72vBel9+y725V5E1hmhjjTmEn/V0uNWNSG3HmtvyjJPJDoarhYiE1dLnWqr?=
 =?us-ascii?Q?nUEEWsFAh77lU/Er2AV0yDRAhyqv91QPv3T0f72pCrqzVAMbMqAIU05XQdd7?=
 =?us-ascii?Q?xaFaJ+cN7PN2HQxdtfrAKkDyP0CjOZ1F624Ng6ZSbNkdbuVJ4gfxgn3uIDSx?=
 =?us-ascii?Q?hcZNdzcu7F5M9Ld6G1LQAzPMPSe1k7Kou1lVmr6c5SJvAjeYz3yDKDWjX7HC?=
 =?us-ascii?Q?rkMhe+MKw2qbDP1WyhZu2hyumFzs3XfwzN8CmJWev8zO9bDQR9MOu4ZYYjf4?=
 =?us-ascii?Q?tttWxHdaAGvap/xrVBR7HS4hHWl/U6yATJ/mFxwaNdvS0hGNBFyYEcZeHYgf?=
 =?us-ascii?Q?VacBoMLuMDflgW46XZSx3Hx5Cs/g6Ngi8hyiByddVLc4QhbFVdniqdrR8XBQ?=
 =?us-ascii?Q?Gnh9bIfTIfrN9RIsWSDLvhAaMXzYWYQxSz1+Tna0GADrD1qxiJNKV3pjjv/D?=
 =?us-ascii?Q?s5W1lamEVPTbCxV7PlZwV96cBJ+jD0+X3s2WjEkPN1G0VyCmcFPnmENvscGf?=
 =?us-ascii?Q?JBLDu/E9m42f/Iy4JfG304+L/iLkvRTz95pqnY2a/NHa7zvH6czh/RTlByiW?=
 =?us-ascii?Q?z0gs8PZNVCSeqlXbtZDZX3h+HzU5ne7KUsOFauUZdhTjwu7iFNJfH5jWKEI1?=
 =?us-ascii?Q?DNiG9N9Uc/tYRe2lq73TKLhyDDI1yaUrW31YMfWU3DCwSaC7mJr7oqvNT3ZW?=
 =?us-ascii?Q?29XKhjHaI2Tdi8HN8rqUmhtQPF/+/djsen38vq2BkBW7xLZsacvXmgUrUqCI?=
 =?us-ascii?Q?7j38MSC9uQCfJVgNfQPL/LMZE552ufBM0r/jWIeRld4MkWGP1IT2Rwo78QNn?=
 =?us-ascii?Q?KhWJFUR5hw9v583W6oJLL2IPeCfslSo1Sb4n0bbWbvwnt25S+LXe1BP7g8aC?=
 =?us-ascii?Q?tL8O5aI0FLh7PakKbD4Pkjd6uWvFVw5ydGfCVud6jZEqw/ZFppigUx2ncWAj?=
 =?us-ascii?Q?j7NiD2j0e13Ykl8qLM9TE+GK658q+RTK5VjbKhJ9IlOfEcmQvBsmAx0eUWgU?=
 =?us-ascii?Q?dZmw2W6PBF3jE1DPSFb8jVz1DaeOOazt4swFYAbiNC4GWO3Nhg/8l1ZtwUFz?=
 =?us-ascii?Q?gdHE+EVY92QoXvrBuaII0On5dFaIOrOs/7DHbbQhUl5Z41wMWoUS2gTjz9Fq?=
 =?us-ascii?Q?WxFpIia8JR1X5siVHnIfm0T8wrsxweQFLMqude0rz8XsIHPAVYoX/hBSNTeg?=
 =?us-ascii?Q?/VQHlIqt/lKfRmG4qap8MKhHmJKWsHodsLO+x/M+MRB5p7+adBJhraIxaN6O?=
 =?us-ascii?Q?dVt0XipbSl7pAbHhRF3j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d816a00-c8c6-4084-be9c-08dc5c4dd9f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 06:41:02.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7512

On Sun, Apr 14, 2024 at 07:56:42AM +0200, Michael Opdenacker wrote:
> Hi Inochi
> 
> On 4/11/24 at 09:38, Inochi Amaoto wrote:
> > On Sat, 9 Mar 2024 17:01:21 +0800, Inochi Amaoto wrote:
> > > Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.
> > > 
> > > Changed from v8:
> > > 1. improve code.
> > > 2. remove default config in Kconfig.
> > > 3. merge patch 2-4 of v8 into one.
> > > 
> > > [...]
> > 
> > Applied to sophgo/for-next, thanks!
> > 
> > [5/6] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
> >        https://github.com/sophgo/linux/commit/bb7b3419627eb34f3466022d1f4b3c942c09712d
> > [6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
> >        https://github.com/sophgo/linux/commit/18e8c6d2cced6c57d62813f49b57eeb8ee02f984
> 
> Oops, for your information, this last change
> ([6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC)
> breaks my Milk-V Duo S board when I boot it with cv1812h-huashan-pi.dtb as I
> believe you suggested.
> 
> I don't know whether the board actually boots, but at least I don't get any
> more output in the console.
> 
> Has someone tested this on the real Huashan Pi board?
> 
> Cheers
> Michael.
> 

Hi Michael,

I think you boot with the `defconfig` config. This config does
not enable the CV1800 clk support. I think you may need to apply
[1], which enable the clk driver. Also if you want to test sdhci
with real clk, you can try [2]. I test them on the Milk-V Duo S.

Regards,
Inochi

[1] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/
[2] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/

