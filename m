Return-Path: <linux-kernel+bounces-58285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C797084E40E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB3828255C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA779940;
	Thu,  8 Feb 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zyNSJGHS"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D66BFB2;
	Thu,  8 Feb 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406112; cv=fail; b=jzGwHY/Q/jOGo1Slm+PJz8Pys8ifMlsy3pKru4JI9tRQ689w1boUasVRXzPfRWQqGqAkrwmzw0V3rg+WgxpV1TR19/jQwa4lATfyj15LmsebRoSanxsGgBMR9bOsatrPTNhZqAmvvLtwJcqAQ6LMcbf7ZJ9EWy/yFMZqI7il4/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406112; c=relaxed/simple;
	bh=yrMS5aSKswsr2dHmcKmPZhyeh5ZME2X5j4p7LA6fva8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B495gA1SyMlkx4A97PHLKdeSx/sTGbJNv+TT2a//9caP/wwbHt0EyawJemeLpUr7dTvW8SRmgX2+mL+Peu1TXkXUAQxBw+tLwL/3IhuduiyJawAqlNL2QhrVfVPkbvWWY3zQ9hIkbhgFTJpCLXbkSsVWK8o0FjaRcqsBLRT5AHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zyNSJGHS; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM3CQABHHVKwxPLk1BjEKDDUPoneSPMD3RHBFEzPzr/T7ALbxCwn1apDjj06Om1xB73l4G+Eacdfbt+M5T/DIZYZm2rdW5wF4nh8OeV35gzOKppra0+zvSnhnDX2Zvic5+alOL1I7BN101VFouQSVRv8yuC1T4azpEPDhAMz7Ad7kKkqHjHqEk38S3u+m/kTvmGVr5GRQ3+XCsq9zGEQHPJni/yEJwbbgC/7WAFFN0Iqp/6t6Ti55tA2+ZDaEjY6Ic7CXxPLQ01j9B756UEFlrT4UzO6UH2EXHYWevNm1RjiJ0sLRgABijAcDiHiryXlkZXALDnuWIVDL3wSqaLk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DozVR33bEqbn1ug4g69Ss42Ef3aDeClTcLFMCobSrVQ=;
 b=MC7FDwqc7qbSlCKAZXrj4/oRKdjZLgG2TbeyVVloNqenaoP0lR9SYl5uP2mAyssn4UmsZPLdZmfgqKlIX8GMu61hL4QxNRQHnnOVSTv2WysosO9QU7hQ1ldFEl1MUDY65PAMEUcoK7I8XW2s6zrRcttajQmX0ky9VYATlTT3/OUqd+UqMqZ50Pun0dnJFhv2EMmR1TYIimy87NF9vxaUW+dwFeqvWeCy+cbPQsst6dT2pHsnyk+NocFrse3dronBKEpdo+8wN0yKSyOyEE+cBNtGLigOyGB7YpMwrnon4DaSbLZbZ9yHEDwmjpuRApWAOnxrEOkSv1SZ4v9D8WWZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DozVR33bEqbn1ug4g69Ss42Ef3aDeClTcLFMCobSrVQ=;
 b=zyNSJGHS1CcTjNfQtVE5YFaT4oSzW/KO/vwxQHNB7DvxOockFsCnKpQRzhYKfwsf4fJTr5W9BmobCEfWBoHGwPiyaKn6F441AetnwN78UdsX0/weqg4u11KdmY++PsvNJ42DSnagNeTsI6G5Rp0Tv7oEzwCJTUqZ5VCoC1vH7xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 15:28:24 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856%7]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 15:28:24 +0000
