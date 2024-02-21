Return-Path: <linux-kernel+bounces-74986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713E85E0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C1C1F270C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F680607;
	Wed, 21 Feb 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g0Ln31o7"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6380637
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528762; cv=fail; b=PAvlHOxkn8pyG31IGJi8gVPUh4xCHbeUHX1mT/HM0mlE05RvDaxo7uIkOxDi5Z2dGVoWCBaYv7jh2SFnv6XKTfPGQ9Wm3xgRqJ++TnhV/wA1ricSDknZ9Q1JmxT8SPI3zSItL8yU2JqByrCBCKbYe0VLijsX0BOWeib3e3d480g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528762; c=relaxed/simple;
	bh=1t7cCQ38r28B2KhhqbhluYuajTBEz2C4MlX70phG3/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lcHKnXx0k+wNyQdlMTyErIOPKU2Znv3EgGCslSfbCMAPjqByqY3f1rmUeIkaqr6HrP0B0XIcjLZ9hTZRUGmpC7wbP/gPEj+UJBVjMCCPGLgzbMZUdppXTUHYlsl7CNjGAU5rdiuY/G1O5IFItphbBk/Jr2UvuIPclZghmb8mKC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g0Ln31o7; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQKysZ8G9JLQGW45AL32O88d6m/xk/Mi4kL4BXV7WYoGNxkokN+kX4rYqO7la4mF3n7eqWmtlstjl9A1hwjOTWqogIXhyg74Jfmy3Kj3+8wF4k0T8G7+QCxNs5Xy1Zez/aY9P29l1CxfrjZ/Wa8l9hRMVwcMg+8BUmASHveUI3Ta01YGNto7xW0bjq24Qv0uxoQT+537UdZWC1uq6DtT7/S3SjBWH6Xpxl/cdF0VcOqhijL34z/VpXyrXjviPpCjh+1k5WSHfrMmHA4iqNoH7b6jYg/Dm0VDARjv1jaa5s1K5C8XmNzH2BPamJy8SmXqcopuM5F3QBTF8YWKgjIjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNb5VnUSQRvn3bMgCn6jW4XRu3OuNdPpunx4nVX1nRE=;
 b=fDjmcko/JVg7BAN+oaAkPeC+epnVykkuN4ZGYiNBn6NFcyfFtk22owAtVf/4qfisfMeL5ah8BJBTq+ewU+a80/tgJlJOhYroaiZ3HBGTUrTOFRD/vAREWFDNieBHxQsqvi0JFbBZGjY8rlKtHjH05uL7b4JAfwNcsim4OSTN71lmmvHaQTk5q8tZmiRtSq5gR3oFlKGrfusrXlT/E9J7pNFEwNSDlmVNfZn5iu7wmKnjCBiJk6L9CbHdxya2hwsA7GKvvhKl1HfPX2RekZ228Nao1SjmeFAKO8WEf1ejjP+kd7ah6pP0Ormo7/UC37dHl2HbwSGq2uxDBtrgJ/IM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNb5VnUSQRvn3bMgCn6jW4XRu3OuNdPpunx4nVX1nRE=;
 b=g0Ln31o7Jlzar5vdm6Wuz2D8L9lEGyVr4gh+WjGDMriow3WTTo/ZhK/gj7AnaHEBwV+loql9pGGbomWzSw5dALsj+krUFglATvA0ZwRr0+gtJ5kqdBxfSpNjgknx6dh4Z77LprwY1Ndh1VGLuRePcqWOvkKUoaM4fC/ASJsh5KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 15:19:07 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:19:05 +0000
