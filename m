Return-Path: <linux-kernel+bounces-99147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6365E878410
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19983282B17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F74436E;
	Mon, 11 Mar 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lkIFNwPs"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5C405DB;
	Mon, 11 Mar 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171845; cv=fail; b=LR/g9+3UrnKPb97re4yGSpStd2OEzR6t07rHtr7n65quV0qq43BNS1j8cLyk7LGER5dP7SWtOfZsUB0Pa4ose4IzlpNhG/Sd5Xn3Qbl7KAC6ePEVzSGNLRORRgL44mExrUzV2fP/bo+v7EyNpNedPEpuvFMUaJPhOTlWUIOo+R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171845; c=relaxed/simple;
	bh=Uhfx+fukyxcBjlHUaYxO3ZAhNqZb+vVTXkrO38Xvj6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFajPTZ67pZX7tpW8Sa4aN6N3v5hkm6lvQ8Pgdr2g/udcxe3s0IIRLVXO0G8FKlpDaeaRl4rW35EIY4hxSPTM8hetHIefJCYV0WPydR/wDSj7hL0Q5SrkjRiURkTHWItdzQaoM2+NIOB5VYwNobrkfVvujuu8y96XimoOspn2oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lkIFNwPs; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba2rOCEcLCJMreXbO7Lfpxe9xTyTP05w1DR5euteQAbMQ1Fk4QZAzOGcZQQqYTfX/CVGO/XE6K/tAeLARvhaepXs0PGr2JAuOs5aetkG9UbwiAYtB4HmxkIFdbe7XBb13sui9f6ZppY69NhlSK19WRgb2YgP5bw6NDrj/F3eqjcnSB8OkiLTeEBKd4g0nuVdxy8sVW5pkKNoL7TMN1Ann//pigcrVNJdqUVsyXt2SB0Au3Is9gNroYL7H8QUs4PN4ZRvvns1VrkoOWhUvyELaXF0C4E8MFVs6Uh/aXh9lhOuyuev1ym8713XSMuweViANOmzjEqN3yLD1U8ZtCGgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LScTdP0GswV2TmW2JAW6tXBwZBbakAAuA3/F/r2FykY=;
 b=JfP35YK0ysGVmllvCc733pNPsz12yMMEPARYUTAfGOtjSIHh5gtMVR02GnNinnoDsLmYR1RmMLKGrS37jZ3GHti5AprtK9wFClKkjUQgTTdtQQNK00lTxO/oGDVmTKlKvnDBH6bzUUKs4wRMqljLvAfkyGSBenC0ltTcv5HtDrXIRZeClrdEIr8ptaOivyVMJ46kf7o8XGhlbsn6/lIiN/N/C8mhSGvsiYPLqq19HT/sAqwre0XujrLH1MDe8aNKX/3uleOwhFyeb/P0reUb1z+6z/6Gx8nuG9JxLMxzHxE5SXLxslZ5U1f8bxb+iY2H/O/4D9KFUB2FDTarSPsrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LScTdP0GswV2TmW2JAW6tXBwZBbakAAuA3/F/r2FykY=;
 b=lkIFNwPsPBJPu+hgRC4fcq1/gCq/reRTJL4jqi/ygAtY0iieg45OQC4kHUcev9hJ6y/Gy6lAAuI4KQL3wlLmuRY5sfZ1K3ISposE26Qpv8REJqpzDSFeWHPNNm1ufpw+XlxzmuCJwY3vALYTZ8AuCFQ9YlTNuBSIsO5VAtCM86k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 11 Mar
 2024 15:44:01 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:44:01 +0000
