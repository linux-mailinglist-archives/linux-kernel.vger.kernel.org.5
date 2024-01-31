Return-Path: <linux-kernel+bounces-45921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F818437DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58506289A14
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA25DF1C;
	Wed, 31 Jan 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GTYhFukk"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CF5DF17;
	Wed, 31 Jan 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685807; cv=fail; b=u8kY6vmziaYxedOHiOWX5s9/kpcS6h7/gDl4AEsMc5qXWvAdbRvrPFPxnALIRHwT84yZ1kx+8liHYdovuFgJfLpzAYt5llZpudSbj3bqOmmR4pBcZzbv0ZRpKXKixhcUvgIcovrsQDfTZ7wkC2C1Fb5zyijwm3627thg1Y7o8ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685807; c=relaxed/simple;
	bh=ePZYUxhjQwXMSrxI23vOjcoO9konj5cWE98gTj8GB64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5USl7nCNCWBBjgCxRqEmWQ0s/9+QCswyHsDh0lQCzI0rmaUc90BefPR+F2NP4+D4YWIbmT/gBqZrL9TYyao1DIwtQ26nzuVwc/cuXo5Hno50G2BQxzAbB9UbAqhzCpV2T0odwf3dgpGiHmtLUqZbUXD17weva+OROXVnocpXyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GTYhFukk; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FivzFalnSgJFvddjgu+5SCVXmyYaOxZqtkxFVzsm7XpBu7As2gzPvxplPPXkOQIZoLmtrhN6TIjXwi4SoBqxwqENTL7K99eR0DzUUPTjotgdVVJ2QcrvXC7dNYRtSs9zBHuNnb8/39vtVstROA5Lx9ySSpF/fAPWVmH5rpP2pdHO9o3NpEzn/pB5qWzENLMd+gGIJ4xGZ5soEPqHe7gNP3wCv8uCd95CoJiukGBgbZtuNpHKTkmMxEAcDdalPjOeRyecjXQShvfab4JyE9Z8Qs7DlJjVKjZ1azJ/LC1DwKWW/LQRidRq2dCKwewerS4Jt37Iyw/zzhVIeSlSCR+adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/HGS/ySax6AXEje74So19UMHCH2y6cgVR6IK/9Mxao=;
 b=oOhfaIt3RpuiwugdTxm/gqmEqLf+8fnGXt36HzgWEK6RwC7Ui0MUWzwyObphpdY8KnH5fFBOqj3nJpKcXV1vvlYRWU8PwdAcwscGqn/N4K6VLpvocLf05qgcinyOh7d+JtDBkRnok+ZMdIEC+3Ml8a0D5hOTpZkaDpGf6WismsX6+gdFDHwpSjxagaOpgz2fNBDppjZG0fKK0GpcsgU4YW0dIWbveQsAq3D6B3vHAlH9ldzeMhzQ2yOx3N4P9Qe8wHu8VuyTdUN1EUOmxswEOfe2vT9/dYRswaaAVwMtwNu2HyFEyP74jEmYACUsrpVrTdxvdBlp2sRn5Mq5my5aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/HGS/ySax6AXEje74So19UMHCH2y6cgVR6IK/9Mxao=;
 b=GTYhFukkPu9LOPNrArkqIgV6t77irfl5tkKTWzGRBLKL18DnKLABo1MH4JoSQVB/Hm8v5ISwdydqw7yqRLCqppcADW40yR9uiM9TDIey/FY8sMymcM7Dgx8KkUUROodbjXDZGZ6daF3+jyrKpUWxDKPb/U2xCKNs3iNLGrofTa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 07:23:21 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 07:23:20 +0000
