Return-Path: <linux-kernel+bounces-116656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A088ACE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A28DB3A83F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FB36DCF5;
	Mon, 25 Mar 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="VaWyFZKq"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEB12A17C;
	Mon, 25 Mar 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352341; cv=fail; b=OXtFsozhwYhmX9eKSXiJomQl5bRMUae+4LJJIjltsC5FcWGfcJDcVRnFR7XJC7LrWFQnecNKbcdz1f3uKweF3StNo7f9SaPMgKo/sS1vj6fu4YwxPhn9f2fTXZcKkqwVm8T57S8s3aZQdwquAGxSz/HwoUTSVevs1sD+LHzfcHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352341; c=relaxed/simple;
	bh=zmN0Ns1vmzhPxJeK4PvjETdW8CrDt66c9/v2cvMnWOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG7ceP7cIMbhsXWoWpccfoec7xX9VgeWyWb5PLHltrm3O0rbRKj58E+lDNr8cIj9hR7Vo/bChvE6sx88mWwddZj7o9Qkb3fJUTIVDqEYi2AONM9hdXrBxc17fi84jsV6WNEXkBYSNvstuZhI1bGLmUVqVQss3s5JyPFqkXhWzDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=VaWyFZKq; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScNvCwfN4aG07DHwL1aYdqIAaFr49RoBAy74wuUQ3apJ77iBGmII85KddfN08BMBpwNDB7lqWQRMUSwYpVWtAByePaFxxQRV5MCGKrGJlGZaa051lP13iSBIRHDixFmQUxvEqArYPyqYcXX5qf3+e8Pwb/6xIgbeY6DNVqPZ+yxxMrNXlOEO8eHinyAWpqXYcBOo8auTGQI6ZKg5KxMYneGEdil4LWgvoCis/MXHusHXee1qpgOmJjvSgivxF8HsygI/YYkUYh5dPVhfBPTrvOHxYGgPAff01/t1D3asueFtzQhb1fr13KyVyxBPRxLBERp69rlTJAG8KOnzTFl3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pDhHdwl/eR8UkTtBlPQazVhEnn1qcmOBaAqzYjST1k=;
 b=fZTTEY5m+G4PdePxu8MTmMZ5sIJBiTtNbd53hvSVI4ZZjEa8gXY7DfgTDWTrLMSVLeNzUfFomlJKUmXr4DoE6TieVeGSmNm+BDEJHoj2+XHfUBrhAHacx23I25TtyRyn1FdqzcRZAVLYmSCFmJcFIQpczHGP4gYlsUP3OkSu8Y/pJwmUgSNAIDoOO44i22zKq3SfRyoTpjQRlHlI8uYC/m1HVtWYQcDO5OALSiBz8eE1Wlfm3pG7qNBK296z35Npsma9xEAUxQplF+SAKxSLHZkb9QuhlHbUxBkrFqUoI3qUt/7q1jtSHOwIoDMgQYA+VtQuQQzFRH6dtlM/cgPTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pDhHdwl/eR8UkTtBlPQazVhEnn1qcmOBaAqzYjST1k=;
 b=VaWyFZKqj7qEwFmeMUU+QWYvd78FiO+SuMdxA8WBPEjRgl1+rfa6ApKE4CDnUCk++cdJiqprjq59hRJdyHs0zOVNwRtRt8kIW7KtJkN15b/YKknAxGSlaHPZfGu5s/Rd9FNXgkK2Kw0CBXSujudmEurW8kSIQm/w6U7WCJspyIY=
