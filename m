Return-Path: <linux-kernel+bounces-144008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CA8A40B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1241F213C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9191C6BE;
	Sun, 14 Apr 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aMutAF2+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2057.outbound.protection.outlook.com [40.92.19.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF617736;
	Sun, 14 Apr 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713077019; cv=fail; b=L2XdKU8b3/IEJ1Aki9u3OCIHSJ0pMnz7fSz6WrESLgZ0TjbEMjuX5Dy5S87/K1gD0RKazlICQI+jDiCIhiJP0uWq03CC34zu6qOMjdeAdCZm3PhSst7ouKfEU5coMPq1K+dgkXhDdldnavhCbzWB2VU9wGbTkKEKE9dr7UkNmCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713077019; c=relaxed/simple;
	bh=IbgGLf6oXR00OADGWDNgCJMVpAy0GskKSNIqCCIIdg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sczdOMl0vFjRJVCMrsxM7xGRItefRIeEocAF3PaCn6Q5PYnMQhuVVEunC6YkozN3/cW4yQj6+iutyYXMsdkUfxKk7lZC4D09uEwjpsJB4pF2cmwoToOcOE/O69mJJGKLge6Ha2wOKjf7IXD72yvtihbuqRavzaLjcWf51xi7SO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aMutAF2+; arc=fail smtp.client-ip=40.92.19.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgnhpOWsFOQDPBKicHD8viA/+RjQc0DWgIVH81cVKn7PU+OscgvtGO0qmX3I1nOCcZny4pJVFVx+8bcUHGGb/37udoBxw1z+JU/2XgVVXuVLUzdc7WTXYau7fRnpdTzTlXt64RhRkfG3lQ57kfZGUUp/WhF24ZNSfsSV2gc3Qa3lhK82sHEJgDkAJy4I5xc86OzZuURCfZwrvX2tzbJD7EPlkuye8i9efzi/kV95qPzG8lMepoBEFx1grfI11E1x9jcHq43A7HV/VR5z/eZmzU7arzuRHtx9Y8CWraPNo2ABG5u6HMX0ztfhA2xl19ttVBRFV0ezTbM6BeIpyNNFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zQUsmvfJ26fqUVc1oui0THygRvnspwx2dQg3LNj77c=;
 b=cBGnqCucIurDuBWliRIMbHspvz4HLgfRv8DzgpMtvywgnsOVNqM2XtnFR77Em7tVwyr+eqDK+1K4k8TsQjj94GKDP38ksA+9iNbpcx6+3Y79iG88y3i/Mc0gjVucyBXjl/yNqQcayzFg/4qo2tUIK25TYQMTDVmA1892whaltgVinAvjXZT1W8j7NaKHCmxnLcIy0+NcMqkutkjpKo2ueYr8n7oIJKmDGlh3jYCocI7+E/53K4WKtJZQKjnRzLIRh3GoAwFy283mAI0Erw1bTeNLlYO4yhuGGhs3apEnFr2jaw4W9XsIcoFkPE8Jd7OM7HYc7evSNTWrCV+igJ0HRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zQUsmvfJ26fqUVc1oui0THygRvnspwx2dQg3LNj77c=;
 b=aMutAF2+l9yjct09I2cvZW2lACOUoS5M6WBKNm/xHVjsD2g+8loyzzTv+q9lF1IkANI4IlDVYjrCRdUTbgfWCgwXywxTDXJzNd0O0tkjsA+y5UWvJ1ndzbL3as2hDCcOEVM/GtJD9RGJVu4aTzfU8AyrjFMKAkl9WPIpH6pyGZr+Yi0aYjOlizx1otj+xuWkijR0rMltRCRQh4zp1JvX4mm1fjy96dwgJflsyBwxbiwtrchHWIQGbuN101Jx2SQEyB3yNxrUmVVjQMGKCrcFAEHmQ58dydieSFUSjbUnyEjGSqepARiFnV3tBX3vXisFU5cP0Ap6FR6krRmQxrl4Bw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BY1PR20MB7512.namprd20.prod.outlook.com (2603:10b6:a03:4a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sun, 14 Apr
 2024 06:43:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 06:43:35 +0000
Date: Sun, 14 Apr 2024 14:43:54 +0800
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
 <IA1PR20MB4953A5ACD22C8CB791C76BABBB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
 <IA1PR20MB49536A93C7A684EAE844E316BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49536A93C7A684EAE844E316BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [9HpiRZiFRXqUcedgRLWz5xe+fPMdIbz0uNvFEy0X3cU=]
X-ClientProxiedBy: PU1PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:803:2a::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <qxnhglvymu7hebumnpzacam3jvz6wljea52grli2vwwzmuowze@ozwmctxrqdbk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BY1PR20MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ff6d3-3df2-4205-0fd0-08dc5c4e3536
X-MS-Exchange-SLBlob-MailProps:
	0YULWdH+7mChbaCZv10gjZdR5M+Aa9K07V+FkQu9csKrinwkEAS+8Xgx4FYASICQcsA1wUUfnxq9BJ39wpOF3lcjVDhzvQEXmXHO+n8q3ks1gyyPpdUcL9Q/X8Vn2Mej0VX3obLUPPRnQcjbCM9pnN8iFkGFVoB6oXRXoSljNSTfdhVC+NaU+b9zOGTwlRn5UoXrlAxleWPZsKgBPjhydd0gNs0vdCP07WtWTztqCwVGZZ4l9TSjU2A+7vX0BBcpIb89ZqqiiN2n3Dt34jxgVsjl+vZuAJ4/7EziPtqZYjwvP5NhR7oCSeRaDJLqS4CH8CC2zBckDs9J+c5dpWO3v24BH6NOqnuYqFNQijrm0kv21pLffiswVUFiLFbZjRCkSSUOU6uTD9Sjj+wWsrejQpo/nNczLHTBg1QoX90GTDNC5oaRpN8pDmMtFptavLwRZiLDeqVAwvVyiscyObGIdxRHvZwALRcVWfOJZZZYPh+JZO7/lypwTryyO/M5WjRebRHXlwWG9sF3LgoJgt0M+NhyK7MCHmI8EY/eqZyJbUVhgG60pyukT/lDjmRqqPRAMVN92cuJvD9iGwNa/nTExVNwyx9FzhcGTHWXns+kKSErLkXdbmTGt7XlmemuzEbQKVkRB7cv9jbdX8rskfznza7QIqH63U2308y+OA+QfRIOGL3czXACvCHYQIYUQU+6H+u0m2MDEIC18PGwcSRrMSsaOwSnxwn2aRRMpuad5PWDOahQ3ICNRmrWMTccQYQ6Zi4vpvhTBmXOB5ip3HLDBDunssBxykzKt5iR0uAcO5lyV85zOc97wBL1UPA5gCJvnotKyiP42j6lqRcPWspUtdg6paLPFo4LvhOv7kE+l+6PkcRO1Yr8Ug==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ISCpW+sjF2lwHZU9cYLkPsolol/8i/8IuOFT1boHEPzAqHm/0S5ErKlt5OXCHj2GOqdg+h/l7JGW5+klR6gesQ0Jba9u5Bt5ydOZaaZxk1/Sh9CyYZ5xRM8WTsXZynJIPs1PYSxXqR5FIaUzqIzmSo3CTkDZpIoAEPlb+baVgfnpmt+9FB8AVTN8BoQ2dorbTvDNCua0wSZezqU3VO4/sQ49hIt06O8glEuyn00CwPKbwehZ4b2fzYvU57osDf7IhCETzAEqaGaNYm2OdquzplM0dcp6vkPdHKnn+BBH0qHa69c9gH93T+kQMgZuOs29WWwSOOCglJwBG2PgUXyItxJDGvr2z0cMFHC7ehLwQ1eTR+KqMPT+3KS/eeyVpy6K3I0Gc8wAaU4seI2CtjHHz3CbLgpVsJOsyUmdbwejeJCZDteo2/gBNJQRh91p5mR3GTlT754LNwyqT1PiP+z3H6MVHDgXN7bNZk5xZd2qWv3yVrLONuzJuLkRrUZGg/e8NjzenHfI50weCJAn45A9SdIJbkKT04lZoZdDYVtQ9cBTgBkn6Lp+rtmNuS3SYQRz215ym/TaScFuCGW97BY/En1TMW6Zjeu9r3SMib31KOVPU4H/2R2lgLW63cPsExMFbNZk99CnoyoxnpVtu6qtef4OJr8oHnn3cz+HoWBBLecNL+uGqGIAROoq2pD8M1Dsd8uDssmpUUxihYN0CvNRg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WaQNewuhE2BDxlmkQCNH6z8cowiKl+LyG2C2Vk8kJasOUlfmv7FUzXI811PZ?=
 =?us-ascii?Q?cUxdIq91E/RQuu3K2qwMt+jJykqPihBWIjheizVvfvGu2bSg82FPKMgp2v/G?=
 =?us-ascii?Q?tIpNie20GO7/iQ81Yf0TroDxh0NHH8EK4gSbMBD+rdMc0aihXeCEGSoWYHaE?=
 =?us-ascii?Q?5/o6qo6ETBOo/H2G5SgKfaIkC0mXcdjdk1IHZtTXCOlM0NVhcbG/ut8Ho5uP?=
 =?us-ascii?Q?NeZR6e9UCwEppW5GB7UO5F02zit1ZEWR9rVkkymAjR437R2OK6Qnh7m4rZsT?=
 =?us-ascii?Q?32ITgAeU2m3X4x+egE1bfQ6ZhOOtRkuqp4lQ1yG1QplSYSygwfhSrdwfzyui?=
 =?us-ascii?Q?rkWHoQboYLzCeNQarGVM5bAlIE3xeoRoZ1MAWzdoUOxq7qbssQVV8oZCRWLT?=
 =?us-ascii?Q?no++xbvfg1AtvJc5b5Gjnt2+QWBl0AIhEYGpvNw9NAgVS+Bur9Dsjr2Rwam7?=
 =?us-ascii?Q?JjWhx1mtKlrK+l1CSC8ei5WkbbUIg4aw81VS7+8BoTeEia8FEIN9t53yt2ZK?=
 =?us-ascii?Q?QstmadXzgMIngpjhivetj0ilTnBybPny+g6rUsitD1p24FLJ602hTlgSnvtM?=
 =?us-ascii?Q?XExprqVQ/e9GmVBXSNnNWWi9Z5HlAMIWDkYw0hb2M9yCLzQ7jy5OB+hI/idS?=
 =?us-ascii?Q?swZtm9XoPZBRy+3SzzN8G5jwuIbKUHpAI84Znq0PQFFZ8jA3ZMl8QzbpoCth?=
 =?us-ascii?Q?24dX7oUSiiGgIeNAbFPr2ix03LwCEbkVznxGRcDXTuUp9V4CCXom/MFNt7cb?=
 =?us-ascii?Q?/IAUxlNKT42JIx8XgdNgTcXuj33kxM6hi9hinStPjhAKl8IpdhQlIyeirfO6?=
 =?us-ascii?Q?H/s15p+Yqu1gsW7jgAiD6cFPB2ICqNRVoibwpLoHv9JTS15Pumdr5hn/jvB6?=
 =?us-ascii?Q?Ry/r6c9dOICezSk2aqp1CSyfku8FEGaGM+EPk2PpWp19u6olMXhWOgDVQqBz?=
 =?us-ascii?Q?Y/YIgUvZd9TnQEERv0nWqaDqk9cBdg3n8KXgmpn8/nEgw4W+VD5Q5Qs07EsG?=
 =?us-ascii?Q?OF1i4qhjjeCsVYlHL/QwLjpbPhSRHey/4IwN/e++SBET0RL+RPCuI17umCHW?=
 =?us-ascii?Q?7Pd0zYWsMnJrbNlZCwF8xbddjVXZqdAAKoYlBzV0bVI+jtDX+V/MIikDZ2qy?=
 =?us-ascii?Q?GrwyaZ5gXJ+WDJhgseCB9hM+dYNn7ykXSovSoHGCdxsDwZlqyE5SJI0fXtiw?=
 =?us-ascii?Q?N6ZlgMAosmRgZk/XRt1r7Qh0L7l3mGqfwkd7zZcZJupS1tnW+T9+iBfsg6/2?=
 =?us-ascii?Q?XYNbNOPgn8tl1XBY6VQc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ff6d3-3df2-4205-0fd0-08dc5c4e3536
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 06:43:35.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7512

On Sun, Apr 14, 2024 at 02:41:21PM +0800, Inochi Amaoto wrote:
> On Sun, Apr 14, 2024 at 07:56:42AM +0200, Michael Opdenacker wrote:
> > Hi Inochi
> > 
> > On 4/11/24 at 09:38, Inochi Amaoto wrote:
> > > On Sat, 9 Mar 2024 17:01:21 +0800, Inochi Amaoto wrote:
> > > > Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.
> > > > 
> > > > Changed from v8:
> > > > 1. improve code.
> > > > 2. remove default config in Kconfig.
> > > > 3. merge patch 2-4 of v8 into one.
> > > > 
> > > > [...]
> > > 
> > > Applied to sophgo/for-next, thanks!
> > > 
> > > [5/6] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
> > >        https://github.com/sophgo/linux/commit/bb7b3419627eb34f3466022d1f4b3c942c09712d
> > > [6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
> > >        https://github.com/sophgo/linux/commit/18e8c6d2cced6c57d62813f49b57eeb8ee02f984
> > 
> > Oops, for your information, this last change
> > ([6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC)
> > breaks my Milk-V Duo S board when I boot it with cv1812h-huashan-pi.dtb as I
> > believe you suggested.
> > 
> > I don't know whether the board actually boots, but at least I don't get any
> > more output in the console.
> > 
> > Has someone tested this on the real Huashan Pi board?
> > 
> > Cheers
> > Michael.
> > 
> 
> Hi Michael,
> 
> I think you boot with the `defconfig` config. This config does
> not enable the CV1800 clk support. I think you may need to apply
> [1], which enable the clk driver. Also if you want to test sdhci
> with real clk, you can try [2]. I test them on the Milk-V Duo S.
> 
> Regards,
> Inochi
> 
> [1] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/

I make a mistake when reordering the url.
[1] should be https://lore.kernel.org/all/IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com/

> [2] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/