Message-ID: <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
Date: Wed, 21 Feb 2024 17:19:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Chester Lin <chester62515@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
 <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 6622ab6c-54cf-4cbf-737b-08dc32f070d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JR1l+wrpy9qx5t6iPZ3YRjyPHOZA2jYM0righFo6ikC7mQpNGavSGeEdFRXJzqDpUS1zAoZeCGt1udtEpMyQye3wv6hisXnt1K1Kah3MlzZRteRJQ8WDQYJFypB4hVOUyWMbhqohXsM6f9LuWAZE5bHu5AhSFIOM+rMxpU64BmEqdUCXwoZLg7gwr1t4EQLiPNtg7/p25MtCBnp85RydV0GzQ33lgWeidbRh1eoyyYRlDhz4wyTKMhOP3uxg34kTYwNOfg9cm7THHnQ6N7A1MJ9K125JJQ+05r5TYIn/AeonmInCqYnVTGG3xYm5gvHi6adUiHLJfhlTPHkrk4LCZazZTCD4PrkhZooyebqL1XESdjWqYRDPYm58hX2Nbk3CA5qoWKDnXVT98q/sMabaNxq6SUTeYRHbSB2C7h2SVmgaci/nx3p9ghD1Vs+nMhxoyYHu6iZIAdZaOh67bAjv4xcMjB4+i3auokrN+TH3fX2H+FjS2KFiECDoIiORTm27HrKZPf7ZHysRv8ctZ+Gfuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNSLzNZd0dLQ2M0SEI5d1diWjJUQkNUR1Btdy92U0Q3Vi96RlJodzhod01P?=
 =?utf-8?B?eVdiTm9tYmhlZE5mUkRDZ1VQSlR3b2xQVm5zK2VwQmdMNkVkWkZyR1orWkMz?=
 =?utf-8?B?N0FnQWxPZTBxMHJ5bUhkM2Y0UDFaaTRxb3ROdFE2K0FHak16MUpVcUNBT3c1?=
 =?utf-8?B?dW0yOTIxOXhOazJaYjR5S3FaTXVTeFR6RE1PblpCY01sREgxcEI4eEc0S2dv?=
 =?utf-8?B?bHo3WXZEeWxYWjJYNVRxaytwWVhrRStqSDRVRFhhOStUSUxBTWVJbU9HMG54?=
 =?utf-8?B?ZXIxZHlZTjhTaXFTR0Jab1ZsMXNoSEtWeHBERk1mcFhzNWNFdkUwMVd2dkt1?=
 =?utf-8?B?Q1k3aFA5WjM2VnROM24rN0RBWVZhZkdUL3p5NkZLNlNEdU85RVRPSXVTTlp6?=
 =?utf-8?B?cFFVUFdjOW1QRVRkNDNDWkg2OFVKa3lrNEtNMmtBZkw1S2RKQVFrK3YvZjdL?=
 =?utf-8?B?ZHhYNnhuVEVOVWRiZEFSdzhCWjJaMm40UmV0bUszNG9JcWRrWW15cDNWUGVZ?=
 =?utf-8?B?TmR4NVUxdzFVUGtKT1YreEs5V3huRm5UdmdFZ3MzU3VFVkJGL2lmL2dSeUph?=
 =?utf-8?B?eXhzQitGKzQ3RU55ZnluM2k3eTE0QjlROXRrS1J5dUx4UzY1cDIxblBna0Vy?=
 =?utf-8?B?Ny9xdE5vOVNiTEphMUlSelFMMGxyRkZhY2ZuUFIxZkJGa25xN3dZUzlhMkR1?=
 =?utf-8?B?ZUZKSWlia1BlUFJCU2tndEp4T1EzVmVUUmZHOG1vVFIrQndoMUhMaGpSTFNW?=
 =?utf-8?B?bFBNMnFib1hxMHljVHltS3FTZWdVbTUwNFo1ajdkOG1aZUxicG1NKy9RYjBq?=
 =?utf-8?B?dHovMmY1Y1BQQU5qVlJ0Y3RNUTZKR29HdVhPMnI4UitCZGc5c0RHTDFKOWsy?=
 =?utf-8?B?MUloVFB0WTRmNlRiUzY1ckJFVWdteXpoN1dPZTVkaktuTmZBakRMb0FDU3pr?=
 =?utf-8?B?SHdOekdJRFRIR2RXMlM0cGNTQXhTUG9sWnpYNnpYYnorYTd1YWxNUnMrRHdO?=
 =?utf-8?B?a2hpdTROSW1YcTBZeWZiWXdWY2l2bnJKN0ZGUk05ODhUdEhwMkUwRG9WVXRz?=
 =?utf-8?B?WUxXc0M4SWhIcUNqOU5ZczRlSEtKekhGYTZXMVArSnM4R1Mwcjh0cU96Q2xT?=
 =?utf-8?B?U1lIWUx0VW4vWUNIWTFnalFDald5L1VvYjhLQ0tEN0E1OTFodlBaOWJKTHc1?=
 =?utf-8?B?SVgxTjhzd29Zb0VPV2xCcC9hNVhVRlpqdTVzeUJVQit3ZllxdnFOTU5ZcmtH?=
 =?utf-8?B?NDZFVmdhcGhOR01RQ0hZQmJUTlpidVBrMTZodEdIM1VDbElRTStFRFFjZlQ0?=
 =?utf-8?B?TXRkSjhEU2J4SHlUTzJFVVJpUlROVW5mdWc4ZDJTUnQyYzFsVVBsZmZHUytB?=
 =?utf-8?B?aHh2b2c2dGIwNHZoaUEyRGpBNnMxSDd6S1hNRFJjVDdERDNJQnBZKzBrUnpT?=
 =?utf-8?B?YlArRnB5akdxdXRnWDd2S2tzR3hNaDF3NENtNWtuaEZhRzZ3aEpyWWNWbXVn?=
 =?utf-8?B?S1J0K3pBbmtCMDhBVWVNQ05xN2FMMWNrOHFQYnN6T0I5bGkzQTZGWmJUN3FO?=
 =?utf-8?B?VUNXMTF1WGE3TFlhZXlZU1VLeDJlM3VWWWxyRXhFT2xXWFhqUXhvaWMxdzB1?=
 =?utf-8?B?dWRnVlBoS1FxUTVPY2diN0MzUyt2bFQyOFRabmJVdFAwUDBNSzlINHdtMnVL?=
 =?utf-8?B?ZmxlQWlHeTNTOXY4THV2RmxHZkNlc3BTMVFDL1EwcEN4cFY3T0FWc2dmazAw?=
 =?utf-8?B?TTFzZ1piN2VwcUhsYVZqVVBSRWxpNkI2SnVkSWUxWkZGeldxaDg3ZTR4M2hm?=
 =?utf-8?B?U1lwa1JTVVlvVWRIeVNNUTl2Um5hVXVlR2tWdEc2dG1NQkpSVStndngxTUtC?=
 =?utf-8?B?ZEZOUEtzWjliQ1lVWkZqM2lIZnRVS2l6WHd5aFJUTHpFVHB2cUZHVUpsZmor?=
 =?utf-8?B?aTM0NjZoQkc3Y0QxYllnVWhzWWNza1hGSWRmZkx5dVlRVTluSld1VTVjcVA4?=
 =?utf-8?B?Sml0NjJrZVlWazlKYTRyTWhPKzRvUE10OGtuYnMwTTJPTkpwMDZBcFViQnhH?=
 =?utf-8?B?WWsraUZiRmliVUVVQjArTm1ocm9tN0VycWs0R2N6TmNQWi9ZODAwWjNnRWJW?=
 =?utf-8?B?VHFRWlBDNGJqM3ZvQVEzcnhJQ3BGeDFRL0RVL3VQUXFhU3gzSlJpZWtyRkxs?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6622ab6c-54cf-4cbf-737b-08dc32f070d5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:19:04.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCEXnqL2IbNWikdlvHC6L3+DkJRrx8i24jtaxOLtGB5CsRepwAvILljuQY7wquVL4lpPHvwAw/WMbECmBtlp1Aly/ElZXhPh9f3rewdvOH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

