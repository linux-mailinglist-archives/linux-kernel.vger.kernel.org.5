Return-Path: <linux-kernel+bounces-73444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B502F85C2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83DFB22BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36D77638;
	Tue, 20 Feb 2024 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Po82oNDX"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2021.outbound.protection.outlook.com [40.92.107.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2C692EB;
	Tue, 20 Feb 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450182; cv=fail; b=EpSSv48bwKAUgD3zRHEGZj6wNKsxIxUUbswaGbL5CQAQ9GimCAlMVASYu/g+QEVvFToWasQVbcUCjgAGxullw5f2UbZpopIgULkQmuwzrBj9/zUpo/qYOV/dLbF0p5hv78IgtK0uljL4tYf1SbiC5wJY23A+3bTZrvx73k3qASg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450182; c=relaxed/simple;
	bh=1IjbZEIqSXivjdqAAzC+3/+1gqEiRSvvVdW+92nnsb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nR+/VcktUrORL4ESxOu4KyY+P+iDsW1qXBzDckLGLRVZOPWMrB9W4UXFLeZLi3hYiZw89BvthafBIJmn0k5r2vxJ2W5XaxJLMVjkgv6MQM3+sfqVzkOpoChqafKcnBM4cFrF4Cs3h1DjHY9gIb4XQQWpBvy/qiLM9mZTLLv2lYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Po82oNDX; arc=fail smtp.client-ip=40.92.107.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j66Vm4mxy9ejguHPj/yDje8eawaT3PwGhtpMO34DMxkEQ0NFvLeGCiYMScdUjoCpbirI7nKEvo1ezQohZu+NyZ0S3E7OHfaZPdLGtTrCGzHrLvVkuZ/QYBKKTMMKAU7QOExPeLc0lMtlMYIpuYvAWdfsLHaNw6HxY4aq7x1wH7DBlpC5OdZPYnT8TUhrhhZy26Moj6K9zthn9KNyiveCRGvkWBt+detsiF90Bu/UvcJfcuoDdNxKKT0dW3A/90s1Ignsl5iyAtvMdVELKEK6zDN6XAFgEzzBuF+KfaaY37Sp+Y8+aFizy+fhfiqzD3WytoGgbUW2Hto6f3r1rX3Ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhcqT6r1fm5iFddPdJK65+4y9bv1OIbZIs4p2KjXUmE=;
 b=DoqW/QePOPRDzuRJFDrqCpXloddHTudwIoiTUR8VP4wcRRwL315j/QhtkmcTBCx/i3LBMQXISSOe4orohyIRyYCygWU23y7TPk84Dl14FCy4oDZvlumQFKltj/6gMSWHxzQMq8u21HEE+TQszj51/5fqRMZpEt4QH7JdyxZwBmkJFvMO8ySNScXPfrWz9B+dF4QDwQXeEeHVPH+oCaG84eEjGDoqOoX8M90cP8J0NxmVFJQhT/PBYuXShEkfRjhZsJzlcRoOYEdtA4cGBzHC2M2w5wu2RrnTKlMtize0vl91LaHaSq5UC7PqZofYP7+i56u4J9lS13CoEqhtcLocQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhcqT6r1fm5iFddPdJK65+4y9bv1OIbZIs4p2KjXUmE=;
 b=Po82oNDX35lwlXYHXzXhBg5/b4Ufpg4YSI4urkdVlaGsKJUgHiw2szHNwbJC+t1mu/ww883RC9FTsRufTSlQTvQW0DthPfDIWLRGPnUi4d4+Tjy0V3UVV286mUzDROPiUhrkB22dEwkzId2lTgCZhS5T6f3tcOXnisef7jAgCbzMI797Kwv/t86bOBFswAOj6rTFe13AWoEEyOa/MakUdDjBNOvTCDgsekZjVkFpqoycDmRGVtQ6ivYb5UAiCyWWVotpUwKHgnRflEhDGRw7PtB5gNqSrq2ZS/m54H6Ffq/AJodFrlDaWB0M3NPeU3MAs5uIJssJ0gUvNFo4fU0EJQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4221.apcprd06.prod.outlook.com (2603:1096:400:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Tue, 20 Feb
 2024 17:29:36 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 17:29:35 +0000
Message-ID:
 <SEZPR06MB6959F718988B9A12C2D69D4396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 01:29:31 +0800
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
 <SEZPR06MB6959456E59D84C15F0C1B88396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <90e0dc10-8514-4827-998f-15b4d45d874e@linaro.org>
 <SEZPR06MB69594CBF0625989A5C54DC9096502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <3b6ab055-360b-4f73-8d11-8f52b272b7a8@linaro.org>
 <SEZPR06MB695996DD12D23D13D3579A8996502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <d59ed810-f8d6-492e-aeb6-fd8ed13735a0@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <d59ed810-f8d6-492e-aeb6-fd8ed13735a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [9ZeCBuQHAV3fTHxBegHczuWryCx57HXJ+jbeftx7/9+4jZ5fKiSqb1QR2qbABgv9]
X-ClientProxiedBy: PU1PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::31) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <025f8bd8-41f9-4214-8fc4-e718dee18b0e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f4e7e0-a790-442b-f083-08dc323981e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yFFMGqezZaSmieGMvWhM4tuGOQCIBYcU+BAAMM5Go+/CAnluKCzC5aCDgLd+6nIIRNL6mz4XaBP5eXTKtt3vemDU9KSNsFZ9mb3OnsEUR/4MSeTl5MR1IaDKhNbWFzrgpsFGiv3E+y0dMoWgygsxoqTlBVgn6VsyuBJLRVDLzNqywOLqPX0Cxsfsxmdadqm9juccw1GIlf9nYbr4uQLsBp47/7E4NxWS2p6vyDK+p3hsztyuTEYs2MDh1asi1NS0vh8xQzODZNu0Oukff9lQPkbNV5QQp5XXK3rArE8ej1ju93lpBQ7U+eu5duaRlUjG3DO259o3+Sg1dFYaQc+yovkk1FjWsWzjPm6+6h6zIgt2+qaThkCcohQqpynPfxFHZsx9F+aWb2v5TqYMLfZTQ2wiwnV7Rf7yEDlt/3v9LfNrrV1c+qgeSNnxLsJr4m2AzTf+CqC6ETGo6ey9qWmZ9iZUsQKABrRam4y0EAJMYnE7y48/ldqkbC35zUvhJv8TwlficA5BIMFndURDcFcurwn2GQUVTXwWX8AuRjz9BiF+WHcchxJnwEoaO8Q3ekuu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFNpdHI4ZU9zTVcydUw1dW9EU2g0RXFETTdIUVlNblExVW9ZWW0xUnZDRHVi?=
 =?utf-8?B?Tk5kRE5vWkJnRW15YnBjekhUcDZ2VndpWTNjNVN3S2t2cy9TdUdrTzhkZGU4?=
 =?utf-8?B?TFFaRFk0ZkRzQzhBSjFLMkNDdmtrRldFeUx6UWRlUXZqRlZMMTlNSGJDK1Bi?=
 =?utf-8?B?SGdXSG1rMjFhaHh2Um1SSm10a3lIZitCb1ovQXVOQmV1VC9Yait0MzZxb0ZN?=
 =?utf-8?B?SkRndUp1REF3QzljVmRaM3ExUXhRUFluaklxUmVONWZUcmZORzJrZERDWmdm?=
 =?utf-8?B?OUJ2S0dlNnpvQ3FDbFQzYVVXZzBCb1B6WlFqOWhNREdnUEE2RFkxRDVKRTcy?=
 =?utf-8?B?YUhCQnVTTWc1SkRqRVBBRE16dWhiZzlYTklvL29lY1EyMHM4Nk03RkJLKzlO?=
 =?utf-8?B?WDVJbGhiZGpoWCtrNEN2S1lCK1BSWGRMVFE4eDRDV3lrcVkrSmxST0E3alVz?=
 =?utf-8?B?V25iTjlPVGF4aW5CQzNkUmREREJVN3RBanZwYmRFTlBMWnlxOWUzRkR4bXN4?=
 =?utf-8?B?R3RKbDFUTyt5c1QvS1dWQXBvRUE3YmRCQWRhdnVkS0hWT1dpcjhIRXduM0Yr?=
 =?utf-8?B?QUVhR3ZoSU1GQ054TUtpcXRBdjI0cXB1OHh4Rk95YkRjU0dhWkF0Q3FkRHAw?=
 =?utf-8?B?SHl0UG9NRHI0MFVKU1Jidkt1QktDR3lodStWVVV4anBJTStGME5Yb2dJVWdZ?=
 =?utf-8?B?Nk9yd1YyOHRadGJKaUQvb0RTSVBKMXlDUzlSMjd2SFZDSHc2TjJBRUM5Zklw?=
 =?utf-8?B?RjBhNU4zamlONDhEWWRoUjNaaXNORmpLS0RGQmw2UTdvYUtUcW5OWC9UalZ4?=
 =?utf-8?B?WHVBWXhWdm1TampQMER6cDk4citMN1RRMlYzV2orcDVneUc5cG1VdTRMb3Yz?=
 =?utf-8?B?Zi9qT25sNjcybzExbTUwbU1EdjY3Z083bnNHRXFBWWFIdXZTVmhaOUt2cG9z?=
 =?utf-8?B?SnBVejZuaG1XdnhaN3F5ZFRUQi8vdzZmQnVqVm85VlVXR25GeWlWNXJmMDVF?=
 =?utf-8?B?K0hFNWo2NkxuZkdOaW5lRzIxVVVSbjhKTm5PZGhnZmdTMlFYV2hSeG03UFlF?=
 =?utf-8?B?YUpiODJDR0FPeWF2Y0ZadEcrc1hHUi9LaCs2TGtURmhHaUxoM3JYQzhDRExj?=
 =?utf-8?B?U25pM1JQRDRGbk8vcmV4QXMvTUhmc1JiNStrN044Q1BVN3M0QTF0N1FQTlN0?=
 =?utf-8?B?K2lXMVpBSGZTbkFSdmZ1NVRlSVVwL2h0NU5PbDdZTjhmazI4cDVRRkZUR0xh?=
 =?utf-8?B?bHlRTW9DeDJPTmhUYldiU05ROUhsemVlMzhqdm9CN3Jvcng4RHhLQWFNcnMv?=
 =?utf-8?B?dkE4R3gzZ3hxS2t4aHZFVDFxUXAxak1oZnMyMnV0OE45NkMrNHF1anBJdm92?=
 =?utf-8?B?WnozdXBGMDdDVkV6SWJSelE1d3Q3clFZNEt2alo2YVExV2g4VUkra0diTXFv?=
 =?utf-8?B?RWhSVi90U3BMcENJa3MvT3ZpUzZRYzV4SVk3dmxzakxXTlh4MTFNYjRnNFlE?=
 =?utf-8?B?ZWtRYTA0K1FRZ2ZLWU1udlNiemtaa2pJODZOZ0hWZnQrSE41cjYyK1Z4WWxG?=
 =?utf-8?B?S2VjZ0xFZHhiTGgxNDZFTzJBMGlxdmZCZFN3RW85aDNtWmV5Ui95RHRPUUlq?=
 =?utf-8?B?OFEwUXNoNkJVUGxwQm9SZkhYaUdVVkVnWEpieGxlMVpyZ1F3cEl6MHBmYTQ5?=
 =?utf-8?B?Tm93NndaN3g1M0VMVW81d0F0TjM2NU1jeXZ3UHY3RFo1dXl4QnZOMkZIOUVF?=
 =?utf-8?Q?gRXNg/Z5QhrcI3WpBs5Qa4LARzTRXOcOrxeadNS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f4e7e0-a790-442b-f083-08dc323981e0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:29:35.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4221

