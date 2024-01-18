Return-Path: <linux-kernel+bounces-30362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8726831DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154F7B25BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621D2C68C;
	Thu, 18 Jan 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="AS67EzX5"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB428E3A;
	Thu, 18 Jan 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596435; cv=fail; b=bFUEeFHeOHJKW3MLf3/eGSgT0jaDhAuxzj+InTiHqB7iILC505ytMK4GOVeTtC2i8TqdVqQLl2KkVc3+tRkI72V+LGSxxpwulo1WBp4h50ea5apqEkXKbqv1RvxrTMJUeBnXpGnvBVr2xbz9LAme2z4ystcap1tLkJovmfRNgXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596435; c=relaxed/simple;
	bh=jzglo9ZJZx+S95yj53V/TLcQT7twAXsACGAsYo6T5X8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NKaaWF8L2nwKp/MOmMHNT3VlLvFqfWhNVJOIC3UzBTCrthv0vZoa9RBJWAtVx/9chlix8G+p0Le5FtAU4aaV3xC38uPi3Xx9m2ACV2PySXFuVIVIBB/b7MjyNy2GsUodVuYSlLmldUOZ26BoNUD0er540c20jE9aNidaOCixKRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b=AS67EzX5; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNTFbTIgu1F0pNxvvHku2STBzSdDaLkJ3Am8jHnonO186rykj+8kFAqkfLxiC1X8huokd7eCHMwDhuBsYIHxsseQhXMyP1Jn2LeLRZlXyplTyHQkDn/b4vxiUMsz6cLKInfXInmCqH1sL4CGJde2K8zspa6uRMjW0Cj0mvNTqJBRVdEQv3UDYmavlw5ezVFJBqJI1VKxigp63tPlvepbAhj+hIq6rt+Nqjk3nsM4CPYKd6uWUTztPUtLG9ll6/kyg4TR39XoiFnIKXcy6DOLDvZqB4hxuDb2O9UVbuQjxRbHh2kgJ1ohk7INRICSqo0cNO40B2Jqje6l/kfuvWiCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCmdSty4imZo5LuUs3kNoKp152wEYgFSRKe9anFAgxQ=;
 b=d3EDdexFQ72aDLCmn6+QcLbcOEEqxB0yiHq0Z6NddOrj6PmPnvcf+RrHpyDw0txy2yaqg/N75+Dts3NyZhfooU/4+gVQhEUJNzpm3KAMsXGjfK9mqKff0N3AxxQSW2ZFU6Rj0b5k4ywHslHEtcbU/0jstepbt+J3vGynVw8hOrZiAClHWVD3Asjdm8LxthUwOuMxgC6rjyCqp2dssQhAoozZBDoN8ivEC92kgBNcCT8fIai1gOAMYRlRLueAWKILmcLgJLxN1xXnmmtNqt+cpizSB2H1NlAvBNv6QYjzV32ByPU0xGH1Si12kSMquDg0nJTUQyrkKz+BC+dtRqbFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCmdSty4imZo5LuUs3kNoKp152wEYgFSRKe9anFAgxQ=;
 b=AS67EzX5hsyT75rLc4/7vW8ErQu16Xu8B71HhBD54LUINjfZcO+Xg07zF0bbP2Ak1U5S2FSMFALYOCsNKdRyn2HQO1fvaRtzVBPhTy5qQF3NGmJNzRez0BS9q/5JqylYRAeEI9w7YFEvGs9+zwa+U1xgBNiFDvkHPwWcLyGxx2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SN4PR22MB3381.namprd22.prod.outlook.com (2603:10b6:806:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 16:47:10 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::edcf:d643:f346:23d7]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::edcf:d643:f346:23d7%6]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 16:47:10 +0000