Message-ID: <279fc3e5-8470-4c46-ae42-7d345555a209@amd.com>
Date: Wed, 31 Jan 2024 12:53:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Content-Language: en-GB
To: Conor Dooley <conor@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <20240130-smartness-relish-d7f13adcb18d@spud>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <20240130-smartness-relish-d7f13adcb18d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: b617cdf8-8d16-465e-ba69-08dc222d8089
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cnf/s3AFizDQyS5O2U8MdpDjblpZTjuE2eWpw+Z93vt0I0NdzOqXtANFRFjsUdSEgVCbzNLrbE0zuCQlt/qxc19YwtIt/1LCceyfQXruTygnql80GE83D5d9ZNbTRs0tqY2mruNK01ZMPf2ATB3ZbLcxyHrv3630YcDPIxhE9d/UJRnbf5VTH+jLq8s32Q/CUXK+FxMuvgYSWRtpkm0TBHCiKVdnlyFjrpIOtKfELaaxqrzhDBeFQ+SIu6ayQNSwBCYKcyKJz1dwjnPTix3uTbSoxBjKDjN4iHIo4dORtmfChLle+7xvR7KWkMMYDjGQhNo3khOgaBkEyuko+q1ibRHWqezHV8WZhsCtv1B+L5d/jfSJif5V2B002MuXmNbd9zyIncvBwvDkE+t7DxPb6nzy7gXSffIeSpvn9WuYFnzTuMaWDE0ongthXFwRCdE6Bth5Rzgasio/QrU70oEpNxGbYZG9+wwEk6/tqlC7Wfzcx94VWp5jwlR5YphKt47ROSalIR5aR1lDaUzKav+B49WDLOdnKTb3zI0j35YLSgXbVWeY0nNolupvM/jhVpFxxqGCrC89arA81aAuDq9pF3BAQ+Z/iDlVJx5P9CyPA3eKcHP0fefd6JcMGxXedTjKe7sIuytBvbxSGNzcADwDhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(66946007)(4326008)(8676002)(8936002)(44832011)(2906002)(7416002)(5660300002)(31696002)(86362001)(66556008)(66476007)(316002)(36756003)(6916009)(38100700002)(53546011)(6506007)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdqekNPSFNYbUlQZlNXM3ZnQzI1U2NxSkRJcHh0MjU1M1E2ZWowUHphWkJa?=
 =?utf-8?B?bHhHU3JWVHF3MG9sZ2o3TjJYdHVvdGI2OXhqY29GQnUzZ1VncU56SjhYOEpP?=
 =?utf-8?B?clIvY0FWSXh1WEJRYnU1cmtRSHM2czI2Q3AzOEZmTkJHbXd5SjFDOG5ja3k3?=
 =?utf-8?B?VnVhMlVDVkZXOEtnNFRxM3MrdTJXb3BvMUFYSkZTSWlZRmRSSUhaL2hWbmph?=
 =?utf-8?B?dnlraEMxRHdrVE1SZGRFQnhMYm9Mb0hySm1ZMjN6WldGWmJ0T2ZkMDM2T2Rv?=
 =?utf-8?B?MzBVLzNpSFZGaWtRbjBqOVE3ZDdxTHBZeTZDMkIzSFpEeHdrdFlhY1F6Um9N?=
 =?utf-8?B?Q0tON2N5a1pBMzByRVpFWEtmMVBreE5FVDgwT2dwZHp3TXhBTFo1b3BORGov?=
 =?utf-8?B?b0MrQ2hWNytBcHBIdnB2SVBEM09mZktIbE1URU0zNVhRVUI5RVZpejkxeits?=
 =?utf-8?B?VTRBRndyNHVNWEJKbUZZS1N1MTNJL0R3QlNNWDJsVWh1QktZM2xoUldlamZO?=
 =?utf-8?B?V1A2YWl5WEs0UjVJSVdOeUJIS0Y4TEtaQ0tWZEQ1WVVEOThFVVhoNGsrckl3?=
 =?utf-8?B?MU1ER2ZUNXZKS250cFdka2N5Qkx5QjNmejQ2K1l1bzVJQzJJL0tVekpVZm9h?=
 =?utf-8?B?MlBOcXNHZW15b1JqWk1IamJWaWplM1Vkb1lybW1GWjBIdFBoNWJaSDdtQnN3?=
 =?utf-8?B?OVJvMTVxYlVkd1ZMVWFHQ3NZR3RhbFprZE9QbldJVTlMSlQyditoTWh0UldX?=
 =?utf-8?B?eElFU3BXZlhQSmtOcDJkY0NnRjVaSUdURmMzcGU4bGpvNG94NFJYanY2c3F5?=
 =?utf-8?B?YUwycTJNMWVrbWhRVWdEaWN2OEY3WXlwN0p3MzQveFErMTREa1N2Z05BR0lh?=
 =?utf-8?B?NTFNMFAzSkFuYXdsNlVhVVN4NmdHNFJMRnhzUTJWQ2pPUS8yUW1MbDZEZXJz?=
 =?utf-8?B?Q3ZoRkM1cFc4bnhiOEZ3dEF4clArWUt3Y1RTaWpUK3RCeVMrdElWaXM4dFZk?=
 =?utf-8?B?TjZ6cHNPbWxFNm1RYVdXWUR5YURQbGxMTVh3ZXR4ZzJXckFFL2l4MHRXMWEv?=
 =?utf-8?B?OFVDSlQ4NERsUXgzdG9lRHJOaWJLTmxVRzBkeWoweFhDd0MzVDV3UVMyWGdh?=
 =?utf-8?B?UGlnaUxPQk5PaUZJRjFwVEQ0SFRwbEF2WHdIa1NjWmVERXpieURtYkIrU2JN?=
 =?utf-8?B?UUZaOW1ZeGd2Yk1sam5mK0k0Sm8xeGpNbkFKcVRQQlF6d09BZ1Q2em1KNjJr?=
 =?utf-8?B?TnIxNGo1cjhNWXpUK0ZOWkJPdHhqQ1M5NXFqMENOVm9VQVVWTmd6Y2ZQbSs1?=
 =?utf-8?B?dHJzeGJCMkxmaE1kdGwwbG9vOTZvNVR2T3RIdWU2Rk9hUUhLY1FadGhYTExq?=
 =?utf-8?B?c0hOTzVlN0RLcUVzbDk1cFVUK3d3SStjak01SFNMT2JDOUJRTUw0RGdVOGdq?=
 =?utf-8?B?ZzhhT1F1QWZrYndzRFhLelJEV0Z0VUI5UXp6M2ZuYmhiWHFRMWZrV1Z6akFD?=
 =?utf-8?B?M0h2TWk3QXhPdDRXTkhVR0IwSFFoa2xUa21aRW9veUQ2MlljemNFRSs3c3c1?=
 =?utf-8?B?TnFMMUxoR05iN1JPUFFLemFKMk1TZ0VLQmxzZm4vS2RuK0tveFYrMklUUzJF?=
 =?utf-8?B?TnkvNkduK0xvaUtWbjJkcUpYYWx5WUF0RksrbUcrdUw2OStueVNFVHJWRVgw?=
 =?utf-8?B?RzJ3TDJxT3gwTTRKUzhpbGVIYUdsRVNRaExpbUp2WGFUOHlIcFdOTE9BU0RH?=
 =?utf-8?B?SkhDdlNWTWF3NlE3bzBValNjVy9BSXAwUTZNNkhkeDBOOGZXc1BoSlhFcVlP?=
 =?utf-8?B?NytwWkpFMUpmcU1XeVo0VUhJbVpiTE4rVkZYRG1KeG5OVmE2UTd2dzQwYnZ0?=
 =?utf-8?B?Z2pub3UzTFVBcmFadHRtR0EybHRNVDlUREJIc1E4TWpEbzVIdXdJOW41M1dp?=
 =?utf-8?B?d1BFcnowdVhKVEtseXAyVXdsK2FMbkc4cXpTclFDN2hKMzN4WVpEOGdYNDhR?=
 =?utf-8?B?Z2FINS9pWDdSbTNsL294UHdPTnc2Z2F5RWVraFArcEdTbTJtOTdtZ3p4NWtQ?=
 =?utf-8?B?TDJzMms0aE5la2U0Mm5qV3JmaG1WRFZUSnhLTXRPVVVqZ2duUDNTNkxnZGZo?=
 =?utf-8?Q?llRkcnx9+ouc3Z/EG4oinOR5l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b617cdf8-8d16-465e-ba69-08dc222d8089
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 07:23:20.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOmSF5dRah2ol3x2Pl0ZvyTh8lKQHfLb7hqnXWRHHecpkJviA/kpHbTiWs+viFG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

