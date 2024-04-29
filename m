Return-Path: <linux-kernel+bounces-161662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF68B4F26
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1580028226C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05663E;
	Mon, 29 Apr 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HZohmaaX"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2028.outbound.protection.outlook.com [40.92.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCA38F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353343; cv=fail; b=oD/ldsZEl3j8pUlH+D7VaCmpIWJ85kkaEGDOMyozqR2bW4WxdWjoXJRFBOkHsuoo30Dvs8woo65x+OKXmwzPFQGkJUz/z8rWRTbM9He1jY+7oBmgpYFSJshSc2EpBH65cOXVzF90zJANZKS4pvA8RmcEg3mU2EclzQSm9BFfLbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353343; c=relaxed/simple;
	bh=oN8Lcnp2D+pqv5dRDRvtlQCtFKr9LPIQOiG12yH2C60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KK0iRE859FG4OJrTzZWq0QHUWaSZn/C9eENaF/hhytbYuyg7ylOUfHXs4ZHd0Uf7nJtY15qjoHKyN9OzOUq9weTkV9cA+LaYMlWJi03UEacO92mGIeWxl0RRvJF2ci3sOfpfOTARVLk8f9aDYetA5fUm67TE0XVURn/xZo7nBmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HZohmaaX; arc=fail smtp.client-ip=40.92.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA3QKghDIqDD7hgglMKLSU6xUD8Y4FyYYESqFqg1w0Zb2v2xOOxOV65xfm/7ddbnYT31alYkqpV2eYdpDsCRP2wDr+xq8Ch+PMlf58ea/jdLAgSQpJnhrQiZQ71vy6tlp0c7KzJ94O+B5gS6gGLpDYiI3w4S3blKhjeHMMlLB4vCRTnW/xHhPJgQ9H+rUp+/Z3XJot/+3p9whWWoToDNsQOx0xHVhiJZ/J04zH5P6Ni/mbNjLkgJAlmDuDXRe7pjifNVrCS89KvJ0TbNR22tz9ws935Cz25P2jNUtN2YpB6y4e2oqh2bnjDll5AjRg8YbmHzb2nFdTwnetTcjRfQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyT57RFSacCnsD4bVchDcwewCUN926qJqd3cWurKplQ=;
 b=dGcLFwYOudzKsOk0igDHB3djuG5ic8lRFH/wWFvZP4AxUVp+VFUQsWqg7aQPSNKsdJwLX1KtYuQTCjK2ZXFLi2T6pVGZjf1U0G66oJBjBQIuJg+fMncelesOXS6hPyCgB/OFcpz1WxtrxWtZHxP5IdN3dqtYTDwTtx6dFxNqen96FcMTmwmuHrxwy/MU6VcBtUkY0DeTbhEUzGnHtM3qj1Iz2+po+zU5jr73TFIVgl84pSw/xNPSdko1ei96o/EOIfxuABc4fRE4tOptD4qDtFNHJ8+xdwrXxNmlhVZfLtvx/6804eDvTVo8xifcsnHQeLoOohjVtHPmN7YafDt9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyT57RFSacCnsD4bVchDcwewCUN926qJqd3cWurKplQ=;
 b=HZohmaaX+XP2uk4BWOgD4GCGdArHQU61tYcFCWgZ//3jqs1jdn5mzbaEy8XmyB8GVRUR/JfYdVE7GJ2O6imQdTIRCYgVTJhkg/DwUcEcFiO6rQH2mEE5+nhplGo/SIf7k6MFNlBqS8zDQCU18/lfWjHktrzvX//tMGpXH5eEQaATjdE9CiXQf8+hemt01uE2C7N0GG+VEs+BQCGhodD4X8UNy0dnx9lzIs612stbuFWxUjSzBc7nHiyD996hR17FMUHyHBlXG/JjLL23pdKdN6JM9pUn7L3GC0J4EDNc8wOPDohjxeGU9e3G0DLNeJhd1dZbyk31VFUnbYIF+hhIgA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ1PR20MB4786.namprd20.prod.outlook.com (2603:10b6:a03:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 01:15:39 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 01:15:39 +0000
Date: Mon, 29 Apr 2024 09:16:08 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Sven Joachim <svenjoac@gmx.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Drew Fustini <dfustini@baylibre.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800
Message-ID:
 <IA1PR20MB495359703A7C5A28940AA4A2BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [ijvFBjpuZgzrDCb0AByJ2GDjB4m/SmGcJ73biad8YuM=]