Message-ID: <11337c52-726b-43f9-8a21-a8b0a13d636f@phytec.com>
Date: Thu, 18 Jan 2024 08:47:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: ti: phycore*: Clarify GPL-2.0 as
 GPL-2.0-only
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Wadim Egorov <w.egorov@phytec.de>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-16-nm@ti.com>
From: Garrett Giordano <ggiordano@phytec.com>
In-Reply-To: <20240110140903.4090946-16-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SN4PR22MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: f7354464-7e06-4b15-cb57-08dc18451d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v2LxV+f9GTuuNWg4lN9skcPGHA31rl3HdKcOdQlDNB+3ycn/iaN6PDAIINSiip1IC4SqnrwE45WqPaiUxfF/aTV1kKWZjtbJUvku9zxLRW1CCPXZRXWcO1PNSojwwiuDCgeh+pA77Yrl6yFz79I4GeEz6FCvlw7qdmh7SozQ/GXq2mFAQO+fzXYDtpbvxZl+aHSCY/LQpO14XDmvWxk3QUpJQTadKtMb5vAintQh1LU7jzdJ5jUPQRaGZYhuu1JHiKfEfr8K7eW9cLHV9TXEnukNMJ7GRfTr2LDbTEeyDWqc86Lua+tN7snZzw6sOxz6jY55X5FNIYXpJApckoL6E13+mJuP9uyyQ/YXpbgioNw1ZdeT2xPTHxJo2rf68G2wFov4PHb+wid+Y7y/hEJ/USZdTXPtW1aFrvfem0Dk3kHzjZVv6+GNJW6aBjw4k8obZ4YYT4HZmmHL4osdBqNhqYa8FVZ5WC2ebzlaNq5h8v1S75ttzN0bRZk+LEmc1mCXp3qBZk+1bfN6R+BtaoaMH+keu4qPw7L2P0MnthgKxcuDBTGxhrDDYl81khGnNbwagdTFImzqD/mCd5sAv/bg4627RB2dMOiCwjNvGdMdSxFFh0yh+MC7pyBVJAN4gpKIn39JSBrIzuNFRj9Q9PEJnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39840400004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(36756003)(31696002)(110136005)(66946007)(66556008)(66476007)(316002)(86362001)(6512007)(83380400001)(6506007)(53546011)(2616005)(26005)(6486002)(966005)(6666004)(478600001)(8676002)(8936002)(4326008)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTJ1RWM4MlRnUzhhU2NPQjNWclBrSjQ1RjY5U1dtRUwxMFd2MEdOdS8vQzdC?=
 =?utf-8?B?V2JqbVR2K3pvNVlSL2Z3MWl0M0VLVlE3Zll3Vmh5ZUdiMDhna1c0YnZFTE40?=
 =?utf-8?B?V0pvcVEyWm4ydjNOdWZXc3ZIUFR6UzBjRVZoa1Nqeldlc24vMGkwd0JQbnBG?=
 =?utf-8?B?QVMwb290RXBhVWVQbnAyN29HMXFxbXM5VHlMbG9UWXVVMXVxVUQ4akFFejlp?=
 =?utf-8?B?OWNXQWs2V2hFamNHbVFDcDkzTCs1czlYM2x3OFBDeFFNUDZPZ3UvT0MxMUNq?=
 =?utf-8?B?aHZjc09BOFFBQ3RsWENRcUxjYkFNTys1UkhDWTd2Y3VQakhrRWRwRlUxd0cv?=
 =?utf-8?B?ZnEyUjh2TTY3bkFZS3hxcVdHRU9wK003Nml2TEhzZEFxR0IxWEgwNGFMT3RI?=
 =?utf-8?B?emlqVU9hcTZXblE0cGlPZXlQNDRzSVJQUDhSZG9PdlVPd0lFNkhmbXNEcWJ2?=
 =?utf-8?B?R1dtZVBtYVMrZ29EMTVuTENpSW5lL05GZDYxMWI3VWJyWTlsVFR6eTN4ZXUw?=
 =?utf-8?B?RVJPM3duYnJrUjg3MU1mZFBwUVRod2lHdVdqMTF5bHB3cDd0K09HQXFKY2Rq?=
 =?utf-8?B?R3grUW1SR2wwOGh1VFFoWHBhNDNIUkNUMmozTWJjMDIxeVZJZFdmNHpxOThD?=
 =?utf-8?B?WFlyS0R2Ukp4c2VHTEpuUVRDMUt2d2gxc2Y1c1JQbmwzRjA4MW5mUHpXd3V5?=
 =?utf-8?B?RUpiMjJWamVrQWlvdTIyM3NhLzhNNGFwYnYvTXlnYnVvc1VkSjBNdnBPVTQx?=
 =?utf-8?B?MFZEbW91ejhCYVlKLzJndWVudDFVS2l2V1JUT2c0SnhsNjRDZWUrTWU2aDJM?=
 =?utf-8?B?ejVwWDBLZ2U4c0VzTnhIZCt1bzhxajE0K3g5MytvVy9VT3o3cGZlTDZRVjVC?=
 =?utf-8?B?Um9QZHNvSG5vOFBFckNPMWJJd2dkWERCbWV0RlRFdlB2dVhvWTBlY2pBei9R?=
 =?utf-8?B?a2REdjlkdmR6MldPamNseXZUY1ZsK1ZkNU9yQTdGcHlONHNZSTB3bjZJcGI4?=
 =?utf-8?B?QkhYTUpYMHpyczdrYkhtZkFjeTM5czI5TmRUQmNnVTJ0dWlJMnY1NGhtY0lO?=
 =?utf-8?B?bjF4Z1Zla2k4M20yNHJvbVRYMEJNSG1aVEZvbFlteC91Zm9uZmlEczFTYVJQ?=
 =?utf-8?B?YXhTaVBsSStmelFPaTJCNTZha1B1ZGNnSENGbVcyWUZ2MWdBa1FKVTlvQzJp?=
 =?utf-8?B?bFNiUXgvVXkxTjJ4cmtveEFVRXpxakF5ZkQvRWJUaTA4b3BhNFFPcFYzRWxR?=
 =?utf-8?B?Um9vU3VzMmV3NitnTkdHRjdKcS9xbkM0Z3RQekFOT2ZYa3k2WEdvU3BEV3BN?=
 =?utf-8?B?bHV6VjZFNnVEVEVqbDZ3Z1VCOGVSYVNubzcxdmViRTc5N1labU4wVExFQjBp?=
 =?utf-8?B?YXFRdjMvbTdQalJwblQvcnJyTlAyOEFSaFl4eEdBZzJXdXU3UndGcUM0YmRH?=
 =?utf-8?B?dGRhMEpzMHpMUkFuaEF6RTM4YTNqakNiTkMyc0pxYmRjeC8vNjlJd2I0bUhC?=
 =?utf-8?B?Unh5c3hHYU9HTWs0K3h5aEhrdU1EZmp2R25aS0hnekliZEFhZ29WQ1dxNE1C?=
 =?utf-8?B?TWttWlBYZ3NMcTQvcy9adUhjUjBieUNPYmtTdUM3S2J5QjdwUWozMXB4QnQr?=
 =?utf-8?B?bmdzcXRTSEhDcmRKN0VIR1dRL2VDVmNvVGk2ZHlKdG80Qjd3WGFjUTZFaU9i?=
 =?utf-8?B?ekVWeDd3STd4VGZqT0xMMElISkVDTUNuTDM4RjF2SjB5VzBRa3NmOUtDbThy?=
 =?utf-8?B?NC9tMS90dmpMSkFDR05CbUkvL3ZvdVI2cXBaUGdLR01ITHJONUlFNDh2Z3dQ?=
 =?utf-8?B?NzhEZnJsb01BTTV0TXlGdWs5UU1EZlYxMGNaTFcxTWoyYndhTEh2MkNLdHQx?=
 =?utf-8?B?NHlrWjM1ZXdnQVNMQlpDbnMwRTJFUzdXUEpuaGZZS2VrNEpUbzloc3Y2OVZw?=
 =?utf-8?B?RUtrN3M3M2U2OUJCeithcnkwZ2I1MThLVG1XK1NMUVViM0x4Sm4wKzZQdk9k?=
 =?utf-8?B?SDFVSDhTVW5qQUtvOVkvSW5jYlhWL1lBN3J6REhEMk1jczJXSVlvVnJzYW9D?=
 =?utf-8?B?blNkekRRVmhmTUlYdEo5VEFYQlRqNm5jdFpiVk1TY0N0UDRZUlRhN01lMmp2?=
 =?utf-8?Q?+8Obo8kw5FB1ob4MBpyX05bcW?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7354464-7e06-4b15-cb57-08dc18451d0c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 16:47:09.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw+HTR1tI56XIR8HcvTLIG8Ecpn0LiSJs0QdYytzG+o+bITJsW2kgfpC4R0NnYwePL/zZMr7TuiCfaKE/ys4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR22MB3381


On 1/10/24 06:09, Nishanth Menon wrote:
> SPDX identifier GPL-2.0 has been deprecated since license list version
> 3.0. Use GPL-2.0-only to be specific.
>
> Cc: Garrett Giordano <ggiordano@phytec.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi          | 2 +-
>   arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts    | 2 +-
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 2 +-
>   arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> index aa43e7407eee..0c8e79de1c71 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
>    * Author: Wadim Egorov <w.egorov@phytec.de>
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> index 4bc0134c987d..69b76c18207a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
>    * Author: Wadim Egorov <w.egorov@phytec.de>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 1678e74cb750..dc76ed1adec7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
>    * Author: Matt McKee <mmckee@phytec.com>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 53b64e55413f..5339aa107865 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
>    * Author: Matt McKee <mmckee@phytec.com>

Acked-by: Garrett Giordano<ggiordano@phytec.com>


