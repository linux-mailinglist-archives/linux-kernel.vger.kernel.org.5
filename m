Return-Path: <linux-kernel+bounces-45934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A6843808
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C8E1F26F93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D954FAF;
	Wed, 31 Jan 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2QoH+9/9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24D51C59;
	Wed, 31 Jan 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686774; cv=fail; b=qhpKViyf5TlIbzcEEnnyJfb5cbQzABdGApT9s2uxc/6Xs1aJaLcdPrARDXhsk5L2IofjEQP8zL9i3VBoHG0UB6Ni7igslA7vgaKgvlOD7yxBVVeuWNnlDy/Ec0xCq9HOG+AMd9CmRh38UtPEj5NOhDDH40hCEYC6DlDvp9ITK84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686774; c=relaxed/simple;
	bh=Y8QiGifIajlXtuWnuyzwFHiabIl2l8GAsQB2VxEPJwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h6GOHKpQEA0wZqDi5oeLruZdFOGv2r7lEAsX+WslWACGHiJz1ksYsRs5a1UEDoITYkqLZDek0cKaI2TKx8HcrTSlDO1AasD48iosPRzfNmLXx0QTlu5/RPyVsjbDpGGnEjheITukf1LHnsTdEN0gSTxb6UVZBI97dIFws08ebKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2QoH+9/9; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWRv8YKs+Rn47P+xVlw/d6BcYZ0uLr1fW1Z9b3/BxqYJtqzSCrRUqw35UpLGO6g+T2o/SAqVWXWApOZxtaZGIjZr/mJYVpxKaTxfmWX7ydLSDpQNgnB8HrPNDmkpPwd5l7ZxfE3VVBhTeOhhTboPiRe0DfgrwpA9SUj3hKXg9Rw4ilgqo+baFNfYoOC1cZ8hd/fef4o5MEN0ihrC6VPXwovGDQhHh0u2DleT4oxYkNCZ/D7KSA3K3bck6/j7onO57rtu685ausTY79JZAE20QosrUi6wEVIGiRGumoJ3HvIQjmP2pj/B3W/CJALpzMsTdiS6uy80iP98xqItaLShug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/S04L7W0kfEkL2olIXeWnR1xeV+q0Iwfp2vwDiB4fM=;
 b=cVKIVz2SnLEVa/S5Miy5KPosR4tVYS2YTgDSkgsyGEnCLDARryKPntcoyZdaUPcJfTe78Yvy+/Ko1N4yPWrorvThMMlZAs4Vr8+FYwPzojc72T4Z3vf81R6b7ijPqwMjuE3gNDKj1FeE+WzmVa3SDqz9QRtQ1krNW7UgUWaid3FU0x5EwaF0r2+3M8A3Yxsy2I+dcw5PKAtu7bEaiWaXDXb7J01437xj5a2DZQHmPP3GEQmQ5f55Qpupd4sMvJU0labYDqWkGJCQFHvzFILp+9IxAL1mxf8YsMtFo5ZwfgBnMNrhK+KWCnIvuvaZ9xSKMKvb5aM5qn7euteTJEsTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/S04L7W0kfEkL2olIXeWnR1xeV+q0Iwfp2vwDiB4fM=;
 b=2QoH+9/9zt8FlS+0ukaWl0CKe7rbfQOE+7eejEC7svJ3snhChcLiJ9NFpxukS8OPCNgDtCDr9x4e/GXLxoLnYGhQpCATv65aEPi3Nm+4mSV8wURQfxIoXhI9Dn2boGwhqC+SQQUGqAd98qqkH7F2XPkjIfLmQiPV0YBQ8Y1AmH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 07:39:28 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 07:39:28 +0000
