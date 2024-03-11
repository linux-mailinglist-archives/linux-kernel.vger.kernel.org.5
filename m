Return-Path: <linux-kernel+bounces-99143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77877878400
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066801F21FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E224436F;
	Mon, 11 Mar 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6SbLEMg"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836642075;
	Mon, 11 Mar 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171668; cv=fail; b=lLBHPPndLlXGRafGaXhfeMhRFzZXsSpeuUb9fhDUX33xCB/5/cCeHixJzuyaOeJMm8mrOF2geMdT++jHu5Q5hntNM8JkFKVzWQpWP0vAqO+G1noDkfBta6rhMU+tKVWVzlmZMQ4zKzYnYlwI4AofzB7uM4OQsteUT0AtO5zhcE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171668; c=relaxed/simple;
	bh=kpRjXzWMVzzYjkuvuGVTYpvik2mda5w6euV8TXJ8Flg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nU81G4+8vD2onITIZNd6Q1tnod5R7yLnEWkMOrCpCCBARahEpy261yfUOt9oem9U9jpMcFpxFrJC3/ZlMFCBmrpa/vtSADW+caHBVd0+ZmIKjptoRqLMhc7K0C6T7vg/aDAD6IT4CS6OtWp855aRlEW8Ns5TF3g9julWoP40MI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6SbLEMg; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZYQRxC3/N2tnd5bsFLUHcIbCEFWvfim+v5JJSDdNupBkSgB5Si6QEoH4O6PGnrAhgWFIB7m4OJKtAznZaEhKhm8u2BejkwfvmwJU/hnAtf8VH26040lUgTM96lyXfvmKFw/GfhzZ02Z3fNORqTh4n+OZTNhh6q7YgWZVpBd3p/kl/9gzvgYj8Sbpb2XeCyNx1pgXIqZ/71PBLXYLFqMIkemJyQgZRHp5Yao1i+EOCYvAUvSEdvY51pdqYp0oqNp136UuRYZE8R+o0O72k3yMteNbQA79h1A37fPEn3PYY/TJY5mbtQgtGT4kTX1Z4W0rYE4SF+2jFvkbb/O0XiKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXWKvpE4h7Bb62+oD4T2Ch5PhyZFk9jAyV/B5XZANFQ=;
 b=mQIF1te6fhHpaKvIe3W8yQ721J7Fr5xNrbuwzgPJiEa/Ss1fhP7HBIvajN1zO5gKWNOqcVNlDAWhcGD0TifZ/8FZfOx8iJzVNsYCg4K7NyYZuMEjRAP25vFsxU9eUfej87zElseBipsZdbWqNj66w+koxP83Ojl2l3QMS6PdmQ+2PIjT/8pe7ivD2OiqojfxaXBvQfLhcw/MzPRTkQqRCNj3MdOKMfiVfOfpzmfAjglcbm9ICvMc0pyJKNUxeA/o0mk7fUbcakwz7WyUfc5hdydxtAXs5pqIGCDOaZTRoy4nEvk4PwG2fkqunI1cKNT84OotBe1p2k66iiYhZdPwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXWKvpE4h7Bb62+oD4T2Ch5PhyZFk9jAyV/B5XZANFQ=;
 b=n6SbLEMgIIsMmNGihhrksQWLwYvm500otNJtbjaEAF03SZKLpQBlil3/IXdx5oTdeg+TP0dLXyqEmbh75GDy4JEXYZ1t/EHJM+ve/UL0JKB5VRdI/59vu8rYtC6dbU2fYvjT82cR6m2TDyBF3oM/Zcr+mAxNw0IVvO64VJRIH4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 15:41:04 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:41:03 +0000