Message-ID: <11baa678-8cbe-4a9a-af09-381d649d648c@amd.com>
Date: Thu, 8 Feb 2024 20:58:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next20240208: tg3 driver nw interfaces not getting
 configured
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, andrew@lunn.ch,
 Jakub Kicinski <kuba@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
 <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
 <fd72544a-f3ed-44bb-86e3-bdfa4fca720e@gmail.com>
 <8a59f072-4a71-4662-bfde-308b81e4ce88@amd.com>
 <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: bff4544d-0b9f-4c45-018f-08dc28ba96aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qkBu6ttPH6W+GCuNqZKchftfV/glroiAb/D7KNogUP+/EWhmtLHTUsargvVH9DDWG5LpY82fhR60vzOYe5qkleTE7Dc4qySqsXz4LcKXZl6myfxx8jYBzyCqf9rvlYMAxbyxStkORft5ZpFQxqPYe+jaRjZ3OoGxTVRQqz+l6nBwDGcy+4u9uzBPvTJS7Wv7FJDjwouFlaIMdBDwgyuII1I2FGX/Ajv0ISWaw/co2maD1Xjrp79WMYP4lb1QaXVnler/kb6Af7v7d43qwghtvr3jL7bRiHOD5TWFJ8KrS512nV4ATbf1FTJUW5X7R2bhRDtJFOJ/OIMSM7IEP93y+RfvG2Gn1JeOrFLRuml6me0GOium2TGQV6cJ1noEL6Yw+fD89gmBMA1OP+lxJHeFOx/eRBkV0ATUfM4Ei4ZI2Vqfd9PxCpmYAtXNODlj2LSDQugnm0IPTCWjdBq6S1MWIqKqvWdx2Jn6Ea7xxqxW3z6Pd5tsiJNpKCUM5sKYJOuxZneJ0FgHuB+iXLkB+WcXC3riRZ5yn+2bn2YKSri2eNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31696002)(31686004)(83380400001)(26005)(38100700002)(478600001)(6506007)(966005)(6666004)(66946007)(6512007)(6486002)(53546011)(2616005)(36756003)(41300700001)(2906002)(5660300002)(66556008)(8936002)(316002)(54906003)(110136005)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R081TldZMmNWYTZUWFBuMVlERzBsRkN5aE0wWVNZK0tSTmhFMHRjc2RrbUl2?=
 =?utf-8?B?bjdVTUUydGovUW5aKy8xOXBvZkpzcW9LOHdqbWpQNUJSNmNFU1FmUnNIa3Nt?=
 =?utf-8?B?SEl6cmI1RXdxNFlVUG5jOUhwWXh1TndQbS84ZlNFc1QrazIyUzJzVGtMQUJs?=
 =?utf-8?B?L3lkWGMvNGdZNkc2cmlPQzdJN2NNbEVxMlg5K3dCT1MyS0Y1VXBUbStSUEp2?=
 =?utf-8?B?eDJhSmg1YzVlYnR1K3l6UUxiQlJ3d0R0QWNWYkc4d2EvdFBwWGZmeWtJdXJr?=
 =?utf-8?B?UHBJcHA3VzJqSUZOUDdwQ1UwYmVpS0tTeTg5dVo1MnlUZWlWbWVmRVcyTEt5?=
 =?utf-8?B?VE9DWG1Dem9wNzNaN3Q5UENWc09OQ1pOOW9pTGtaVEFMSmR5eVE2eHBVTStr?=
 =?utf-8?B?UStuanMwcGpONjNFbldGdWJMd3FUNFBPVytLOGUzTGtOUm9FOUtsZHN6WUgx?=
 =?utf-8?B?Mno1WFFrMW1JZ1NJWmszME1ydmtWMGtkWGtoM2oyQ0huM2lpeGREMDJjZGtl?=
 =?utf-8?B?KzdsWWYwYVduYlVCN3FwTU51d2xaOXhNWVUybEdyRjNjK2NMN2tFQUpVbUls?=
 =?utf-8?B?UTFkTmJVTVJNUUVRREhxWERwb3E2cEMwT1FhbWxOeTNPZU5zcXdqYlZsTXJS?=
 =?utf-8?B?SUN3RXQ5cVkycDdoUkRsTkgzQmI2YmFYckNIamoxUFdhNWQwdHVQa1VibGUx?=
 =?utf-8?B?YVM5aXBpRGtGRUZCU1BveEUxNE9jdjJCeTNZazd1RTZhbUdjNEVLRXAvZGx6?=
 =?utf-8?B?YW4xMjhuVENvSDNLelVoRzZTQU4wUHFsb21iUUUyK1ZmdU1MdHcrYXpDc1Jo?=
 =?utf-8?B?UEptQ2x6dHk4dG96dzZtcnIwNlQ2U2FxcjRrcVM5MkU1WHRwNnJncjMvcTZu?=
 =?utf-8?B?VEpFTklqd0h6amRJWkRVTy80M0gyNkV6UVNaLytKTXpUVWVPSjMyVDRaZkFY?=
 =?utf-8?B?djJ5eXQ0T1h3NGFpKzBVUVpVczBuWitBV1ZpeTFmTWFocHdZUWRyWkZkU0E3?=
 =?utf-8?B?dFhLZjZ2dk0zWmFJRk9xcGErQStaVXdGTks2N08yQmZ6dXphWEFqbjRKMmJp?=
 =?utf-8?B?MERNVTNaNCtnMS9XNnRuaTV1b2h3NmdjSVkrcHVtY0NOL2NzcTV4SFpuS2d1?=
 =?utf-8?B?UlZReG1qUG1GU0gxTXg1YlFsV1pnT05qZjM1NlE5bC81YVV0UWtaSis1dC9T?=
 =?utf-8?B?emxWU2o4NDhJVjRrUHNTSW5qcnphMUtZYWMrU2R2TTZJOEIxSCttRkdQTGRi?=
 =?utf-8?B?ZXZ1cm80cHpMZ056d1JOeXVKdzVWQjJkR3dwTWNXR3NRWC9PTld5T1E4SVdL?=
 =?utf-8?B?SXQwSWRtWWxWZHo4dENxUjBBckJLRjFYUERkdWovY3d1V0lLOHk4SVdmcC9O?=
 =?utf-8?B?Qi9nR0dDU0QxbVZrMTBSOExjM01EZmNZTC9GYjdYejRCQzY4L3E1TFQrbXRC?=
 =?utf-8?B?REpJTGF2MXRjRG8rbnpyaUNiYWF0OTFxMzc0U0pTM2crREJtUlM0MlNNdzY5?=
 =?utf-8?B?NW9xbmRsMERpNENGb2N1dzdoQXJERWk0UWJuTHRvYlJsR2c1dElmWVRZbldn?=
 =?utf-8?B?TGFwUndMSE5Eamt4Vmd0dXFwS0Nsc3hlTWR4cjdUT1NiVGY4N2VDWkpFZkNL?=
 =?utf-8?B?WWFQZEdpWFZDSEN4eVI3c2t1bTBEaWVLMk50Vkh6bUUzNlhJcFJFUDBNU0cv?=
 =?utf-8?B?aHpXS0IvZTZ6SHhLMmdURHQraWl5bDBvRG9mSUtZaXB4ZGNKRUc2d2NHcXJJ?=
 =?utf-8?B?cVc2a2VVSjZNRVR4Q2M3YjlNeVRKQkFWdXN1R05tODdNMEVHRjRRUGIxNyta?=
 =?utf-8?B?bmVYVDdMeE5laHd4Vm9PNGJNSTB0M1N3SUNxSHYvSUJZa1FZZUxsaVFMVGRB?=
 =?utf-8?B?cHJkY1M2U3l3dkNIWCtidWp1YjVTdStFNS82UW4yU3BGeW5CV1dOQldYQXZF?=
 =?utf-8?B?cG5FbUxQc29HT0pwTzdaekpSZWpuSDJmT2xBcCtIT0ZQVjJhTWdNNUp5YkU2?=
 =?utf-8?B?U1V5N25POFUrL045d2Q4NktFU2p4NU1vdnNoZnlrclozOGF3Tzd6NWpmU2Ir?=
 =?utf-8?B?RUl6SThiL3VrSTBwUSs5UmFwd2xpbXU0TWZQNitHd2QvYmhEZXlVUUxidk85?=
 =?utf-8?Q?ke8IhiR0MsPBwcKlk22VbWquO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff4544d-0b9f-4c45-018f-08dc28ba96aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:28:23.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kxwqivh17QaWM5LOll6M8qylnXMxOrxfl/Xay58ImKmsUe2PGcw92xEDaUgs+cLRpmGyAzZZHeGp+yjLUSNhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770

