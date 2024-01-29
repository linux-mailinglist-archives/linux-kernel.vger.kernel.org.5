Return-Path: <linux-kernel+bounces-43198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62A8410BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4657E286B38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5C3F9FB;
	Mon, 29 Jan 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MphCcYH3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43E3F9EC;
	Mon, 29 Jan 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549248; cv=fail; b=dJ9JslszzFZ7bMZBF4CHN+b7eIvcXZYbX1hhPXKEri8lZuYxDV1XMceNa+skhSp5y90Op4G+VqF2kLmqyOnI69kGOgMW5DKHyYyjoD3ZB+nBYIOTK1HTsojmPNFicMZL4bVyKj/lGWxWawLuZeIe9YIeAWv02XETh6CvsYe+JgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549248; c=relaxed/simple;
	bh=tTw/SpEY2mMJyfF7SBF/vz0p94ycw9MowKotBbiWFto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+ITWxxuDCFjDE+bz0I+wnnxyHBOhvzdDz+mCTq9zSW/2ccYVa3xKYODV8NtXum8SNg+UaBLHgasY6qxXs0Fg6626xbPWzGgzWFvv0ecIJXQKaTWBmeT5I5XQ6wqes0u5XlnEYpb71tiG7lasfuzNS2CbhRzQjLFOYWx+7ONacg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MphCcYH3; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtQcB1VACvmWYjjoRoThfYgN94SgPtOdAjWLxDWHRdnwP+M/qr9xlTfSPzkFU0xCfP5Hml0ocSwATHz8bzVctjRZY5zU2/oSSdIyUXPd9xNKedMp8DCd94ldyLp7dNOY5UCGcGji4KHfHI+W11Fn9C56WKKTTFWT9vGo3ahKMx7qrQl5oX4V2ebCm0ZHvq3o8UNlIZsjxkRH+OGjI2HTSFUIJ7CNz6n2urTrm4CphaaSRytOurjL744n6V0nJkNaT2Vx3VarC/6gr5ITUq12pvvTQbSHOtEZ7m3tD5tg6Uz0gj/ZbCgh+zIfrkN2z9xTvMSs/HDHIu2QADuRWpbP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6pp60nj1TNdJjik28tAMnHLwCrw8YgNwsANBA228xE=;
 b=oKRR5o6OFikCFqyWgqXMaGIVNpEnl9aX7jGmAxqzH0Xtp/VLPiJa8cjZvD5qNyv8z0bfPCqy+QZv3AvoFEvrhtGNHrcZEuTwECQLcjjMyBmhJm9GHy9cF48yFC6AO53+edPSfIiTsl77SJHBV3EjmPssRt+QEVG4q7xXROCLvQvyoqdmgGlAJKFQD4zPfh1y7MOcsrjY5zpW/tf6YT9hOt4Wu1iTGJTp8qmxVUxumsiVDvh0k6rkqVUIb23o+jg8x35LZ8POWJeA/1Nkqm5y5T1TZu2FyGwLS9iFOhjkoEiQBiu8BLaLiup187qakYuQetvHe8Gu1AA6e8T1t+0DDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6pp60nj1TNdJjik28tAMnHLwCrw8YgNwsANBA228xE=;
 b=MphCcYH3aSKxk071fddzOjsRb9kwsg7QMbqW4eOalT1rVv0fcsUvrluOunExH0Y2TNKmZTu0bkozepQSWNeanBEzJzAq+r89b/dvZHf6wR/7TBtLB4Zl9g9t3ndnf2WWApTVGUzoggxeoAcMSYZBo/SV/bIpSR0yAJY4+wo7oMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:27:23 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:27:23 +0000
