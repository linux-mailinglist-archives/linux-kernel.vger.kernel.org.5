Return-Path: <linux-kernel+bounces-92537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BE8721D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B256E1C2241C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B14126F0A;
	Tue,  5 Mar 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSUsj9i/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402486AC2;
	Tue,  5 Mar 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649946; cv=fail; b=Aa1KMho9o3m7fP6oz+XZnB9wVb5EMRCP9DxpIwDzpPJhV7J20DSahxSNe2wMCo8hB2Smvbr2Lx+46pq85JGpJgXhCYDBmod+Fv/g1e5UQxCl0n48J4ywYVznr7q/I6qbyvmg0tKXxFpPM54QVKOJ/OtZryIsl0Nd3UNEkD42cr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649946; c=relaxed/simple;
	bh=ZUCL4ofWgkmflapEPMM7WnIBqaujVrCrEIblPjPD2lY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMKmdtnAA5BnBDat9G1H+NXxtPmMG0zJa9kxbo8Wp5TVvotZ2Zmy15nmO9ej17En4N0oxu1qdESybTlNn3oTST7At/vsv19Kdi/rqxsSfPbVIufYXWirgZAKSsSrKFRe0/4j480Q+CeLvCUZJEkpy3JHSN1jgnu/ib72K2NMtvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSUsj9i/; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MriIWc6b147g3aEZZMWLb29cESjQ1Iz5/wncxTM1OJbzoJne8Yl8Tb+PNhGU1xxJIqlQ+1KBfSnhRKkqjkyJ/TLUY4dxS7tYQebGot8Wr3CMUF+pcGvOPXWhDrEEdLaENuE8vz/hXflVRF2Ixb75Bayaba3Qhawpq08ic91PKD4GuKkIP9zdViQ17lBFe4ZTmx0l3AgZEcY4Cz/iW13EQwP43XedpX7ytNydVABUY5xm5BFxSvWwoAh1HFEDkSeQXime2BoVyfI+vq6/WIrE7Qb2MuTExgW2Mqcu0IircIVaoSpwU0Grnm9vOBREyUN6lhpVoO3VXrIFvEVtFbOSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j07vYcJzn83y2DSff8TYQBlLMhbE+Ii6vjv5qBOn4+I=;
 b=bN2HLzZh4Bo/sLnFPckC0HS2Z9vgKofsgrgeOGOnesv3PWLpnCCe+P+6QX+yzvwZNWWKxeUSvbO4v8xNu2/O1cjIyzLyBK3vTWTLekELqGenSGOWH2saEh/UySMzNvHjD6LYZ+rh6Bq/6eh5WytT53GmIvjeL8oOnmlHNfqiJzUTESJ4PEODVZ2g6gNv4fjE++3VIUv8XC/8hpQTIBi/AgrfFkcY4iebteGhv0hCSp2gli9cQx0boNdafENxT/JOYXqTxSdk3tauNyuOXJkKPRzVo90iq8ly7YCHiRcHKmTLjAAGuUVm6CWWJ6YRGDlwuI7j+D8fXYD3pmJX11UH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j07vYcJzn83y2DSff8TYQBlLMhbE+Ii6vjv5qBOn4+I=;
 b=hSUsj9i/ZDkJw3qhHMc2AD9B3MBpYDQfZXxVTeWoBo0L79gUSKE6pybbRBUtZ77VZV2QsSLrA6VU3pSMDbuUc1fl9a3CdrqqSDc7y5pBoXoEOnU513fiDRFTrXDCjz6RgXGx+Kzs+50WQW3GcYLBPmNrXBME2q6UJFJksIZCCiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:45:41 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:45:41 +0000
Message-ID: <bee77573-b714-4889-9f80-1b3b27ffda63@amd.com>
Date: Tue, 5 Mar 2024 20:15:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
 <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
 <78730bb7-4588-4038-9336-eec6e2635a75@amd.com>
 <8c0efb9a-d92c-4b9b-be75-498d460f67bd@lunn.ch>
 <9a314461-3097-41a6-a264-1b109f30d3ec@amd.com>
