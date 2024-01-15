Return-Path: <linux-kernel+bounces-26254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2998182DD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B93E1C214EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAEC17BB4;
	Mon, 15 Jan 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GT77QaAP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IxJQ9DV9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1917BA7;
	Mon, 15 Jan 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEaScM018914;
	Mon, 15 Jan 2024 16:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q2HbrBHDhXBA1a6v4RY8g4XrIbmp3ONRGWu0d33dIN0=;
 b=GT77QaAPxA16CqT1nyxA/naXuyu5aM9m3Epk+rC3MeGVV5rlDK8lU+uLLg5jWpsZ+bfs
 PAx1X6uKNDM6bxvelLfFjG8VWnO3ZFgY4fCFY0EF1sJUY782khUTzfi0B68c3GUnLyob
 PKF1sW9g45j8qErV+SKLvn2z2CkLYqVzocCPOFMrv5eB9V8c4awaMTCFxA2B3OxIwWaN
 YziAG8y/MjEKAZaIQJYn12patNqdPbdZ4L044V9YBRwytZymLm3FzY4jlECsEAc8UTX3
 DHCcWupgFhiSPv+YyqJxzjBnOgHFYZNj2r9A/i+wCQcZ8TgHJKM2bfYubon9r4zRlaFb +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hjkhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 16:25:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FENbAS024963;
	Mon, 15 Jan 2024 16:25:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy6csqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 16:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+FAeRzH/bWqojTmkzVOxRBaoVZj1BffuYwQtw6Nq0ZoTzYO6afNjIlbp+oNmfiYNobMtGkOOUN1TLCyTAmJwNgVkrcWRPTW2R5neMJXedCWe60Y+lB6wfr0mfnLEOcNt+HCaGbtHQemdOJayyqqId2NhKfib2eANzdamdXU3wBLPQ0EvKzFqI+XstRLT+INhlFcLLp1ZkhBkJwLhBW2Qou0k8pDSuxEbqu3TNiu3JMjpl1asdR4cVem+p7r6bP6KYV80/i09M9VVo/35tWa0jz5gvqKddVugdL2wZqkEF+0+yDN0kxQt+6mKXxuyJuzPMVHrjgzVyapkBbsUfogNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2HbrBHDhXBA1a6v4RY8g4XrIbmp3ONRGWu0d33dIN0=;
 b=gTXjgU/whkyO1uwBPX2DD3LoGVj24mcB2wUsSjPTpsY8nLO9eNMX4S43VoPYaUq0t1u7e+4wZFMc3IgwLr2zSgX+Oyx2+t5vN47EJ2XBFuT8SwsQPl22vgildl/YpSSvdMoV+UiH1TUL0jpQUAjAds9PZZLUx1BAAm+4hjJLZDVDdjwy1pWGr+Z+yJ4O4gqXWxoYIZM0SkZXr8hRVm/a0m4egFiZDfbNEBLYNcZv4sSTewdIxmzjMcclnRQ5HHL32seGMMQpW/LGSu+l0Nx9c/CWPYwxgRIUJ4IJ2xXuACIpohqy+WHxtz7h6472yMqnAacxQfEaId5BS2qovnc6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2HbrBHDhXBA1a6v4RY8g4XrIbmp3ONRGWu0d33dIN0=;
 b=IxJQ9DV9rIMPKFfwCCNK8t2DkMPLoM6j0bO80syJ4E0QL91etHLRkc5Exo+7qnYzgGMhppFMxIpFFt9dWQ0IQZlqqe6E9AskTKR+GnrvbiwtxJqFGEJTZZWBK17M7DZjrv8eFBRN1ynUdKYI9wURELNErAqju2/vbCrD55Br2LQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 16:25:37 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 16:25:37 +0000
