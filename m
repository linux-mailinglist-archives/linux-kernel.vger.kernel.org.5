Return-Path: <linux-kernel+bounces-1187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95033814B70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99461C23429
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C73EA81;
	Fri, 15 Dec 2023 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BeSq/ItN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="te6/DFpe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBF3D970;
	Fri, 15 Dec 2023 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFExP0l025486;
	Fri, 15 Dec 2023 15:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mQET99UJg0uad01Y4allPJD8/tOMd0Cr3OxvG/S5nOg=;
 b=BeSq/ItNaOePFUv4OYrsS13m/HP8EWbRVsJCoOi5EhU0yO9voeaBrcnTM8PuBmzHRUxb
 8W1HblwkTFWS1iMUO4rvs4K1wJf8Y300vCse39tH5y76bFtnUP/8SwKzcF0ce2o+V1uQ
 q8Iz+Sff2X6rOXmy1d0NQE81Ig1XyJGWwqzxGgy77tGg0iWuj/WqMl8gbtt8ge+OdcNc
 ftxY/svosZ3EQEufcOMvT99FbRwJTJgXM+MjZnbXvI/BvJtPzZkmJRBXRBLT3u/shjAG
 bCw/5vtTQjnUanrK54+v4lWY5JBRfoad0SSgGAYbxuZW+DqEvds1Tb4RpmFSR6oCqfOC OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsunk2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:11:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwB5p024762;
	Fri, 15 Dec 2023 15:11:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbxpeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSCYA7aW0DafXO9UDXk9jSFKK1wJZIdFqpcRgDkoSYrD0t3JGWLZL0+KcU188Z1OjitmKN3SyenUpy4mXtc9hW16t1Tc4wurng98p7t7uAqSyBuWXP9pR8sAqMR5je4Nw/hHqnRv2ovdbI9GH3fj7oi9TN0bHB0mkflRlss7wz1XEKl7JyJQP9EvK/Ze2WLk5gQkgK+Qa469c6N+vkBG7QVzBDZDed0tUcqXAxnBkqZDBws+ptffl8aFnEhLoqx/iZGacmaRLzjrYhy+g7/7KOgGzlkS5LLNXOE6yRfJMPS+fJvdk5zNzwSnX1dYtyiyFqxgRCpWdgYkn4vE7hErlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQET99UJg0uad01Y4allPJD8/tOMd0Cr3OxvG/S5nOg=;
 b=VpXjv5PkIvZiYUqZZ/tEWapxTiLE8axwkT+JwAozXnRd/CnlEGFOD/SIBjjEa4lf4O8DdwscD2/CGOY67vaIyekE/IoaxWSGRfJ7OikosipBYMG6ZXK4yFdTGdTOUPITPOPH+po64gYVa98QJcqHn/oK3ZjpcNyqLsmezdXuAvP139VE0H0zxix3kjs4ARwN2HL92qh7GPyWLGuVLxzEplFXY/3xbsoBaIF1smrKNkHvI9r3og87YPmUWPJuaxFcWX1ZC8C4wBSF+L0Y1GoqdqqnZKjR+B8k2PHPW6KFOdNP756qIvNHePhB/2WWlybsgggYZfJ7sifGwJbQRuqyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQET99UJg0uad01Y4allPJD8/tOMd0Cr3OxvG/S5nOg=;
 b=te6/DFpeeu20yukTwcA+yQXqcBrvgTG7KZhNFlcTtu3oyxCG0qzw3bMYLdflMhvRPVtZIbk4a16x6LCvnbKZ4w3kalYm28qcHtErsRuUt1KOxZKEV76lWIdfI5RK/58+aRLNSH49tar8DZ4YlqjNRygsveo+ALur3tYSqWDAHHc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB6529.namprd10.prod.outlook.com (2603:10b6:510:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 15:11:21 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 15:11:21 +0000
Message-ID: <cd45200a-7e9f-4a97-88a2-6d66408fe81d@oracle.com>
Date: Fri, 15 Dec 2023 16:11:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: translations: add translations links when they
 exist
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res.211@gmail.com>,
        linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa
 <akiyks@gmail.com>, Yanteng Si <siyanteng@loongson.cn>
References: <20231215123701.2712807-1-vegard.nossum@oracle.com>
 <db501d4f-f922-4a78-8496-858ac528df9e@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <db501d4f-f922-4a78-8496-858ac528df9e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::18) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH7PR10MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: a891f49e-1436-4d71-f3ce-08dbfd8018b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G2ZCz7KVOaiFD0ImJjb9cNITCpT1HN0H9/Rtv3uzn2ggy9Qjo92NEGQwbAcdzZ+vwDerSZExXZLvy5Pz+6mQEYfxj6gDp1BXm71wUdca0Fvi6IQbNdeLTyAKv8L6HAg1oAAC6mxk/pIP/DOahQfHiNYkr8Cm2k2+RgtkWnTOQxnk3Nyj4gmubcm/2tcHHv4Ioloi7DXFU5dF30qhe7Ve5DCLQPbHNyNigWQ7oso3Gl+5p41+SEfZynYEajftuUTYfe2dS9u5zudCijrLjUBJpo/6LY7qMR9Jt3ZDOL9PgvoweuxwQAXlIVm5eb1jvYu6SghHt5AaGpxpj/YLDKkgWPKSx2Z5I9q6u1gITbWB2IEFN847CqYOX3fd4iKhUWZVGe/j3p2U/rnj8HZRdgC/hnJE5zJgU7FXECpRI6NXHoWqE6VbBHlrh/rLiI8xaauqhPyDo1J3KurjRPreR25AZWXI4iqEwXKdsAqt0k7x8TIyH4UGJF/5OnWeTKCP/68IKYheYGwh0OTDm5HtScqSZoqG82hqH1FHti2u5oiV5jxr4TMkF6s4FYlMvgqW8tODzXmQ2rqtQndSfk7gv45KgH4rRzTUMOrevITjK3+6FEijMZvbWHY+1py3zk8mWYaWkrYNKgP8O6SllT94u9OxqA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(316002)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(53546011)(478600001)(6486002)(2906002)(66556008)(66476007)(54906003)(6916009)(66946007)(6666004)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(7416002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czJNc2EzeDRod2RrSzYzYS9uUDNPc21JbG82U3psaVVTSTJ4TzRCNzBhQnhi?=
 =?utf-8?B?cG9pV3BxZHVIdUR2YjJvK3MyVVNYMXBJaWU2ZUFIVnAyOG5oaDlBb1pLMVlv?=
 =?utf-8?B?WEtVUE8wRGhzYTZtd3V6V0tsSVc4TGpQUWxUNUJGZFhiWFN6eVN1MWcxcGpU?=
 =?utf-8?B?d0pGRjZwUFd1VGNWNGNXVWFISTZMRnR1TndRZDJKQzVKUmhKMWQ4dnloZUJP?=
 =?utf-8?B?TWthS0tDWlFvQUlGYVprMUZoc1YrNUdtdlgyVUdpWTFTbWUveHVHRXJqejZ6?=
 =?utf-8?B?Rm5ldktzOFJVcG1WTlM4cTViOHZ4VDBMbzNwQ2NMZnVpVkdaN0crL2hueGww?=
 =?utf-8?B?U0NoQnN5ekpwaXpMTWVKVWM1Q2t6VjB6cnBUeitVcHV0NkZ1V3ZZTnduenQy?=
 =?utf-8?B?blY4SHh4K2NkWG1aYWRSUE01MjJFWmY1T2ZxeWs1L29STkgrdHl2bXZoMUFO?=
 =?utf-8?B?N3pOTVJZSmZ2aGpsKzhiS1YxV1FKa2NwSDBZU21sQXZoMmtPNFRjVjIwTDUv?=
 =?utf-8?B?QTlkTmZQMHNvQnUyTnVud2NETWlHK0l5d25lSGJwQnpWMFQvMWxJL1c1eksx?=
 =?utf-8?B?TVh0cnV0UnVBREM3Z1VRMTNZYjZXejVaQkFwTjFRVVJERUdTQmYvektlWWFn?=
 =?utf-8?B?ZzhOM2l1QkV5TEVSWjMycnFDMzJobmJCR1VMWHVPbGdOWXh6WEIzZ3p5TFEy?=
 =?utf-8?B?emMzVmVWMGRraGk2RFN4VGYzNTJYQ2M3eVp0WmRGRW9xVG1xYWdhNWpIbkpt?=
 =?utf-8?B?UHNRQUg3WGtZMnY1eUVjWTJkTGp4QUIvWDBzNm1VYzZxUmloRitZdEpHU3Jk?=
 =?utf-8?B?ak9KdG5yUkZqQzhEalFqeXRjSzZCZVI0V0NueTB2VUl2QXRta1VjeEltYS82?=
 =?utf-8?B?S0ZnZjNWaWxMSE5LVDQrdjIwSGxmTVhJU1FTVTh3SFpEZVlXbUZFMlYwd3dK?=
 =?utf-8?B?OTZhOGtnQXZ3bGt3UTVabEEra2tOZ0tDYUZmRW5LWW5WTmUzNlVzOGkxZkRs?=
 =?utf-8?B?dTdFSFhxbE1HQlVRNWUzUWZEQWh3UDVYU3MzWTUvRXovTExsVUthS09XQ1Jj?=
 =?utf-8?B?SThpbm9UMnZPMERsRlR6SnZOSVRJZVFLTEVIL2lFUEkwc29PNjhUajdKcElY?=
 =?utf-8?B?cXVrSTFIRDV3NTFxbEp5cFI0SGhPeCtWbWxVQy9BODg0T0k1OTJ1cHc1M1dp?=
 =?utf-8?B?Q1NzckM5dnJHZE9iVldWcmJOU0FVRjdSWDRsK2crTkFHQ3I3d2dRTG5GSGlY?=
 =?utf-8?B?cnlDcjhtbDBQRW95VGp5aFNhM1lJTU9tclVTcXBBSUNKeG95dVQxYWVrRk9Q?=
 =?utf-8?B?VFZhZ3hzcUkzYTBTeEROam84TjN4cmsxWmp0cEVNWU1pZldtWVplSmorZ3hs?=
 =?utf-8?B?NGZTd2FUdjJ1TFk3TlJrbG1Ic3o5Sk5JRkpiRUFMWjRhbmF3cDVKWG5UdTJS?=
 =?utf-8?B?YkZLdmViZ3RFRjNsa0R3NEhmNExBNkpSOTRzNDlPMXlaVEdRYUNUM1pGSDNK?=
 =?utf-8?B?OVdTeE9QT01NTy95TStQblhPemlMdXJIRDRrRmx0aXdmSlF6empXOTBaT1Ax?=
 =?utf-8?B?b1UzWFlheXNKc1FHYTJCK0dJN1dWUW93Lzg5UHRZeENjOUJhMlIzaGFGRnYx?=
 =?utf-8?B?NkVRMjllZjVYb2tjdEF1Rm5xejRLbnUvT3REYWIrMTAySTBiTVo1cUNyS2xy?=
 =?utf-8?B?eGd4bUFmWkNNMXYwSUorSXlnTldvVHFyNlI3VnZVSGFpc3RPTWt6aUFlaWR5?=
 =?utf-8?B?aTE4MSt0Mi8yLzNTTHJvVWpxZkw0YjZITHlJQmpZTzErbjZsWi96aTNwbmcy?=
 =?utf-8?B?OUFXUWVHenJZc3JVZlhHV3NUYzNyYUhMbE9RVzR4ZzBva2NqMWFsSUxTT3ZZ?=
 =?utf-8?B?a2lhMkJJNmV1bGhDakFULzBlb3F5Uk9SZEgrbVpQU2NxUUczQ3BvNzhiaEZo?=
 =?utf-8?B?ZkhUNEEya3pQd2ZSUVZBYVZpRmJ4VjFuTi9kODJpNGdwbkFpTS9TN1VFbnJJ?=
 =?utf-8?B?SVR3VFBOSVZiVCs5Wjk1aGZraWdmVFdOenI3QnI2aWhRcWZiTDRhai9idjNB?=
 =?utf-8?B?Y2NiSDFZUlBVWG1lS3I1SmlzRTg5Mmt4SlVhVE5OblRyMVViVlphNjZJMlhv?=
 =?utf-8?B?Rm1ZWVJQaW1lQTZyMmdtTlVsOEFYZFMyMXI5dmt5NVVBZ0RxU1JvZFVZdC90?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/SOx0qahl6QmNmJ992dTXUCg6C3XNTt8J/7hdfnyMdfY8ZcsW0sTgLViwXm667st9IlAT3USMC85Lkq+Wd/fU8opYWXfaRJN9uW2kzE1j7jSuQFxsjdPRWloDS0AveZG1zlMI7Q0NiQBclA+V2RzmnY7OGuujzS63MYhAGB/ro2OM6sdpTrVB9di9xj9u32NpAZPX4bQkYss+hyQs6Ur2Wzw74UUbxsSsGYt2zdwdZptHmtmRLd1C2Qmf2L4+qUP5ICE0WgmEeEliVuNbjDeTX9sxMw+bTKc5naNtf55Hrtj4+NXr8pO/slN4XZshW+nQHMVnlEjP9uUqUSmC+5GApFZQrkftLBqlxt0STWN9xXPaXwUg3YfWWBiACw/WePKe+02aKenfjyt8wNftKcWgujgidNqfu8mnwZ26nTUNrhcRY7g0YCL4v+rFKvmZaomOZL3PbWZi60CTSgDr/YWJO7QqBPAPFSIbAwMi51cwfnJKOS/5zOmoDnbf1A3b4jl9Os+BxruHDWc/IU5B5m33M7A0ZZOx5lCxnAH0k0V6FOUa//yO1LSD7z6vwasA0c8fJ/7BBGawP6dzq0AhGttJRGFGjuR2Vy39k8ExfHJ0G4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a891f49e-1436-4d71-f3ce-08dbfd8018b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:11:21.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX8Lexo5stDkZLDeqx/3k+bxHpeNK5PvdI3z6qb2YS1S3FEE3xZJ846nVqyyqR9IFWfu3QiZtGWYsCIwQZGVSiFmdeL5XZ2F/FDrAjrdFdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6529
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150104
X-Proofpoint-ORIG-GUID: eeQLS4QvSkX64tcw9C2vJRbH_7Eqq95O
X-Proofpoint-GUID: eeQLS4QvSkX64tcw9C2vJRbH_7Eqq95O


On 15/12/2023 16:04, Vegard Nossum wrote:
> 
> On 15/12/2023 13:37, Vegard Nossum wrote:
>> Add a new Sphinx extension that knows about the translations of kernel
>> documentation and can insert links to the translations at the top of
>> the document.
>>
>> It basically works like this:
>>
>> 1. Register a new node type, LanguagesNode.
>>
>> 2. Register a new transform, TranslationsTransform, that inserts a new
>>     LanguageNode at the top of every document. The LanguageNode contains
>>     "pending references" to translations of the document. The key here
>>     is that these are pending (i.e. unresolved) references that may or
>>     may not actually exist.
>>
>> 3. Register a 'doctree-resolved' event that iterates over all the
>>     LanguageNode nodes. Any unresolved references are filtered out; the
>>     list of resolved references is passed to the 'translations.html'
>>     template and rendered as an HTML node (if HTML output is selected).
>>
>> Testing: make htmldocs, make latexdocs with Sphinx v4.3.2 and Firefox.
> 
> Oh no, there's still a problem. If I run make htmldocs, make latexdocs,
> make htmldocs, then all the translation menus disappear from the HTML.
> 
> So ignore this for now.
> 
> If anybody has a solution feel free to respond with it.

Wait, no, I was accidentally browsing the wrong site *facepalm*

It works and the v2 patch is still correct, as far as I can tell.

I have covid and a fever so chalking it down to that. I will stop
posting until I'm recovered.


Vegard

