Return-Path: <linux-kernel+bounces-99141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2108783FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D2B1C21B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D594207F;
	Mon, 11 Mar 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3RkonYRe"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033941C6E;
	Mon, 11 Mar 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171582; cv=fail; b=qc74FodkSdPVcz7AoW3AtLk0QJBsZ49rnmuExYGeGo0nkG46dY8/32oJRN4bCC+e6bfIsnEoovgHnEw/0Ud0fz+EoqrdfZmzypsmHjcK9amL3utPzDVnQRz54A/xuFeZvrX7s8Yqfr69N5yd1uUM8roPawCmlm9AL9WaoBkNqko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171582; c=relaxed/simple;
	bh=55zSUXAHWbV6BiiUkFLz3PJ7AGLYScGvGef3EYvA35I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvCGP3LR2Gcl2ZTB8mqZJL/24nlpOlMbLaURk0o5KqTZidkmcrLfqcofW8ia3gepL6FgmJMuQlNKNjJq8J9+cnp6SnwI/cvGPRFO5/Kw9LW53HjBsOiie++vSmwuVyP0En4nLgnEb6dXGlKeUkF7CCxaXMyv4eLiLqrn2oeedR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3RkonYRe; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIeeQoxqahNoDbCrRdn/GYbVvs4HuCCOTIHjwuvEhm/IWSBGfLLx0tFmHUXWmZRNRBNNa3l14QOVbYVTm1GFmoBqPBSqZ5eeiKQ0lbOULwfE3+awFcqFt/13ySreuob5xhNRSJ6prlMBQLKYSUj7ZKyMCg8Eer+BLZdAR4gkq1xnfQXuZkjc08Qy2f6+gubnaBQh5XSsRoCzjkLWhDzoATPpt3IlRlr1wKA7hvke2XN5Rgrzk5MuB9RLRgFx3eB8nAnSmSaf2qdn1BvsTjYL/lEiSpSY6cUi3eWjCvPwfP5tH5cNqG53ske05C1GVg+26U3EPcZn3/goDuIjwxjX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHzxfaQ3TnOc4lEnNyyGB2VxkkUxBfVhUDoi3yvwH6g=;
 b=Z/B0MMLj1DZrHDA95enYPOywBo3F3fTfNzRCors9+KYxLx9Aj6rsz3ei8CqDn3nnyS+spAwWkG2dNR2f5qK4tFoEpgEwI98sOdq8DX7uZ/A5AEpxgetQ4i7gOaOsbZag5PAT+leMqJ/UpGhDFn5LVhrOwR4eOo956gppCk2G/VyYStowWTFjDSBkKpd0PYYjGjtGL9mXzpAqf3XpYMbvpMeGUlZKDoMMVilAjruDvaOuvyUX1CNEXxSKnjBxSIb1DDH2jo/3k85pdtJM4BdGHJ7dyy4o2snBRDN6eD5lnFu1HRsU10WoGUTgL/wwPBKW9UUqmUCKWRS+BXvHwLZCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHzxfaQ3TnOc4lEnNyyGB2VxkkUxBfVhUDoi3yvwH6g=;
 b=3RkonYReCdEfeK2imz8uhSs2ydNlG5W61RCjHl7qSpIAsHlJURYi5p/1Qh0dQ8ZEvFw0DHaV5+6RRJ8CAk4p/9c/SMSXlLuUrr2ZK+e0hoxJVUndPQEOep+VMHN52FQwjXL+xySAxoY880iUrOg5oEVDhU0sgSuZrkDwLNnBHeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 15:39:37 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:39:36 +0000
