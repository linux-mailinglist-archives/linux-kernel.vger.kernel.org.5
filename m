Return-Path: <linux-kernel+bounces-57755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C284DD0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD5FB23338
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8CE6BFCB;
	Thu,  8 Feb 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MVjOAiO5"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB906BB47;
	Thu,  8 Feb 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384909; cv=fail; b=CXXHVEXFdFbbytRa859GdVzI7hoUCJBvSxqY5xmImnG7LJ8d46UFya1DbWem+o59A4ME1uDC4DiZWpcFcK8RQfhFFtdZNFcxDV0kocJC6gjHWk5hcMXl7MZ+PEVtBA8/2I6eTgveQpDlFI+hP0RkqFXWPQTuXDtmRIIm4bpTJdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384909; c=relaxed/simple;
	bh=jBVdVafWcf/8Gk2yMC+z3amfDSqm/lvvwdL0nC4ubeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L91WGuafqDJ1yg7lJXT6KDPacub00fOSjBNyJqGLq6tWLrMXRlK7KDO+taopnElSkrdBd9gSQZsFIsDktytb6zvCv+q08azmzn8W7F4PJD73GXJ1B22Qhwnm0k5/SH7dYM/dLdUiY+gsPVsO/n2Aoh8mjrENr63w9tLhKa/QzB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MVjOAiO5; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzlQQaDYy3ivmP96LH8yKdxx7r5UJwK7XGyY2U2YLXFvg3MzXx4vJH71bYu0bs84SG6FrwOVc7A+jl4atnwXZ8+mUw4zafUFoY9hPpUEenfEROQkO6Zsb6AnyV2Z/k041QacJejZFE/HhyU/8FMMV+sFlcgnlh90AU93xBgCreSiVDLhB5lJjheVq9eXmFpNmWvt/LWbBOwSTkhhc6+1fZyCTLgWIcQ53KJUCfDPN3hAR2ctlu+SGcEz8+Il5nTcgJwIqKDQ33/EYZlJl+LcMZaBECn4Isoklw/XExtH0P36fn1LbDQZf27hT2t97tiPnKupr+0y/NIX54Veote6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxLu81lXm4d7g6dNiDrlP30JADrO5UM95YvpQzwdzu4=;
 b=c1WbSgW0Rxhv3wzMVd3pOvlCgyU2SfCy7NjDat8Pnrp7EOdtxN8l9WydfE/7S0nBjATkSMkOFeyIszrTzynW5fXszB9OtWEj14equlBKLjxuMZXguVnLz4BEYr9K812+1zsZBnR2c0m7kN7/Sif3MN3gA88gTK4kMALi1wzNZoSjMpimbQk+OFh81kC2JsxeigFDxAYRmzdskJHoVCST/Kah9fygthty6RvZFaQPyDGpmK5BQmYv7jUeA4qVr+HMhmZ/6t0TPQgu+4SkhmvUtcXeSQVIX/Gf8Mj25W/GY8C4rvH7wPPVyPhrVkJxo8NpO+FLUm3C1sr6AmCxXTXwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxLu81lXm4d7g6dNiDrlP30JADrO5UM95YvpQzwdzu4=;
 b=MVjOAiO5kEytjphE2Tywqp0uu2dmPhuN1jd29tl7eQstdV08IAVaYVocBMI5eLgBNCC9xoncnj2Do839g4RkEwWM7SZ2tR2zHxLgYnozdrPnexgpBEFe1ixQ2n2qMtTHLCT/vIU1yWJa7dB8GFq7NtzEGSUk+Q0WRJe5zM/pT/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 09:35:02 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 09:35:02 +0000