On 2/21/24 16:45, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:42, Krzysztof Kozlowski wrote:
>> On 21/02/2024 13:01, Ghennadi Procopciuc wrote:
>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>
>>> Add myself as a maintainer of the NXP S32G DT files.
>>
>> No need for cover letters for single patches. OTOH, this commit msg is
>> empty...
Thank you, I can correct that.

>> Plus your patch looks corrupted (wrong encoding): F??rber

Indeed, it is due to 'Content-Type: text/plain; charset="us-ascii"'.
I can fix this as part of v2.

>> BTW, did you contribute anything to the upstream Linux kernel? Do you
>> know the process? Downstream does not really matter.
> 
> I found the answer:
> 
> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> 
> Does not look like. Please get some upstream work experience first.
> 
> https://lore.kernel.org/all/?q=f%3Aghennadi.procopciuc%40oss.nxp.com

Although I am new to upstream communities and may make mistakes, I am
eager to learn and improve.

After leaving SuSe[0], the current maintainer of the NXP S32G DT files
became inactive[1]. As a result, this area is not currently being
maintained. This is the actual reason why I attempted to add myself as a
maintainer of that area. Although I acknowledge that I may not have
enough experience to become a maintainer, I am concerned that the NXP
S32G DT patch submission may be blocked for everyone due to the current
situation.

Should someone else from MAINTAINERS take over this area, or are there
other alternatives?

[0] https://lore.kernel.org/all/20231115234508.11510-1-clin@suse.com/
[1]
https://lore.kernel.org/all/a7a55dc6-c204-4aad-adff-9806d3302b6b@oss.nxp.com/


> 
> Best regards,
> Krzysztof
> Regards,
Ghennadi


