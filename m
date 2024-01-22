Return-Path: <linux-kernel+bounces-33708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB24836D87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E094228B67F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271856B89;
	Mon, 22 Jan 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E/FwMl5/"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2069.outbound.protection.outlook.com [40.92.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160423EA64;
	Mon, 22 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941380; cv=fail; b=MOB4yxojtAxx3rHd1ZuVh3hQimtNcLwD4joMoYS0bzdiVvjnVvckuQ3gSoOV+BzlBZnqGsW607rcjxE5p8+/dPGt0WvkctNaCdkfeBV8/uAUU/XQJ01EIYNt0zRxJM+Glt8Qbjsnas9qQEklgKSnsv+foaH+wUuplcISS+6P6Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941380; c=relaxed/simple;
	bh=rm5c2SKM2ED5PnktcD0oH5YqJzzr0RVd2tAl3UN9tdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BbrhsojALeiK/euZ+24CQjuzNCCDeug2kH6ap83+E7FtRi9ehDvTyXBBmmCDlHbUJ6aDcaSfodzJOP7elXucaqv86pW7oJWhHEv+yc5ZfIeeFtF4LQXiEauyV3VzH2GEPcUjRN/xQoJt7t3TuXYbvy+4DB4v3RRwOR0bPNUUtbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E/FwMl5/; arc=fail smtp.client-ip=40.92.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjWquVqT0WD1YpkjuXu2wHj0pWIKYTfekAYJdT5qyrmlxTERaMcPJ/3cBHI7J+MajSEjJoO72yS7oj7EEWYtGlkTo0YLEn5mV0Z40KL11BiUgA7uUE6S1c0tt7AhoDV2mRNAPw+5xdRjmwIAfLbV/yyAuJd4pYcn+5emWnvKXwi2SbzvDh3HWX8OmWPrgGi8moGWZ9jjHG3rvz4BIbRmYFTQFA47iRiJEgWZ2t7D1N3ubc6ba2vE5p+Km70CDDg9Pu4Ujb2a4kKqHrsZqc5c5EBeJCyd0cAZkZnLU5R8M8N+7L58WQthE9SqImY1YlDk9KuX2u1bsb5aED6AYxEPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+PBNr8qfWwc2fSfin/Ly2CKli0vrATLMNzz6YnqfpM=;
 b=UgcOj8MdZ45/6xhoVYgA0fH9O79R/+5A5gcjnEBNXHvMrLOMqJmoT4an5y3F+UzzhNlrbHHodEmJeuH6jOHs+5MSwylJAAyeMSr+Bgot4z0z+QUUdwGh9R9xbn9PgZAuzl0RNj1MkLlBG/QF9CMM0t0q+JJe8qZKCEDt1CPH+0IhhqL4vdJLnd32lnK20AFbyp2f24XWV+TPYLQQgdPsIw4e3PGRKP+Tjcjig7oh5elvq0w+i4KT1ar9d5nZkhkz6nYNTrtZM1N3+Fx1dniX5jNToidphhWl4RMIHfpwKde67uAJXJpKcsQd3xo3rXWfpSuBI+/Q65xdRxHb90c4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+PBNr8qfWwc2fSfin/Ly2CKli0vrATLMNzz6YnqfpM=;
 b=E/FwMl5/f4tyCua5be0eAfMV9FQ3F5UpXaVsy5fiEa8bcNwM9DPcKiNCLfrKOo9LD4OzWjZ4G2QcC3z4qS75t7xYuZ8oh9Xi7PinKxohLCCq9M91rq1oFQtXepq6up9qZzwY2EbZZF3t29B6ggY5aTbCynJJ9we7/aMQlQWWO28Jezp07b8hPYg3OcXxxlG38ToGtbD/rRhzpk9nrI+kyVy1prE9GNcDLPeimXANIkydmmtyXSyTcQ+xItDEWoWyQmXe/uGtzTbbgZKr2FpGugDSDaCLaJORQTUZOTRW0K6VImRfUKW14SBrjZWUvdIwNRu5uFaOxaSJo9XCaS1clQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TY0PR01MB5410.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 16:36:13 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 16:36:13 +0000
