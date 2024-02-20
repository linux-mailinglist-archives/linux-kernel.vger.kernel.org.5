Return-Path: <linux-kernel+bounces-72793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DD85B8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DDB2A618
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B805612D7;
	Tue, 20 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HLzItswx"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2029.outbound.protection.outlook.com [40.92.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB385634E5;
	Tue, 20 Feb 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423968; cv=fail; b=nHknpUe6KiWzO/OUX0kYngY6rINkdvBIGG0lhAu5txzeJqtZODzIDXBN//3hMnr5CyZhXCXT11CLkcwfCeDvxNAuVU2/AJAiiG4OT9s9gzHwJ0J8p+40iMSJFvOjeHxYm3TT0S6mDRessTUdk553x+xA99xKIoIHvH1unFThna8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423968; c=relaxed/simple;
	bh=EivijStO5xR+srLAaUNMtc1aMb6D4x4UDrOI5xTAyuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnvvrIC+dxeA6/+wwL8t7KgoEyxV+LR743wPp3kz7gsR3owsWGYEHkoopNQXW7rRLKW8wlQFssKeBe90hCEr201LwVf2oYSeLuz1B9/HVQcWjHSTvJ4wBvSGZTzeJAU9BPVEbtB84Yvi+7chKjjtSfirBC6kStai+/58PMjlOeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HLzItswx; arc=fail smtp.client-ip=40.92.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdue2tYhUFUJHsrB0j6o5zdvXSeaS81liwnQuT0hQkkPI1NjsDTxVsiPWXyHnJZ3NL4lATWt1fKXiFMnIv5YvYn1e6/jT3AzzgrJo75An/2U7BUtiwPQyWkWXcVh2QLnMn0QBwIxaNCBTNux8FPHPsOw5fLgg2YHDifm90Vejs16Y//fYq9De++2IrPXt8a1clKJqwhQxjPkJsGKdchSXwY8pt1ZiTwaHCuy8DYYD8nE/9lwUCc9p8jm2Ahd6tIZJA5ISiyegHCxuGoVb3Xa/7iHUrkR0BTkwyoNaUfpjpgjSvDUctWfxiRGPSh/fSTu0LDDBt1hqj450uYE1YID4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKz2AbxeT8kYvhoXLFHRF3tJa6JVa5rLYja9f/djKTs=;
 b=Rmk/EEHWR/MVFY34vAz/+ol+5pG0/CW5lBl6jICp1lkqwUGyKc2zLTGhJSbOAXurxjVn0w9bHt/UYJLNeMxH9HSDipj00gNXRU3s2G+SWSMz7Jpo8qtBDYupECS2r0kvCN9R00KlYIxvuJBhQQj2BnEoBx8kXbgN2qqDeEKSwH2QjhOTvYDuYLQF7YydSvHKz+oeKZauuX0J321pNkawlsVn489y5NimQa2NdB5EPEwfhnY20pgvyEkF4/jgZ85nkjdjcPeKFhXHLP4bWQ8fPSHF14aXeXGGfiXoGLzofBbJH/HGga72lnQBOc8r06TK+NYlWcwV5HYifLpiBz6y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKz2AbxeT8kYvhoXLFHRF3tJa6JVa5rLYja9f/djKTs=;
 b=HLzItswxpXCj8s3yHCaO+xaoSGULY2ebHC4bYTZsh9P4zl5xVyFFx+scVnGB3sma9eUEQKnN8tr022Fs+87cvpUUrIrTKuu31/uDln1kv0DR/iu9F0TMqdxXEcUoRmxxhg3IW/HDZPSQE3vbwhadxCSNah8mcT2imntur9Jk296ng2NARxJLCzXbiaxN6e/YraRnwPPxJwwgktC4hNA0Zu66WXMQk5YGsgTxEsJnVD83Xvy0kz77z/U3uvnFXD7reoFXyGNuaO6N/XOEVZlDyjF6X7fkdauWOyWa9ZVDgtxwLsmPuOu3EsQrx8XkKFdc4Kqr6ySDF1TRt2ca9YqrkA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5574.apcprd06.prod.outlook.com (2603:1096:101:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:12:41 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:12:41 +0000
Message-ID:
 <SEZPR06MB6959939E06B2F6068094DC3A96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 18:12:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
 <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [MtNTJoRgWN1QzCxomNDvjmwM1cOcxpJt90izkn63du149vKFDjz5EFOorSJydgBr]
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <72a2551d-21f4-4e29-895d-f12d251c5e2b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: c131ffc1-ff55-4e2f-74ab-08dc31fc7929
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a4HZlSyabC3IQ/FEl+Q4jMRwZclnFHB+r0oGr1HTtHoAIKNvqKy152YMWpZ4oyo77NRowpQTB1RFJVUq31A2Fh9rbLa/xagtKd1DZlMuODto0JmBnN6eNhNN6YU9g2q3cGlbGOYOeIdE5dDt/lDftLLFMoK//uyw27MrNWVi3wiVRQkDmNIzNCh2MTEx+hJEw86Nc1ToZf1nliO10Gou1Rc0ItAS1KHh/X9sktGjWukNWV0SW2/sZdW7f6GyGFD3zOY996zBFyq0HFKP0g/d+1eijmaGeepuETB/rNYXuG5jVxbQzOFwyuxjR0rlORYKFGXhPakuWvOm6m0nBdsv4hTsjhDNOaRaBlqsvdzm0V276qPS/npMRIEouXNMtWjkUcZfbe/awZot6IhC2uoBJPmXCyYbZ/j5SwMSYiqagwrWgOFrWtPDumK6Yl+CN1oUu5+Lv7VBOdyNIZ3/5J+2PsZAeUxYEeH0jGJvdqDDa2byrq8Aa++GERTcp4Xpx0yRl0+lbTIKvkIHYGdqHAiOoky67i9I6NC0dbfdvyW1PZ5BfOePivgCK9jzDcGkPfRe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnRROW44blh5TDZzQnBkZ1dHUEMwcVlYSmJMWEwvOXZETDlhRWQ4VWd2SjAw?=
 =?utf-8?B?clA0d1czRm1GMlUyMTB4Y0h6dk1ubE51cXBwQ3NVbHVadXptOFdDam1TaVBF?=
 =?utf-8?B?MGMyNHlPcmJycGN0UjBOREUrVW1UR1FCdXNhaVhXOXJ1ZU5qUThDckZwNnJJ?=
 =?utf-8?B?bnd0c1VFZDVKMGtXWS9Yc2E4ZlBQc3dPcHZHdTJYcWF3N0l1V2xzMlQ5TmFr?=
 =?utf-8?B?VXNYVUJkTEs4QmthclJzaUgrWktub3JGOFl0MVg2VXI1c0piVVRFQ0c4bFpo?=
 =?utf-8?B?emFMbFFjT1NNaEwxOGkzcmI0aFhTNzRaWk5vNUlrbE5iMG8vODNCQ1BpOEx3?=
 =?utf-8?B?WUhFQjVOaW9BRi9mcW8wd0x0NWdNaTJJc3dhRFQyVC9CWndyRlhGRVZmVDRM?=
 =?utf-8?B?UEhJTXU5RlVkTjNUMFNDTE9CVnp0VjQzWlB5WG5uSlJtMEUvNHlobU9jRk40?=
 =?utf-8?B?cEc0QVpWdlhYdUhkV054OTd4dGJ1VGlXT2Fkb2Zjd1NRcFV4RWhhWEdiTE5E?=
 =?utf-8?B?RHpmVVo4UzlZVjVNcEtUYkptYXB6Z0xyMW9VSDRzY0x2UytiRU1mc1RUb3l0?=
 =?utf-8?B?L0g1UHFxRjBUU2xvcE5yVm9BK3U1TC8zYUc1ZXJZTjF2blN5bWZLb1c5VzNL?=
 =?utf-8?B?T0tKbisyYzB6NEdWK0p0MHk0S2xjTDIvNWpOUDhONG85bDF4bzErSE5ZUm1u?=
 =?utf-8?B?TDY5N3E5NmJ3SVMycThUSzY0VkV0VDR5Y0V0ZGxmRVlUekxOYlZYekFGR1Rt?=
 =?utf-8?B?TmloMC9lMExOZUJIbVhVLzNnb0hJZUJURXQ4eE1tZlRZeGR4WFJoSmE2U0N2?=
 =?utf-8?B?NkVQZzVaTnRBYWlGVE5lTGN2S1ZuQkpaMTJPSXFNMk5HZnRyOTNDOGkrSzVk?=
 =?utf-8?B?NGJTRE5NWk1jVGw0WFBBSHVsWW13bWZEZ0l6L25BWFpRVDB1U1Z1RGNKU0xN?=
 =?utf-8?B?TXh5SVVjYURnU1g2Y2QwVStsWFNucGwrdDF2eDBjVnJGaCtUMW11OThYUUJ5?=
 =?utf-8?B?bW5ObFAxK2tqOXZUWndlNXdEc2Vod1puYUpKSEVPd3V1eVNoSmNBQTczaFpR?=
 =?utf-8?B?ODJSOGRBSUw3dlhCRUg5SUtUbXhmanM1YjdBYUpsdHNjV2JoTDljWXdZelN4?=
 =?utf-8?B?WGZDbElJeG5vVzFXMGUrZ1ZOSHROdkx3RGRDZUIzZi8ybU4yMCt3eG4wQnlx?=
 =?utf-8?B?ZGxXcHR0bVdPNHQ0WHlndEh5YTN4S2x3djErZSt6OXhjWlhDU01ZYU14Ui9V?=
 =?utf-8?B?dmVhb3o0VjNxQTFGSnVlaGk4TUNSeDVFeGdsOUZZbGRIQWwrUGxoUmk4Tkta?=
 =?utf-8?B?Q2YzT3NyVnA4RS9DaTRONG9SL0lZK0dDNG5IYUlaZHBLOWRMenpYTXkvZGF0?=
 =?utf-8?B?ZzdVd0xUa0V0N2gvaDVjeG9sbjVpZDdzUHdxRHRsRzhwWHltN29uQjh0UHVr?=
 =?utf-8?B?T1ZwRW1SV2QwMi9uRzBKVXVuU3dvZ2RsTk9hMGJKQnhTRWVaVFJSK1NOT0dR?=
 =?utf-8?B?RUJsNHpxM3dDLzZpVHpZRTRLblZsdTZrSk9zR0JJZWo2UjgzYlR2TXZXSDVv?=
 =?utf-8?B?bDI1OEE3N093MnFabmlmSWhmcXl2NXgyQmJyWlhweitxZGdJVWdiV1dFTjY3?=
 =?utf-8?B?NFREKzNaOFlrY1hFZXBQZXdoL29ZSWpEY0lXdmhVQWJ3aE0xOHZMMDFOTFZB?=
 =?utf-8?B?VTYwaGJKcFV1aDBmZCsxVHpGZjJsS2VjMVpNdURRZ1owVGJaVTRILzRkaVJx?=
 =?utf-8?Q?cxYVSHeDqFxSDUs/CUgFGXHPnLaNTkOBbWfmMpR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c131ffc1-ff55-4e2f-74ab-08dc31fc7929
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:12:41.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5574

On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> According to the datasheet, some clocks are missing, add their
>> definitions first.
>>
>> Some aliases for hi3798mv200 are also introduced.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>> index e64e5770ada6..68a53053586a 100644
>> --- a/include/dt-bindings/clock/histb-clock.h
>> +++ b/include/dt-bindings/clock/histb-clock.h
>> @@ -58,6 +58,27 @@
>>   #define HISTB_USB3_UTMI_CLK1		48
>>   #define HISTB_USB3_PIPE_CLK1		49
>>   #define HISTB_USB3_SUSPEND_CLK1		50
>> +#define HISTB_SDIO1_BIU_CLK		51
>> +#define HISTB_SDIO1_CIU_CLK		52
>> +#define HISTB_SDIO1_DRV_CLK		53
>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>> +#define HISTB_ETH0_PHY_CLK		55
>> +#define HISTB_ETH1_PHY_CLK		56
>> +#define HISTB_WDG0_CLK			57
>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
> Why? It's anyway placed oddly, the entries are ordered by number/value.
>
>> +#define HISTB_USB2_UTMI1_CLK		58
>> +#define HISTB_USB3_REF_CLK		59
>> +#define HISTB_USB3_GM_CLK		60
>> +#define HISTB_USB3_GS_CLK		61
>> +
>> +/* Hi3798MV200 specific clocks */
>> +
>> +// reuse clocks of histb
> Don't mix comment styles.
>
>> +#define HI3798MV200_GMAC_CLK		HISTB_ETH0_MAC_CLK
>> +#define HI3798MV200_GMACIF_CLK		HISTB_ETH0_MACIF_CLK
>> +#define HI3798MV200_FEMAC_CLK		HISTB_ETH1_MAC_CLK
>> +#define HI3798MV200_FEMACIF_CLK		HISTB_ETH1_MACIF_CLK
>> +#define HI3798MV200_FEPHY_CLK		HISTB_ETH1_PHY_CLK
> I don't understand what do you want to achieve here. Clock IDs start
> from 0 or 1.
They are aliases. A friendlier name compared to ETH0/1.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


