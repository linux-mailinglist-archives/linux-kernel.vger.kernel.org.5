Return-Path: <linux-kernel+bounces-14714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E4822117
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11CC283F67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CE156FC;
	Tue,  2 Jan 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZd8ONhZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pU5uioZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D3156D0;
	Tue,  2 Jan 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029TOFP017583;
	Tue, 2 Jan 2024 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hqMFsyKGhNXLe/doh9ogF5u6TyERjZDpsIRueabHLns=;
 b=gZd8ONhZhyCAeBg3nDT2xJP7kmH3/4CWoOpJnVpNMy1uSHBnXaNkeMdYEODjQeDzw6tL
 0iz1miXdPjndNKHyc+MT50SVriRS2KpWQBS7vBMvHYCWRimSZu/wwdADA+5E0lX86389
 +eGRQoceNIXHNX0hhCD5fTiDJHmd8aToIBZ+vLjIjR+3XsTAU6tHV8bgMIbHGjM5Qz4B
 bT4RCFqMG2C2maVN3vZDQ4fi+QaDHGYydJXiXvYOfcKIqML5mh9Lo0GV7PuKRi9r40Uk
 SAELsXGYR9RpxnFFlZHgx6w2fiMQEqHThWD5OQgzfgT/KVlh3dytVU/KxeHUKehuW9Cm QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4cbmvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 18:34:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 402I8Av2024225;
	Tue, 2 Jan 2024 18:34:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9ne4crs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 18:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1+HiizrdRCAuOaZIURDUFTd6H0kkotxY2f4ljH5ZckTFf1++VJoLwmjLsgWu33hepzRPFESiGH5kgKnJeAB6H6LIlEUr5RI4/g5uEsz+dGFPtkia13Pk5vj5WPVrbeIRwjyGZlMSpfTyEhdLJy76vaObze+TtxTytf+qP7vpvqjnWdH6Sr2SD9PsKzhRhCsxnjiaS101lOPkTBNnb2n39Crnb/PxtePvDgrHWfIjlJihiowsAc76EiZlLi74xBZJYJHJnHCBGspnpNHSRVnbx2sAnen3vlAWM+ROaElweaN5jSJlbOkqcZVwVYtE8OJlJ3hkLvns6YOx/uT9Ovb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqMFsyKGhNXLe/doh9ogF5u6TyERjZDpsIRueabHLns=;
 b=lefdaUYRc3EJHaJP8O+y/c7TACFGboztOKcCBWDyb+Re/m/vpMCp4jgk3WeF4RGtD+UyRLi/g2TUL41KdbetcEOixorTHcRN+ITRbKfBdVjghgRfp73cGIuD9laQ2jKZu2332LOJq2pyJhJoLFHgAH9k4clhuUvjcdSEgR1F/YRTMnHWWZz0ueHT4VNKxJMYvD/YFDWoIW0HRC9AH1BJPDaxPX9t8Lv1xNn/nTNAq/82RHpgNkPOBDjHrY7OSpXMoOrE/AJ06MW6X/rTrcJOFuja9tqWYMWh3RnmGKyl7YfR8LeGaJjJEwnK6ZRFDqebTQcRO440E0UUz1MuhAUPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqMFsyKGhNXLe/doh9ogF5u6TyERjZDpsIRueabHLns=;
 b=pU5uioZcAvsMGv4uOK/tO6aSs62dxZVcJFPLivpKVamrK199Jj8BNLv6NTwPRmA9mjqiprnZ69jX4mdjirtyqBNXcah6n5ctTNvAt7wwVH5n2ocFzkIKzQiC5+gYr3XfHpdtFrhH3LIONkAvBRQ1x8w6BjhBbi4jUsqr7vXdDlw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 18:34:40 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 18:34:40 +0000