Message-ID:
 <TYZPR01MB55565998F43009AD351AC07EC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 23 Jan 2024 00:35:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] clk: qcom: support for duplicate freq in RCG2 freq
 table
To: Andrew Lunn <andrew@lunn.ch>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Praveenkumar I <ipkumar@codeaurora.org>,
 Abhishek Sahu <absahu@codeaurora.org>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <28cca132-d5bb-4cff-ba2f-9be241a5ce83@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <28cca132-d5bb-4cff-ba2f-9be241a5ce83@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [2+4/1UrGzweW/mU9TWVSb3sKLGtdip+K]
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <0084a8a4-6aa3-443f-8def-0995824c6df3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TY0PR01MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 6133cf9f-d0f5-438a-0ff6-08dc1b683f0a
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+gBgqCImLTqb4mdYBvtNPT4iXzvBtdNRMk2oDSCCTMQLW8L7CJOf39Pa0AFQMgPlx+mmSJmu2Ow/8C/lRsGDIlRSyWhq30V4uesq8QpT2QYlqxhdV9GEjGpY1u9jfxHZ3bn+/HIr/GBxOKxVMIYs44TgEDv3FJKU5z2JnMnEESA2HbYLjVM9wc3pvmba0WXxukhcpyNQmCBqqKmtmMPJtXokaoxhMdDY7HsRWtbwyiWFiCdrUDHuv2l4M/dmQhq0EGGQkwy7xEdvmQGQZ+1t6AEDHzjCxj2LRZSzdiwnUCN5Xl4hjwGPFBYGvMFcfw8QEpqL7sPwyWJhQlrHUUs1EUwZaxdDeKDse4omTNzET/VeMjHzaiMGcv4kNvmZ006mKd5EiMzjxG/x6SpiORKjnliwwOhQf0xdSMfZzEUMLgl5HlZDF9CIo8vLv04eIlXsZw72rNg0pcddDZo7P7gZoXD3igtWKjv8uP2RyZN++cq+7QKKAENXlVHkfqZGxr00ExYBhkmRm+Fuhf0T1+J4XuVMtUxARTNbYvy8CMUVzSDBKyT7WINxOF2v8RM3+u488ymJCD0JBsMr/BTNS/H/cWsrEK71p/bbTDQfbFA+u5AdtPIu7nh5ZkxE10b5kPEX1g6RuIoA+jBwHRUWR2LxSEw4yhtKEqj/YSOfHXjdU9QDS0PhCfIwwgVcm5Pkm+eeed/YKiSNfr3d2gSucRij1L1I+yw4WrYUtHd/Er7wVgkejCSyfGihP1dTX6dJEM9wvg7Wua129IuYXOxt9eeeTzeg+zg5GOusN/HvZBYKScVrBuK+m4OoMc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSa6DPc8PLaytwzy++j1+JkLJrlBOUfyspnJooYIj4oSO5eY/gxgjDu4cUdX9AhOhqlyMx04/dKqhmP7mczGBVo5WyHqtVxEIrc7POOcDaC4CDrK8PLZ83HqVus9lrUXn7Ek3YsqrWaNxGJC4G4VCkLkp7F2d/YSMcD+FmXMWvhVhOQREQA9vYwwROJqW11hIGO5jfGUj9xhfaWl8oDhTb3kESrOKQHk9X6RQ07X9lqtKn2X0d6UeR1m2Gep4ZFJJDZ9uhT+W/9yajH6VeNPZ+mQeXqFSUlxAhfa5rTkXNdmaMo9Wf0Ea1j2WE1JIUc49kZQsLBjad8/FiCJ9RUaA462EUBVTqw7T9nibcIiuPbZr8ZgxymmGYivmmq4q6hpPDv2x9NWzB3phDHnO/8yy8R92iEQGs0E2WOssDthoRxpeRs72Lgqcg0zwQZMdf9P2CdG4Oo6ZLrNgpdIJuIyMU3u6LUc576D0old6PDpDkSsaooKSd55rx5bAEubA1jq8Kd/Dm1nBKteU9YVSUBGwb8toVMWWtwaPL2qS6bm8Ijm/QU4ESVFVAhhMefQx/AKx1uE3ZHOmrn+rD2pJ5j5rGDrd3AFIEp7H/PC70Q1OOU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWY4U1doeUpEcW5tLzJ6L282T2ZHU08yWVB0YXlHMDhaaDZJWFVERS9sb0c5?=
 =?utf-8?B?cWhGaTNuTzc3Q09TWUxETDVPbGpaUlpNa2ZJMFlWUTIyNHFxRGNQc2dvdTlk?=
 =?utf-8?B?RktDVENmZmljdmF6bmZCNWxGMmdqcjRrSUFlcW9zME5GenB5azNhMi90RXM0?=
 =?utf-8?B?R3oyamgrQVk5ZnRwYTVVOVZtSUNLakRtRHJlMnQwd2hhUUJ5aGRJb2JpSVdL?=
 =?utf-8?B?dklTWDJVeGNheWJEK1VYQkRYTlpyNWN0Y3BxVU5nYjJqbWh6VkptY1daS3lG?=
 =?utf-8?B?ajZKN1k3Y3VXUGQxSDQwaXppckVaZVdseEE2cTRzZUZjVy8xWG5FNlhWN1hJ?=
 =?utf-8?B?RUlqRnZYUFFtbThBZkVISFdDMUMxTXI0WlhlOTZOQkh1MkltQTB2dklkaHlt?=
 =?utf-8?B?OXNDc1JIaUkyaWxqZURoRUpVT0RvaXFUODdxcWFWWGt1LzdYYjQ3bVVqakxu?=
 =?utf-8?B?eFFOTXlZK25MNlFMbHdUVDZoZmtSYVNsZnZDV0dWWjJRbVpTV3JabklqTzhn?=
 =?utf-8?B?UjEyOW9WQ2VDbXR1c1hrV1YzakQ5OEZMQ3UwaEtoYjZKd21jUTJYZ1B1S2ZV?=
 =?utf-8?B?S1VBdDBwUVQ3bExYWFRrdzIxTGIzMmFhbG9iYUdKVTIwdml3YkJsS0hseHlL?=
 =?utf-8?B?NXc0NXFyOXNQSG5XL05WT01GYkZwMHZNYkJTUjcwalRIWjJ4aGk1M3Rhd09n?=
 =?utf-8?B?Z3dZSWU4cG5MOEdNVUU3SURIYjh3alg3Z0J6cnd4ZVRVdUJlbmY5YlFTaDRw?=
 =?utf-8?B?aUI5OVgvZTZpd1NQVzdFb1ZEZlVxMitsTWdJeHVnNzd3SFVQWkZHMUdRaTUv?=
 =?utf-8?B?cytheUpBbVZOOHhzZlRiUDdqdERTUWphNXdVc3VoNnd0N3FHZlRFNzl2M2NW?=
 =?utf-8?B?WUxhZDkvZWwzNm1PWFlqUjArNSszT1lNNmM4ck91TTV2SWlHQWVPSlpQLzJz?=
 =?utf-8?B?WFQ2TFBCMkxOeEFHNE9OQXlMTDVNZlRoTWlodVJ1SzdsQ01iSTI1NXVmWkhx?=
 =?utf-8?B?Rzk1Zm4ycWd3QmxCTFBtbXlnUDM0R296c3JRTDdITTkxbE9HNm9YWWwxaGdQ?=
 =?utf-8?B?N0ROWlpIM0Z0TW5JTkhVMHpkN3RldzJXVmk0QmRCWXZzeGx2MVhQWkxMaUN1?=
 =?utf-8?B?TW56N3JYaVlIUEhsSlFETEhML3R1Nk9PSUlaY2tWVzlqeVpMdk9HeHAvSmxm?=
 =?utf-8?B?ZzF0RkF2Q3pWU0RobC9za0gram9oaGlsNUdpckh0a09WS0NySUZXVkdUYUMr?=
 =?utf-8?B?RWJTQ0JSOUN1NnkxVFlkVUMrSU9wa0tWWlpmZ0pxT2l3N25pUFR1NXNQMFJL?=
 =?utf-8?B?TG1ET1E2bHBBUVY1WW91SzBEMHBuTEVPYUlMTi9hMmR4VFNhZHNobndUUGpv?=
 =?utf-8?B?bzMwVU1JMHNyblpjS3p3djZyOWpRcHg4MWc0RDhwcGhBL2JON0tXUGdPaTla?=
 =?utf-8?B?eWZNbGNIOFNFaTRxaWZNTXBsZlI1aW90czJQUEZCUmtkY1Nsb2RQQm1PQkRo?=
 =?utf-8?B?L2E3ODc2R0o5aGVKZWk2VXZpbXRjRGxlZ0JLRXpuak84WDBQR3VoNXlTaU5o?=
 =?utf-8?B?eG9MMEc5cWtGTzl6ZTRFcEs1eGlLSzZacUM4VXdXOHFTLzVLdVRpd0FiUkRY?=
 =?utf-8?B?K0MrRUd0bGlmZmZRMnYyTGpqSUptYnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6133cf9f-d0f5-438a-0ff6-08dc1b683f0a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:36:12.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR01MB5410

