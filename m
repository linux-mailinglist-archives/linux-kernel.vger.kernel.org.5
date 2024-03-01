Return-Path: <linux-kernel+bounces-87962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171A86DB87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845841F21DC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5167E69;
	Fri,  1 Mar 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="SvdDdQWe"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6175657C8;
	Fri,  1 Mar 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274960; cv=fail; b=pcRF7Jki+QVtT2l4TTRjkO1YFiBXnPswZdCDrds5CI+zcMfgJU3jP9j17Xo0X81dubJ2KTRD65IcdasMfRNYEmqPFnokFU4Gia2KSIn1K3BcsY7jquL/8+urR/O10uZPa6KfegLu0nEVHNTxr7dHtXDxO0/FJs4p4VdUShHnmk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274960; c=relaxed/simple;
	bh=EeaKMiIJ8O9ZXv7u5fIdyTTSR365PlpE44FGNEX5Vcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pYcRfHDCWpqvws8AIZ6nFelh+vhY4w8w775gsXEQzrQ9maKC9gLpATVr8Qi0MaTiFX/jQZQoOyzBF7/UHUPKWkUYNc5mdAujG2p33C1rhH53JQ8c/oJzv212f1neDlmQVQReZyJ02kop4EfqBq6tmwxvqe0e7IKLbXBjPWHatlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=SvdDdQWe; arc=fail smtp.client-ip=40.107.215.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8vN8BENtLzPAtoM+aQVrQ7KmInlsEF/QXZJaAP3h/U3szNlr0rFDvczKf3RvdCQUQHc1ugC8PMF5zbIalpGY5UmCB8AK5XXgQk3mTD4CfhQz1WOzLD4QB+kxQ0EnbytM5ic0HVIw+jdTNXx7t0AvNBj3xxn7zMDzY6pioLxAXawh59XHSoTTb0vbc5Hv5ZxfdkF9dUB/jVykEotGP2szX6ZC2SgU2SzaMsh6X5OO9pjp95EctpjUIbfMlTCqqpEtk1RRwjO8gJPCNzEM171wZ5E3sEP/0P2/6ocj5BVR/1rLkRzTS9wZEFPCMLu99MKcLdtXbMNykuPRJp1tm+RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIM3y697e5sfMo/q+WrKKNnxb26/lQ/figdqxklG0rU=;
 b=XW21UrLkq0+A+3Q4oCJpWcd9NjtQtTxZuhdwvwBmdPjpC7Z0qNpEmcguvQSpcDyTiWIdViDIYa6wWDZSHW3ZaQdjberCjirUIb9jelpqlYJqitdGjvymoUZG4CmeSTkYccLUIqT5tjY61IQEGnryGj5IkNYxCbTsAU/uELUprg+LFlofvW1wgx+MMM/tQJMdk39BawcyUgXfiS05YWly0SWkMGh+UT6w5Tm2OXk3lx2g9pEqyYnT7HxB8OVwmMyfqh3G858IhvRq4zq8hHX8aHwlMJi/fo9ujaz7NRomd0zpb+81hl83YiItW4NoCGAPFl1oyv+waU/OqoYeXWOtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIM3y697e5sfMo/q+WrKKNnxb26/lQ/figdqxklG0rU=;
 b=SvdDdQWee3YKFdUy1zrXpfQ9LCpAfAqwcxDjWLv5k5cSh/niNMuhy71hF+65TOyYujrg9mf8KlbZc3WbAndwSD66XTtUrqA2benaJ4MN+CXdym+qqQSAV3Gt3X+8+kO1vBeb8HmnKhpggOZJ2+qGhT94KXu5gog59Gi5fjiWZPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SL2PR03MB4348.apcprd03.prod.outlook.com (2603:1096:100:5c::17)
 by OS8PR03MB8869.apcprd03.prod.outlook.com (2603:1096:604:28b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:35:54 +0000
Received: from SL2PR03MB4348.apcprd03.prod.outlook.com
 ([fe80::8694:77f5:d686:6869]) by SL2PR03MB4348.apcprd03.prod.outlook.com
 ([fe80::8694:77f5:d686:6869%4]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 06:35:54 +0000
Message-ID: <9258eb2a-8764-4b2a-9c40-de3faf903610@nuvoton.com>
Date: Fri, 1 Mar 2024 14:35:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: nau8325: new driver
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
 scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
References: <20240222083825.190854-1-wtli@nuvoton.com>
 <20240222083825.190854-3-wtli@nuvoton.com>
 <6ffb4165-95e0-4ccd-868f-8ecda56b4079@sirena.org.uk>
From: WTLI <wtli@nuvoton.com>
In-Reply-To: <6ffb4165-95e0-4ccd-868f-8ecda56b4079@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To SL2PR03MB4348.apcprd03.prod.outlook.com
 (2603:1096:100:5c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR03MB4348:EE_|OS8PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a52c8d-87ab-4907-2be8-08dc39b9d860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LtcuQOyE1pHOSwc0bUD2aVBSgPW7DhwjVLCFlRJtZVtigBhRyiFqcCX+fDMj/qlWwD4tkhnSUAfLpdMa7O4LH6y49oJwkutvUMwXWYqzrBPnbJ+GKDO6mkuLH5o34Ux6ypX01j334qNwlxFfnuv/oxE+TuTaRcFXMNa79o7j2Q/uvda+adL6VhyznVNhLSfK5MJ6LUuH0SvcquEYHzjz8Gn72viQOf17At7plPbL+n4/wv1Oq+dJ03EB6O1Ll/KeIvmfBXB3EJzLb7Y12NjDkI/jV7oyqjX3KHWtfFhNyvfcSryHdyyyT9+7MpLiy8MJ++FHhJ4B2pZiKZ5tNsXzjwl/krtXo0g+hXvygK/ZJrIPz/diGtgNC81oll1cT96AiiT+L1OwIh2QgA82zUcLnjFY20jDq9TbQDjJe1s/ceUbRjNlgcReypJmLcdF0ek1SBC0fhZnTEnm7l7HkvX0bggwNoUHPZ0Jv4RkavKeWQtYIW6f1O60jAtAwIwE8LWY1XedOzGYOTHKSAadcA/2Zmmiig478J3vlhqHxgvefwZHk3t5Nbei5jlDW+G67IIq0wMdnithYx2L+d2loI6l3n/Xg1Yis6SHK1tknEV0b4OGuvuchoPxtVRvCchVBoF4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4348.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzAvWGpteHd3OEVGS2ZSRnYyR2djcUkvbkxIR0JRc2Rad3NtUWd6MW9JWkhs?=
 =?utf-8?B?QjlDSEtwS2xwRWpCbVZPUFNTZ2NwS1VUbFhRc1NpclJQUE9DZzZSeENrdjFW?=
 =?utf-8?B?YnJMZEFHbHNVRzM5cGdYVUhQRTR4WUNOMGtoa3A3am9RTlFrYmE3L1h3cW5Q?=
 =?utf-8?B?MWlaUE9UbUZLS0kyMURJbmRVSFJ3bmZMY1FLa2Q2M0g5blNwazl1YmZmZUFp?=
 =?utf-8?B?SlBta1k4VDkweElsd1RTRDg0VFBkSmVMWjVxTE5RbENYOXNoTGhvN05RYnFp?=
 =?utf-8?B?YVBvazlycm5tV29sWVY3WDR0T1oxckFZL1R3eUZOd2hIV0QxemlLemJpMlBu?=
 =?utf-8?B?OWNrbzRHS3kzV2FJc01kWWtmejYyZkQyTGF2RzZoYkxzNWdtNTRnNTBRQUVG?=
 =?utf-8?B?RGx6ZEtLTVNBdElGR3BPY2NuMUF5VVpaVGIvRnlrNk5tRHR0ekxBVmowdUN4?=
 =?utf-8?B?S29teUEyWlByNkRWaFFOM3ZQb2ZHSEg0SC8vN1dDWFlrK2IrMkdmWUk3QmNj?=
 =?utf-8?B?OE9tSGJvTzg3eEpwb0R3cy9kUmJPUkh5eDkwTVkwZkJvcWNEa0JPWStyMWJj?=
 =?utf-8?B?cGJqVm9JSlRnNWtkaEtiUU9GdGlZZkhPU2NYem1ZZDEwYTRrUlYrTzZyanJN?=
 =?utf-8?B?UjB1U00yOGNBRGsrQzcvbmJZYVlHTElKZnBvWGwyL0VKTXA0d3lqdU1BcjRU?=
 =?utf-8?B?VDRBN0J4azBDTzBoeTFZaDhDcjhuSEVReHIwaDZBTjFFUXQ5STE5a1NpZ3hE?=
 =?utf-8?B?UTVaV0t4enI5ZndPRDBMWXRYY2MxTVdjZFlMT0NEbzhjZURTZFpRaFVpNlJa?=
 =?utf-8?B?YU1RMUpXRzk3T2dWMWVOYlg1T3lzaTBhclpnUGFqeGJaZ0NaSU9Vem1COWdZ?=
 =?utf-8?B?YjZyQ2c0UVFUV0lnSXdVaEhlTXQyUDVrU2tTaXdJMkpxR3Z4NGwzeTJwOXpn?=
 =?utf-8?B?SFY1cXBpTEQ0R1JKQkRqeERUeWMvN2dmQ1VXL0oxaGtQVi9JTkh6MU1sMWRG?=
 =?utf-8?B?OTZabmdOT0RUY3JrUDgzd2cwTlJ2RE9Db3docURZazVnU2NZaDVwUmZnZnBl?=
 =?utf-8?B?Um1EanEraWlad3BMcEFKL2hhQ1dpR2Z0N1ExRlJQWkhTaHZ2SlU5OEt4Y2lO?=
 =?utf-8?B?Wm5NQ3UwcHdRWGV4SW9kWFhnbDNxQXlIdEE4U2FReXZaN1hLYnNQYUlHUUMw?=
 =?utf-8?B?SFFRZlJoWThVU3NuMy8vNFl0eWc4dTdWUFhCRjF1dUhyUnJ5RHNza2JaNitC?=
 =?utf-8?B?a3JnK2RXRlBzeHlnbkt6bUlCVWRyNDE1M3JWYnZ4UXlCVUE2K1AzdUE3OUUx?=
 =?utf-8?B?V05pa1ZPTDVIZXBOQkNMU2hWZ3QzVUl3RUw0SnhuY3lHS1E4YnBkM0FDUFF3?=
 =?utf-8?B?d1lkQ2hsZEg1K0JRcVFWY3M4dTdhdS9mbHNHWmRwQWxpOUhIbHY3eDluNE85?=
 =?utf-8?B?UGZ4L0ExMisrVzVmUjRCQ2NNdlh1V1hIZm1TaW1nUStWWGtDQzlzUnpTdlRv?=
 =?utf-8?B?ajVPOXV0d3VjQmQ5Y0M3RGZ4VG4vM1ExM2Z5OU1aRmhXZ1dqSjAwQkJoNGhi?=
 =?utf-8?B?N2hXcm12N1ZJaDlyRFh3bzZQdzB5Z0lNWU0zQ2JCcXVPYXEyNFViOFhOeVVC?=
 =?utf-8?B?Z2pSeWhpdUltNFYyNnhkUHVrSEJTNHNZQ01TV1M1TGhyRlQ1ZC9mY1pjOUt3?=
 =?utf-8?B?a3RoNUMyTTZjZll3TkFFdXpTQ3N6MTU3SzFTWWhEaDY4ck1TeWJqYy8yd0tv?=
 =?utf-8?B?Njhqc24vUGR0RHQ2OUNZalN4c3BMYlF3dTlld0QxR0ZYWXZNbVlRNDNPTFpW?=
 =?utf-8?B?eW05eUoybURJN0NONzQrMUZFK1hvTlZiTFJtU29TRUFYMnNOa09ybWU1UGFv?=
 =?utf-8?B?aWk3SE1IWDNZVFNDOWVWLytsQzZ2V0pqOHh4YVlxa2x1UllDRzMvVU1BWWZ4?=
 =?utf-8?B?OXRpOWtqQnkzbVpTeHVNTmpPUEkxTTZ4YlVMTDBGNlZCUGRPM2MzUmNldWFM?=
 =?utf-8?B?U2o2TGJBWUV6ckFMNXQza1pnUXozbm9WaDFpRGZMZnc0YUlwMjB4c25UbUcw?=
 =?utf-8?B?bitwSjBOVlU4S3BMaHJQZkEvRXFZR05oZ1VkbThkcmUwbWpKdWFvUlRLVzNw?=
 =?utf-8?Q?3QlxlTjb5q1Xbs1e2zEIX6U70?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a52c8d-87ab-4907-2be8-08dc39b9d860
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4348.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 06:35:54.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6aRrVtpjQwB+XpcwXOrBcQkGsfF/pYghU3RCHYhElCz85mls83kqgObGDxpuv9uyM1VPxU+LD1eij0bXVr3mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8869


Mark Brown =E6=96=BC 2/22/2024 11:47 PM =E5=AF=AB=E9=81=93:
> On Thu, Feb 22, 2024 at 04:38:25PM +0800, Seven Lee wrote:
>
> A few very minor things below but basically this looks good.
>
>> +static int nau8325_clksrc_choose(struct nau8325 *nau8325,
>> +                             const struct nau8325_srate_attr **srate_ta=
ble,
>> +                             int *n1_sel, int *mult_sel, int *n2_sel)
>> +{
>> +proc_done:
>> +    dev_err(nau8325->dev, "nau8325->fs=3D%d,range=3D0x%x, %s, (n1,mu,n2=
,dmu):(%d,%d,%d), MCLK_SRC=3D%uHz (%d)",
>> +            nau8325->fs, (*srate_table)->range,
>> +            (*srate_table)->max ? "MAX" : "MIN",
>> +            *n1_sel =3D=3D CLK_PROC_BYPASS ?
>> +            CLK_PROC_BYPASS : mclk_n1_div[*n1_sel].param,
>> +            *mult_sel =3D=3D CLK_PROC_BYPASS ?
>> +            CLK_PROC_BYPASS : 1 << mclk_n3_mult[*mult_sel].param,
>> +            1 << mclk_n2_div[*n2_sel].param,
>> +            (*srate_table)->mclk_src[ratio],
>> +            (*srate_table)->mclk_src[ratio] / nau8325->fs);
> This should be a dev_dbg(), dev_err() will be very noisy in normal
> operation.

okay, I will make the correction to dev_dbg().

>
>> +static int nau8325_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> +{
>> +    struct snd_soc_component *component =3D dai->component;
>> +    struct nau8325 *nau8325 =3D snd_soc_component_get_drvdata(component=
);
>> +    unsigned int ctrl1_val =3D 0;
>> +
>> +    switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> +    case SND_SOC_DAIFMT_CBS_CFS:
>> +            break;
> Please use the modern _CBC_CFC defines.

okay, I will revise.

>
>> +    ret =3D regmap_read(nau8325->regmap, NAU8325_R02_DEVICE_ID, &value)=
;
>> +    if (ret) {
>> +            dev_err(dev, "Failed to read device id (%d)", ret);
>> +            goto err;
>> +    }
> Probably a good idea to check that the device ID is what we expected
> too.

okay, thanks.

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

