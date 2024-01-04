Return-Path: <linux-kernel+bounces-16608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8B82410C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E79C1F23F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC921366;
	Thu,  4 Jan 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0NmOpav";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TPcJix62"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177F2135B;
	Thu,  4 Jan 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404280M2012406;
	Thu, 4 Jan 2024 11:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3bhrdoyK34c36V82lBZ/+MxGDBJFG1/N0U0xLpeog1U=;
 b=I0NmOpavIHIpAoLYNKdMAhQffN72Z/K2Hn/ylvpril/T0EwDmfstyWiroizWozsWtoWM
 0hl5QP1mByNsMcANVSMSuNYimzYspU7yLZ/4YtkRcvnCm5zXYuPQG/Ixh6109pb9fbKC
 GVJAputHddWoeHMUr1kk9dhgvRkLAqL+x+totYxUHF7YFvBNAAqZ7i3EWbpluXjM73YK
 g4iIe0vM3I3fsdwO6Ot01A34hWbrNpWV50FSvF2B2yOTXFNQiDCdVNDVvLTVyovCEkFs
 9huhLyZO2hQWJmFt++EaN+W8gCppFF7bOaSW/U/jmDdvp59cKfcm36mzBGn0JtEWXkdO 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3axwma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 11:55:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404BsTZn006042;
	Thu, 4 Jan 2024 11:55:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdv5xr59n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 11:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQuX0aaAuUVZxM5jaZhgoSxmrJjQhZKnwUNdcTJezdFkm3VOwVAfkRJdGm4XpOocknZdMSNpfWC4lITUXNCE8yGNGdkxu5X99yZTkAmCwuJmOAqfwgD0F4J7D0JrJkf0/RmIA0b1zP5XB1BcEdRh6oFCH+7WgKsiF8Pv5XQ2ZoBrXuq60LfSA4tA8+ccuCGFxoeEsbbzeL4/QD4B21DVzlCztVtOsY1Pmqh8I4YqI6k8AM4+VdtXcOx/CZ9jmP6Q7NGNUobJRDvcFz/woLZwrSV/DnUn3ENwclGZT+8Y5bQN408SE3vs50hIn5LjI6zC1vzlooh/o9jaCP0s+zbNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bhrdoyK34c36V82lBZ/+MxGDBJFG1/N0U0xLpeog1U=;
 b=LM86UiOzwo/L3+NY1GF9GuWxhIUaSJ376BFBfOXDAM+T+Iqk0p9bDn2ePmQQuYNNoVO7LeOF6MJ7PSJwomvasYZ/eBm3ejvyW9HRxhoJXjPC3QASSkfZj2dayO0gdrOIOfP+iuaFMHocshKWS2xzEPbCSRQbJDZnTCK06U/hAPf9noYr7DAOWIEp8tlEHWDsapnbDBMbeQ6kHjMZnnTVyE/YK8YWr9aYoIwBvqM8toTJkj1kpxt/z+8E1WJ7Tt5gUVQDsaYS1P+JVzJ4TAe0FMAkKwOiFGGNFWJYD4emQ2DMQjQR9sD7dt78v58tFPB4YAplKS+DQB0CwVwkSczkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bhrdoyK34c36V82lBZ/+MxGDBJFG1/N0U0xLpeog1U=;
 b=TPcJix62kZyjJnhkLtE9Mh4uUOKs4kTM5YLSlBqGBqWgILJj3F7JEYEETNoFcJwCaM4zx/aUe9Nn+DVEnp48FCDItC21/k5tlho3BSJujCZU9HTcFrZrk9qB1bclxJghe0oP/50/O84Cv/OcksnHB8AeugDkBG3ZNDQGcrIETUM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5027.namprd10.prod.outlook.com (2603:10b6:208:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 11:54:01 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 11:54:01 +0000
Message-ID: <6ae0e327-eb8c-4c9d-bcee-6a1b123de197@oracle.com>
Date: Thu, 4 Jan 2024 17:23:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240103164834.970234661@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: b484b22e-3fab-454b-ebe6-08dc0d1bd7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9TKgjgfKGur/URAG2QBS09pkpSq7Z8rK6cbv79dJk4odt1lwN6vQoGoA+sHBqLLpyCJQwCzjP0UI3rGZlm3GRXQj8Bavj7qfy0vULWuFLwwGKcZhej++NzO45EI9VFXEHnKKnMHHwIKnatmpK1obkmht6n4F3iIt0+oila5D42R1ptDqOY3Img7WTTYrx9sx9kiIYV8nRa7T7v9pggszMNcDbaRH9IqTJPA+EOCJaygR4S5TiXCxUD/puDlfDdCVHSxEf93z5Ko4TrUkoKByuP0C08HIzlKXIm9EAj11cBlqQLiPwMXb//09I2NOMNcc4CQMPZpWvfrBe7UiAG1+0Q41KZuCV4Y2D++MjWJj4amyv4cq2ES4Qk5OCJec2g9mp9DQVHZT0klyxZ6YGeV+cMayYaLs7sU1jBL5iUd7TnlbHx8IsMaDFrpf4xslX5GVipviZX2hOy8uLHFXB2z/2qKsbxlAL/1GL8p7WGXo6f2R1lm1gCXdYRophy1cbDj8q5o206gMBvmSQu6ZkEzJCWa7av6nGJKo5+0PTnyoRKK4ADDoWo/H/bSaupL9N5mDBe1Zc7AHE7uYq2KyuEGTt8FYqxvdpKe2fF0s8DxZ0x0kIuBV8ayUrANxBfbgzRV32Ki13e3ovklk3zTK9+OpTQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(86362001)(6486002)(316002)(8676002)(54906003)(4326008)(8936002)(4744005)(5660300002)(7416002)(107886003)(66476007)(66556008)(66946007)(41300700001)(2616005)(26005)(6666004)(478600001)(966005)(31696002)(6506007)(6512007)(53546011)(36756003)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTFrRWFKVkhOZThVQU55dWxnWDNhRnVjQ2tsN3I4RldEUGJnUHltYi9VTTI5?=
 =?utf-8?B?UkZVeTlTZFpTd2NpV1BYay9tMUIxQVg2a1IrcGhKdEo0Um5Pd20vMlU4TVcx?=
 =?utf-8?B?RmRPTkVnWHN5cG5SM2dNRFZhSGl0RnNsbjBXSjVNMWYwZkwvcXB1M0hTUGdC?=
 =?utf-8?B?amZkYzRDeVBFRGlJYTJyWHA3VEZJWnV0ZjZBNTJIZ1hHK2ZOMWxBcHVrTWFF?=
 =?utf-8?B?S0p0VUthc3BQR0lMUXQ3MmNEbUdQVFBZR3BUV1BuMFBUYXpyMjF6SGlBd1Iv?=
 =?utf-8?B?T0d2TjBMZjY1TDhuVG5tR3VCRjh5YXh5ZEdOYUxMNHZ3N0tDc1VwRkxNeFpO?=
 =?utf-8?B?Vlp2YUNtbWUwVlIydUdJYmRVSFNIT0x6c1l3QVlsYWMySVZuaEk4Z3QxSWM2?=
 =?utf-8?B?ckhYTkxOblYyK2pmUnU1UHFSdm9JUHg1WHMvVGpPdS9YTlJHT0hIVUFWV292?=
 =?utf-8?B?RDJpU2lNVTBBbFNBTkVEOWY5TjNPcUJMNDVFa2VVTTRwSTJlbTh6YTU1WXAw?=
 =?utf-8?B?OEV5V2xwUVZDemFRdVU4RkU2MWg4TzlvMjdPdEZOY2VQSUVXeHRaNit0WlhB?=
 =?utf-8?B?WElRQlBGcXIyQzRCMkZVVFl1TE12dkVzV0pYZm1iN2dPUHhzYXVHZCtuRnBr?=
 =?utf-8?B?MDB3VXVlRDdqbGJmRXhaZUcvOWFzWHVmT0dDYU04TDRVT3BnYm1ZLzh3dFVq?=
 =?utf-8?B?VDltRFFwZjNsbzJzR0hNTnpVZ1o5TzRrdFIrWGM0RkdqNHN5aHdyZE9ranA1?=
 =?utf-8?B?Vng1WWNmZ1JYSzh3b2xnZnhKRDRFT08rRzFlQXFsYmdGbkNodlp5Uk1DMERw?=
 =?utf-8?B?T0RjN0Izd0FNVzBYKzRwdnNac0pyRUpvZmhobmpMdzc4RHRVRGtZaDZkT3ZX?=
 =?utf-8?B?U1Q5YkQwQzNNTGhVVm1nWTR2UFYxWjJMNXhBb1FnSFQ0OTRVekZGMHNhYjVI?=
 =?utf-8?B?aWtIUjZCNi9SeHdhdjFCbHo0OHJzc21qeXZhOFR5ZzF2UW9mWldsS2M1SDk5?=
 =?utf-8?B?ZlhPNlAxaUVJV1AvOGhSWnVVaWRtVlVYeVdQZjdyYitKakc3MVF3VTBSd1dV?=
 =?utf-8?B?SGNKVXlyUUNMZG9DV1FNRURIdytrM3B1VDF3ejBlSnpZKzh1MGdwZXlrVW5t?=
 =?utf-8?B?TjNPUkRtNmZDMjlibWF5eVgxYVlMaEswazJWWUszNE9uVm9ndlYxVXlzYWNM?=
 =?utf-8?B?S2pQMkRsZFB6eHVjSFJNb3FuREYvaVc5MVdRdzVoVlllMEYvV01MdGY5RDVy?=
 =?utf-8?B?eVF1bTg3eCtvNHM2ZTM2STBrUEJvM21DMEo5NTJXd3MvZ3o5dWtxUVFJRms0?=
 =?utf-8?B?anFwQUdaR0NyNFZnK1BBSlF0ZnBkNWEranpWUGp2Vk44NnNmNEtBNnU0TDlM?=
 =?utf-8?B?WnJDU2JDRWpNSHZGdEJET3FtcFhHaXArSGlnaTd4SW1JbUJmZS9PZU5SS3gw?=
 =?utf-8?B?VUh6SW5hR2JRK2dCUkpIZ2JWSXZLakgrWUh4RHlLL3NybGx3QUdoWk9Hc3I2?=
 =?utf-8?B?QmRMSWlRUzEyVVQvNm51LzBtVHNRSGRkNWdwY2UvbFQ3OVhXSi9iQ0lBZ1pK?=
 =?utf-8?B?YTJ6U21ZcGZhYldOYUpvOGJDUm5EUW9PcUZMVks1YzcySXJPMHh0Vzl1NkF2?=
 =?utf-8?B?SHZYbW1Sc04xZzVmMms1R29QSCt6Y0gyMGIrMldVTmZyS2Y3OUM2VTRPMXlQ?=
 =?utf-8?B?VzA4czFyb2x3SktmVXRKZjZGY0gxdVByRkRJMVFzTElOV1VZSFc1bVJPZk0y?=
 =?utf-8?B?bXVJN2NUcmF4MFRuQmtZbGcwVzNDK014czQ2L2hIVUYwWGpFQTMrRmFkeS84?=
 =?utf-8?B?dXJyM0swTnRObDhqVEFKVkt1M1BVL1p2YUR0WkFrSmtSV0xPdHRwcUlTS01l?=
 =?utf-8?B?Wlk4dTZtSVF3WWdtWXdPKy9xKzJmQkxURDE5WXg1bk5iYk5kUTMxZkVLRktY?=
 =?utf-8?B?dkZLaWd5TGpVNDQ3V0I1QVgzSm04R1hYTU9MV3VQR0p1L0x1YitKU0ZpaHU5?=
 =?utf-8?B?OTZRTXBUMkZIelppSzdxcityejJLdlRaWmN1TEFZQ3dSVVJ5cnk4MXhteUM3?=
 =?utf-8?B?cXhSM3VYME9VMUY2ZnZTcXBkQnkzcm5lVHNjdHBZR2R5QjJQVUczY2FjbUFG?=
 =?utf-8?B?d2thTDZhRFI3NFZaZDh5ZXlTTFFLL09ac1NjbGNsNDJmU24rU3l5MHRTZTlp?=
 =?utf-8?Q?wACWBTTkXgI33VsTc+zEeQE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iAlmZmrLI0HcO1+KDM0Q2EhvMBnQXLafQCc4zZBpvh0ktMxN1yNXWtbEWO85H05U97l0DI2cdPUNbtqNmONafDF2dl6SU+t24TEVhPKjSmUOHbp/tUNPa4wjYWw1qGZ3tiBZSpB47T/zzCYEJ6e6xF1n/Gn4lc2C3kC+MR40yKhr2/18rEoXjirorBn2kQNKHUj08fCaZ8Lwl6CzSGRqWhFPuF7sDLWlV8KJbvb60Q/ofbNy0q4h9iUCOz4oy/AYc/SYYCKWEpvlZERImWZTASmv+wh554QNZxyaUj/ZZ9cm6NpEMiWLYAaHxWV6vzlsG0hR1fJjGblGmgE+8m2537ETxz3ZFBv16wgXrgGEpifAHtrRZf0EXTuDDzh452bWpjuyzqPsi75QTQdBINSfA7Y8+aDO5Nzn/1VVr4smGr7zdXh2x6uM0NF+1Zpog81JFSqnd/u/01qre4oaYcfAX84y8Mcr8fmHywuB0WKsXLRNGdXNGQd35AFhwSR65zmTqnasuTP1lD8SnxpbABuYBkcejyGLa2l84WgaScAAx6RjiWiPQcQUm8dsegbDMuzQUV2fXusHaBEScGmyXEjJIbTGK/lEAktBt0O948WKtfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b484b22e-3fab-454b-ebe6-08dc0d1bd7b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:54:01.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QutZ82kJdtsS56wawggaaNUvO3+seM9dFq8AJtrvXDl3FjELhnAL9cdY27RtZD/LLz/3v43IdH6D0M9z1ystB+y2+l/zsoG7j3uPKQLBpJ5oYwgVGeYtBDOsTUtjPlBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040092
X-Proofpoint-GUID: ROhy5jr2qcN4T-6E-1ojreWeMSlnzgbW
X-Proofpoint-ORIG-GUID: ROhy5jr2qcN4T-6E-1ojreWeMSlnzgbW

Hi Greg,

On 03/01/24 10:25 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 