在 2024/1/22 0:57, Andrew Lunn 写道:
> On Sun, Jan 21, 2024 at 08:42:34PM +0800, Ziyang Huang wrote:
>> From: Praveenkumar I <ipkumar@codeaurora.org>
>>
>> Currently RCG code looks up the frequency table during set
>> rate and return the first available frequency greater than
>> requested rate. If CLK_SET_RATE_PARENT flag is set then the
>> set_rate request will go to its parent otherwise the clock
>> framework will configure pre-div, m and n according to the
>> returned frequency table entry. In this case, it is assuming
>> that parent clock will run in the same frequency with which
>> pre-div, m and n has been derived. But it may be possible
>> that the parent clock supports multiple frequency and the
>> same frequency can be derived with different pre-div, m and
>> n values depending upon current frequency.  Also, the same
>> frequency can be derived from different parent sources and
>> currently there is no option for having duplicate
>> frequencies in frequency table and choosing the best one
>> according to current rate.
>>
>> Now this patch adds the support for having duplicate
>> frequencies in frequency table. During set rate, it will
>> compare the actual rate for each entry with requested rate
>> and will select the best entry in which the difference will
>> be less.
>>
>> The existing functionality won’t be affected with this code
>> change since this code change will hit only if frequency
>> table has duplicate values.
> 
> A good commit message for a change!
> 
>>
>> Change-Id: I97d9e1b55d8f3ee095f6f01729af527ba90e50e5
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> (cherry picked from commit 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2)
>> Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
>>
>> Change-Id: If10193fc79a3c1375ab73597813745ff1f4df0ad
>>
>> Pick from https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/6dfb368bae130bee58e00ddf8330b55066e1c8c5
>>
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> Please clean up these tags. These Change-ID tags are meaningless in
> mainline. 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2 is not in mainline
> either. The picked from might be interesting, but please put it into
> the body of the commit message, not mixed in with the tags.
> 
> Who actually wrote this patch? The first Signed-off-by: is from
> Abhishek Sahu. But you have a From of Praveenkumar I ?

I have no idea about this. This patch is from Qualcomm vendor linux 
code. And it's necessary for choosing parent and calculating clock rate 
correctly.

What's more, I don't known how to deal with these commit message since 
I'm not the author and I'm not sure do I have right to edit them even 
though this is GPL code.

> 
>      Andrew
> 
> ---
> pw-bot: cr