Message-ID: <023092e1-689c-4b00-b93f-4092c3724fb6@amd.com>
Date: Mon, 11 Mar 2024 21:09:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 18/23] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240311151217.317068-1-sashal@kernel.org>
 <20240311151217.317068-18-sashal@kernel.org>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240311151217.317068-18-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 47aa629c-fb50-4397-9960-08dc41e174e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sxTXqNJON/kUWsQg85JBDMuOZrgJi1AXko9glT/bmRhHUuxoR3Sn55E+B5uUogi3Zm1FELbUd0Co4hD/3gnKcmvQIYWJnC+OFNrXu8ObzQp6vEwic4BP++u3d4E6lLv5AwYkxU9GBvg50Z8QtKq+w6hAno2nfzUzvPl4iOigiaRsBThnoStOdVai9t6PWaipcdew0tOyRsX18qKTP2IOR1BipNnC9cCOind20ii5MvJGEWKKP5r93gt0iMS5VzKz2tUUPBB+H+ywFtLgekL1ng1To9XtEbr9o9mcIRsHR4DCoZhnkwX6ZkOLT5mI6/FAsUzuJBAkhc0asFZ6TjjkDy0XUPoT8q8BWj/26sIv1xWOC9gZsGK8M6brjMJ0tdaVr9yCmwzFef7cmlmmEVrRDON5o760LWRGp1uFXhERRVDWq0VcRcvzDzCLOlAK/+aCvgv9HS1xFYkvn7kj09JCV5f4cCnyH1Z7wjSHDJKC6q8j9JJ0k7uow2/g740BQpbtBKWsHKWiWfRRzZqAWbEEW4LJm84jsDgUC32+UfHsWRGukGff0vOT6MeLPaFThe70tHtpK481oeE3y2BuhLWmt//CbINLpktBW6fLyxf+L8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUt2NGxHVEQxS3BKZUU0QUdLcFp1eW9EZzdRUEF4Yi9qaVNqNkk5U1dEZ0Q5?=
 =?utf-8?B?cjIyQWxjbFZqeUtnMWtTR216eStNbGswc3YzYklQbmNxQzlhWjFJREZpSWhi?=
 =?utf-8?B?SHZnZ1lCYXczZURNR1BkaEtQTDUyUVpkbi8vRnpGNjJmcXQ3dExLNXRxYUVi?=
 =?utf-8?B?VmR5ZElQc3g1ZHBFWHZhb3BVeU5CVTRJYUlvazQyVm5pSXBKbmhldXVHdnNS?=
 =?utf-8?B?TzJ3UWlmQ05lUHIzQk15VFMxSU5razVGMEhrKzFWQ0RPOEJjVmpVMEpsZEJM?=
 =?utf-8?B?OFAyQTBQcXhiN2VSUGtLV08xRjNBNjBpTjFEbHMrNFlXcldkd2NpNkEwNHo5?=
 =?utf-8?B?ZlBBcnhkK2tyd2ovbVlFOXRxM3JWOHpwcXBsTGtTbCs0QXZGUUs2Mkt2SUJH?=
 =?utf-8?B?QzlBb0RaWFdNNUFHTURoZlE4OHRJTnkwc2g1bHdVZXhEbnU2cGlpR00yNWgy?=
 =?utf-8?B?cjdmbXY2MDBuWUhYN1ozUXU2bWNqZnZrZU5ETXh4SnpiaXpWS1VGZlc0K0hk?=
 =?utf-8?B?cVY0cExCUEdmK1RVb3dtOHRmU0NlUHc1ck1DMkVTVUJ0eVJqalk5Qnd6QUMy?=
 =?utf-8?B?VHNLQUk5VnQ0bHdSLzdBcjdteHJBNTBPQk5OZ2RiZDBCdG1Xd1RCUHhNUmpn?=
 =?utf-8?B?QTcrdkxLcDN2ZE9ZZVJEaFJUVTJESXJGSlNGbUtlYlpkOFhtcGxLZHlxNzJ0?=
 =?utf-8?B?a25uR3JCQ3NOdlZWUnY2OERqYXozejU1MmpwN0hyQXBJU0tGSWJ1RnFHWVds?=
 =?utf-8?B?Wis1djc4S3RGS0lqOFBTWmR0a3RXMXdLY0h1SFc2ZVZESXRpTzhqS2JseXFj?=
 =?utf-8?B?ZGZaeFhtQzllSU1mV2lQY1hFaXBIV3Z4TTY5TVd3UGNMeVBZMzRNWXRkekln?=
 =?utf-8?B?aHY3bE9ndkZra2V5R1hIQ2kxOUNlby9hSDZ3cmVFZ2dRNlVrdkdZbVAreEJo?=
 =?utf-8?B?Zld5WkVnNGRDQlh0NStkWmhuNmMxM0pKN0ltSGNpUExCQUsyenYvcmZlcmpE?=
 =?utf-8?B?a1dFaUcyeDJiWlRyZDlheGN2WktPc1MwZXNJbnFjaVZJMTNJa2pPUGZBNXpm?=
 =?utf-8?B?RjJ6OTIzZnhMVHd3b2JCTnhvdjZISFAwdUllYTFNT2RUYXVRaEljalpUaFNl?=
 =?utf-8?B?Vm81ZTF3a3Z3UG04ckxKais4TVVNc1pOQm9GeXJ5QUFJbDFtNllpMy81ZVhQ?=
 =?utf-8?B?andOSnIzbndheFE5TmZNUVJFQlVxUXJrUitKRUc4TVBMUTZKSWJqNElFNFhy?=
 =?utf-8?B?SkMrQjZGK25nTVlaSmhZcEhMUWdUSW9PYzBHZ2F6akhnbEd1cEFaNzRnTVRh?=
 =?utf-8?B?QmRIektYdHpzbU9IVzN0MmFLcmFNUG0raXVVQUhRci8xWG8wQlVQOVdhK0tk?=
 =?utf-8?B?WWFDUkc2Mko0K0lSVDJpbjB2eThCR0xqMHIrOFBIRG91eDhyQzQxTDVCYlJx?=
 =?utf-8?B?azZCR0tOaGNjTmdFcmpoNW1ucnV5bURGSXlRVXVicEhUQ0ZqN3VBNmwrc1Av?=
 =?utf-8?B?K0F2NDVRTmFKTXd4SUJNR0VRbDMvTTZlMUFGNDFESjZRK1BxN3UySEdkbk9B?=
 =?utf-8?B?dWxFVWFBRFZjNjAwbzZhUHA4TStHYWJhTTV2STl1ZWpGc21pbzNmVndCdVlH?=
 =?utf-8?B?S0pKS2ttblJvWDh3SzRUVzE1MWpKdWlSbUdEZ05qY1E1ZEJ0Ym5NZXNYbEs2?=
 =?utf-8?B?S1pmTDNhKzZRZGhNREhUdWxOaEt0VVd0L3dkRUF2elovbzRwK2gxS1JOVDRl?=
 =?utf-8?B?T3IzWnlPdFhIYW04dXhHQ2lNR2xzcnBWZTkxTTVRYnRQYkpnNU1WYkQ1RUlB?=
 =?utf-8?B?TW1GTW04cHF1aUhtM3ZZQkN2Q3F4NjBqbm44aGhNWnFFM3J3Wkw0Rzd6cWRz?=
 =?utf-8?B?UFpyRGgxYzR4bnpQekdET3MrSmVPeFd3d3hmcm1KamQ5VzMwV2RRa0ZUM2xp?=
 =?utf-8?B?WElGQzBnNm9ESWVtL3dOQzQvVStUSC82YXJWRzFwRW85dUJQK2FHQkduaGs5?=
 =?utf-8?B?WHY2bEFrSGxadmhPeFRJZ2FIcEN1RzZyckhGQTZ5bGhtaHBFUDlmY3V0Y3ZF?=
 =?utf-8?B?QnBVNy94d0wwU3FvU0lkRm5Bcms1ZnlPQnFXNXI4ejRLWlRXQ3Bvd3dSZm14?=
 =?utf-8?Q?YCJN6r1lk12repIPz8woe4eaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa629c-fb50-4397-9960-08dc41e174e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:39:36.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtON4YnovyNuy0C8Wx2DcEz8oGZbqF6cklAWf1Jk1HDch/GOBQJ+iG5P+DeNvxEGmVLF7Y+uBIpGlPZQU/WanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

On 11/03/24 20:41, Sasha Levin wrote:
> From: Jiawei Wang <me@jwang.link>
>
> [ Upstream commit 316a784839b21b122e1761cdca54677bb19a47fa ]
>
> The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
> as detected with lspci:
>
> 64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
>         ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)
This patch has to be reverted.
Pci revision id 0x63 corresponds to Pink Sardine (PS) platform.
Its not yellow corp platform.
Already PS platform ACP driver with PDM controller support available in mainline
kernel.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/sound/soc/amd/ps?h=v6.7.9


> Signed-off-by: Jiawei Wang <me@jwang.link>
> Link: https://msgid.link/r/20240228073914.232204-1-me@jwang.link
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
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