X-ClientProxiedBy: TYAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:404:14::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <2ocbyuckk5jl2a4yeiieemxeb2wvcyczqoyrqfbwdd7fvrladx@de4jizqlv2yz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ1PR20MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 840c4d1a-6f85-4fc9-7801-08dc67e9e19a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3YeeRK+i01ywhEMOwPGtv+GlEVAfMU7BaBzkKjggEwMQ1lRLL1BvlssgtAzWnIvh7khvD1MNsEz1sAD9j0Fnrkwj1VNtnYW00oX2KEtXh0j71VVzS5qXADn5+JH43QHthwPrYoeStG38RWDOSRbLD+GavZzopfyh7XcDQuNsN6+hGC56yTnObb/DYWldVPByTTnRZZmKJ9W0tyjMsFZ9Ddytgymt8qde/Sy1E+xsu9cvhXOviLcj5uYkXPz/PVvpCxGA+KcH0/eWvXqipNWQl4a1AuMmCcPgo8SPP3tv70Dv8M4tomx49fZPLWOpq7hm4YEGdrWdZR0wlGKG7/1TBjCc37PTZ8PxFJ9uH+lMh9L716qfNiOAON14jU5boy+PuUBjVR8ZzgYBTOn3y72HP+bwHudqAD3N3QspqgaHcAEnlWa9ER4SI8yIdnU0dTJDIe+qO0zl6lwyJRdlDNP/M9Zhqw+j860ZAuHkiJsTUvZB4/17SkXfud9I8oti7RzKOC1CmhnWFsxUJI5msbAUosankDL5huBipTGDeYgB2d9FF4JZT5b3KouPa+TJTRch6BCBh8sp6nrJ7Y14stHh0zrdjmYYXS6y4e3TtTlRRuLvmT4/BarJwRvP/BHuwSqY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vAvOPNykYEVtARVBNFGNxEqxayfKVrVEpFXnUhpOR6Y374uvvg/rraw9rnig?=
 =?us-ascii?Q?c2v8mnlUk8CF9zkdmvW6bUm2zt3qrcNae0EqNt66B/6U+wwIQF7S8qFlDJA8?=
 =?us-ascii?Q?tVxZsvkdmDH1tEVcSlNU9dGQgbXegJrW/9cAsMtVNkShGUypzd/pfyUseEUN?=
 =?us-ascii?Q?s5ECYrtshR/WNLG6t3piltncCKOOKxleY5KZYtVIqnm7GMg+/8Dc7eSBryOp?=
 =?us-ascii?Q?iubu8JY+n4BY9RS7F8eEZ7NNM7yzFnbZ8NPzmzyRb8CAiM+zfICoFmG+QsTW?=
 =?us-ascii?Q?FkQYF8bOjylAX216DH87WyblUfyEM5U0Sf51zuHtDQI9I5R9aawruI9vfe0m?=
 =?us-ascii?Q?llhiMtg3ShQv4PBX4NArtkFBMAhZ1+HTYcKMd4Pa9aFvl8zuHbSMPRRllA9T?=
 =?us-ascii?Q?qN+EExsoL+fIELSWUDr9fOxzu9bl7xrPZ3iBz1YjaQXS90VrN5PkFYM8KROO?=
 =?us-ascii?Q?qtBRgReFGYogBPECw71+1NHZwD8fU+w0sqAYawgsTmEPoDx2iyX9thSXttPF?=
 =?us-ascii?Q?XqyWgkzC1qWXz3lzhra3b3yDsCKaWEe8nqE/ouWRNmjIe+LPGspjJ00eqvh4?=
 =?us-ascii?Q?GHAfLGrlzEeq+CSDl9Cs0jcDduMuHnq3ZXg8J1uXmHfCwrRp7fNp/IyINsv4?=
 =?us-ascii?Q?lAQ3wLY2hyr40KEUNEvICdBr7rlwgWJY2AGycvG+UPEI5CgiZaQ6TGDYtpOD?=
 =?us-ascii?Q?CNC4upfZqGaNFMkSUttmZxPGNObzEOLSJqF2bTuBPghrPbtfpndLgYFSpoWt?=
 =?us-ascii?Q?ZhzE1xVOPf+Zu6sl2V3ZHsVwsAD9InjFSJfzZ61U1/WUJyYzQfZDfGRDjA6G?=
 =?us-ascii?Q?JmTLp7Ndgq/CkMqgcb9o/4K3bSaaH6Zp8TnGfLgq7fsj5vOdM5XsOQlrL2Io?=
 =?us-ascii?Q?4D9PROUvUv/wtF92V1bd7OXVAfEgzsCeKj4scetQ0tV2xLc6R4HvK8yJse9Y?=
 =?us-ascii?Q?Jf2IN1fM7q+iVOB2WcuDuF0gK+svWLKdkyC14nTXbLIAIhstKDzz6aN1TIaL?=
 =?us-ascii?Q?DZBR1VcsFnJeS/dufuq6/+dl/9auTUKt/FnfLKx+4BrTNxjxrhS6F4098gpo?=
 =?us-ascii?Q?6W/zjutwEujMgEhdHiuWNGMSzqLEQxdsh39K0Cxpz+MVp5y3gD81thJp9xy/?=
 =?us-ascii?Q?qqk6jgNmgh+msKuCSx4DLhPoSm3US5ccTB+L2tmUFoLA7l+7p4qorxigLmLb?=
 =?us-ascii?Q?1dQkiaFyKIx9ZbiYVIFIhyAsS/9mUosqSt/ZzoYIBNzVknizkVe/PDakv43j?=
 =?us-ascii?Q?F4D+OmFPk9+OxTHIEU/g?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c4d1a-6f85-4fc9-7801-08dc67e9e19a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 01:15:39.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4786

On Thu, Apr 11, 2024 at 08:12:40PM GMT, Inochi Amaoto wrote:
> CONFIG_CLK_SOPHGO_CV1800 is required when booting the minimum
> system for CV1800 series board.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Hi, Palmer,

Could you take a look on this patch? The clk driver is necessary
and the minimal system of cv18xx will be broken without enabling
this.

Regard,
Inochi