Message-ID: <a7a55dc6-c204-4aad-adff-9806d3302b6b@oss.nxp.com>
Date: Thu, 8 Feb 2024 11:34:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] add uSDHC and SCMI nodes to the S32G2 SoC
Content-Language: en-US
To: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0040.eurprd03.prod.outlook.com
 (2603:10a6:803:118::29) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bde920-0c73-4468-60d5-08dc28893992
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OpEP3Q43IaxieBf0Qx7EShapuILjAIRF2vRHUolbAiHbh8gyvWNO7IjgHzYiXgzsG5hUZ7HCynVJ8zaIRoeSo9ITLvfMgGh9pnxXKGoL9ja2KxFkigx1J0v6aHkDZHjTsFYFqkFrcLX0lk9NsJypyNyKlKuFSufGJVkl7zwhpCgi/95DII+EYIB6LCchEPoY6ZuLXBn4/2jtpdxrFTzfxgIjLOwdJnlqNY22ZK18XSMbV0lGcVWw/O4p7PERWmc5Z2zgbIHU0PleXSgR5bKLwy7B5N2qcUWvIt9uFa403Y+VbNSDyn4zlDcHB0qF6/EQHhZwc6NGIThKs45AeLxQisA9grHbXGnvP19w7dMkMuhBBtsRMPdwh+yHERyjY5oNU5ka7u1hwbhzKqKzQNDs3cIwPz0iX6UAewxkXd6gSPdUZ3S+I2Osu8MjaKXt0N7bdHKsU2hUISDLqRONht44bdWe83mjyvbE1EB7T5L2LmquePmQUpoWr/zwVtwUwxoMVFbOTEuwYSgyPXYe+TPH3lCllsd9H3s3D4FT321tWORCGKaCFfX9TipD1I5mrAJFgjOrzODuXZtSuS/g0vfXCWMBYXZoLfqqvwLdPeSTs/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(31686004)(6506007)(6512007)(53546011)(6666004)(83380400001)(478600001)(6486002)(966005)(5660300002)(2906002)(66556008)(66946007)(110136005)(7416002)(26005)(44832011)(2616005)(921011)(31696002)(86362001)(8936002)(4326008)(316002)(66476007)(54906003)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXg3M2RxZVIrN0lBcVllMzhYOFhRSWdvTTFiR2ZVRmFGUzNSc25ZWS9QZTh6?=
 =?utf-8?B?bTNZc2lvbFNzeG1MR2xKd1pDajJSUGJTMVlGTE9yTXNpdUFlMEk2MnkzZGtB?=
 =?utf-8?B?UDViOFhTQXNvNGZ2ZVh2TDdNcERqbGJKN25rTEVzS0ZnTjFyTy9sWTdZd3ZX?=
 =?utf-8?B?RlJiUjJkeWR6MytzQjBWRGhmSEUvTEF0UXFqMGhudTE5cVRPcm5XMi9QVG5O?=
 =?utf-8?B?MWdrQTlOTEpjTXdteTdNbTlMTnhyZVFtbG9sNVdiY2l0YWNCbzlQc052M3Fo?=
 =?utf-8?B?bzFjVUFmSlNXYU5SQ3gxV2s3K2ttdnRTa2lnWGM4dnlzTVE2d0tVZlJkVlB6?=
 =?utf-8?B?NGZTRmdPOWhrTVBteStOdWpzV3pjdC9FTzZXK0F5ZDBXdWorL1lyZ01KdEc5?=
 =?utf-8?B?RS9tMlBFUWtiZDFiTVVuSFB4cGJnMGpDbkdtRlhUaE1STnhYOFkwZ1c4VFB1?=
 =?utf-8?B?NDJrWnppWXFaZXZSUnlKVlBobzYzcWh1cGdEUkZtYXZORDdYam8vVExjdzFH?=
 =?utf-8?B?M3BPaEJOYnorVUszVkYvY0pkbDJId3NEbzdEK3ljNkg2SzNjM3JBNWhQVnp1?=
 =?utf-8?B?VlFjM1ZUNzRxazBXRndGMkNLaVYwTmh3d3FrdXArMDcxYzFJT25uUE1oR2xM?=
 =?utf-8?B?LytHMWZFOTFtczBjMmlmNTFsOWFEaHBkT0h1K0FvMm16bU0xTWk2QndIdlVO?=
 =?utf-8?B?VW90Q1kyT2p6T2x2cWN0Q0ZJUms2N2V5QnIyOTVhYkkrZit4bVJQa3RWY1hU?=
 =?utf-8?B?aTRMQXJ3bE9tSkd1MFp3clVlZWs1ZVBrTHBPUU5CRnN2ajkwaWdoKzI0cHM4?=
 =?utf-8?B?WjR0Q0RpblgzWWhLbDdrNkljY2huL3NseWxibGVKNWVEemJQMkJLZnZEdFpT?=
 =?utf-8?B?TTVQZlNPWU82T1dwTWJpM1dCWXVsRjVGMm9zcFIyMllFYkRvRGpES0tQdXdz?=
 =?utf-8?B?SCt1ZHdSU0NTL1p3eUhyZ2gxOUJmWFB2UHk1OVNpeVlyekpKeDJtcWNvbEcw?=
 =?utf-8?B?bFc0M3Z6S3dQTFJBS0Vvb0E4ZlE5Q2tmdnh4SXZydmRTMGhOeEdmYmJRL0RX?=
 =?utf-8?B?Y0NWSTJ0SDNheUloNW5sTTJUZTFRSDhKUVo5ZUR6aXVtRlJxaFIxRFFaNzEx?=
 =?utf-8?B?VEVnNkJiTDMxQ0loVjgvQkpkamRPYkdyY3NEb2RNREZzcmQySGJvUDRoOEZE?=
 =?utf-8?B?RnZobk5UU0lrSmR2MG5IVEpocWdJWXBlK1ZuOThSODlUdHVsbm9oQXVUNVkr?=
 =?utf-8?B?aElzdmJ6ZG5lNkNyeTRPRjNERlQwNlZpTklWMVhIVFB4dFRtRWVQZG1zWkJP?=
 =?utf-8?B?SUFLMWw2djZOVTl4YkpldjIvVkgyckphTFp2NUpvd3hZZVNXVCs4MnFOTWVh?=
 =?utf-8?B?U1dQcm45UmdxOTZaZkxJZzZvOTNadEk4SlA3QXJlaHRPNmduTVUwOVBENVhH?=
 =?utf-8?B?VFhLSWpNVEdxditCeThSSVFlaWFoMmJMWmtNeUx5SWQ0K1hoQjRkRVgrZmR2?=
 =?utf-8?B?MkpWeXJDLzVMM09WaTFKbGYwYnJSU3ZzVDhtenlxSWtuOFBDengzaHFTV1g0?=
 =?utf-8?B?ZVdvTUxZZ21ic2tPWFp4NzEyUHFZVE9iNHlUTzJmcXZ0aVFEeE5GZlB1V3lN?=
 =?utf-8?B?c2d6Wi9CaG1CVUtQWThuMEZTMkI2dkEzTE5iSU4rcUNFT2dXV3A2d2paOElM?=
 =?utf-8?B?aFowSGZvYjJBdzN6QU5LOUdNVDVmVUFJclU4MzI5WG5YQjFQY01LYS9LZ0pL?=
 =?utf-8?B?V0tYZHA0RnE0bHhGRFRjcTNoY3NtS1VHSW1aSU5ncTBlUnkzRVh1bElNN3cw?=
 =?utf-8?B?djBCZ3ptM2NHekFacjRMMi9lZVZvL0szV085bXpUVFhQNUtvVXNxMzNZeGN1?=
 =?utf-8?B?MlpmY0VVQ2gvbEdhV01wNzI1WG4rQk1kSjl5Nkd2NTJ0RW43Qzl5eUJxc1li?=
 =?utf-8?B?am5Yc0Zrc0FtU05VUW8rM0RaQVRtZjJGZjA2Y3NxQ3NPZjZPVndNeDZiWGdN?=
 =?utf-8?B?Si91blJ5SFEwekM4OHZraUZzU1YvbVhJbjUzblM4ZHdJSE1jODJCUXdubXFO?=
 =?utf-8?B?L3FoSnBhMVhEMlZWVDdKdG41U1VPUWdJN2ZIckNpWkpDS29TbnNFcjlxSDlC?=
 =?utf-8?B?N1VlL3FueGVLdjA4U2VIOEs5ZSs4aVNjeEIwaHEwVDVJOTRqdmN6ZXdUTXBB?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bde920-0c73-4468-60d5-08dc28893992
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:35:02.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Tn3/P+E3RKaPf8FkL82LXyPz3LD8vCaHoDtucwGAevBKc4fTyBJVc5hf4OYg439lK49h2iKXQcNdRsMakv9vlvyp3uBrPKPhL9kHHBwL0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

On 1/22/24 16:05, Ghennadi Procopciuc wrote:
> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> 
> This patchset adds device tree support for S32G2 SCMI firmware and uSDHC
> node. The SCMI clock IDs are based on a downstream version of the TF-A
> stored on GitHub [0].
> 
> I can send the patches individually if you prefer that instead of
> submitting them all at once.??
> 
> [0] https://github.com/nxp-auto-linux/arm-trusted-firmware
> 
> Changes in v2:
>  - The SCMI clock bindings header has been removed.
> 
> Ghennadi Procopciuc (2):
>   arm64: dts: s32g: add SCMI firmware node
>   arm64: dts: s32g: add uSDHC node
> 
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 37 ++++++++++++++++++-
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  6 ++-
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |  6 ++-
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
Hi Chester,

I want to confirm if you are open to accepting the proposed changes for
ARM/NXP S32G architecture, given your maintainer role. Please let me
know if any revisions or adaptations are required.

Regards,
Ghennadi