Hi Conor,

On 30/01/24 11:00 pm, Conor Dooley wrote:
> On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
>> "wol-arp-packet" property enables WOL with ARP packet.
>> It is an extension to "magic-packet for WOL.
> 
> If it is an extension to "magic-packet" why does it not depend on
> "magic-packet"? Are there systems that would only support the magic arp
> packet but a regular magic packet?
> 

The IP version on ZU+ and Versal supports the below combinations for WOL 
event:

1. Magic packet (Wake-on magic packet only)
2. ARP (Wake-on ARP packet only)
3. Magic packet or ARP (Wake-on magic or ARP packets)

The existing DT binding already has one entry for
wol via magic packet. We are adding ARP packet support to the existing 
implementation.

I will change the commit message in v2.

>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>> 7c4a1d0cfdc1 net: macb: make magic-packet property generic
>> which added magic-property support and wol-arp-packet addition
>> is similar extension.
>> ---
>>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> index bf8894a0257e..4bea177e85bc 100644
>> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> @@ -144,6 +144,11 @@ patternProperties:
>>           description:
>>             Indicates that the hardware supports waking up via magic packet.
>>   
>> +      wol-arp-packet:
> 
> Bikeshedding perhaps, but why not call it "magic-arp-packet" if it has
> the same function as the other property here?
> 

Magic packet and ARP packets are two different wol events.
IP supports configuring in the above-mentioned ways.
Hence, I think it would be good to not mix with magic packet.

Please let me know your suggestions/comments.

Thanks,
Vineeth 🙏

> Thanks,
> Conor.
> 
>> +        type: boolean
>> +        description:
>> +          Indicates that the hardware supports waking up via ARP packet.
>> +
>>       unevaluatedProperties: false
>>   
>>   required:
>> -- 
>> 2.34.1
>>