Received: from SI6PR03MB8987.apcprd03.prod.outlook.com (2603:1096:4:235::7) by
 SI2PR03MB6485.apcprd03.prod.outlook.com (2603:1096:4:1a4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 07:38:55 +0000
Received: from SI6PR03MB8987.apcprd03.prod.outlook.com
 ([fe80::13be:c406:46ab:8d0e]) by SI6PR03MB8987.apcprd03.prod.outlook.com
 ([fe80::13be:c406:46ab:8d0e%5]) with mapi id 15.20.7409.010; Mon, 25 Mar 2024
 07:38:54 +0000
Message-ID: <b2907420-70f1-431c-ad94-739b58572ac5@nuvoton.com>
Date: Mon, 25 Mar 2024 15:38:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
 scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com,
 wtli@nuvoton.com, linux-sound@vger.kernel.org
References: <20240322025405.3340064-1-wtli@nuvoton.com>
 <20240322025405.3340064-2-wtli@nuvoton.com>
 <b8b33dab-809a-47d3-b4a3-cc487a02b5d3@kernel.org>
From: WTLI <wtli@nuvoton.com>
In-Reply-To: <b8b33dab-809a-47d3-b4a3-cc487a02b5d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To SI6PR03MB8987.apcprd03.prod.outlook.com
 (2603:1096:4:235::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR03MB8987:EE_|SI2PR03MB6485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	34Ox7uPHpjSnZIVU/dGIft/fXR4wP4KdSZD5zWfOfG1mOg7whniMdauS0XckrNR3WEnHzIRq73e1p8BRPlqthQEyo8cvGoWP5VsKfRcKXHNu1s2YEv3MOxkbAA+76qIUXDh0ku+kSFOggGo+U7SNiiJRJR9Q8zC71xbPav1ZqU8Uk+KjHDZVoSR/ZYw81kEwi7NvuhiyIstZNIrT0Xt74eBEEG6Et6Wh6SP8fJ6sOA2MSb57hQ1or+5up1a64ZKzbX2Fo6JQUfOtyG9mVhYOIiShvLkise40qDQaVuIhKz2U8JsNCy10IVxDLZ9eYtuN+bHdLeLad7vo9yaSyhYS7bOv4ahyBYARlb0Q6wctplTWRvGOxzg1P6yDT7CMtDHr0ESzGl//iuhl3aHWHGiSXj0a6vpNKxRaY9GLVqWXNz4NFx3OC+bIK+yGjucNP/sBhvvwD6d/UWeJaq0LCZ3fbrEKJnVjYsHtXHXlc9srFy+OgcmYMm+s0rjeMUse8iBpCJdOrXkwJSiSt4zI3F1QumVQwvSQtezf+FWCtG+SAHKopdotqz4ckRrcGV+AaZ2AUfpg2URBUZexi0g9RkTLPwnSswwhEWFmvlPkh6OkvlV6UgT5J0vK0ARrOlTDndnHl5MjNYkimxr65Wk/GfuF2gj2diy5HEtlcqP8/RbzxvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR03MB8987.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUxGa2ZCTElhRHBsSmw2eVM0V3c1cXBOSkYrUGQ0QzA5emxxVGI5M0ZVWE1w?=
 =?utf-8?B?ankzZTVVdCtCSDZ1clc3YUlWTmFEWlhZMXNWSHFhdHo1WWlWUDl1UE5BdDNz?=
 =?utf-8?B?WkdFcTR0WElJR1NlYk44cHQzNmY2N3E2QzltL3hmZlp3b2pHbWhGaG40eFJ0?=
 =?utf-8?B?Wm5hMk4vcDRObUZNdjNaOEFaRm51UytCUTNoTkJrUFpjeUxrc3lpRjU3bWlU?=
 =?utf-8?B?THlFSWs2UkRDZVdBWXpNaG1BVXlHNVNRdDdlTjlsaktaNXdQTTNNdXl0UzlG?=
 =?utf-8?B?cW9SekpxbHdQOWhWU0xwYlU4UTJHK3Njd0J1dkFPN2luWWM3bEZaM0w3VC9G?=
 =?utf-8?B?UXhIOGJGNkJvVHpiWjd2L2paVTFIWVlMWXQ0UVhPbTMxTmJlc1ZaaVFtZGVX?=
 =?utf-8?B?SCtZZ3ZVTmswZDdHdTErTGJJMEdqZkhYbDB4WFdObDNyMWZ0L3c0Z0t5cHNN?=
 =?utf-8?B?SjYva0Y0V1VlTWFnVG1LVzB4ZkFYVnNiaUpNeE1QL0RRMFZncmE5bVpuK1Z3?=
 =?utf-8?B?YlZJVmpZRjZxbWNrZ09qUlI2ajcwY0U1ZlVRRUhNQUQ2SXAwL2pvNG5wb2VU?=
 =?utf-8?B?VDVWWWUwV0ZYZWdmS0d0ajducUZRVlZ4UENFdU5TanpEZnlrUE11dDZkRGJP?=
 =?utf-8?B?bmkwYnVTUWNodUxKSEdodCtheVF5K212OExzcytadVJtY1hPeFRJZkpRK0t3?=
 =?utf-8?B?UzJLaXJpeHpWS2ZuRXVQUXk0VmhocHViM0NnUVkvcmhhdVowazZOdS91OHFJ?=
 =?utf-8?B?WlY5TkJGY0RwdXh0UEQrNkhyNWIyM1MybUNDQWRZbzlodVIxZU54R0NuY1Nn?=
 =?utf-8?B?MnNScWVWblp4SFlEUGowdGhObUlyd1lqbXVYL1IxVFFibjZMV1lwTUphUGlG?=
 =?utf-8?B?ZFVieWRzckNYbXFFVDNOeEo5clN4c1M5cSswdkpScXViays3Mmw0VnZFTVRV?=
 =?utf-8?B?cU9FZ0pBOWhkcFZpOUsyZmc0blVlWm5ZNzBwalcxSExiR1MrUVhLL0FJOTkw?=
 =?utf-8?B?amoxMTdrNDBLaXVwTitoYTNqWFhYZGlJaml4YjZDYlVtVnNYalZXVTc4cXRj?=
 =?utf-8?B?OXhtd2p0SkcyWU4zczAzR2d3OGZDZmMyZzJ3azVEQXVjUjMyTzBPSE5vK0cx?=
 =?utf-8?B?TDZjdk1QeW1kMGVWQW5vTG5BOWt0RmVsRW42ZUNRL2Qyais3bWFiZ1E1N2NB?=
 =?utf-8?B?ZTZoZWx3dW1TaHAwT2tmaU9DbHBLTjAzV2lRa0pDak5qbkJvbFVSNWR3VGF2?=
 =?utf-8?B?eTVRcnY2andwSmF5MnU1bjJjY0srV2RoZTh4QlVXbmZjdlZpODA1ZndLakNW?=
 =?utf-8?B?Y3FlNlNBSkYwa0ZvOTVhWjFNWnJtZmFUU3hIcUFqempVTTQ0MGQ4SkozS294?=
 =?utf-8?B?S1QxY1FpOG41STlLaXpCd0tBcU9uRitUR2ZOOVNmNVhWcXNWQnB6R3JkTWtC?=
 =?utf-8?B?R1B3Qko2ZWdwVlI0eWs5OWlPZEhxLzZVYjFFTjZMNUhFcDdhbXRiWEg1T0RJ?=
 =?utf-8?B?Z0NxUVN4QitKeTd3bmFjQUVPTHphNXd2S05HYnhEMGJkTUttMW1KWFM0WnFI?=
 =?utf-8?B?RWRHWHNzVXo4TklQQXFyeVhNN0ZaZVN4ZGNQazUyb3dQSEFKSG1xVnZlUjVV?=
 =?utf-8?B?dlp5ZTdxOUFCU3A1U003QXNOdm9CLzI5RDZuOFZqWmlielBsUHFyWTVicUI1?=
 =?utf-8?B?K2NaY0Y5bVphb3hHbkFHOVpKUDN5ZFBJS0RJZFhpc2tGY1N4eDhlSUNMUDlI?=
 =?utf-8?B?cCtJcldMaHVkamxkYVZVc0lod3hRZ3I1MndSajY3bzJ0OEVNUVkwdmhScnNo?=
 =?utf-8?B?K1dQbXpOdEhMZ09vSEdoNzB5MVBVeEIvVThKL0xzdG42MSs3bm01L3lJR3I3?=
 =?utf-8?B?T2lPejBNNTRNeXlsSldGVmhLakZLeVZkS0hON0NkU0tTdFB5SkxJL0oxUTZC?=
 =?utf-8?B?Nk42V0d6eFNnRDJvZzJSb3A0Q3U4MjUybERxZU1ONVlFOXpSK2xIejl2YU9S?=
 =?utf-8?B?dGhZcElsdTlBbTVFZCtTYWdQMnhVL0NGK3lZbGxkKzNBVzNsMnFMRUxNTHpx?=
 =?utf-8?B?b1VnUVEzTDUrSmdzSGtJWmpmNTJXMG1ZSFR5Q28wdWpCVUNnM2EzNm00RXA2?=
 =?utf-8?Q?vynsFRcxvLMyeDnZf+iAu4sjo?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a366f1f-f9c8-402a-0978-08dc4c9e9f8f
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB8987.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:38:54.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT2fiC3KdU8xglxEi127Vais4bQqRq+HnuFE391PR4yldLtulPkoxRdiaaI4RuZYWtzshi93cu3IOtvo3ONSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6485


Krzysztof Kozlowski =E6=96=BC 3/23/2024 7:05 PM =E5=AF=AB=E9=81=93:
> CAUTION - External Email: Do not click links or open attachments unless y=
ou acknowledge the sender and content.
>
>
> On 22/03/2024 03:54, Seven Lee wrote:
>> Add a DT schema for describing nau8325 audio amplifiers. The key feature=
s
>> are as follows:
>>    - Low SPK_VDD Quiescent Current
>>    - Gain Setting with 2-wire interface
>>    - Powerful Stereo Class-D Amplifier
>>    - Low Output Noise
>>    - Low Current Shutdown Mode
>>    - Click-and Pop Suppression
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>
> You keep skipping maintainers on almost all your patches. Why?
>
> Best regards,
> Krzysztof

I'm so sorry. I will use scripts/get_maintainers.pl. to get a list of
necessary people for
check every send e-mail.

>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