On 2/21/2024 1:06 AM, Krzysztof Kozlowski wrote:
> On 20/02/2024 17:31, Yang Xiwen wrote:
>> On 2/21/2024 12:25 AM, Krzysztof Kozlowski wrote:
>>> On 20/02/2024 17:19, Yang Xiwen wrote:
>>>> On 2/21/2024 12:13 AM, Krzysztof Kozlowski wrote:
>>>>> On 20/02/2024 15:06, Yang Xiwen wrote:
>>>>>> On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>
>>>>>>>> According to the datasheet, some clocks are missing, add their
>>>>>>>> definitions first.
>>>>>>>>
>>>>>>>> Some aliases for hi3798mv200 are also introduced.
>>>>>>>>
>>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>> ---
>>>>>>>>      include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>>>>>>>      1 file changed, 21 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>>>>>>>> index e64e5770ada6..68a53053586a 100644
>>>>>>>> --- a/include/dt-bindings/clock/histb-clock.h
>>>>>>>> +++ b/include/dt-bindings/clock/histb-clock.h
>>>>>>>> @@ -58,6 +58,27 @@
>>>>>>>>      #define HISTB_USB3_UTMI_CLK1		48
>>>>>>>>      #define HISTB_USB3_PIPE_CLK1		49
>>>>>>>>      #define HISTB_USB3_SUSPEND_CLK1		50
>>>>>>>> +#define HISTB_SDIO1_BIU_CLK		51
>>>>>>>> +#define HISTB_SDIO1_CIU_CLK		52
>>>>>>>> +#define HISTB_SDIO1_DRV_CLK		53
>>>>>>>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>>>>>>>> +#define HISTB_ETH0_PHY_CLK		55
>>>>>>>> +#define HISTB_ETH1_PHY_CLK		56
>>>>>>>> +#define HISTB_WDG0_CLK			57
>>>>>>>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
>>>>>>> Why? It's anyway placed oddly, the entries are ordered by number/value.
>>>>>> So this is somewhat broken at the beginning. It named after
>>>>>> histb-clock.h but actually they are all clocks for Hi3798CV200 SoC. For
>>>>>> Hi3798MV200(also a HiSTB SoC), there is one additional UTMI clock.
>>>>>>
>>>>>>
>>>>>> What solution do you prefer? rename UTMI_CLK to UTMI0_CLK, add UTMI1_CLK
>>>>>> after it and increment all the indexes after it? Then the diff would be
>>>>>> very ugly.
>>>>> I still don't understand what is the problem you are trying to solve
>>>>> here. Your commit msg says add missing ID, but that ID -
>>>>> HISTB_USB2_UTMI_CLK - is already there.
>>>>>
>>>>> I also do not get why there is a need to rename anything.
>>>> Because there are two USB2_UTMI_CLKs in total, at least for Hi3798MV200.
>>>> UTMI1 is missing here. For other HiSTB SoCs, there could be even more.
>>> My comment was under UTMI0. We do not talk about UTMI1...
>>>
>>>> If we add USB2_UTMI1_CLK, it looks silly to keep USB2_UTMI_CLK without
>>>> renaming it to UTMI0. Just like all the other clocks. E.g.
>>>> I2Cn_CLK(n=0,1,2,3,4) etc.., so the same for USB2_UTMI_CLK.
>>> Then place it next to old name and explain why it is deprecated with
>>> comment.
>>
>> Do we need to keep the old name? I can fix all the users (only
>> hi3798cv200.dtsi) in next version and drop this name directly. Is that
> All users in all projects? That might be tricky. And even for Linux
> kernel, how can you do it in a bisectable way? Just keep old name.
>
>
>> okay? Should i insert UTMI1_CLK to the middle and re-index all the
>> macros after it? Or simply add it to the tail?
> Bindings and header constants are ABI, so you cannot change them.


This file should be renamed to hi3798cv200-clock.h, it shouldn't be 
called histb-clock.h from the beginning. Now I have to workaround this 
in a dirty way. What if another HiSTB SoC has 3 or more UTMI_CLKs? Do we 
need to add more definitions to the end of the file? The file is gonna 
to be more and more unreadable with scattered clock definitions.


Do you think it's acceptable to create a new header file instead? I 
think we don't need a generic histb-clock.h. Each SoC should maintain 
their own clock indexes header file. Maybe we can rename it to 
hi3798cv200-clock.h and include it from a new histb-clock.h (also mark 
this generic header file deprecated and only for hi3798cv200). Then I'll 
create hi3798mv200-clock.h header file instead. So we don't have to 
workaround this.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


