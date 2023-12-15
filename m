Return-Path: <linux-kernel+bounces-1149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC70814B22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F042853F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0824358B9;
	Fri, 15 Dec 2023 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUjAHwld";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8Dy7V7i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57B538A;
	Fri, 15 Dec 2023 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwpdq025676;
	Fri, 15 Dec 2023 15:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1SAkqfsAb2lZBq+hryY5qEJw1irrcGDrus7C4SmZXAI=;
 b=eUjAHwldZ0opdRolYFo7Q5WC7+qQOEczR6p8B2LY/QyT74JZFDyH7lnJ3zA+inOfIZcj
 A2jE79YLxQCV3KoJkLF/y3qeQnHs1jcV8jw9B/wq85HUsqIY+zv6rFLXaa7ga/uMFZll
 yrma63S5YynrKQUPUEkUeOOLUoPoNBCswdQP/0zOTyt0VVnXD+Od0TvPn0m/mMWoiPOq
 z2MkK5MDXDsR64WxYVq8amD5cejUYyWuC+TCgBG2WA+ujimJjn9O04yYEHW3c4OMNzFU
 GKliKy+fdzkg/dErwYe8WrdfonveH2qiIEztjWzTpwARlEMafbuIXrzV42HLtZhHhALm SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuudjsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:04:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwCCM024845;
	Fri, 15 Dec 2023 15:04:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbxdht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxpIVRxwNM4qpxQbPmuJ3zc2EKUVSWwLO8dTueL69c7jF/om6jJFILETnvWsIapFoxEWc59zWuAoauGUq8bsn39lI4Eto3oCya8Iyn8+BavQcpwi0HmAmI4uVlMSwr+nYeQpsIPHF+QrMJ/YAatYO7Kai5XRt8TBYjN8z6HVLtD+doeWgWuODZxxQ+0d7+goj5aHuIz/LeHd9Pg7ZU0IY+d1MI7a1pwU61KJSyni49+yD8GakMu7uiJpKkgMw9X3e5z6+I2fAcvbFCmCK9h91bihZSefi1YKgRZPAI4JdZT1zflK0exDCxbIUty5YGvfFwo1yyVsxsEpySPWP0NCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SAkqfsAb2lZBq+hryY5qEJw1irrcGDrus7C4SmZXAI=;
 b=i8HprHctu9ITA0w8eBtes+H/z1ICQbIkhqdjsNwxZTm3/jMFaYe9Yxc16HkO4H71ITeh6eW3SHgLlxfSfKMpdhNKFW9jUs7MqLieaY1eFOtcGSGiI2Aio1FkdxyR5aX7yZiJqvQpnWCgnSFHQhOwsEz1xcQmIxC1l+xp0upzVd8nmclgnmq9+vPJNg5dq414lViUrzCOIdNttV4itJEgKkpjI8dd0lKwESUsZBXv+5vBfHK9ZFboQp57v+POjuv+65hYUlt+LARQNX0O2IJW4edbGmAVNOYES5wC50tVBPLiNEegrzzOllPaSWzHYd8SgQYkmB64nmPbemGyL9rEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SAkqfsAb2lZBq+hryY5qEJw1irrcGDrus7C4SmZXAI=;
 b=i8Dy7V7i1SYnj0eIzy2T7IPP2Li3J6LRuCENUHy2sXIYX8KrX9l5y0vQk8T7AQcqW6hWXLLxD34le6uGzy7y0QrmH6It1ywUM3JPaiPm5dIlT+FY8RVfhqxn+dMBRvekJuq1NgD2Vqgvf71UAgC+sKvicgvMWtFeGv1C+sxjU/Y=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB5760.namprd10.prod.outlook.com (2603:10b6:806:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 15:04:17 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 15:04:17 +0000
Message-ID: <db501d4f-f922-4a78-8496-858ac528df9e@oracle.com>
Date: Fri, 15 Dec 2023 16:04:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: translations: add translations links when they
 exist
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res.211@gmail.com>,
        linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa
 <akiyks@gmail.com>, Yanteng Si <siyanteng@loongson.cn>
References: <20231215123701.2712807-1-vegard.nossum@oracle.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231215123701.2712807-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0109.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA1PR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c1a27c-1bb3-4cdf-c059-08dbfd7f1bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RN6CJqdmTmbSVbmVHlD7Kn/bR6OPDGF5l5j00CIYjK1zmoABWB3XgTn41015kZWywlmjZ+Aq32Wi7uUbyebkZJ5F1WvWHZb4aEYpxx3oMZmkxSG8WjxwvtwV68xgpVuDic1zEkQhMgt4IVQ4TcOT1AaQ03R5QoPQvllDAkOg5WQvloh5p+NLGQqSEm4ORVv/t43ry/bb1okA+1WdipIXptPjDgSzt/GdHiFTg+pXAlvyRldGH44MpZzAraoKVH/LtwdRWVp3i+i7eJhqN9/a5ysEwXhT7l9VOa3KEtppR02NskKZFjFcM7s6oj/0hx1kFAlCW6D/bOpCVepzM4cb5iERpH7Icn1axlH3n8QjHb3mochmx08JtO0DtNH5a4FjLQeidDUMlMnQXu8nR2ve7oiN531pLLMludpXZl5q6DvBh4Bzxb1bhSSukZkR4HM7ag5LNyn9Ne4QoZ7sD1xBzi2lbk1QXNIzphnU+zChxLPV9ZvlXFVlmPHmApzsNbLzNqqYSuKZA6CmorBKRmbsRjhKlJujuE0y5KoEg0aN+FtmSztFpksfz9Fj8P4OZ3pgGuvKvQvunNPGjFyVasdAv0rHlEJQtM375FW/wswxY5lcwY8sGG1E4bTnaMXfnzIeJzp/h/38qNQ9f/FOqxBdBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2616005)(6512007)(26005)(38100700002)(8676002)(4326008)(8936002)(316002)(2906002)(6486002)(44832011)(5660300002)(478600001)(6506007)(53546011)(66946007)(6666004)(66476007)(66556008)(6916009)(54906003)(41300700001)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjBVRkFiY21xamUxWWVKdVorM0taUUV4eDZXZUhqNU02STdKZEVHMEtVYlVI?=
 =?utf-8?B?MG1EcHM5MVhVdUlxZlppNkpGbW9JdnRaQ2Vwbi8vWHdOdmtzSUV6dVNVVDAy?=
 =?utf-8?B?TDJJaVpJTzlmemJ0ZGtFMllEaXRqOEhqRVU4d3VJeEFadnVXbDdOeXNqUmJn?=
 =?utf-8?B?ZlZkSzFYUy9BalB4a0FKbm9pZm9EODhHYlhNT3RoLy9Cam1GQVhqT3k1NjE0?=
 =?utf-8?B?cStabnZSeDY1RUpqdTBsZTE5RkM5QnRGeFlmOGZTU0dmNTkzdXA4c3VZdldr?=
 =?utf-8?B?bkRJTVg3V1BFT1FyamMyZmZjYW5WejlJTmtUNWVDcnBsc3BpY2YyWWhEZmxE?=
 =?utf-8?B?Rzc0SmFycElPS3Y2SGtGUnovdzRjbDZ2UVo1LzFBRFk5TXd5cUZFUWNIem5w?=
 =?utf-8?B?N1FTUDQ3K25EUVBhODI2RTgzQVoremNYRyt1cnVQd3V3dXp3cUVUbHFEdVMz?=
 =?utf-8?B?SllJc2pYaHJPbDJzRUNtWDRudWNyM2tWSWpPdTVOb2hNQWlMUGMwQ2d4WkI1?=
 =?utf-8?B?VnQ0WVJIOVlXMEdZTkpUd3lmSjJuU2ZKTk14S0VaaDZhb0xqTldKVm0zdW5u?=
 =?utf-8?B?amtQbmRveVpDUktzb2NnaklTUlhGUVU4OWtnd1YrOEtobmR3VC9ic1hPcGFp?=
 =?utf-8?B?MllWbkVsdmNWL3pOd3htVGlMVVhuR0Z1OXJiSVBpdUlJTGdMNGJ2b3M3Z2or?=
 =?utf-8?B?YmZzNGR4ZzlFYkxicWx2S256alJ5UHN6NTM2L3o5S0Y3RlN6aDl5cUdXakJy?=
 =?utf-8?B?NUNyaVpGcUNlZDNTS0x2bTJUdEF5MDBSUVhIMU5SaW92aGY3YllKcXlyVElI?=
 =?utf-8?B?SUc3OVVQdDI3VDEwd3RpWlNjTlhaL0pwaHlxTFV5cEZvQk1pQW5taUorZHBU?=
 =?utf-8?B?M2pXYktHRGlRczl0SHF4SW05SDlwOGFWT1JrNlM0M21sSkJ5Vm91b1k0TmlH?=
 =?utf-8?B?aW5NMTRGS1VmY0t0dnZ5SUNoZ3A5aCsyZGhta2cwd3JHNmtCM1dIbzZ4UUhW?=
 =?utf-8?B?eUhFeFpQSmtXVUkrc01xcVpaQ0RzYktiTTBpN2Y4b2lpT1VqbENjOFZJaEhm?=
 =?utf-8?B?b2RDRnJMOWJ2OUUzM3hla2VJVGU2S2FlSHArOFNZb200WHZVUlBUSnVpNHhG?=
 =?utf-8?B?OGJqU0ttOUIyS1hCQ3RUQVpsbE9FZlNvWUoyTGcwN2k4UDVzcGZ6YzMwWnI4?=
 =?utf-8?B?emdCY3JzdHRjbWtHS2ZpWGZhTDJxVGZ3elUvV1pDRzJXSTMwUFlKRmhwWmNW?=
 =?utf-8?B?VDNqRmJTWEVNeVNJS0ZsdWxlbkh3Y3dVNVlQc2Z1TjhhQ2k0UTFaaGpSK0Jr?=
 =?utf-8?B?eEErREVPcExNeUlOOU40N2NzK2pZWDFPWXl2d0k0bmNiQW0xcjFFOEs0MVM3?=
 =?utf-8?B?c3E1T2VzZ3BwVjRESmN0S011ZWR6M0U1M1FPT2toVC9hcmprOGFwRGZCOUp5?=
 =?utf-8?B?QjdkRjJKUHV3OTZiZWNsWGJPVzBiOVBJSG1xTGFDNzRzMjZlTVJFcmdCVXRB?=
 =?utf-8?B?NFpTRjZSMFBCL1FuS1ozdENjWjdxVEZZNndrcmQxZ2IvelE3bk1Gd2hWV0NZ?=
 =?utf-8?B?L2YyNmJ1TFdzR0NaY2gzMmkyKzFxQldaQWZCaExiYy9XUkRrY1ZkVnMwWXVt?=
 =?utf-8?B?WjdVaXZQUXViMnlHL05JWEhrdmxGc3FCaHYwRkFUb3R5S0JPczRLNHFWaU5X?=
 =?utf-8?B?SGdLMXJBWUhMTHIxdmdpVTBqS0FENjdXaEt6cld6SEt6MzVCOUcycHhLUHdG?=
 =?utf-8?B?Ylc1NDJXelpUOUpnbjdIL0hWQ3N5S0MrWjcwaUo2aVdyNzRqTE1YTGNUdVlX?=
 =?utf-8?B?Q3JXQlhkNjNxVWxJRU5pQi80Zmg4SzNtZzJ4T0tZb245OWhMWUNoN1V5c1RG?=
 =?utf-8?B?ZjlYcTlLZEx6YVY0Yk5LbmVrR0sxVnQvWCswZUU3Zm1mY2VielpQNVh0SXhl?=
 =?utf-8?B?SkxoVkpuc2dMb0tKaThOb2xFbkN4dXN2K0d2c1ZYU0xNWFJqT0tOMEJ3SWFG?=
 =?utf-8?B?ejluR1FXT1Zvei9NL3ZXUDhZR1U3QVhVTFdVV0xYZHk1QUsxSWtsZGcwejV2?=
 =?utf-8?B?ZFFpakpPejB6NDMrYVEwalNwTmk3RXBmcnlXQWQ2VkVkV1FUREVxVWZrdS9X?=
 =?utf-8?B?Q2hLa0NLdGh5UWNFTUd5SjArT1hYcDZ5TTJZN0t3Sy8rdnFhb1h4TFpwUi9y?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aOqGViWqKJ9GVADLh1ZUfnoURRNYFlMJ4cBwKM+D7cL/r3Oy0/FIMJgmuutuhNI0A60xeS/eX/hqxtRkrQKWECNQzBJLFQnZdk58KrFvFFLttnp6lytGTV7UAWM3XXZTG+UlMtrjMCjaE5b7/rtXRPQl5wYlLuh5nICOiAee0GlLx0+HzZDC6I4IHR+322PPNd+g9jOd0oSw2gPn7k38XT4/wSk5/y09YxV5PBlcls1JHIBn0AlyDaL9tnm/hLWz0TxOMczUMQ9Y8uqjlVuCrkf0/BSn1BpwhF0m54uMqekPyBuOa6T5CFk8N0ms41EdKl1zlqMjIaVasvao76izXDCaW08Wxn3WiXCBfWb1fqHZnOcTQr8SgGIESCw4yX6THEVjtzopE+dGHNZLnufF5jM1pG0M1A5/c1r63lR3JM/JX8/Dc4en9OeKPpOGipgkt4SZgJ9cu00AI6eWnv7uUnsU4r89lp70J3kHUXL62KqSBLCovSycO6JgAgtMtw65fUsChPIkumJuEt5OLGRABcHNGnWd9N7PSXLawTA/5Vs1zLFoqAE6SF5FL/8ug60+1zGFK0WvpvVL5X2ja3VgdnHKJZlhAnveiu3s7PDE+pM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c1a27c-1bb3-4cdf-c059-08dbfd7f1bc5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:04:17.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+Xw/pPjsjaSXpjAAXRwqKhaQcwC85WCtu8XZCSwwNNPeab+fFzcmxkTCrDcKsdBKJ2Mpz6/Nyglde44goqV6qEvvhNcGrcuiSq/h0rxvYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150103
