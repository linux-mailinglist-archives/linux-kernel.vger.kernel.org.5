Return-Path: <linux-kernel+bounces-66827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD1C8561F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200F61C227E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840112B14B;
	Thu, 15 Feb 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cf2uRGGI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B212AAC8;
	Thu, 15 Feb 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997501; cv=fail; b=XdhP6MJoCAWttUC1L25BRml2DSLiDzzf49gp69L5A+wfZ5+8LfZOMhQALIkP1ulD1oQh8m9akHS8rTzPFRVcLJMuIEXtAIR/S2waX3UTHezuyKRCXRU7hSqcCgICv0eMcQ4BMBEF56X3johHvBZ/XFEGlTUz4fAEcMChTe6VH98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997501; c=relaxed/simple;
	bh=ekhDzlmJFwfhGoFjxDsx9OAOKUyDLHUGntYH+Cl3lZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1DfOWJ1XyRHKCBE6Fmduci1z5uXakq+alOX5ROGeqbnlcWjtJ1xfsmWi2uReq6Xe1vtX8GH6Flk1t4I0jBQCBbzlj+KJ9CKq5zV+YpOsr/oBJ2jxvbR+wR356I0LHFgKg+0l/lAhRkrvq9mzjUuaW/UllRFCcT2cNoK6NTYDrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cf2uRGGI; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eoa/k9LjDSgEcQTUncwUZgVcegC/sk4G34kwaDL6WZjnFgw/95iysgvihkhdDQ3JAudhv/rVvqZSFQJfUxR+pv3cPwEU+c+8r5rvnRQ7RJ3+M9nsDY9LSozTihE+zleB9gF+NnPJXB8v2/ai+KH+o6uZdwruDumAi8JCRR4/yao4Z71XFQz4SusXC7LGss2RvOcGGcIH6vzQ740mmyP1LZZYJPPqPV6gtMjLpSsds5cB1HNtXI7lY/VM0L8MxclYfXgHzJwj2AiiNNvfrCXTC2RnMM8yWBT+HdEinma9sCZzXT2HFgRAWuomo6ZZ7GUgHA4IYLwhQFmGv6WuJbzY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aJTmm8+eHsr7j37OTwemngDshPKDco85554FxUeOTM=;
 b=XGtBrpo6YOgoaIzn//7PFtMXerRstpwLFplkPX9tC6peoRuaUgiw5m1K9CF0Qtn35PKCzW8B4xnubdkrnooY7OywCzEMSG9LktsarS+eNQBCP1aaSAjvla6qhplEOkwPZcAzyaYCSMt/GZ0iwVRHo92TAZ7b1gE3q0MX1jo8iA45dyH1UDyRCa2h5/yzCGyiGEA/gKp3T0PbfR8Df6gPwi+q7j+fo1fLV9Q4FmuTkpK9kIcTZARBUsr9oYNadwekBTZS7neh/Yr4EjvZ6KhdCRfycgEvKwBfdaUiHQbYTmn32DPF+AuucYfvXXGP+1EZ/W13QZplGYnc/1JHoGzkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aJTmm8+eHsr7j37OTwemngDshPKDco85554FxUeOTM=;
 b=cf2uRGGI2JpSUKr+hfzw1SfmYLUNsWC/YPqEUO1l/+uYYNKu5FdSVb03sXaGwndkdT7caGD6L19s42EXMm8bl2TB2ImeT7P1wpURDykHFuKXut69SNey6BVH56/PzD9Eu7cpkBBE+JDPQoB4hY2kZiBCqJS3Am7fomwBKhJSOjmzQOOXbmULrufq1rozFCbeYHzgeLfFrKLOoGWSGkkffOC9gzoffGoh/WrFDb/qw3qwTVN2kNyd4FuUc5B/CVC/Y2PrM8qU040G9S7IQj8FDf7TuV5/Is6R/a+nZh36nT7V4KX6vk9NjCNJ1iDNtjxgA3MmyvGB++kzE9PuqQQGkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Thu, 15 Feb 2024 11:44:53 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 11:44:53 +0000