Message-ID: <7da8652f-a466-4b38-8d0b-6494e9901a98@amd.com>
Date: Mon, 29 Jan 2024 09:27:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/10] pds_core: Various improvements and AQ
 race condition cleanup
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shannon.nelson@amd.com
References: <20240126174255.17052-1-brett.creeley@amd.com>
 <20240126204423.47c20ef6@kernel.org>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240126204423.47c20ef6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 44687d41-ffd2-4970-e768-08dc20ef8e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JhMX0fyw9ODzq80MsBwDG8t7SOTKphzrg2pE/IGe80ihvSRODu3JM3BhtB+XqjYOtWWsraFaO+aRoP5BG7os4j+qOhNs6ckDRN83XRW+RgDlj3/z9zKJVouHaqG3X+hGyJ4PAfJp6O9V5B2/Bv6zDhfOWuwydN7VuoEczm9pDB7403KaOgRU0QKnvIKdRMdXCp74d3Lpuszg6xORGSPv2RRQUYAemfzrhJBZaxxsdOtPw/sUvKKlLv6xxtzkO+JiG7g25mHgPutCtKXMQxxBZoBjfJerdqJNMPLpnXQ6RHL0ju3WIL0aD/rQYf8izvQzXcASW9s/3T5DffAYqRgkBCGgEv3lbK9JL3owbO0oJzeFhzSlGqELyw5fGtasV0uu7UT16WS09Ift7HKBVcEhettdLWVetUkU4AScIuCoMbQLEoi5EqML5l7ggq+zZlih3MMxlRuaYAqVDEzK0CB3h7cHjSK4hJmZ5vCuVd1Cyr1LAD3lKdhJ3jd1D1R2jBNhrzNXvEPvZnvU8gvLM9kInO4S1/Ai3Lw2OnUJwNO6jzoSjSwJyqod0zsMZPK4nYn/o6uDkvwSpIY4U80XH3p5kYQj2buOCgQbO+jqo9DzinzvqU0MtvBPUfBvxKOOV79ikCmfmI1WOKMbxIXkuzTR4t+M8noME7vI/Z63SlSYHQydbO5+sYWsRctOUbMCWhia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(6636002)(316002)(8676002)(66946007)(66556008)(66476007)(4326008)(110136005)(26005)(83380400001)(31686004)(478600001)(31696002)(38100700002)(2906002)(5660300002)(6486002)(2616005)(6512007)(53546011)(6506007)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2w1dnpaV2dicGlzbHpqVXVoSXF1M2x4QmVkWVplTTNNVXhUdXo5TVBsTHJh?=
 =?utf-8?B?dzhiSzhsdjRrdWF3blhTbHZhMTBuNUE2KzM3aEFqVXh2a0J0VEl0L2FxcUxL?=
 =?utf-8?B?alpmQnRDT0dXL05vT3UySk5TSDlVb2FrUCtTbWIwVmhGWGhZcFl6WEY4L3JB?=
 =?utf-8?B?bnEzUjhUODNHSm0wSGdyd3ZGSDM1Ylg4amRFeTRGRlpJY0t5QjZvZVBCY2Va?=
 =?utf-8?B?UDVLb2FtZVlNWGdWZ0hyTERMVTdnQWcyWlZHd09lMXloR1IyY1Qwdm5oTTZ1?=
 =?utf-8?B?T05HY0FqM0d4bHhUc1dxU2tDU2tQQjVodFF6SUUveDV1ek15ZVRneEtLM3pJ?=
 =?utf-8?B?Ky9qN09hNW42YnZHeVA3OGVVWmcvUmdCaEJqN1N5K0hucTZkTENLK1hnbEI1?=
 =?utf-8?B?bHl4eXZDVFloSno2K0VRMUVtU2YvdE1oMUloaEJ4a1g4NGhraWd1L3dndkI1?=
 =?utf-8?B?SmVqUVBtZ2NBQW1nU1RCNmU3Uk5EbUZEeDN2VjgzWTkvRW5UR0tnWk44d2JW?=
 =?utf-8?B?K0FhRERUTE1CRGdTOGNlUVNVL3VpUXAzOHhOdzFubGhiM0ZyaXFBOCtzUHY3?=
 =?utf-8?B?S2lwV1hMc3JFN2g5aHBGSGp5dXVTSG5kQ2pHT09nYU9FTzQ1THMvdTUySDRZ?=
 =?utf-8?B?NHgxS3hMQW1FSEM2SjhDNWdRNXJJY0RwMnZFVnpaYnZFSC9FbVJpd1lSMTMy?=
 =?utf-8?B?L2t4dUEwK0lZRGd2Zm1CU29uMjBQdkVwNUZpOTBkTWMwZWVXUit5MGIzc2sr?=
 =?utf-8?B?dFFMdWZDY25PL3dvZkRUTGFKcHBCUmlXRnVrTWJhRmRGd1MrUWtHUE5WcjRD?=
 =?utf-8?B?eFZsT0p3Q0tyUVdHcndKbHBIc0NYOXovMkc5M3ZFUHJGZUZ0R3BqUkczdHVS?=
 =?utf-8?B?UkVNUHM2L001YUhjMlo0UWduV3d1b29hSWNZUTR0cXN6b3FlM0ZTVFdNOExq?=
 =?utf-8?B?Skl5a0VkYXc1SmlPKzBLNWhSZFEySklwOTNnM3gvMWdlZ280Y083SFZlU2RC?=
 =?utf-8?B?amhha2RUTXBSSWhkWG9CamlOWFpsb3p3bjh2NVdMMVkyK2h6K3JiSXV4SEZZ?=
 =?utf-8?B?M0NoN3JRV3E2Vks5WWxhZzVmOXZTMFNyeDdkQU5OM3M0eW1WQ1ZIWTRnR1Nv?=
 =?utf-8?B?TVo0VTdpMjhSSzAxc2p2U21Dd2tPdkRXSXhKdWNacC9xa2xBUXlPdWxwd2k0?=
 =?utf-8?B?ODlVOElKUXczamN6UkFRUEc0aGVleU0zVkVaSHd0MEFITUEya0JvRkQwVDl2?=
 =?utf-8?B?UFZkV0VxQ2E3S0dNZnczM2tlYVRhVkF0Wm9ZbHdxdkNaVVVzb2QrWlZEclIw?=
 =?utf-8?B?MzVYU2lXQkpLUGREcThVZGhua2xwd21OaDVaMHpUd3cvVXlLck9mc3ZLMUhp?=
 =?utf-8?B?VC9pZXpVdVl2Rmd6MXV5dHRCbEk2dTBCcUV6czVjemdyVHBVUVhUUDdTR2ND?=
 =?utf-8?B?TmNIQllsSjN1OXdmOXFTdHhiTFBGWE5rZzg3eHlZa08reDJXVXI5Zkc5WVI4?=
 =?utf-8?B?aG1sdGJseVB0N1MxU3VIZy9OUlMzeVc5ZDVscTYrYVNra0dLNnNPc0daTGhS?=
 =?utf-8?B?Q3JwWlpRWTBaYnEwVS85SzVPVVh2NTlTN0xvSlRObHVHMFh5UTJoTmVCUWRz?=
 =?utf-8?B?RTl6TG1nZVZaMFBMN0MvVVk2bUN4R0lWVDNBRkk1Y3V6S0FWVGtaQmJPYUxa?=
 =?utf-8?B?dGF3cFdqTGVxVEswUTkxMjNYeWUxOFRlQTdzTllYVDVONHhxeHB1bXFmSzhq?=
 =?utf-8?B?V01IWEtWcFRJbzhzcGxaMS81UHhJTWM3Y0VlT0UyUTBsTkREWm0vRStIUFdN?=
 =?utf-8?B?b0gycWc4YzBEZTRPZjB2eDJIR1YzcXovYk53QWJRZW5JMThBVURYTDQ2OU43?=
 =?utf-8?B?Nit4U0h6bFRSOEc2czgxN1QrckRrSXhLTHBTaEpkQjhUam1XdHNlSlFmVGlF?=
 =?utf-8?B?a2ttY3VlWDNQOFVqUmRCaXM0eWRreHQ5UmZxaUJLcDl5S3AyVnVTdHQ5b2tZ?=
 =?utf-8?B?dFJMTk9maGF6S1lCRXh0MEx6ZUc1eDFZMWxwRHM3ZURaK0J0UVZ3cDJyQXpH?=
 =?utf-8?B?VlFpakwrMXpVSk5Jd2QyWGh4K3B3WDdIbGVsWXFKOWdiZWFITmRmNWNCZHl3?=
 =?utf-8?Q?hqmnxzQwjT9MxHrDcZKwXATQL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44687d41-ffd2-4970-e768-08dc20ef8e38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:27:23.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40TbV4IKZq3oIzQD3b4Zj8Yth3KFBxW0sxNCj8qIT2nZutf8qELeLN60hJtT3PrUafY2cSDFLzPUb21vOBBttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

On 1/26/2024 8:44 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, 26 Jan 2024 09:42:45 -0800 Brett Creeley wrote:
>> This series includes the following changes:
>>
>> There can be many users of the pds_core's adminq. This includes
>> pds_core's uses and any clients that depend on it. When the pds_core
>> device goes through a reset for any reason the adminq is freed
>> and reconfigured. There are some gaps in the current implementation
>> that will cause crashes during reset if any of the previously mentioned
>> users of the adminq attempt to use it after it's been freed.
>>
>> Issues around how resets are handled, specifically regarding the driver's
>> error handlers.
> 
> Patches 1, 2 and 4 look like fixes. Is there any reason these are
> targeting net-next? If someone deploys this device at scale rare
> things will happen a lot..

No reason, just an oversight on my part. I actually think patches 1, 2, 
3, 4, 5, and 9 could all go to net. Unfortunately some of these patches 
are intertwined (i.e. patch 10 depends on patch 9).

If I push the previously mentioned patches to net and they get accepted, 
how soon are fixes typically added to the net-next tree so I can 
rebase/re-push the remaining patches?

Thank for the review,

Brett