In-Reply-To: <9a314461-3097-41a6-a264-1b109f30d3ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: b50abb6c-76fd-4dbd-1225-08dc3d22edbd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	stz3QugU/xF74gTRDZK50LQH3n/AzI9eI9/eKVi6RhNWafmAbVZxiFFk9U1pFCzQvX2o/fNBsihMf+0oBS20vebeofq9EfsAocbXuvva6j5R+MohVIMj7xZmm8BqiWs3xGTJ/4/wIhsmuJiXtOOr0APoMSqHskW36ZrWxf7kOlTHopGeC/dUpaHF+fOspKDSoNh4piGQvEnUoEiTVUSHCBGckOkUE+US/cRYmd5HlwfJ2GQez1SvGda3KU4tL/a1LDz7vXQsP+upY3odWjEan7WLsCFXTgl2M6fx4RvFGNRe65oLZZFEg6cTMMSmOvejnh75ccCi2g3DBittEjqE7v4lKoozsTsDa3Kg9tcuuzjs2pObKPHfXNj75Gr08ecaSSq+klNHzZ1bQH7AeUcIo15eMrCP7Bqoo62fY7l1NzG6CfGCj6CIwxnW8rZ7QufahnEJTxZb7QqyxJV96BLmPsUACKADXk4jM7e7AKWWVF7ZVkKoakggseGkmL0+On3vtvaJ83ShC5vwRNRbhEfP3BNNGIaqaD54cb07thfdNpNyfL0CZcqEjvL72AoS9AOAbrqTww9v7jqdaD04RmKK3wcQcsDOxueMj8Cd19iG1A3oUB1T+sKef0wpJ3mYhs5P0mkk3Xf4+AJp0Ps1bSXrdlDNl7lI3azi0p1v4BKQOFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hEWTNOWmxhRE9TWFhkOEZCQkJibVMvMFRWZE02NCtaM1ZzUm1CekRkOGlq?=
 =?utf-8?B?ZXlOdTVidW15U0padkgxWWlRS3V1UjZHb1lEVHpkZnlnRSs0N1g1Si9RUGRO?=
 =?utf-8?B?bHhwWTlZQ1RqRnBUczBEU3M2MnN6Sm5mOTZIc0tHei9nclM4amRpcFFLWFFx?=
 =?utf-8?B?NTF0aEd4WVZJRGd3UktYam9VUnNVYXMzQ3oxa3diTmh5TkprWTNlWGd4WnBt?=
 =?utf-8?B?dUFlN01ybHUydHVVbWZjbFJMQWw3eloyNnFKcDBwU0toL2JmSFdyUENuVHBo?=
 =?utf-8?B?RUdlMEc1b2tXbWxXNUpBdTlRRU43czF1dGRTS3k2SjMxWjZ5S3lTK0xZdGJR?=
 =?utf-8?B?dmRER2F1TnlqbmcvZkFvMlNrM0tUakFEWVQzaFlHbkNxOHlOLzdGdzByQktr?=
 =?utf-8?B?dS9EaGJteWFINysvMkJRUnQ3QXFUMFQ1QVVQUTErQm9zMm5acnZ3R096K2VE?=
 =?utf-8?B?MW1PRWZQYXgyT21BalBVZnI1NVZCaXlPMGVwWWpGaSsydVJEenUrZkEydDJQ?=
 =?utf-8?B?aVZXTGhnUkVrc2I5RTVBMWdVdlpaSE9xN2hFcmFBOXFjTm50c0tOcXJSM2ln?=
 =?utf-8?B?amlZK2FXYmFYM00xSnZDWE9sSWtKRFdvRDh2VVlPdTRZNGZMR1hScUN5UE9z?=
 =?utf-8?B?dlROSmhYZ1FIVGI0N3RQNi9sRXJmeTl5eGYzZHB0T0p4L1NTU0I2NDBkamlT?=
 =?utf-8?B?S1l2Si9qTGQvR1poWGIyVkdCWmRhY0trUXV3eGFzVFppaFo2REFGTTQwdEJF?=
 =?utf-8?B?S0ZWOGJDcyt5RG5jR3UwbTYvd0w4OStWbW90S3JtUlUxZndYSFJwVnVVemtj?=
 =?utf-8?B?a2RYaTZ1czJXSW8wVmVTUVkxTGI0WlZLdFVqKy9yMmtJSFF5aUZlT2V4RWxM?=
 =?utf-8?B?bzM4UnNpdVpCTlIvQUxmODFVU2poVk1KallPWGF3L0ZUR1hGNkUzRVdJQVZ6?=
 =?utf-8?B?eTRoVUF2N0U1QkFKVXJuOXFQQ1NPRFg4cWgyK3lkREJRWFd4cGd3WmNzYlhB?=
 =?utf-8?B?bUJOQlN4Tll2Smc5WC9IODFxckFzL3Uxd2RHQVR6eVFmc2ZWZnZkVDNkNzdw?=
 =?utf-8?B?YjJ0K2o1NWh3ZG1XQmVkNHY2b3hjMlB1a2pOSGFRb2JtVHZoUUx4R2hvRXk0?=
 =?utf-8?B?enFzbHB1cHd0ZWV6bUVvcVJwNEhtUDlCV0FleGIvbEtaNzh3cU1FN1orZ1k2?=
 =?utf-8?B?d3ZQdSt4OEk2Y3Z1dlJCeHVzV0JzcnVxaHdhSmFnbzk4eWgycWYrRXpIMGU1?=
 =?utf-8?B?Uk9pNGdLRm5KOHduOEJFdk9TbitONS9BazNSaU9tcFN3V0pMQ29ibjRPYlVG?=
 =?utf-8?B?dFNWc01ZS1QzOWZoaEVJUDhRTUpIaVdYR3pHamJZWW8zc1Z2WFc2emJNN2Fm?=
 =?utf-8?B?c2R4dFBCdmtCcC9xMy9WYUdQUnRoK3FXUjc3d2VNQUZxNHNJMklNNlJRblUw?=
 =?utf-8?B?UDVWQ0ZURkNOTzVYY0ZUUUxqTlcrOHk5UHNQUmpXT053TzRPVkY5dWE0RDBJ?=
 =?utf-8?B?NXNWMm5PVUMxMXZCZ1ZTWHZEYWdObGliNytpeDVZYW9yQkFNK1NCWEdaa3hv?=
 =?utf-8?B?cHl4WEp1djZta0N6bk40Y2w5Tjh1QjhkY1NHVnUrbDIxeGJMeDVsWFNQdU5x?=
 =?utf-8?B?N2dTamV5U0U2cng2YmY4RUhMNWNhWCsreEJTcUREcDZjYTV1SUtYSVB6dlFZ?=
 =?utf-8?B?MGdSMkxuMUtBbXhtNEtWemJiSXZ6dzRPTGFNY25yM09LWmJIUmsxTm9CTDFm?=
 =?utf-8?B?d1UxcWhRdTQ3NHpTL0E5Mi95U2ZJTU8vU1d4VnZUSTRJLzYvMGlsV01tWjBJ?=
 =?utf-8?B?MC9BUzNTM1ZpeXY1ZzFDTVVrYm9KeWZicjc0YmVWQ3dKMmNPSkw4Q1FvRDRW?=
 =?utf-8?B?NUZlRVlsU2tPMzdZSWVDL0RrcThkTXlDM0p5c1daQmk3V3VpcVZiOGs5VDJq?=
 =?utf-8?B?MkJ2dm1RMXJrdE1hbkJLMnBUSDhjRGtOQlo1Lzl2TUtUVC9kWmJ5dENBbVQ4?=
 =?utf-8?B?Ty9SMTJocWpVbU9Ba2FXUTFITEZrRlllbXNCWkNWenBneEd2L1FYVkUvUkJZ?=
 =?utf-8?B?R0VHVU5NdnFIeFE4VVRrVFVGdFpFTmVMclJ1Uzc5b2lhN3R4NWFjTFQ5bUtJ?=
 =?utf-8?Q?zg+3a93bZ1Skh3FT8SKHlKiHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50abb6c-76fd-4dbd-1225-08dc3d22edbd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:45:40.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEj6VutOupeJODgBII66+oPJVaBQE7MWFgj7rKhvvaqkF3gbAPHudpnQmnW9QNCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