Message-ID: <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
Date: Wed, 31 Jan 2024 13:09:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d09582a-e994-4054-d217-08dc222fc17f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K3fkd/C63weL1ViKSj+ynBxmoRsa1SNRjmEcj5gDzt8CrOfn1hHhy56KBBeV8F3DGT8A1Ehod4YVbV0sEdreyMKKOv5Qqn4zgFGJHpNP2/mXuTvz7dO/9/+xziDNTzdwG6UTdvAojcYcrvKIJXtDuUo4OEk91w84Lj+/ZJ9ynQG3+rZg7mp7sLA2ewtS4kARtGUvFkGXBL6vwWYofvAT5OaGlxh35B1q5luFofC9/5IutbnwliL8uNJ+eMvuis8RniricUOF1s7cbn4I7Hl/rMrOgZvXDVvnJjfN18RxnKCkUmrbAWvrxfc0WXKSpimX8z/z0CqvCGu7F9FHKMr+AhaIVNzNczEP2p90lHBav52+0eqhsCsUkAvqql2fz0/JCkuwzSG3M6lAJJ9qTat9IN5rUQIwztQMFhihzp8KiE9X1T69FS4pSKc5MAgHBiCXS4dfcYPVhaa3tE4dMDhXi69jIv7UkazZpV1hG24O1YBWMAXWs/scnlpxLOZa8P6KI8mdojE42CEDRs0o2MlTj1Fr67dNQGlM24+8yb0vQYNKwmdmN3hWs7XE9iChjw9BCZ7wtbz3WDReKM0UZIHQlR+6SvOhsHeunMTjOANAUsE8594RPzQJJ3c/pLzZl/4zi4C9cGJFADWzqAKBpfiqaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(31696002)(36756003)(41300700001)(26005)(38100700002)(6512007)(2616005)(6486002)(6506007)(4744005)(2906002)(53546011)(478600001)(6916009)(316002)(6666004)(66946007)(66556008)(66476007)(8676002)(4326008)(44832011)(5660300002)(8936002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStqUVRlTW1kWGFETTNiNldGeC81UWlSVFpPKzdjcnNYK3I5UHlBd1UvSThX?=
 =?utf-8?B?TDd2dzBnUzBXZy9Ga0tZem5LKzRtcE5TU3B5WVZSaE1XZEN1Y1RSaTF0Qmk1?=
 =?utf-8?B?Um9WZno2NEhQMzVjQ1FWbHZRcUVlWDBMUnRiNGs0Vk1kLzdxRWhBMzliRlMw?=
 =?utf-8?B?L002a1pLLzZPR1dJYnpNOTh3d1VPSkk3bmhRT2hQaWpNYWlnWnQ0MzZGUTBH?=
 =?utf-8?B?ZStGcEk5d0d1RHIyeVZhNGZqNlY5ZHh0OE9JVGlNSUZkcmFhdnhYdVJ5cC83?=
 =?utf-8?B?RUk5VVlXRjZQb2JBbktvOEFTZ1FBWUUxYitBV3lRazdZUmxrNXFHNmwvRDhV?=
 =?utf-8?B?WXJSRWFjMWpSbjNmQm1IVXBVS3NRRHF3V1hNT2J4UThKeG9SQ2VpN1hqTkVY?=
 =?utf-8?B?L0FIM2JkRDk3UnZSdUdka3FXZEkyb0tQRVRSdkdtZmNXVkEzcUJHMUdQbWVJ?=
 =?utf-8?B?Y0VXQ2Nhek9IMUNxVEtPVUlidTZaYTcwNGRwd2RsUURhQlRyN2tFUngreXk3?=
 =?utf-8?B?QitTeVh3SmdJc1B1V2FBMFRtRSs4amtQNmdLTGJzUitzMTZNeDBsM005dkxo?=
 =?utf-8?B?WEduRjFzaE55MzZMeXY4Z3JjcFNmb1NZbVBidFA4QlQ5Z3VjUzZPdmYvRlp5?=
 =?utf-8?B?TGF0MmlJajlLbjBtMjhVWlhnL1JKbklvdzUvMEF3OXk4UkpSYW1XNmNYT2V4?=
 =?utf-8?B?bnN4YVY2Z2RVbURlOXlGbEpsMFNVZVAvb1B2VzNBK0JuNmlmMndOOHJEd2FT?=
 =?utf-8?B?cXBWVCtaY0FnNlRsZ1VuKzNwaThJdWJZMk9PT2poZ1IyRm8yckdncDNTOUZh?=
 =?utf-8?B?SUEzODlseWdPUzJ2di9qWEVieEZFSGEvYjZlUjBaWXU3UzdQaytsdEF2T1BS?=
 =?utf-8?B?QzliVGllVjdXZVNrSS9ZbFVGYlBxbUx5blBoR3R5WVV3d0JBZUtFS0w4RnUx?=
 =?utf-8?B?MkhLUW9XQXNDWEFkd1RXYyttRk1FYWRRcklhdmV5T1Q2M1IzeXRnSGtsOGd2?=
 =?utf-8?B?YWRYR25tT08wZzlWVS8raVgwcDQ3U1JpU0hFRFY5Mm5FRTM4ZjdNTnFJVzh3?=
 =?utf-8?B?NXFscjZmK3hnSGpWZUhRTEl1QW5YQWdmKzhlM3lrdG5oOUpUem9RMy9IQTho?=
 =?utf-8?B?OTlyaFhRdG5LajBXVWZweTBkQ2RMM3BKQUlqZXNvakwrdW94Y0V1L05jekVE?=
 =?utf-8?B?SUt5V0FZYTFoNkhFR3pld3Nrd3pLVmFVS0dFd21MNzEzM0c1L09jU2pKTTM1?=
 =?utf-8?B?SDl5QnZ5RThxZTZCNkxoc09CZ0MzcE1kWlRRM3h0UmllYzloNSsvME90YmJL?=
 =?utf-8?B?cWRBK3FuNmU4YVRwS0ZQS3QxdW1TL3lQdjlRV2ZKK0x1ZlpOQ0hLeDZ1THIx?=
 =?utf-8?B?T0RiclZpZFd4aUpLeEYva1ZJK3dNZFF4Znl4aEVZOGVNRFJid3Fwa204L2dI?=
 =?utf-8?B?c1RHUjZFbzhhc2huNkI1cnhpdEJ4WHZYMzJEbURwNmp1ZjIvQUprZmxON2I3?=
 =?utf-8?B?NGFsSE8rY2NBejA4bWtkM3d5eHEycUhTTEZ6SFFtSjhMTVVrU2MrRlVoRnhp?=
 =?utf-8?B?akxjUzBqNlJhZG50bVJzWkM5RzNHRjJMMzZWaDFJR2s5QTh1MGEzb29TMksw?=
 =?utf-8?B?RG9wWEJJYlhEWEtJYjNvTHA2eG5NRzErK25VQ3hCMWFySXdLRTFHeFpGRGFX?=
 =?utf-8?B?QkFBaTVQTW5ybnMxQ1JXWHhUUGdCcVF2K2pWdWkyNXFWVk4zY0FubHhrZTFN?=
 =?utf-8?B?NTJ6djVsbjNFOW5FU09qSnUrWGViaEJJSUhJbkhNaUxya1dYRGY3bExuclpZ?=
 =?utf-8?B?VFBQcmFRT2Z4clJkY0xWdWM1Umo1cDB5T1lKYjhVUGh1MFArc3RQclNmZHN6?=
 =?utf-8?B?ZzR4MDF6QWs4NnU2Yk1HMVpyTWYxZXJmcVcrbTc1d3RNZVlkNDFZR1EzNFZP?=
 =?utf-8?B?Q1RvQ0lmQlNMSE1pM3RyQjdvKytVMjZOSTlUanJlZnJNLzE5eGovRStibTd5?=
 =?utf-8?B?KzNaNllIUXlUKzNncXNHZlFhZ0dDaFg0T2hXN3UvbzZOVXdPekliTGRxODlK?=
 =?utf-8?B?YUdYY3BKZVpTQkNkQi84dkZEL0N1bzNSZGh3dDNDL29LM0xTWUdpY2NIYm94?=
 =?utf-8?Q?iS4sFJGTHy2F3pdReKW4+yokZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d09582a-e994-4054-d217-08dc222fc17f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 07:39:28.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBkY7tn6ZpQiZssWoAn+H46jOKW4YJn9FxCbUDx032SX+tfiKm2e3Dd7thy9e89p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

Hi Andrew,


On 31/01/24 6:56 am, Andrew Lunn wrote:
> On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
>> "wol-arp-packet" property enables WOL with ARP packet.
>> It is an extension to "magic-packet for WOL.
> 
> It not clear why this is needed. Is this not a standard feature of the
> IP? Is there no hardware bit indicating the capability?
>

WOL via both ARP and Magic packet is supported by the IP version on ZU+ 
and Versal. However, user can choose which type of packet to recognize 
as a WOL event - magic packet or ARP. The existing DT binding already 
describes one entry for wol via magic packet. Hence, adding a new packet 
type using the same methodology.


vineeth


>      Andrew