On 2/8/2024 7:32 PM, Heiner Kallweit wrote:
> On 08.02.2024 12:05, Aithal, Srikanth wrote:
>> On 2/8/2024 4:16 PM, Heiner Kallweit wrote:
>>> On 08.02.2024 09:30, Aithal, Srikanth wrote:
>>>> Hi,
>>>>
>>>> On 6.8.0-rc3-next-20240208, the network interfaces are not getting configured.
>>>>
>>> Thanks for the report. Could you please elaborate on what "not getting
>>> configured" means in detail?
>>> - Any error in any log?
>>> - Any other error message?
>>> - Interface doesn't come up or which specific configuration are you missing?
>>>
>> I am not seeing any errors in the dmesg,
>>
>> [    4.019383] tg3 0000:c1:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:90
>> [    4.019391] tg3 0000:c1:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>> [    4.019394] tg3 0000:c1:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>> [    4.019397] tg3 0000:c1:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
>> [    4.041082] tg3 0000:c1:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:91
>> [    4.041087] tg3 0000:c1:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>> [    4.041090] tg3 0000:c1:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>> [    4.041092] tg3 0000:c1:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
>> [    4.077483] tg3 0000:c1:00.1 eno8403: renamed from eth1
>> [    4.124657] tg3 0000:c1:00.0 eno8303: renamed from eth0
>>
>> nmcli says interfaces are disconnected:
>>
>> [root@localhost ~]# nmcli
>> eno8303: disconnected
>>          "Broadcom and subsidiaries NetXtreme BCM5720"
>>          ethernet (tg3), D0:8E:79:BB:95:90, hw, mtu 1500
>>
>> eno8403: disconnected
>>          "Broadcom and subsidiaries NetXtreme BCM5720"
>>          ethernet (tg3), D0:8E:79:BB:95:91, hw, mtu 1500
>>
>> I am attaching host dmesg.
>>
> 
> Thanks. dmesg lists no error. Please send output from the following commands.
> 
> ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
DOWN mode DEFAULT group default qlen 1000
     link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
     altname enp193s0f0