Message-ID: <5d0fd28b-d476-4496-b51a-7e2b6c5f8f4a@oracle.com>
Date: Mon, 15 Jan 2024 21:55:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/38] 5.4.267-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240113094206.455533180@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3ea754-ce6f-42de-182d-08dc15e69b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vjwafvLYZvBfclKsS/g3+x51oYOU21aBuU1LUKR7dsSGZ4P6C/yEc31TXt3dzdVtcOMBUVXf8QLxgxLNatd5eofuOSwAbWZhkTt7xnmkj6Q+xhsKlsLdk/7eZlq6p93H9xGzGKOl1Ku28iqrvNMVo+5o7SNYXZenpV/EoPkvw/SAfvMthEQhS1TKCtjiq+as4VzBzQgE3LcaQkR+S7z8e5/cbjhpNXVXAEdkrCs2nBmEVZSrWxhCNIxbOBQPvEuSXl9K0mIi13qWXPAzCIjmYTtdOToCR55aWQUOu/FxFWN3D97zuS/rpLJFafJ3pRNE4iPabjh8DirqiebipT8Ghnh7mZUtYRvYtQ5ITdMn4uYU+ICpdlbAWa4PXliB4l4Bci23VtKv6so308WQ46vZbWsZL2WsmWuLJF1jkDn2P8FO7InI8kpVRFIFBJ4ukdPmz/pENx5aUvutClwp+qkkgcCT6oOMbmhrKcu/C7DhUBt05/HPft940lAJcWeLL3PdFHlkw55I0r7qzRpYVKDufywWyEhB8XtCoZFX2FtKKB5kkmOrUAjlo2EcvH0QjrFjTrdeLsc9ncChZR5+iednULvNY4jgUctPhj8JN+aCv0R6vrykSRti7JwAbtA1dIfGkHTangbBqMupyoDh3KqRMQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(31696002)(36756003)(86362001)(2906002)(4326008)(53546011)(2616005)(107886003)(66476007)(26005)(5660300002)(66946007)(6666004)(6512007)(966005)(478600001)(6486002)(66556008)(8676002)(316002)(8936002)(6506007)(7416002)(4744005)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3ZCemRiY2tqR1VrTytWd01LMmsrY2g4cEZmMzVIV1pOUVRkeTQrdisranZX?=
 =?utf-8?B?WSszckFBR2d4M1JmblB5bkEyZXcwZW4zaXpWMjdGT2kzdW4yQ1J4TUVDbGx3?=
 =?utf-8?B?WkdKUFRwdEFuMlRvWDBVd1BOcmhkb1RyMW1ZRGdyTjVZWTI2Q0lCa3lOU1NX?=
 =?utf-8?B?cG1DeGpBZGlVbG9PQUJ6RW1CaHNoTVZIalNtdjRMbUFUVU03a3dnWCtYNFdD?=
 =?utf-8?B?eWZxTU04UXBYellKUFY0NW05SC8rTU9qNjYwRDlxL2p0eUpCajdCVENlbytU?=
 =?utf-8?B?ZHlGcFhUNm8rN283VWt6MUxmdXVENE1HdnhVbEtwQ01EeldxaEprMWJCaDZQ?=
 =?utf-8?B?VjQxbkF2WUhMdHFxQWsrby9COFVWTXY0eE9oV0l5VXlhN21LWEdTaFVVSFBG?=
 =?utf-8?B?anphREVSM0xDRCtiRFZ5bUJjcVN6Y2RWaTJEYW5DblpGNFgzMmJnWjlZeVM2?=
 =?utf-8?B?VlJaK3Y1aUU5SFJubzZUamF0a1VLbWQybGJ3b2lBODBsM1duaTlncFRXOFdB?=
 =?utf-8?B?b201dWJKWldTKzBEZmVQV3o4QmtFRE1aNmFwMmEyczZWVTl3bFVaU2FrRG5r?=
 =?utf-8?B?VTYvYTIxcEhueVlyV0FqSnNxVmpVeFdadGxKanJEY1EzMDdsNGJDajlOQXhu?=
 =?utf-8?B?dm5BN1d3QVZYbEtRZEFkck1kSmtpUURTWTg2alU4V1pKOTZVUHZXYlM4T1BF?=
 =?utf-8?B?VWFHRGg2SlZLakJ1T2NtL3YvZ0gvZHJBV1ZUNFVzVXA0dWxLOXczelU5VDdP?=
 =?utf-8?B?STdCQW1aT2E4R3ZGYkxFNHhxVE1yVXVsZHpTREhGaElKbWFXVnlobzRmZEI1?=
 =?utf-8?B?dDQxam5aR0hGaEFUaUNsaTEzeWlKMkdwYU9uZEQ1UWdXRTFvYW84UDdyNVJN?=
 =?utf-8?B?aWlqREF0eG5WMFVxYlZPMjdBbURBK0VVR1BNY1BCTWFwbkxtRThaTHhZc3Ax?=
 =?utf-8?B?T0Z3K2MzUUoyZDNjbkIybyswc0hEYnNvQWFlQk9LYWZBa0xUSk5WQW8zamR0?=
 =?utf-8?B?RWVtRFBzRkxmdFUxMEpLT3dIRkd1NGhWeER4bzJlMmhqb1lsaXd1WnRQQUFI?=
 =?utf-8?B?RmtwQ2FCYjgxUGhlMDI3NHk4eUlzWHlGMFhMS2t5SENBc2VHM280RVJFWkpa?=
 =?utf-8?B?Y0Yyd2NGK0FUV1RsKzVvTUhUUHptd2lhbXFDbkRSclhrZXRWYjdTa1R5MVgw?=
 =?utf-8?B?Z0pJTEJScFdvQUx4OFdjYUV1Y21kZzlGMk5HM2JWTWR3WHNBTDlXV2ZyWEJP?=
 =?utf-8?B?bHN4blN1QnlVQVZIYlJ3dmMrWjJZUnpEcFJYUzkvZ0FjZnNlcllSc1FXT2NB?=
 =?utf-8?B?WDl4RmdNYklOa0Z6d3JWdGYySW5UTDNKa3FaRWQ3UXZmYnR3M2hJSXQvbnI0?=
 =?utf-8?B?THoyWXUzWXZ5eG9XWSsyNGtSWExqZXdvOE5Ha1gzcVo0ZU1jbTZXakFHMW5R?=
 =?utf-8?B?L01yMzJDcFJFVTJNVXlablVGWmljVUNCV1lSQ3JKemRoWjh2Wk1NWFd0R3Ni?=
 =?utf-8?B?ZGJzRXUrM3ZvNFZKY1RRZVVEMjRBQzhGRHNudjlWQVlqLzJnaGlsd0pWV0pt?=
 =?utf-8?B?MnNCQzdKbkI0OXNxU2cxOWxDdXRjU0VjaGxJSllDcmVKV09pUDFzbkdNVGdK?=
 =?utf-8?B?d2dOd3BkRkRDMEFONkp2VG1MdE5JM3ZTY0FpYWU5MEloM3laTWNraGplQWJU?=
 =?utf-8?B?SG9TMTd3MEIvbVNEUThCdlgyWWhvTTF5VlRvMko3WGdQdkRCZFdiUnErRUd0?=
 =?utf-8?B?c2hsSmdEMnNTcFFEWVc5em5ZM1oveVlwVHBRcC9vUnZXOThrU29ubFQvSWtm?=
 =?utf-8?B?Z0JTUERaYlEwL2lYbEFabzU3eHZhNTZrM25Zb2ZzeHpHeU1BWC9GV2ZFTjEr?=
 =?utf-8?B?S1hZdHVsaHZnek10N1FQRlpZQ3BCMDdJYUsrT3ZiNUxvQ1doTW11YmxtNHVE?=
 =?utf-8?B?OWxIbFdJY1NTR01TM1RLNko3SUY5Wkk0ZFRrZVF2SmtOaGpydVFJN0FtL1N1?=
 =?utf-8?B?bTN4OFJiMUhoNy94YXJ4Z2pxRlhtb3FleWp0RXZkS0pabU5nTHRFclFMQU90?=
 =?utf-8?B?T1lEY3YwTFNBbXlQTkJRcmNHMFNQTTU0Y2UwUjQwSnAwQnNjandnTXNnVFI5?=
 =?utf-8?B?czNpSDN6eHJTYzhIdExxWlh4VFVhMm9VM2VKVHE1aXpZS1Nxa3NFK3N1Kzho?=
 =?utf-8?Q?0t2fWKVuTK2suORe3CriR8w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5aEH0stRXYRKu5O2yL4fUo5ibdt3+ZKyP2zRAw/eUTqtLRWXUC94NmyIUykubR+0uRHMs9c2RqT7l900zPYshMCVFt7El+d4dH36UD946VUIANPmmvJdYjGODyTXBHfcKU6aCldP/HpZ3RePFwRIErsPBuIedImR+/a5G6637rp7MpXUl2Rtb1pW/IR6o9+sKYbunyR7v6TI3paPf/4OJVNb5gSJU18WDYZ5/w5tVihwtK4LmsXG+AJU82uE/4raztnFyAJdl6y5kQslVvyluLLaVVmNr2k5PeBDdpRH3u1cC7BpcrMZXrKfPzTDC3X4xs5FHIffw87/exL4HWO1cs7MKKhf31sLY/DR5nwMrgNTrqXwLdp5PqmCr1wBGM1TGuVuIPOSCg8Z2A4Xp6TjxnHTTrGsA8NKIsPoD7Mp0rA3udSQxk+lwaWHSwIYWzZqjjbNd2SKMQaXof6Fe5PMmxpLeFnH/KD67a5ApdSFTnb+OEidoGCzu8sbqIOsGHt9sQzY/xtaEMCa5hKajyNUk5Pqq6ItQTMXEX+rW3LkUD5UigDAKNRqCUqocaQGbqb347i5mwsTsir1jqxzmFhg1UBb53crAjPwDs8M5Cjc2Qk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ea754-ce6f-42de-182d-08dc15e69b6f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 16:25:37.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFX6HWGw25YbZOCd7W8upoLVbBpTl5xMr8u3cZW/8LWHWxos9OYYw0qza5QZOvcF1+8ad1KfjURSMFu4vwYoED4wIrcdDDp/5iWQ7nJUBlEqWSZQ2I5EFV6l7bbTAIKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_11,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401150120
X-Proofpoint-GUID: XBb1IKIQ5P33lhREApLkHak3O9tJFGtb
X-Proofpoint-ORIG-GUID: XBb1IKIQ5P33lhREApLkHak3O9tJFGtb

Hi Greg,

On 13/01/24 3:19 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.267 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.267-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