Hi Andrew,

On 2/27/2024 10:34 AM, Karumanchi, Vineeth wrote:
> Hi Andrew,
> 
> On 2/23/2024 6:56 PM, Andrew Lunn wrote:
>>> It is not specific to AMD versions. All Cadence GEM IP versions have the
>>> capability, but specific vendors might enable or disable it as per their
>>> requirements.
>>
>> Do you mean it is an option to synthesizer it or not? So although the
>> basic IP licensed from Cadence has it, a silicon vendor could remove
>> it?
>>
> 
> Regarding that, we are unsure. However, based on observation from all 
> previous cadence IP's in AMD Soc's, this feature was available.
> 
>>> WOL was previously enabled via the device-tree attribute. Some users 
>>> might
>>> not leverage it.
>>
>> This is not typical. If the hardware supports it, we let the end user
>> decided if they want to use it or not.
>>
>> So if all silicon should have it, enable it everywhere. If there is an
>> option to save some gates and leave it out of the silicon, then we do
>> need some per device knowledge, or a register which tells us what the
>> synthesis options where.
>>
> 
> I have looked into all config_debug* registers of multiple versions 
> available with us and there is no mention of WOL. I think we can add 
> MACB_WOL_CAPS to default_config and advertise in ethtool by default.
> 
> Please let me know your suggestions/thoughts.


Adding WOL caps to default_gem_config is not effective.
The individual config is overriding default_config.

I only see enabling WOL by default,
- By default, Advertise magic-packet and ARP in ethtool.
- Always set device_set_wakeup_capable to true.
- "magic-packet" property is no longer useful.

Please let me know your suggestions.

-- 
🙏 vineeth