3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
DOWN mode DEFAULT group default qlen 1000
     link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
     altname enp193s0f1

> ethtool <if>
Settings for eno8303:
         Supported ports: [ TP ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Supported pause frame use: No
         Supports auto-negotiation: Yes
         Supported FEC modes: Not reported
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Advertised pause frame use: No
         Advertised auto-negotiation: Yes
         Advertised FEC modes: Not reported
         Speed: Unknown!
         Duplex: Unknown! (255)
         Auto-negotiation: on
         Port: Twisted Pair
         PHYAD: 1
         Transceiver: internal
         MDI-X: Unknown
         Supports Wake-on: g
         Wake-on: d
         Current message level: 0x000000ff (255)
                                drv probe link timer ifdown ifup rx_err 
tx_err
         Link detected: no

Settings for eno8403:
         Supported ports: [ TP ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Supported pause frame use: No
         Supports auto-negotiation: Yes
         Supported FEC modes: Not reported
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Advertised pause frame use: No
         Advertised auto-negotiation: Yes
         Advertised FEC modes: Not reported
         Speed: Unknown!
         Duplex: Unknown! (255)
         Auto-negotiation: on
         Port: Twisted Pair
         PHYAD: 2
         Transceiver: internal
         MDI-X: Unknown
         Supports Wake-on: g
         Wake-on: d
         Current message level: 0x000000ff (255)
                                drv probe link timer ifdown ifup rx_err 
tx_err
         Link detected: no

> ethtool --show-eee <if>
EEE settings for eno8403:
         EEE status: enabled - inactive
         Tx LPI: 2047 (us)
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  Not reported

EEE settings for eno8303:
         EEE status: enabled - inactive
         Tx LPI: 2047 (us)
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  Not reported

> 
> If the interfaces aren't up, please try to bring them up manually and see what happens.
> ip link set <if> up
Nothing happens.
[root@localhost ~]# ip link set eno8303 up
[root@localhost ~]# ip link set eno8403 up
[root@localhost ~]# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
DOWN mode DEFAULT group default qlen 1000
     link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
     altname enp193s0f0
3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
DOWN mode DEFAULT group default qlen 1000
     link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
     altname enp193s0f1

> 
> 
>>>> I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
>>>>          configuration: autonegotiation=on broadcast=yes driver=tg3
>>>>
>>>> If I revert below commit I am able to get back the interfaces mentioned.
>>>>
>>>> commit 9bc791341bc9a5c22b94889aa37993bb69faa317
>>>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Date:   Sat Feb 3 22:12:50 2024 +0100
>>>>
>>>>       tg3: convert EEE handling to use linkmode bitmaps
>>>>
>>>>       Convert EEE handling to use linkmode bitmaps. This prepares for
>>>>       removing the legacy bitmaps from struct ethtool_keee.
>>>>       No functional change intended.
>>>>
>>>>       Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
>>>>       in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
>>>>       the current functionality.
>>>>
>>>>       Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>       Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>       Link: https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
>>>>       Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>
>>>>
>>>> The same works fine on 6.8.0-rc3-next-20240207.
>>>>
>>>> Thanks,
>>>> Srikanth Aithal
>>>> sraithal@amd.com
>>> Heiner
> 