Message-ID: <1ed2a42a-65f1-487b-8370-ebc812e4c2dd@nvidia.com>
Date: Thu, 15 Feb 2024 11:44:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240214142244.209814342@linuxfoundation.org>
 <4cc8718f-6035-49f7-bd50-39564ac4fba4@nvidia.com>
 <2024021556-pungent-huddle-8204@gregkh>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2024021556-pungent-huddle-8204@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 79503f59-c49b-4e20-89c4-08dc2e1b861c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bcvGsiTcjyDEMQKxlvff2GIzGveE+4YStNHchset8s3AQ+NJgECYf7G27SDjal2sfJ+HeYtVtfx8QLKo+gu9d/6w5O+9xJn6I2ncuXlvceCv1eAFgLHMyxxeZecIG0NDitbjD4+l2mg9NPPtjEo73PtRvf3+uWwk0WtzEsLZPsncBsEoADA4jOqnZI32i4TgBKBLydzJjYPgqOfsgN6qA/BRDi43OImccr4bQJ23OWPl695fzXDbaGhb53xuOXhbaogqPeCe5vApNNzDW+oYoDJKLdHWpQQKo9fm5pFUsXkrZMKzNB4uDsvGGPXZR194mvayUQ3iD4TI4QQCeIXMQwbStQb9QjPDCza+qo+LEqteFPJYCAi6bUYtg40p+TDyHmP9TDEQx+h80xUPTJ+AILdbL/HyvaYfuCx8yxBqC3YiWjvgbfWI3FCTy+DO31scmyLggAjhRIs0WN9nQBXO6PSPfGwtpVwnwbGiOhVnJCcnSZOqog8+g9fBS62LELjQ+fqYZ6u4QPfdsHo9TrqlylnGP6tBWkSaupf4/1C6j4NbITN10nqpYqBJ4JbOjlXLVskv9NkI3Qbo+UlCc5ytPokqjJJGFTgjM5hkYjU0uRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(86362001)(31696002)(316002)(6666004)(66556008)(66946007)(6916009)(2616005)(66476007)(6506007)(53546011)(6512007)(55236004)(5660300002)(478600001)(6486002)(966005)(7416002)(2906002)(8676002)(26005)(8936002)(38100700002)(4326008)(31686004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtVTUY4Mk9rbURGUmpXc0U2akR1SjZyanhFbTk1WlNwVnRUWUJJUXoyOG1Z?=
 =?utf-8?B?cXhINHJxZ3gyUGRuUE40SUlCcE1tOFo1R3YzUjJvRU5XcWZjSDJBa1d3S1l0?=
 =?utf-8?B?SWhUN2ZYOXNUQStOeTR2WWR4aTRkU1JsTFVyWWdselhqblpLME4vcVUwV1dV?=
 =?utf-8?B?emZHb0lBTEdmMlZSOFZYTzFtRy9OV2RCWU1UWUhDWjBMNFkvakZ0SXRVSExK?=
 =?utf-8?B?OXlzV1B3amU3a0ZBUnplb2RLSHlockVHd1VCcG5NVXlUamt6QjNNWkM4SENx?=
 =?utf-8?B?NWs3ZDV2QVVGQktNUnhYRHRTeHAwQW52Wnlhb1RjRnV5NGxBUG14bkZKcGZo?=
 =?utf-8?B?QTZ6WXBBY0xrWkZpQ0hKamx3TWZnYVZvQkZJb05JZ0tnbjBsMmkvc0c2eTNr?=
 =?utf-8?B?anZpemFONnJySk1STnVwTHprQWlGTzFaUkh4WjZXa3hxNTlPVkhuVVEvTGlN?=
 =?utf-8?B?c21reGZwRjl1djBOUVZTcFdhaDVMVWtEUXlRU2hvckVFNXhwWDdwZFJSd0NJ?=
 =?utf-8?B?OVowQittV213SWlDSGo4KzFmUHJqZnVZQ3cxaUFseVh6cTd0dWNQQ0w5dUty?=
 =?utf-8?B?cnVRZDRxSG91SnoxR3IveGtjRU9KY2hDMTdRaGl0emUvWW5ZZWV0ZkdheUs2?=
 =?utf-8?B?VUFVQzZ0WGlrWEdjTWZrNjZEeWFEajZ6Nk1WNHIzd2t3b2hWelFMejdWWWVx?=
 =?utf-8?B?Qk1hdVJxM0JtRE03TWsybG1CNDJURXdHNVdRdjh4OXQ2YzJhalhYRGg1MU1S?=
 =?utf-8?B?bjg1VC8wdWpWL3BFdXZnczJuYXFrN3lqZ1huRm5jZkFTeENsTkdCc3hCcXRU?=
 =?utf-8?B?N3ozanBoVXFpKzBBLzZqTy9meFF4c0ZpcktTK09DcVY0TnJMV0NTcHAxM3Y1?=
 =?utf-8?B?QlR0NmtiN0pVR0JlNkhFME1Zam05YTBHZ0Mrbm4wNS92SktKaUhiODVWKytr?=
 =?utf-8?B?TDU2dm9VdmE3RkdrVmhzZC9OR05Nc3EwQVZ5bnVHZ0puWStTTFNGZEVjK1RR?=
 =?utf-8?B?KzBrMld1TlVnTS9kanI3SmQxUmdLbG1xWHdBblRFSlJHdzd3UGJTejNneVF4?=
 =?utf-8?B?NER3Rll3NllGLzdrNHpXd3F4bktZSG85M08wU1Z4R2hCMU9VT1BGdkhDL3lk?=
 =?utf-8?B?MVRNcUFBUFROOFhtTWcvaXJ0OU9MbUNkUU5YUXdLb3BjamlSUURUQUVaVk8x?=
 =?utf-8?B?UzVhaGt5U20xSy9JQ1lFREhsZ3V1VWVld1phQnVIR0JuK25iMjVGbFNyL0VG?=
 =?utf-8?B?RmV4eWs2aGRDSzA2bHhUVjBGaXo4cW1LMngvS1llYjd0KzZxbW4zOHR5OCtt?=
 =?utf-8?B?eXlHWHl2Z0t2bEppQjVGUzRJckE5RnJ0bWk3TFJmdEZxckFuUXByQmdPaXFj?=
 =?utf-8?B?c2kyd3BSblFhZWVBT0JlQXJrSWwzQ25aZnFvWDAwYVd6SS9KdG05NWREU2dF?=
 =?utf-8?B?Y3NZSVhSMXM0YWRjYW1ERXVNaGZmNmxTdUhEUHc3d3BRaXViTStGWms2NFF1?=
 =?utf-8?B?QXBVU25FNTRqT2VpMVBub2hTWmlKMWhaMDk2OWd6dkE0Nk85N3ZOS3BNMlQ1?=
 =?utf-8?B?RFBCbzZFWnZreExPWXJJT282WHA2Y0s1cnlqVUYvcTJ3NitEcnJyMlZoMlpJ?=
 =?utf-8?B?NExrSVRyZHJjeENJM2s1YlgvYnZSZFFxdmhCZ2ZEdDA0Q2t6SzVPYXRkYzN0?=
 =?utf-8?B?NU9TeWlrdXFvSml5YmgvbGRQOEk3U1cyNi96ZVhPYkFoUmtXUUJIRmhhdWVX?=
 =?utf-8?B?cklTZ293VGJuT2FUTHd0Uk1wRE1wanJLK1lNYlQ1bCtkUjdrVURKUkhnR3RP?=
 =?utf-8?B?VjBpdmpPQmtFM3dZMUJKRGxkWWRMOUYwVW5CNGVoeGkwTEVNV01VZ21ucHFT?=
 =?utf-8?B?dkpiaTlwcWhwUk9Ca0ZDUmJqYVc1THdqQVQrUlk4S3NuNHhoVk43S3REYndZ?=
 =?utf-8?B?UEpZRHlqTUV0TlJFeUE3b1VBVmIwS05BS3JBTGExS3F0RmlHdjRyQmN6c2s4?=
 =?utf-8?B?bDM1L2RkS0wzVkJrQ2pmOFZ5eWRtU2lEeE0za0ZqK1ZQUU5MT3EvTHZiSjJm?=
 =?utf-8?B?d1diRERSZ2Zqc2NPSG9ld3dCRndlazBXbE5uRzFxaUcreExWaDVBbGY0RG9E?=
 =?utf-8?Q?YoRMWl+cR/983vNSQCJJJ/Twn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79503f59-c49b-4e20-89c4-08dc2e1b861c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:44:53.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EH4iHxJnTrAPXAcx3U2zJt0KXI+z6E0y8f5FpSDORw/KgIfPnDG9emwTuFJQ5g6xZC4sSp9VY3yzQJdIgyAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220


On 15/02/2024 11:27, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 11:14:22AM +0000, Jon Hunter wrote:
>>
>> On 14/02/2024 14:29, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.7.5 release.
>>> There are 127 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> No new regressions for Tegra ...
>>
>> Test results for stable-v6.7:
>>      10 builds:    10 pass, 0 fail
>>      26 boots:     26 pass, 0 fail
>>      116 tests:    115 pass, 1 fail
>>
>> Linux version:    6.7.5-rc2-gc94a8b48bd4b
>> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
>>                    tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>>                    tegra20-ventana, tegra210-p2371-2180,
>>                    tegra210-p3450-0000, tegra30-cardhu-a04
>>
>> Test failures:    tegra186-p2771-0000: pm-system-suspend.sh
> 
> Is this on track to be fixed anywhere in Linus's tree yet?


A fix has been posted here:
https://lore.kernel.org/linux-tegra/20240214114049.1421463-1-cyndis@kapsi.fi/

Now we need to get this into the mainline.

Jon

-- 
nvpublic