Message-ID: <8732426c-f428-4237-94d0-70e322ecfd13@oracle.com>
Date: Wed, 3 Jan 2024 00:04:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        vegard.nossum@oracle.com, darren.kenny@oracle.com,
        syzkaller <syzkaller@googlegroups.com>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
 <2024010103-connector-plausibly-bc35@gregkh>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2024010103-connector-plausibly-bc35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: de801298-9ce3-41b9-b1bf-08dc0bc17ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lc9FyyUM5ydImCoxO6wqmSrkDF5u3WwM1apaV6+A+8j3fBHSMWm+QylzjS5mwsO2QqCAQesRrZiEOkTDNQwNHirA4FyTeP4oDiRHPnhLPaZtY6c2NkbkSCcNVjrEXDsZvTzLOBr/4gHC7cn7g1Dxggjvk47941L/M5CyqQq1CWDR6WmMEeccBFdCGyrNheSXBDweqKpd2JYZxvq87eBdbESUlULaLVPljEeLKPb8g16nUuNXVWx+pp2K0/C7xdHMivVEThLuGWHkwTguJ/NVCuQSVsIoDb6M4mAHH2NBReUorWvIgdSWRaDWbR0c76wI9CeajmY09RxuxbhuAb0rU75yXw2YLVORP1QisUFqldTXlNduehNH91+slVHAYb92dZe2LX4qkDuvSB4w2byo2QZ3fjx/aXczHgtOij004ARP2Ly1N+VYpRxHTJI5u8CdoAWxb2AU+7mYdaBDw+azGgJ1LeJX0rl7DTu5F4YXB9GD7qhAIHZtHYvoepy5qYDJKbkYADNcS0UxAmF0Sj4hNOcOmwEyICO24uFBW8HbAFTNk9inNfy9ZRacUvqN2jtz5MVNK4E1pW55GDNI7jrhNvQuBruHL6IrmW39qSEQk3a2KulLcLB1+GIyvABpxXyPM0sOWOCySDrQUOHHxPrVoAgQJ2qcPdrQWw3vAamvsob1fEvVwmnbzoQLHY+1T+Nc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(2616005)(83380400001)(26005)(6512007)(6666004)(53546011)(8676002)(5660300002)(8936002)(4326008)(7416002)(2906002)(6486002)(66946007)(478600001)(6916009)(316002)(54906003)(66476007)(66556008)(41300700001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlREZTBOSDgzOWkrN2l6S2JqNmxXN01QK3NSYk01SVpxbzUwVkQ1TVJKZWd3?=
 =?utf-8?B?dkR6S0lLYkpsdXNmdk50R1RUZE5jbFBlUElzczBVNGpPWW5SZ3Vka2Z1YUND?=
 =?utf-8?B?dWt0WHF1cDdwSVdDMWRPRy9DOFFPelZQSGtkeXYxemNMTzdkWGZram1hNXRp?=
 =?utf-8?B?OUFJMGlMYlZwMXVTd3pad3RoekpqREVUZU14a0E5bVlGL0tCK3ZFOTQ2ay8v?=
 =?utf-8?B?MVpzWjdxeHhEZ1pQRTFPbnkzbzd4ckdIa2xvNnRxSHI4OXdKTXZ2Z0liK1Zx?=
 =?utf-8?B?TS9lc29LdkZUdXBTa1BUYzlMd0FCK25wNlo3WGh2MHU3Q2FadmVIbnpaUTBH?=
 =?utf-8?B?dm1VU0xmamhyNnNRLzVuUVU2VEtUZENOdmxONGFQRGp3c3h4SFB1ZjMyVndN?=
 =?utf-8?B?NUFzVHFxV2FwV3BGbXc5NWw3Snh5NVF0WW1qWWI0ZmZtMDJUMXlrNGgrc1gv?=
 =?utf-8?B?d01SMXNpYmNxNkhWcVJVVFg4L1BsQ3ZGOVJFZWw3dm0vOVk4dnZBWkJRWlZT?=
 =?utf-8?B?V1FnZ082OWJ0amZlYis3ZjVzakFGZHM5U1ZMbHl2R3FxbkNBUUhpWEVwMDUy?=
 =?utf-8?B?S1ZuSXdEOU0za1dBQmxWMldPTDNLaFhVc241Ym53OFU0N3IwWDZaTStCdk15?=
 =?utf-8?B?NTQ1azVXOENPamZKd25NS013YUlJNE9MOFNEeit0TkZvRzlsclhBaTA0eS9i?=
 =?utf-8?B?Ly9RL1YvSU1KWlErU1NPcnVlTWNLTmE3dnh0VHVhQ29Xd2lEU0ZIR2lUVUVT?=
 =?utf-8?B?SzRMMktGZlNkdUNndUdkalVwanJHWFZ6SHJ6Yk9FNHp0elNqNHdmVlcrbXh2?=
 =?utf-8?B?RUE0TDlkVU5tNFY3ZDI0aDRuV21lc2RrelBIVWc4NlhjQzlMbE8xalF6UmhH?=
 =?utf-8?B?bFh5K2pRZW1JT1Z1ZWh6L2lxMWcvcW52cTdWRW95L1BJT3E5NzRaUmdFSEdN?=
 =?utf-8?B?VDNRcDIrbXo4NFFFMXMzUkU4K3FrUjlJOUFEWEhZSjZZN3JCbmp6NklCME44?=
 =?utf-8?B?VDhjbTMwc2tNeTVldDBOOEVGZ3I0R1lsU3IvT0J3dFBHdnlORXpYL0VjRzFT?=
 =?utf-8?B?ais5amp2WEJWNnVXd1NEc2tnR2pjcms5dFVaSy9BelBKRlc5cndwdE9WRXJn?=
 =?utf-8?B?TW1vR2c5Q0xvNVdydkdTZStuSG1mQmpoaXVQakZkdDJyMFJtQVZJQ1RnUDFQ?=
 =?utf-8?B?V1I0N3kzUkVmOVFhYUc1SCtSeHd0bHNOa2Q4MUFzTkhuVEJ6cElQUmphWDJr?=
 =?utf-8?B?OGNxcmQ3eDdvc2JoSXhRSzNRWmpISkZYUFNid3ZSVmtPdUtsQjRROE1ITkxh?=
 =?utf-8?B?R3ZZZ2hQcnVUUzYyVjc2MFBMY2ZsN1Z4YXl3YUIwMlY3eENWT256ay80QjR2?=
 =?utf-8?B?WldGNlg3ZlRIajh1a09ONFdHMGJzZ0xjTXJsQkpoNW0zV1pwaHdqYTVKd2x3?=
 =?utf-8?B?eWxqdGRCMmRLakgvSkthU1JjMkl6MVdOMjV4Tm01V3RxRzNEWXA5N3hjNmRz?=
 =?utf-8?B?RUJyV2I3WG9aQVJBOXppTmd4MzRmVy9vbTVyS2hjbVEyTTVpNTlMYTkrS0Ji?=
 =?utf-8?B?alFwNVVsTFZZUjdIUjZJTU13N0ZKRitiZmdOcDA3U1QyekNGK20xYjVQQ3hu?=
 =?utf-8?B?T1lteEQwNVpsQWp2Y2ZsUFN5TnczMnlBMzlyb3B1UUdCRCtFVTVXWjdXQnhq?=
 =?utf-8?B?UElFQ1c1R0FQWTB3SHBzQi9TbXl5bVREb29yZlY4bG15eTJlMHlqWmNUMUYv?=
 =?utf-8?B?QWZtMUoxR3ZtT0pySTJJa2V0ME9xUGJUQ05KM1EzWWVOZVR0TGR1T01Na3Zy?=
 =?utf-8?B?M3FFWHBsRWNhYVBETVNsNitCRWxPSXZUY0ZSa0kydUlTQWtZOEEwY2lwSGFM?=
 =?utf-8?B?ckwzQ1NER0NKV1paaFkrMGhqUlZ4bU9WV0JmN2tDYjNKR0hBZHRENHBqUGRy?=
 =?utf-8?B?YUtvQzRxMGFqRUtBcUhYYmlzYjdaRVBBTWhIYU9hUm82dlUwU3hCdk1mM0hN?=
 =?utf-8?B?T1IrRzJ5VHJ6RW8zNmdIU1F5NjE4UndiTENBdkJOaFpqM1RINmxXQ2llU2dP?=
 =?utf-8?B?bDdSeWFNMTlzTkhoNDdXLzJGZ1lucXNoNjgrb3g0WGJvT1ZTeE9PVkdGZDJU?=
 =?utf-8?B?cmE0dTVXeVBVZ0hha0xwUk1MRStWNFBjTDZJUTF6dmZCZC9kMkJ0TlZNaTd6?=
 =?utf-8?Q?/Hx+5SqgJKcrkwsWrsenvN4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZGvPhZZDH76YJOgwnhHDJfrufjE43mPHHEn5qVTyL0ganO/LkBkSzPtzN2m5KWka5gCxu8mxDiySP9waEQCRD+uY7LvqGxkA+mdvgC9aEr2tkQFW4J+aEasYc6zBCAcyf/0O6xO5RqAxUnJhrIcvgTP7CHLoso7n3/8jIzuHh5LwQruQnYKor9HF1ZXycGmzcQ22aSkDt4Fs4Whv1wxNDruo3+Wqm4hagzQFn9gc8nzwjLHqM1Q2bWpKjWLivxb/5QHnBmnMzIALhvAnNl2iZ4/QIzrzP86mzpipjF59sbJvee2f+DV/DvxCbFtQPUe//1a+HjU8lQvZw4rtr5dcF11PMiJ2bmCjIB+C4p/31ctnaz4fiiw2epOcmGJsXknkGKFye1rJXb/fKL5PVNxqovBVHqiyUmCwcb8OpA87UoqB8+1F4b201OCgrK3MkZY00buPKolV8GjhwYYOXhUuRO+eMWSHa9R5Ew5b2VPAlq3jc4AE/jnn4mY8RhifBWwxVK8ctrD61VB6qBHssHdJkwXTOkpeZQ+UdIePJHsmcAq2QUpnhT8fDZqHfi8YyRCy78Gcp96I4cwCw3IkG/8CBSckWX/iH0afxXO1DshCT9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de801298-9ce3-41b9-b1bf-08dc0bc17ae7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 18:34:39.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD2gOB/hbV91LhmxElqyKvz8rTkEdVt2GAmP5S283YRTIe3gLOOEg/ZusXBAznr5gweHiLfXZEDlbYfVjaADjyk0tqf2YHiQRgl9HydwEufryUPqbfvy4azKfAPijICe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020139
X-Proofpoint-GUID: bjdlTYBZ6QefRcrcI2xXUu19hKXNKsqM
X-Proofpoint-ORIG-GUID: bjdlTYBZ6QefRcrcI2xXUu19hKXNKsqM

Hi Greg,

On 01/01/24 7:25 pm, Greg Kroah-Hartman wrote:
> On Mon, Jan 01, 2024 at 05:08:28AM -0800, Harshit Mogalapalli wrote:
>> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
>>
>> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
>> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
>>
>> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
>> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
>>
>> Some code commentry, based on my understanding:
>>
>> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
>> /// This is 24 + payload_size
>>
>> memcpy(&dg_info->msg, dg, dg_size);
>> 	Destination = dg_info->msg ---> this is a 24 byte
>> 					structure(struct vmci_datagram)
>> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
>> 	Size = dg_size = 24 + payload_size
>>
>>
>> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
>>
>>   35 struct delayed_datagram_info {
>>   36         struct datagram_entry *entry;
>>   37         struct work_struct work;
>>   38         bool in_dg_host_queue;
>>   39         /* msg and msg_payload must be together. */
>>   40         struct vmci_datagram msg;
>>   41         u8 msg_payload[];
>>   42 };
>>
>> So those extra bytes of payload are copied into msg_payload[], so there
>> is no bug, but a run time warning is seen while fuzzing with Syzkaller.
>>
>> One possible way to silence the warning is to split the memcpy() into
>> two parts -- one -- copying the msg and second taking care of payload.
> 
> And what are the performance impacts of this?
> 

I haven't done any performance tests on this.

I tried to look at the diff in assembly code but couldn't comment on 
performance from that. Also, gustavo suggested to do this: instead of 
two memcpy()'s; a direct assignment and memcpy() for the payload part.

Is there a way to do perf analysis based on code without access to hardware?

Thanks,
Harshit

> thanks,
> 
> greg k-h