X-Proofpoint-GUID: _nW-pg_Kw-vZvXg35fBQvsWDH0-6CYpj
X-Proofpoint-ORIG-GUID: _nW-pg_Kw-vZvXg35fBQvsWDH0-6CYpj


On 15/12/2023 13:37, Vegard Nossum wrote:
> Add a new Sphinx extension that knows about the translations of kernel
> documentation and can insert links to the translations at the top of
> the document.
> 
> It basically works like this:
> 
> 1. Register a new node type, LanguagesNode.
> 
> 2. Register a new transform, TranslationsTransform, that inserts a new
>     LanguageNode at the top of every document. The LanguageNode contains
>     "pending references" to translations of the document. The key here
>     is that these are pending (i.e. unresolved) references that may or
>     may not actually exist.
> 
> 3. Register a 'doctree-resolved' event that iterates over all the
>     LanguageNode nodes. Any unresolved references are filtered out; the
>     list of resolved references is passed to the 'translations.html'
>     template and rendered as an HTML node (if HTML output is selected).
> 
> Testing: make htmldocs, make latexdocs with Sphinx v4.3.2 and Firefox.

Oh no, there's still a problem. If I run make htmldocs, make latexdocs,
make htmldocs, then all the translation menus disappear from the HTML.

So ignore this for now.

If anybody has a solution feel free to respond with it.


Vegard