Message-ID: <b13786b0-fdee-45a4-9f1a-33427cef5635@amd.com>
Date: Mon, 11 Mar 2024 21:10:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.6 12/17] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240311151314.317776-1-sashal@kernel.org>
 <20240311151314.317776-12-sashal@kernel.org>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240311151314.317776-12-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aed15b-eed0-41a1-52a7-08dc41e1a8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	prF9oHczN/3USq1OxCKVI5zWEuskkxuPohHx++8qi29g70WYfhTscSMotOfFXl+y15ZQ8IaDgpEJRBt4c2l7EaO4uq4E5q+DnzYKJmZatMnTdVacJH65GVoOOg7FYY1p/FtpF3boryZ2/JFaIozAj5qBNROI/zlufL1kafvfIEURBBBghQa2I2RKbgvr0wQpkzf+sZZR755EL0eQnm/snBT9wX42lvxyqwWTXqLDODwFAlYufZ9BaIen+bQRJHvWtCAaMqeMOoBItgV3KzPt5t81ptbwLJBacJeKjjimYtNSN96z8TGPXhwqrEuwrnIV5SIfvAZ3+NXd8DVHUvLeZ864T6U8QBmZczzZDPmiyWpeQembj7Rf0OEqI26SauWJ6xhcRjJSd0EIx38dabn5AXcX2smqAZHlF++CSvoapRquCynFMBGHnco7ir6oBmh8WlNp1qUILJhXgnYADIfUTsm/C4W8etyIi5N1VmKC0+SB5KoSA9N74CgMD4axqhKBmOp4GxyEJZ+WCvjpgeI2sbZZ9rPEkXzSWbd9qPdHQ5l5cUIJHGSH+OvwZzdDget+vIMXSNUW31/thuuoClLYE7wOva8BXp/rhqhLDyDdmXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WSszTVZXaWhPdzV1OWUrNTB0bXVjRCtIU0ZSQU9sSWtBa0hjcFdNTUxuTFRR?=
 =?utf-8?B?aVR2cGUwRFNkOFRZZUZzZXFyNjgyYVFrMEFIUTlvVHZOS01VV3c1N2hhUjBv?=
 =?utf-8?B?amJZNUpZbEZpUXJySzcxRG5CcXNPZW1RNUdmeXFiOXhRK2pwVzhiMEdBdVhy?=
 =?utf-8?B?TW9rQ1Jnd3ZTZi96enJBUGdYTGRmSVR5aUM5eFFra2RRcVVQWmNjYlFmQVR3?=
 =?utf-8?B?TVRZZms2U0RaQ3FSNm52Z0ZqRFBYUWZZZTRiQmF2dEg5VzIrd3VxZnYvVlFm?=
 =?utf-8?B?Q00wQ1o1WWw1WlRGVGJmZTM3TjJnUStERTZDTTJzb29PSVpSejFlZFJaNzJy?=
 =?utf-8?B?SHA1T0RsZmx3bFA1Z2VUSEtkS0lCOE91T29yc0drL05zVnBLcWN0cWdFQTdp?=
 =?utf-8?B?SkJWNWptMGRScDFGZkVFdEtHdHZRV1g0eHJFd3E4WXlQcFhKaUROUkMxbTBl?=
 =?utf-8?B?VHNCZWJ5TXRmVDNBNGVHV1dyVk5MdnlVS3FJOUIrMkpGbVFaT01vUFIrZGlL?=
 =?utf-8?B?RGsxS1MxT2dibnhGUmdaK3dPb09QWENJSUhnV29QV1ZqcHhUY3VhZHM4S2U2?=
 =?utf-8?B?ejJnc2xQZVBtRm0yQnRBYmlFNmNCUjh1azlNMUpvQTlNTGJyemthdVlHdkp4?=
 =?utf-8?B?N0hIVU1GR29UbWh0VzV2eGpsNUpTeWtmemRxMW1TZkxpN20veUpsZGxJcVJH?=
 =?utf-8?B?VUtTdjJGYm4reVVsUUVJdEhSR2pqUHNVT2NreXM4OWhZSXZyYXdRaW1kUWFW?=
 =?utf-8?B?OEV0RGN3VUQ0OW56S3hvWHMxN2pramFLUTcrR1JlOGxZZDY3U1g0U1FMS2ZS?=
 =?utf-8?B?L2txbWpkZDkybGhmbUV0NmwyYUJwTU1uN0k4b25hOVU0OVNmT3Q4Q3lFS0M5?=
 =?utf-8?B?OWRJUjVFbTFHcnpSam5Kck5INDNxYVVFNTdVaENKcUN4UzdWeHJsTkRjdjZy?=
 =?utf-8?B?Y3pZa08xMnphTkxESE9CNkswSklmSmFqK2Z4MzB6ZFhkTmhZY1lMNEFubksr?=
 =?utf-8?B?WDdDSFBjbGFTdUVyaDZ2L1ZxVm80bEZKOGZhZTJNSWIwZUh4YUl3aWpHUDhi?=
 =?utf-8?B?c25FZVdwYTMyLzVYd0p3dGViUDMvS1lJTTRkelMzcVlhcE0raDd4Y2NEN1dW?=
 =?utf-8?B?cmNESHhvSnUvdU5HWUtWRjdTSzVUVEcrbnlHT0NrVkd3cml1bXMzUXYyZFFB?=
 =?utf-8?B?aWNsOUk4VUdOaVBmVTdWcFozRDQyVVNWQjNUbnRIRDBCOWc2NmwwT2t6bE1I?=
 =?utf-8?B?dmhkQ3BMMVdWY2NISE9uejcwKzVoT29JSlBMVndOVWNxMklWQ1ZxMVc4WVIv?=
 =?utf-8?B?L2U1U2d5OStwTzBPS2l5b25JaTB6UzExT1JFM1h3dW0rb2ZPYmJ4TVlSUFlu?=
 =?utf-8?B?aDc2eWFTQ3piYlkxYmx0WVgzR0c5Q0E5dVdRMDg5b2JkQkw1YTYrN3pZTmRN?=
 =?utf-8?B?MWRVUDc3Z0QvMzVkVS9ON3hOUGJ4QWUwWkRabWd1ODlrZ3pXRW9qOW16T2lP?=
 =?utf-8?B?OXE2b3Z0cnFad3NxWlJueWJsSkgwTzhOWk0yalEwNVJJcUhrQVRVcVdpWGFH?=
 =?utf-8?B?WElmcUJTcUcvMnBHcFIzVEtXM09RUFNlR0t4eU5ZRm9sc0lBRXRpOFl5Kzgy?=
 =?utf-8?B?RW1PT1Y2MTg3b2lzRzZobU1ldENXZ1FTMXI3K3hxSDg4L2hBSHZNUUtkNjZx?=
 =?utf-8?B?OFhIS2prUFZLWjExRzVJbE4vTUNkdFhXTzFnZmx5L3d6WUdEaDR0RjFXbEFP?=
 =?utf-8?B?RzF0THE3T2FQZ1g1Y0VZdXhnK2RJMkh1eXlyQnRaRlMyUnpqL1RNbk5RRzl6?=
 =?utf-8?B?WDlYVTg4dUk0MG5qTUR5K1JBUnpWb1J5aWRRNWdVNkg3eEY1N3ZkRzV6aGRx?=
 =?utf-8?B?eW1DaEZqNHFPeGVhaW9DMEU5VVR4UkQxVmRhelBpRjBoaEJXcUxpMzdEaEZY?=
 =?utf-8?B?Y083TGNNNVEwSy81YkoyVndhS2RPcG1pY1gzZ0IyOU9PWUNNN0JxSVcxNXF4?=
 =?utf-8?B?TS9xTytPeHY4cXBNcWpacnk3RTJQeWIwS1VCM1FSd0ZvNFBuTUE5OFlaaHhV?=
 =?utf-8?B?bVFFRG5kZ08wV2M0bS9jL0V6OGIvMjk3RTE3Zmh4OXlLUTk0TG5mL3hlU0Fy?=
 =?utf-8?Q?IKnnuI/ureV7mJvaPfFGxWeST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aed15b-eed0-41a1-52a7-08dc41e1a8cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:41:03.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SZoP2MKk9OXE32xDH1oroywrsMaqF+DJS7GmOgB/S+m5lwBPP/ld0/bRkVG/MelgZPOa1mJYL0Rcs9V2N3Htg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

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
Already PS platform ACP driver with PDM controller support available
in mainline kernel.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/sound/soc/amd/ps?h=v6.7.9

> ---
>  sound/soc/amd/yc/pci-acp6x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
> index 7af6a349b1d41..694b8e3139024 100644
> --- a/sound/soc/amd/yc/pci-acp6x.c
> +++ b/sound/soc/amd/yc/pci-acp6x.c
> @@ -162,6 +162,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
>  	/* Yellow Carp device check */
>  	switch (pci->revision) {
>  	case 0x60:
> +	case 0x63:
>  	case 0x6f:
>  		break;
>  	default:


