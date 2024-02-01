Return-Path: <linux-kernel+bounces-47711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E8B845191
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FC71C23624
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DEF15959F;
	Thu,  1 Feb 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OybueztM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1541586DE;
	Thu,  1 Feb 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769688; cv=fail; b=dWC1+nKNyuYtWUCwcS8WoQ6NiPtXwEcS1ws2lBh3nk+6SOxZtHdfIAdw1eQ9isgUg++Pd2NdzRKymK6pu1x5CG7iAp2X/KvpMKq4eIf5m/t//wrA1pXbOHtd4iuICY84m0FP1f1MB41p+CF4WA70yFM2HU9thvQvfZ7ETyFI92U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769688; c=relaxed/simple;
	bh=IBjN2CHT5/O1ppY4iEeqA5CVoxIVBSFpK+imrH/IZ80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbZuhc8QWjUT7zm70VUBd8mem6nDQX89cyK5U6gXWrx+ZE3zofUD1H+lVZz5uS4tFpH4afJ4PwQ5qRiLXIOcyi9srZ3dODtx/44uXRxMzSttocg7DV1xfIYcSgYNksd1AvAjC7Vik5WLLtciexbzHgW8Vqy1pKijhE8JAMbhNpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OybueztM; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1ZAloIQgvSIfDVlVBBzwbuHQUIvIYTpYy0RGmnnGFilbPO8VaYz5oXPmLqN3138xBalobDU6Gh+7jUrMoRN+e573rMvFG3z9MEQrumZx0bYZ88ZlR0GXOmdhMEwySZJhmO/FuBBf2R6+9Hb385DISSgg2Q/0puL64gXa3hzWZSVa6KFr9mqgcEqiagRNi7wErxKwzYZHxTd/CwhO/hDCJVwjC0NedJX0UhZv613vo81YFlvErhnkfCJGbmKtIfHVmILeVR4xPxO5EP5uEG3iSfcv2hcuLYXNVq1KO4S2hIjAu9ojrnzJh0dDcgynccqmY4mZuZisUjoLwSF4vO91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVz4ssz0UzueaQc/yHXGq3apYsucao+eay39ooiqJdc=;
 b=OA9qu8sq8eNKy5+NAC1TsH5uRf6jzEx1I4ALADMZOs9rNqyH3pexAJkFr6BDv4aUajFwdpdfdg3HkYyBygk1XalnY1Pd+iDJMKsjY4bHsZ/R5TuyLJqt2LDuq697evlCugz1t/sKYCCBnwmWK+gFe33wnrkDbkE4PJjPu2o0cHPPBvSuvA4weOifj8pQmFwdzoKdZCNsFcSkN+RbwQy63mnWRbEu+fum9iZcfLjNMhlfC7KcQ7T5UGq/cCmZd8mctUKuQ4PmKQPB3hZQxn08Cph5/+vytmRi/oas3RKMan5F5ByZP5CPCRA+Ft+jsQ4NZ/J0XOf6Pc0KAhDNzGjA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVz4ssz0UzueaQc/yHXGq3apYsucao+eay39ooiqJdc=;
 b=OybueztMHcj8TLzcmW8hCPvVIwbybBgOmD4feIJ5s7UZboEhBCjdPIRkXsxmkJZRXRvv3cQ+ndHFKnCvDeT/odGp2BwmNW6WfPRtzwxXao6ie2wcPvKcsMzWUWGv+QNTK1/N+3gKb/72U+SWE/hCe8NAfyLwERlycfzk1zHhUew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 06:41:23 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 06:41:23 +0000
Message-ID: <7a063832-e1b5-42df-92cf-66486d4feecb@amd.com>
Date: Thu, 1 Feb 2024 12:11:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
To: Andrew Lunn <andrew@lunn.ch>, krzysztof.kozlowski+dt@linaro.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
 <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
 <9b4a2c23-5a96-45eb-9bdf-cefc99f25fec@lunn.ch>
Content-Language: en-GB
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <9b4a2c23-5a96-45eb-9bdf-cefc99f25fec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddadc05-1f7c-4c77-23ac-08dc22f0ce66
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FCJa6Dazbm3bdRsfLI1rWnzAW9DSXyE+tfK02GwHa8qkfxMYdCZXWEY2OAHM6sDg48SFwRTw3ZRUBZ0xCSxfejKQLr+ReuE3eX/yu3NqhGbWGVYtPhIgsaDmRw4x6G4vYQoWp/VL7g1o9/9ICru9+hz228klnoIpN8yFsYesT6pNeJNRDbnH60Lc8RwD8VkytdkVXAZAFLU0UUli1c9owjQZ0xnKJTdyWEZRlvE1N/KzifpMBn5Fowd0j7Mxj8vUhNe0TqP6s2nkKpeSHEkHph2AgDPkQUbViuvALGhEpnq8qT5/rqIDEhekTIFy9iGuZlMGGar0Ml2WYUe5Hi5dk9hao68RJ+omNpQg4w0wi4ngHTpu6alHw3YlO0CUDLYmiw/i5kqp9bGHkZQ8+VxKBON8HOJYLd+aV2awNLEYchoTl65ezG/Ivg8d6Qjv9cSGpZLpJWRECEtNufoMx+ovJiLmfnWpNlF5PqtFp9V3GsNMewb1sNTk4qEyG9Pl0H/ZK5C53P2lVg6Yegkv58AmH0AQ7RRWm8Gt5Jf69M36HVlRxV6heKMFvfUohBZtZ/GwCDXi3wEMeSwa+bZNVXDEwjchduwzV2zCzv23f5sZQhEdUPqnjtPsEs+RZK6t5V/yxQFfhtOqXVZzB91Rq2HJMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(8936002)(66946007)(8676002)(4326008)(44832011)(86362001)(5660300002)(31696002)(2906002)(7416002)(36756003)(478600001)(38100700002)(66556008)(316002)(66476007)(6486002)(6506007)(53546011)(83380400001)(6512007)(6666004)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXo4cEovNWs4NS9DQUUvTnBTSU9IODNmNUtRWmk2ZnpKM3VOZS9KVGFIRzZQ?=
 =?utf-8?B?VjhtQ3Y3bU16ZVVFWlFVWm42NnNkK2NuRlp1Yko4NUVVYTZmYVEyRXNUcXlX?=
 =?utf-8?B?VHRleUFZNmNzMmdzRkFaWEpCSXBaMkpuNVRyeWl3SDI4M2hzWHBUMnFLaU1q?=
 =?utf-8?B?MHpnZWFSSTdPd1VIV0ZVU3BYVnJ2cDZraHFaakluSDlkeG9SOHNLY2dBaVBl?=
 =?utf-8?B?WTJYQ0taU21CaTdlcFVkVkFtd1YyYmVIUGwwWWVSYTNDQjVaSzhqazRYdjRO?=
 =?utf-8?B?Mm9yMndDUzBwWVhHRlo3OHNKVjA1SnMyMDJ6UjIrL1VQQlBrdDVoQmVnZVFR?=
 =?utf-8?B?b3R3bW9VdWNBWlovSVc3aG00NUdraHVwc1ZMRHJ4MVJiMXdkYjU4czdlRTRa?=
 =?utf-8?B?SkRCWnBCaWhUM1JqTU5iRWNWOUhuYXh2VHlkODJWRTF5Y0VKSWtobGh5djk3?=
 =?utf-8?B?ejdQNXB3V0NHRjM5SEpEY1VhazgwS25JTFh3OWxhWFhseVZMeTUvaVlWMk5J?=
 =?utf-8?B?aW9kQ243WjBpKzVrNkt1Q0ozUGlidXB1MDhYZXdhd2wzQTJtTE5jVzgrL0VN?=
 =?utf-8?B?WjZuQzRLN28xSFB0dzVsYWhiUzNGa0xkTnVrelVJOFBBTnlVY0tVQWRoS28w?=
 =?utf-8?B?YnYwNDRFRzZTbnlUbEVNbVBTSXp2RmNsaU5nK25IaWNIeEFXd2ZibkVscDJ4?=
 =?utf-8?B?dW94YkwvWlkxOG85R3BhNGIxSEdpbytRTitkZHVISkFNd2RPblovL3FsaXRO?=
 =?utf-8?B?ZWpEaFJEMUdtN1Jva05IbURsZmVFYjZQcVgxMHFxTTlDTGFueGg1cDBqZ2M4?=
 =?utf-8?B?ZDJLMUhwT1VMc0ZSc0Y4RHY5d2RNK0N5TzlwWkN0NmsvY2R6N2w2STdoSjhF?=
 =?utf-8?B?MGl4alFOTHFBbUMwcm1hMnZ3Q1JNazl0aEVYSkVNNW1raFRmQWh2aWd5aTZs?=
 =?utf-8?B?bTR0QzFYNWl2SEJsNHAyTGZPVjNGQXBzTWFSK0lsUzNPYWJmOUI4RjhIbHdj?=
 =?utf-8?B?YUVTMFNNQXc1Y1g2Qyt6NU5XcG4vWlhldVI2S056ZEVOSTd6aVdZZkQwS0hU?=
 =?utf-8?B?VnJUN0I4bGkrQ1ZPQVc2TXVhRWFtTWRaalZUeVFGOU55TDZrUUFUSE5MdFpP?=
 =?utf-8?B?NFhIZE5tem5WYlY5d0xzQTZZUkNMVnNCR3FvYU9haVVxOWZaOURJYysrOWg5?=
 =?utf-8?B?eklETGhlUjJaYW9EaG55NkpwS2Q0cVdwaTRiQVJPSFlwY2tOZjlJa2xlMVYr?=
 =?utf-8?B?NnpwRFNLbVI5NGJFVGlSeVY0aGN6N0ZDandXalkxTjk4R015TjZJRGFqTkhh?=
 =?utf-8?B?aW9TME5UaEt4YVEzcWVadTlDbWplSFJtRTcyNmxDT1dHVmxQbjBxdlNFa2xO?=
 =?utf-8?B?SXZyc2g3VGxGekhkblpJajNVUDR6Q3ZramoyaGE2VkFMejlGZENnaG5jTVY3?=
 =?utf-8?B?VlZES0tlUlFIQ2tiT25BNHBmVnJ0bndKNVlsNVhXRm9ZN1R2RFF4Z3d6WjBD?=
 =?utf-8?B?RkdRZy9vZUpaTUJzejdyTDUrcVZIV1RJRTgvbFU1VDdPSVBZcXFDR1NyUUhN?=
 =?utf-8?B?cXZYNlh4NkZLekoxUndYQlJwWTNIZkZQaldPL1lncTVlMllVbFNsc1I3ODRj?=
 =?utf-8?B?ZVJWS1ZaMTI5SWYyNWh1YnFxN25pQ0U2RmtDSHlqMjNWNGxLemdhUFpDWURI?=
 =?utf-8?B?Qnp6MkV4enFleDJ2M0I0Skd3Mlc1T2ZkK0FTUitaSjhHVVpjRnFCWU1yanZx?=
 =?utf-8?B?ZnNGaUFxdW1EdXp6Qk52MUVKUFc1a2dSRUdPdWozeUN2cVRJek90OTdCdUM2?=
 =?utf-8?B?a3ZEdjk0WWxhbXJMZDJlcFQ2MmdmNlNMQ1pSOWtLcGIrbVV5NEU5N1FWQ3Bp?=
 =?utf-8?B?SmFhRVRRbEJ4V2VEZ2xmcE8rSkliYk5Fc1JlZE92b3hVWXZ4RjFTWFYrU2Y0?=
 =?utf-8?B?endqRC9wajcxUGpVWHdpYXE4aVpObTY1UGJYV0NuT2hrOEFabG5aTW9HRlZM?=
 =?utf-8?B?OU8zOTlSOG5tbFJNRDZVQTJ3K0VSK1AyV09KOGdNRGREY0k3ZFVZNjl1eUNw?=
 =?utf-8?B?MmNsVXkwUmFqUjhBdzBoZ2srNWtmWFBxRG5vSlVFamNaeE92WW1HNkxBSXZX?=
 =?utf-8?Q?DvQ3hStlZg528/YEvHIPFHRKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddadc05-1f7c-4c77-23ac-08dc22f0ce66
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:41:23.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY0z4H4dwfHN/PMgx7nDf/PSxEs5maom2UYWocSIQ8mvQ9cyPLVRSde0uI2mWo/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

Hi Andrew, Krzysztof,



On 31/01/24 6:48 pm, Andrew Lunn wrote:
> On Wed, Jan 31, 2024 at 01:09:19PM +0530, Vineeth Karumanchi wrote:
>> Hi Andrew,
>>
>>
>> On 31/01/24 6:56 am, Andrew Lunn wrote:
>>> On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
>>>> "wol-arp-packet" property enables WOL with ARP packet.
>>>> It is an extension to "magic-packet for WOL.
>>>
>>> It not clear why this is needed. Is this not a standard feature of the
>>> IP? Is there no hardware bit indicating the capability?
>>>
>>
>> WOL via both ARP and Magic packet is supported by the IP version on ZU+ and
>> Versal. However, user can choose which type of packet to recognize as a WOL
>> event - magic packet or ARP.
> 
> ethtool says:
> 
>             wol p|u|m|b|a|g|s|f|d...
>                    Sets Wake-on-LAN options.  Not all devices support this.  The argument to this  option  is  a
>                    string of characters specifying which options to enable.
>                    p   Wake on PHY activity
>                    u   Wake on unicast messages
>                    m   Wake on multicast messages
>                    b   Wake on broadcast messages
>                    a   Wake on ARP
>                    g   Wake on MagicPacket™
>                    s   Enable SecureOn™ password for MagicPacket™
>                    f   Wake on filter(s)
>                    d   Disable  (wake  on  nothing).  This option
>                        clears all previous options.
> 
> So why do we need a DT property?
> 

The earlier implementation of WOL (magic-packet) was using DT property.
We added one more packet type using DT property to be in-line with the 
earlier implementation.

However, I echo with you that this feature should be in driver (CAPS).
We will re-work the implementation with the below flow:

- Add MACB_CAPS_WOL capability to the supported platforms
- Advertise supported WOL packet types based on the CAPS in ethtool.
- Users can set packet type using ethtool.

Please let me know your thoughts/suggestions.

🙏 vineeth

> 	Andrew