Message-ID: <42e0ff59-4c80-41ee-ba76-950db89499a1@amd.com>
Date: Mon, 11 Mar 2024 21:13:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.1 09/13] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org
References: <20240311151354.318293-1-sashal@kernel.org>
 <20240311151354.318293-9-sashal@kernel.org>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240311151354.318293-9-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f58556-c882-4cd4-516b-08dc41e212af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/1xwnXxjok3WmRo0yJbXMNUlxdEB2IZi2M4kLu1ATq0g47xGr3uUyvLMvM4T/jtJdYfV2I12zHSjZwY9s/gTAt7wriCiKe7g6iGPRh/xAnQKV/I2j9wZ3hhCTLcSz9zJzUsH46hxuh4UbZdAR0lNxV0rpyGFS1tDBTxUDC++eXS7zN/qxd7pz+fQQNjY/upzxO7U8SHds48d+30fowzndzVTNwTdYEcTQwWEi48ocpdbkLNTDBY4mFPcgywq02JA/2dQai7elDMi8+8XiX60wNkZD9TMcrOnqx/a48w5YwPtlVzPoPwFdhT93ueUVxttUsMIRThYCJcKSOEtjq8V8gHSjGiEleedQ/OaN31EbB01vYleduDReH/5zbagnCSUElq+3+BdU6KH2QDE7OuGlf6sJZBiBTy5792fOLzGNBbQdWIH9P9IBaHr/+NBu30kpEvdsIRKtOgRcLeL4knW7lwquRTWmr8apknDJMK58wzYbO8iTGh1JzuPJPW5iC9X49r/EHDXI7fyfBO0aTpp7hulVsS4k/02BL3HqIF9u3C9XCuI5tbndorAVKCbEfV9WnPIq9TmqeDkUBEndYPZVg+QLbBmkT85RmixuD100YI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFRXSityN0RzTnB4c1UxVGlEUTVvd04yTjNJM3VuMUdmMWFNcFdycXYyT1Q0?=
 =?utf-8?B?R3h2MExITEo1NVdFMGVCd0MrU3YzN1dXODBGVWtrQXlieVhDWVoyTkZuNUJM?=
 =?utf-8?B?eGV1MUtDTmNMVVpSRmNab1M5bnFtdjVpSWxyMVo1Ni9yY0JOY3JEMlNxUlVj?=
 =?utf-8?B?QndQRmJqbGI1QVFaRG9zMlJ6dDdrQjMyaVRXbk1BeEF3blc3eitBQUtpSlNl?=
 =?utf-8?B?QUNLVFIxZVE5b3p3N042Y0xrTHE1MnVVSlRPV2FHSHdhZXBJNXg4NFpvU3VZ?=
 =?utf-8?B?Qk8zZVFXanpUbHNBZjhBTG1PelI4VUJOSmNZbWc0OUVTdnVwYTkwK0hIR3BB?=
 =?utf-8?B?eU5IRkx1bXlDMjYzK2tabWtWUHJrMFcyL1dsazN3NEVLTlN1V1RNbUdoa0dE?=
 =?utf-8?B?eVFEeDVob2pLZFZIcnltbzNCNUZLazNrVTFJYmdOOWNqUFBycWVXUFJ3K01s?=
 =?utf-8?B?Q29xQ09iaEVFd1lEUE82R1dBeHl4SUFySE9BR011WHlWazE2THVwcWZQaU1W?=
 =?utf-8?B?ZitaQTdKbUpvSDJXU1ZEUVBtdEVkME04YUd4dFk0ME9GSUd6anEzR2d1UEVi?=
 =?utf-8?B?NE41ZHZVNFVsTFlpUjB6aFNWSFN4NWRVSDlIa2x0SmlhNmNpYVplSWdCTjZ5?=
 =?utf-8?B?ZllUNTR5ZzRZUUVacnJFcmRTeW5OUlYxeUw3ZldoU2tYVGVFQnU2ZmlEbUE5?=
 =?utf-8?B?TFdPM0kzd3cra296dHR3Y2lRU2Jjb2J2RHp2MWxnWHVrbDFVUGxDVFpibWo5?=
 =?utf-8?B?UTNadDZFNUt3Q3czR2RhK29STzFhUEhaOHByd3htMFJDZWJrbEFKWU5scjB3?=
 =?utf-8?B?djZiV0l2MUtFZmFNRG44T0NDZEE4bGRtYTFKUlVuNld1alVLU2VJNHU0ZDlm?=
 =?utf-8?B?TGR2dHdoSktnQ1pyOVdjM3F1SkU3ZUsrdUhxcWtBb0lVU3pFQXZRU3ErWDVt?=
 =?utf-8?B?dFMyQ1J2blZHYTRjSUNvS2ZYODhMeUR2Y0tiWDg4Rk1ncDFvN1ZMV2cxRzA3?=
 =?utf-8?B?MjhaK282Nnk4bWpoU3lVVEExZk13WWk2Y0ZiQTdEQlQrYnhuTXo5emgyQlFJ?=
 =?utf-8?B?Mmw1Tk1EemwrUmFEZXEzbktjdGtuYkxYRFo2RCsyNzVSNmYrYURKNFo3YlFv?=
 =?utf-8?B?UkRVK0I0KzdzQWkyQ3M3aEgyZnZoTkcwS3VtME0yd0l0ak9wbXNQN2JMZ3NG?=
 =?utf-8?B?SS9QTkJRSmhBeDhNR2hvMEFyazBDMFovRE96WmlYa29UUnB5SGZ3dzVCMVlG?=
 =?utf-8?B?S3VJTXB3emtZS1ZVSG41QzdndVhYRC81Ly9RRkdCUVFCeDd0RXVDcXdWZVRu?=
 =?utf-8?B?T1A4S1RsZzd1dmhxYUlQYlFBNjJSM0ZoSjJyR0o2T0hHMzQ5eVlWcmNCZlpq?=
 =?utf-8?B?SGNHNHFGeWZuQ0FqYlZWVXhxZlNreFd6LzhWT0dTeHhXMzc3QTBrY0NpaThk?=
 =?utf-8?B?MWhMUm1mUEx5eE9QbitLVlN6U2V4cGxKck5FdjVFMXZGaEFSU3VMd1U0cDk2?=
 =?utf-8?B?WFVYSDlQM2U4L2JYUThSL0ZLUzNmQ2doRG9vQjNKMk0zblFiSjlTaGVyK05w?=
 =?utf-8?B?cktoUGE5TTNUcVg4Vi9yOFQ5cVRaZ2VQVHRLMHk4bkk5SnljVExZRzJjWmpy?=
 =?utf-8?B?UDRuSkcwOFpucmJQUmwrTmV0NVU3cGYwcVBvSmc0Y3BzWGw2Q2tlYlc3ME5M?=
 =?utf-8?B?aE4xMXl6bnRkeE5nS21ocGNTc2UvNmROMTFoVGVwUml1QjRPSzFZdkxaZjYx?=
 =?utf-8?B?UVYzRkVhRnE1b3VyV2tXWTVhYjJocHp5cmltb1VaU2JSdzZUa3llVnN6N1Zk?=
 =?utf-8?B?cXQwcHFtdGQ3SUpnVkt4UmF0ZVdwTWt5a0tEamVNWTYrZ29PMWRJWUFEYUNQ?=
 =?utf-8?B?NWlXeHNhZ0JoYWRmcHMwRlhGSU45NmhTS2toczdNcDluRmtyZVFqY3A2RmpE?=
 =?utf-8?B?dTFVcGdNUlZIUElvK3ZQZm5tYlMxOER2Y21lUjAzN2w0ZEczSndXcDVNYm0y?=
 =?utf-8?B?elF6L09rL1J2M2NIa21hNXlPTFB2eHRYRlYva3J2SnZnOUtycUdrWXlYYXda?=
 =?utf-8?B?TDFlc3ZrRHRxR0swWVk2aklES2tsejE4Sy8xbmoreksyaytMODVrZDBGWTdD?=
 =?utf-8?Q?P2iQ6nvFa68ZtfAerU4E2Z93u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f58556-c882-4cd4-516b-08dc41e212af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:44:01.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKfJZ31z2IJ7MfO8Q7PiLRcVNMn9W7V6rLFgl5XgTpJt3eLdj61t5pUf4BpwYeBthm6tN4LWH+t+v4jP5JrVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

On 11/03/24 20:43, Sasha Levin wrote:
> From: Jiawei Wang <me@jwang.link>
>
> [ Upstream commit 316a784839b21b122e1761cdca54677bb19a47fa ]
>
> The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
> as detected with lspci:
>
> 64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
>         ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)
>
> Signed-off-by: Jiawei Wang <me@jwang.link>
> Link: https://msgid.link/r/20240228073914.232204-1-me@jwang.link
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch has to be reverted.
Pci revision id 0x63 corresponds to Pink Sardine (PS) platform.
Its not yellow corp platform.
Already PS platform ACP driver with PDM controller support available in mainline
kernel.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/sound/soc/amd/ps?h=v6.7.9

> ---
>  sound/soc/amd/yc/pci-acp6x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
> index 77c5fa1f7af14..81dc32f70de21 100644
> --- a/sound/soc/amd/yc/pci-acp6x.c
> +++ b/sound/soc/amd/yc/pci-acp6x.c
> @@ -156,6 +156,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
>  	/* Yellow Carp device check */
>  	switch (pci->revision) {
>  	case 0x60:
> +	case 0x63:
>  	case 0x6f:
>  		break;
>  	default:


