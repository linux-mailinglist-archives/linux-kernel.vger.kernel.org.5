Return-Path: <linux-kernel+bounces-33733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE3836DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C509028C877
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047295BAE9;
	Mon, 22 Jan 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hMtkxZ7m"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2061.outbound.protection.outlook.com [40.92.107.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB53D974;
	Mon, 22 Jan 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942699; cv=fail; b=RUHMhQqJIqVlnk5318qeUm6UwYf5ke+NcgI058HspVieiuwJ+IkZ1jjx5NmCPxfCO5zdQsJ9kaGLf1WHl98tB27WvAakCSvlqbr+YLqbIRVlb/2XvLrRNWVCnYG0svKe/e84DJWJai+qSBPjv/EkgBK4kMcUIJrPXYHRnmBfSOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942699; c=relaxed/simple;
	bh=7iBDF1jaIb9RM2xB3WS9BMY/UtVIWMcCp45iIADZ3xY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzcGNGa/eb8wZA4lMp0EXgKkrmA8yUaR5jVkipeiPa6UYQUV+NKoSxlXRzitOeDOgfL/ncmbWC7VeNtWQTPoZGt/zlxm6OxmiDP3OQ6Xcl0SguwbVQHTZ9xUFnOcuFEQLhyeunWik4jokvnjW8uDdw1v2Ej6FY9fMpSM7C3zhDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hMtkxZ7m; arc=fail smtp.client-ip=40.92.107.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ4BFVPNIsKHUMBOfnAHD+rjs+hO0zMmioGbRV7tdHYluE0/u083yv15jnDjq0r8DT0+BEzp4P1yJJNZFDfjI5Ili0+PqYxjvJju07aty02ew1kNlVqoTSCMY5Yj21Jt7vCoKxx5bcOxz26kwttYyMt9COBCONuwDOSxVQ2HD0lEBYeiSnhjtolJk1a8w3zyGqG9mrEHZNpu01nj6t7OkSFkHf2PHEYIOIadklAdJ1loMb3jE6mKizLuw7OYbv9V6VD0ixdsfIMECo9tCGT0AjgaqktjzbHCzHAme+Tk3E10V+aDaVMb3C28mp25Mv2zYI0G87aGZ8mxCDb2pRv3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbQkkmDb/DfJmOxciCW8jUjSMZsevOM9xfTfcOtlVZ8=;
 b=OTMEQDZnakbCmyHzwPhFCp5soVyhiC6TYmFHZTmjaTH+ILTnrj6xbdDXDnxvgZVVjkEs1DHmCCloOo1dpld/LlU/hGnzpFzneYBR3CnAhfg+jm3hQ5hamC4/dnIVngreiAPSQuqvwR7/y0tJX4V9VtdWOc9EzuCMZAknjHODvzUhyOi4fW/iXB6RVP80RfhbVXfqieVHtvo2egE4zfINICj2Y7kbzX4yVVZmZ45n0W/dksc+epMxshKx32UPCOln4z1QKBdYoWZVSb58PZoQk4jw6PRsgqzngo2fNqzIpo16uahI6fBKx4/bc66KoEfuj9mlLgyIDtc80Fk+OeEeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbQkkmDb/DfJmOxciCW8jUjSMZsevOM9xfTfcOtlVZ8=;
 b=hMtkxZ7mCF4ruvJ5bABkk2mQ+fl/brhNUhGV9KAfTXVDXIHi5bJmeQp46NumTEt/WkJiikBTw/gQIj2aG8sB4Ir5PzzImhBthMAS8YxjOqEXFuuM8Qva0HKRXcHObnesPUTvJHb+5jmIh4ZN6f9m4qVb1iTnTxxKN7gw7u/A/aZ5WCDezVjs6JzqGxLiUM4Ax0JaO70zp7Y+o/Lh26Cxcj7k9lsDG8o6DM/1+ZmeCwWpkRp5lA7kpr89tGYlLOo8EIj0s4YVHnPmVqbQ/vrbA3xoOMIV+VqQnjkOuDDnUzO+AKcG3YN9LY/e4rNxNUlhRm8G09eWTkZ/FaUQcpx3ow==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYSPR01MB6359.apcprd01.prod.exchangelabs.com
 (2603:1096:405:8f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 16:58:13 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 16:58:12 +0000
Message-ID:
 <TYZPR01MB55569715C43B7B1EBE613B86C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 23 Jan 2024 00:57:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018-rdp432-c2: correct board name
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <TYZPR01MB55564BE24CE8718DBD4644A2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ac35936e-2fc0-4ca5-b746-25fa0e31afac@quicinc.com>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <ac35936e-2fc0-4ca5-b746-25fa0e31afac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [FjsYx4qLemGUnJH8ZvMkI5Lgsn+CTJW6]
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <05b9c7c9-42dc-414f-97b4-65164d32aa2b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYSPR01MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: afa72410-006a-4af5-7412-08dc1b6b5198
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VOUyTdWV+10zWqJEsxCknAZbcGOngS3MacbV1orZ0Y82R1msZ+aNMQuqZjQ1rA03BbLJr967X0yZvIjFd1+ojvW92OsnNd7aQ5mYHJDBfASWFQ7E4Q0AuZB7DxqbKC55DRSv5O961wvtxwIOXmFuMmL2kBGJmPtEFGnmt95zkZ6TZbh7kCTwg9Rp7sBKuM/blAetpSQj0QYlku/8on6LR8GVeyrQie4Z0nNyBVhRWyd/RW5/Nmy1SlcO+cn82zCJisXxUOB1N8P7fOQ7ODTDqH5y2M0TJA1tusmCR14O9sBuhzGr1COsIwXI+8aRzhlV7JMAEPlT7yQbPtTFtdbUgTjsgpG9QAcvF68nsUsscDys+hoF0HSBZ2iplyIMX+FUG2Wq0YYa4wQrXrnM/kc/QIlBMkCBXc4vhUFbbWX8qXyKl12SMBRoxlaXDCMyOs/EhUvUc3lmLs1mg1Uq3abien4sZOOBrBiD1SMYJFD13+XV2HAxPoAz8818I5sC+a9DyAow8J+a+Ifxbq8j/z5FVOwRBTYjKNDmwvmXtCbhyJ9L4sJWpsJ0QKoupPY1YjTB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Umk2SFU5Z1hBQjVDaDcyM09BNjJjcXIyRTN3L0tla1hoSjRaRzhkYi94UGJ2?=
 =?utf-8?B?TU5KVHF5ZGFTZ1h1R2ZoQ2txMjEyUXh2ZGNvNG5GSCtzRXhkMFQ5dXM5RXZz?=
 =?utf-8?B?RHhmd1kzb3BsWEJWWEtkN2RRVjJjNDdWcEt5R1o3WmRGUUtSMnlZdDIvYjNo?=
 =?utf-8?B?Wm8yYzhNZnhyUjM4TTFsTXpuQk0vMVRzS1krSWgwWndrQk1RYm5YV1AzY3dQ?=
 =?utf-8?B?bkNYVUtOTU9aT2xEWDFIR2hpYXhCNDU5TUttUjdGMlJKTjZVbkVCdFM2NWhX?=
 =?utf-8?B?U3dtbnRqRGhhOWlVam9TQng4Mm01VXlvM2NOczBGRlN1SXdSVnliSUdxVkZk?=
 =?utf-8?B?M01wMXljU2NDc2sxVWxUTzJ1UXRwME4vOWdCK1ZTNXJCMUN3VTZJekp2Vnlp?=
 =?utf-8?B?Zlo1NDdTYmlzcjV4NWNlV2JqeGpDb2VqYUJBa0tqSndkdXlsYjdscnJkbVFx?=
 =?utf-8?B?VVgyaHNMZGI4Smo4c3I4THNLV05LTzRPcmN4dS9TOUtUZXFHMk40eUtjVERa?=
 =?utf-8?B?aU5aTXNHVGJYSm53QzRlVGxhZ2JWK2hSbFR3YUdXcnlIeExCVDl5VUJIQ0dW?=
 =?utf-8?B?Y2p3MjNpL1JWc2tvZWUwV0ZXWXBmb2V1ek1STjFadnJZRjRxNkVvUzl5WHlE?=
 =?utf-8?B?djRBeVpYVWdyNFN1WUg0dDNmKzlXOVJzRStGdFZyRldKUUphOHQ5OVpWY2pR?=
 =?utf-8?B?Tkc5dVlCZ3hKNUQyblZQb0lXbnc4clNpQlh2TDMySVdhenk3dlEzOW9TR3ox?=
 =?utf-8?B?bDhZb3I3dDBRRVZoRDVoTnN5TDRSb3h2NkVTTUc5ZmVlK0tyRytJQ2JJVllk?=
 =?utf-8?B?VS9ZeHRqSkpTUlozamJqa21ZUnBxZjVOZHE2bEhPbkN0OG9QRmxOK3RMV0VO?=
 =?utf-8?B?bC9rckVvVHlXeE5uTXZCVGdIb1JneFVtMHhHMjVsVWJqTnJRVnI4U2JFakJT?=
 =?utf-8?B?enhBL1RQMFZKdTByd0ZnQ3B3MERBUENyVmdCNHh2YjgvakF2YUM0THRIa0hq?=
 =?utf-8?B?WDMxdFhkRTNkRmI1ZFZnKzBocDFWd2RIRDFIbGVqVjVGUVlMT2w3RHlLaW9Q?=
 =?utf-8?B?Njd0UUhCcmtPbmxseUc0L2VsaHRiZHdVVkx1UDRqWG1oN2hISFlrc2IwZ0hJ?=
 =?utf-8?B?SlQ3MGdTemZsWlAreUJHR1BkcHpIcGkzZUw4VmZmaXJSZTBoVXlMSmNwbVBB?=
 =?utf-8?B?R1RjNS92ZEZ1dExhRSsvaHM0SE5BVVB4a3RCZzJnYmNDNG83NlU3VWRUM1Zn?=
 =?utf-8?B?ODJJaUcvK0lJeFVaSVIwUFF5M2FHWUJhdFQrdGNzR2ZSMkV1OTVocEFLY2pR?=
 =?utf-8?B?UGlsV2xQOEprQ1dJZHVqVHExU2Yza2sxSGJnbzJBRENSZnhiWGdVRkttOEha?=
 =?utf-8?B?VkJrUi9IazNjaE5tQlE5MzZURzRSekdFM0R3V2Uvc2xCajVGMnFuUHlPcFh0?=
 =?utf-8?B?bStoQkkrazZGVVRGT3VuaFBKRFF2WDhCVEREbS9xN0pWeXkwUldxakVVVXhT?=
 =?utf-8?B?TVpScmFIT3VjWjVEbTA2Y2NEU2t5VWtFVk1XOGw5SnV3YVQ0NHJldGFmQjk4?=
 =?utf-8?B?cWVoa1FmaDFsaVYzcmJxZklHZTFKRS90Ym8veDJxTWtVS1I1SWV5b3VqWVpC?=
 =?utf-8?B?amhTbFJXRmxRS3Y4ZEMwS3pRbnJRUmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa72410-006a-4af5-7412-08dc1b6b5198
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:58:12.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB6359

在 2024/1/23 0:03, Kathiravan Thirumoorthy 写道:
> 
> 
> On 1/21/2024 6:22 PM, Ziyang Huang wrote:
>> According to Qualcomm document:
>>    MP03.1 is RDP404
>>    RDP432 is MP03.5
>>
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts 
>> b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>> index 074b78d7939c..f7e8b5af6b44 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>>   /*
>> - * IPQ5018 MP03.1-C2 board device tree source
>> + * IPQ5018 MP03.5-C2 board device tree source
> 
> 
> I suggest to use the RDP number itself here...

Here is an embarrassing thing. AP/MPxx.x name is more common in the 
entire QSDK while RDP number is almost never appeared.

> 
> 
>>    *
>>    * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>>    */


