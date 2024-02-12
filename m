Return-Path: <linux-kernel+bounces-62352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A3851ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7761B283505
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70A481D7;
	Mon, 12 Feb 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ryH2eM/2"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09743AA8;
	Mon, 12 Feb 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770790; cv=fail; b=fz7CMnoAgoqrERSyE0Qt1v3keXLAKLUtsx32nKmoa72iJTKxAx3xTd1nQd32Zqx+nfQoRGDhpuEJmT4uEUGKNralyyaIRTB7b2tWjCatqax+Yz+EFwm+nkw+XEGcTayEGolt1H7yHLLla+PMHUR7gWgIOLqXzkirAKDlxsfdfTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770790; c=relaxed/simple;
	bh=GC49zhrBYbHZPvP7vSVzZyB8M3flcgoDXoHw2Kypw0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EgWY+YhbdVCiC79EJDFWg6hpE8tX+s+U1k4AeUt6lyYa4QaXjEIJyvIM96xnF7bGbYaTgPxnHoerdmDRmBjep1WOKfkxAtWmQnEoQNl/t2Y0yTdKD/a3xXBfU7+u+dbHf2SF5U0k64WD4+r9okdAZHJagn5LSnDDYESwaeHytvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ryH2eM/2; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4nGaF4t7Iw6oqY/DUDa+16zSrIuaa28dK0EF/FDweVlUE90zE5KgHN76ySnxuOIE5M2ZG4sYW6aRgHzO68kPgx9ZJkO1Hf9dk3INwZRw22LCdFWLd8w0ce5jLKMs7Lr6UIBae+F1T3gL+DCG/LZItT3xomBniqFG23Q2BKMM+ejYILXGsTFnrpEmPVVOqsS9GG9LHqDeobH3/qLH46yVy8mcHQPe4z8m1QfOUtDeMAudqxjBFnKfmftzpI9kYRDgkFea2fvYalyJoZbWrEF1CuqWMg+O6H/bNNd6UXB4JygeoDUnDm+Khqv8A5nAqbZrSrHxM7AJLVCd3kvL3eA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuVz3y+XM4TrQnk8ieX70Kfukrb+JXO8na6ywRjo6ao=;
 b=KCEghj7qhND5sil4ynzIUVnMAsRlqy4ZS4gs+NygbVSXdiTXWE/FiP7/oU3WbRIPhZOYqruaBaYHmig0QSxbaTk+hJnPTVOml2m+ILXS9RkB6WE9hduIGDkEtcZH7+qneaxGhrKDZLtzxRXmKS/OlrYRaYOxZG4KwVNaMslSH3lLQrllD1J31JIcSOv2juqqLw/2YVnTk4B05l2m53c+VbRpdaQh55TvkuFLr6tiNSztAA+VSgsZtClkg+l4zm9fHSsMBOSCENCIHztSqSGkcMCrsll4GSZvMo+Hz7EKFYOhu2Wr0ZDr2yYD91nSL8CwCHHxEx3/5MjflZ7xFosTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuVz3y+XM4TrQnk8ieX70Kfukrb+JXO8na6ywRjo6ao=;
 b=ryH2eM/2fUEGDjTDdN3XkTAbZTrZ7GGMwsyzusKDTDj2upzZtMx1pmC3Tg7Oj3/WH1payihIXIfgYjRmorg5LYhMGmgFWhmHe/aXh+BiqHiQ1zLpcJ5RP+NS5ICO0XcaYRMM9XNz1pjJtp5fbf1qzXlRRk4XFJl2P4oows3rcLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Mon, 12 Feb
 2024 20:46:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 20:46:23 +0000
Message-ID: <e94db745-9454-4a10-8398-f3b0bc0128e8@amd.com>
Date: Mon, 12 Feb 2024 14:46:20 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
 <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 221a2d68-79aa-4df7-0c8f-08dc2c0bac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5qgpp/k37QGRWc1MCwSYjywQsmNG9t5kJhYXGX5Ly1q2j+CZuBArptUQKK+Dy7jIdJr2jq9pmK3IlbJ6lC0cM0vUlCa0AjCbrdu9yZW5SEoyOZciur/laF1/C2Umsgqft1b0r131R7HDZFWrecnlQc1nA32dsBaMVMJ3W7PdlBUfwpEBrHUtKG73tVZ1lzZQAgW0/XI5NWdFWAKq35RU5VNWGAXFia2BGmDJfS3ryKwv438xsRt5rXSphNoKikcRGLHflky48kUu4GyhfHM7KrpujAQ1SWpcYdRM/qP+/7pX0ICvgx9VV6sYnRVNFH9v0N1FftWjQyJ86eB+AIsdPG544c5G9kdYYuJ3KSV2VR8p033AHwXEGYYDYd6v7MAUwRbHqLjQXOsyOZ8tut8sBLn84+YtTGvX63lY+P3aZvCFOeJRAA2pHJGIvl69bxfGg+zdAxNQ2S9qioWp1OZsFE5q6DMtejNQsqhTlazcevXiSEB36tTNpnpMb+tv9LcjQUuIH7VGKOvCCsCPEXe6FV7h8sDtcoOZMiqqau8I7JQz1g6Uvoo0W37hOuwmYat1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(4744005)(5660300002)(3450700001)(2906002)(478600001)(53546011)(6506007)(6512007)(31696002)(86362001)(36756003)(2616005)(41300700001)(26005)(6486002)(66946007)(66556008)(66476007)(8676002)(4326008)(54906003)(8936002)(110136005)(38100700002)(316002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk05NVFoTHpKOGFETDVXa1hBMnFZSWZHazJzcXIvQXdzY3F4dXB3RnBzVlFz?=
 =?utf-8?B?aWtDUzZPQkovK3hKN0Z0anRqRENBc0JOYzlnUDlOeTVxSC9tUWtoeEZncHNq?=
 =?utf-8?B?WThKVnpPcHluMHJvNGI4TjhRSk56WjBzMUxjUmZoamVERVRmV3FuZTJaMDFh?=
 =?utf-8?B?UDlldTRoRk9OaUNKa2JTcmZleVR0TThIWXR5ek5rK2xldWd4THNUcXNnOCtT?=
 =?utf-8?B?WEQ0WFBLL3I4UlZPalJkMXYyRmtWQkhGMjZxMWQ2TWRBRGkwVzZGRzkwdjlQ?=
 =?utf-8?B?Wm1Ga1BDeUhRcnVyOFg4TnpiL0c4dTQxbWVXZFJ3STg0ZzR5V2RqOG5hN3Mw?=
 =?utf-8?B?OHhvbE5DVVc0SzFkZzRtVEZoVkRPcVhDYmdtNXlWTGhDK2dUbFJhYlVPN0M1?=
 =?utf-8?B?SXowMW9reTlJSTk0b01vciszL2ZKMTRSdWNscFlnbmR3NjduME9Id3QvZzBu?=
 =?utf-8?B?bUp1cDJ1ZUR0L1E2WUFjKzEzOFd5L2c5dGZyeVJjNWlXenZUK2x1TTNwTExM?=
 =?utf-8?B?aDJyZW1NNUd3dzJuU05kMVhOUldILzRqWTNFaGNsY1VzaWZxdXVvVWFXdCtM?=
 =?utf-8?B?NE92UU4yY2RGWGcvcllQaHZMV0hFYXUrQ082aENlRkpuZHo4THdQWTk4NWtq?=
 =?utf-8?B?RDBoYWtnMmtyZFM5R081eWRENGJFYUUwdDZROU9hNkxtcU1NdUdIS2EvUklp?=
 =?utf-8?B?UXNMejVXWjZzL05tNFI1R1hGU2k1aDVIWVl3dDdlKzlwRVFwNjIzc1NlTUlp?=
 =?utf-8?B?bk5OTnlkci94d0NraWFxV3MwMC82UVp4ZmIraE5DQkFNeFowcHJWWlNnM0Z5?=
 =?utf-8?B?TlZ2cTM2V0oxS2o4WFlBU2J5eU1yRnVqaXpRVkMweUsraUJQRTUzOEgrR1Rt?=
 =?utf-8?B?VndyOC82VFNENTRWaDZySTNueG0wSWtaK3cyTUYwb3FYVW5mZCsxSG1KaUJr?=
 =?utf-8?B?RzJMVEFpTjZXYUhBRWZnMys4cXVGSHpqUTBiOGpyTmZCRmEyZTQ3Yml0Vity?=
 =?utf-8?B?dXN3S2hCK05RUkh6S0x0UGp5bExXWFNNME1WL2pJZFlNMWkxRFJqN0gzc293?=
 =?utf-8?B?a1Vtd21OU1E1VUxJMjhHcTFSNWx5dkJ6MXR5c1dwQ1cwRkVQN0pOSjBFSlJk?=
 =?utf-8?B?RHBTSlh4UkgyRE82YkJNdUhYQmFUU2JUSTB0ejhZREJmY1VvUDBlcUtQdU1L?=
 =?utf-8?B?OXpEdXNMR3ViVHFFdS9waU1ydjUwNm1UblcrRmdPcGYzMnJGLzJyWGMzeGkv?=
 =?utf-8?B?OEpSL3dzaDV5VndLSUllTDN1RlZmRnlQc05kSzRnZlh3RzVTaHN6aWx1MkZZ?=
 =?utf-8?B?Ri92Q3ZDYkx5ZjJZV2hDelhTWHBNU09XdXJYWG00RDIvNzlMREQ2SFBDLzNP?=
 =?utf-8?B?TmNCQzNuUk1ZRFcrWndoK1pPNDhZdXptVWUzR3hxY3RGaGYvdmFybEc3TkRG?=
 =?utf-8?B?d2owaERiVWJyZ3ZDNmUyamRYRkRJRnc1VUdqejNreWZudGhuK0lrb1ZPa2xW?=
 =?utf-8?B?TVFwS0Yxd3FFNUtyb094NjlNYVRWREhvVG1sTkhCaWVmc2lqcEZVdjFCZXpG?=
 =?utf-8?B?RHowb0NSMEtpOC9QTWZIZGxvVXVjYnQ4ZmVVWTJ0dWp5RW1DaWg2cVhTQVlN?=
 =?utf-8?B?SVpBTk42cDNwdXFVSFBxMVJPTkdLRlltaS9rbHQ5ZE13VkE3akN2UE9pS2xY?=
 =?utf-8?B?VkR3VllocWFTMnFHMEdyN3lxT1ovWEZxbEp4OFRrM3pmbW5Ha1VnWXMrVDh4?=
 =?utf-8?B?aUUyMmhKR0hBcTdOd1ArcnlscHNOUFNqdWdvOW1ZNisvWUdITXZmWFJkdlgx?=
 =?utf-8?B?SnFMZ0M4bmFhN05acHd1LzkvWTVvSzN1MzBBeTh6Q1IvNzFablFFK1lUVDR5?=
 =?utf-8?B?Z2VvN3phaDZ4cDIrRE9Ib2llREcvcGFTdTdGL3lHZUVscFA0bU5FN3lVYzZt?=
 =?utf-8?B?TEpVSEVJRFVFd2svR1dlbmxwbWRHWS9jS2o0UkZxZ2JVWmNqYng0YnFtYncv?=
 =?utf-8?B?cnRSdTNZdUxIMUxVNzN3NWw1WEJiOHlsWnZYMDloNkJHTjBuWHZhUjNyOXY4?=
 =?utf-8?B?QzVaSnVka0tpNHlQMnJJREpCWXlBRnhBK21kSEk3L3VhQXFxdDROaXUwNXZz?=
 =?utf-8?Q?y+6Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221a2d68-79aa-4df7-0c8f-08dc2c0bac74
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 20:46:23.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X90xEUPr1neCzeVEhjq1odKwq35ZsE520BISl3y1FvSiwF/IRwLP3VJcX5t19qYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407



On 2/12/24 13:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/9/2024 7:27 AM, Moger, Babu wrote:
> 
>> To be honest, I like this series more than the previous series. I always
>> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.
> 
> Would you prefer that your "Reviewed-by" tag be removed from the
> previous series?
> 
Sure. I will plan to review again the new series when Tony submits v16.
-- 
Thanks
Babu Moger

